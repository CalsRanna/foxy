// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import '../repository_annotations.dart';
import 'list_model.dart';
import 'naming.dart';

const _fullEntityChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFullEntity',
);
const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/entity_annotations.dart#FoxyFullField',
);
const _repositoryChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/repository_annotations.dart#FoxyRepository',
);
const _filterChecker = TypeChecker.fromUrl(
  'package:foxy/infrastructure/codegen/repository_annotations.dart#FoxyFilter',
);

/// 解析 `@FoxyListViewModel`。
///
/// 方法名一律按「返回类型 + filter 具名参数」从 repository 实际方法匹配,
/// 不依赖命名规则——reference_loot_template 的 `getBriefLootTemplateRows` /
/// `countLootTemplateRows` / `copyLootTemplate` 前缀与 base name 不匹配,
/// 签名匹配天然命中。
final class ListReader {
  const ListReader();

  Future<ListGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      _fail(
        '@FoxyListViewModel 只能标注 ViewModel class。',
        element,
        '把注解移动到具体 List ViewModel class。',
      );
    }
    final className = element.name;
    if (className == null || !className.endsWith('ListViewModel')) {
      _fail(
        '@FoxyListViewModel 只能标注以 ListViewModel 结尾的 class。',
        element,
        '使用具体 List ViewModel class。',
      );
    }

    final inputFileName = buildStep.inputId.pathSegments.last;
    final expectedFileName = '${toSnakeCase(className)}.dart';
    if (inputFileName != expectedFileName) {
      _fail(
        '$className 必须位于 $expectedFileName，当前文件是 $inputFileName。',
        element,
        '让 ViewModel class 与文件名保持一致。',
      );
    }

    final entityElement = _readEntity(annotation, className, element);
    final repositoryElement = _readRepository(
      annotation,
      className,
      entityElement,
      element,
    );
    final repositoryClassName = repositoryElement.name!;

    final baseName = repositoryClassName.substring(
      0,
      repositoryClassName.length - 'Repository'.length,
    );
    final filterClassName = '${baseName}Filter';

    final fields = _readFilterFields(
      repositoryElement,
      filterClassName,
      element,
    );

    // Brief/Filter 是生成类(在 .g.dart),build 期对同 phase 的 builder
    // 不可见(解析为 InvalidType),所以方法签名从 repository 源码文本提取,
    // 元素只做方法存在性校验。
    final repositorySource = await buildStep.readAsString(
      AssetId(
        buildStep.inputId.package,
        'lib/repository/${toSnakeCase(repositoryClassName)}.dart',
      ),
    );
    final fallbackKeyType = _readEntityKeyType(entityElement);
    final methods = _readMethods(
      repositorySource,
      repositoryElement,
      baseName,
      fallbackKeyType,
      element,
    );

    final mixinName = '_${className}Mixin';
    final source = await buildStep.readAsString(buildStep.inputId);
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    if (!source.contains("part '$partName';") &&
        !source.contains('part "$partName";')) {
      _fail(
        '$className 缺少 part \'$partName\';。',
        element,
        '在 ViewModel imports 后声明生成 part。',
      );
    }
    if (!RegExp(
      'class\\s+$className\\s+with\\s+[^\\{;]*\\b$mixinName\\b',
    ).hasMatch(source)) {
      _fail(
        '$className 必须混入 $mixinName。',
        element,
        '把 $mixinName 添加到 ViewModel 的 with 列表末尾。',
      );
    }
    final withList = RegExp(
      'class\\s+$className\\s+with\\s+([^\\{;]*)',
    ).firstMatch(source)?.group(1);
    if (withList != null) {
      final parts = withList.split(',').map((part) => part.trim()).toList();
      final controllerIndex = parts.indexOf('FieldControllerMixin');
      final queryIndex = parts.indexOf('QueryVersionMixin');
      final mixinIndex = parts.indexOf(mixinName);
      if (controllerIndex < 0 || queryIndex < 0) {
        _fail(
          '$className 必须混入 FieldControllerMixin 与 QueryVersionMixin。',
          element,
          '把 FieldControllerMixin, QueryVersionMixin 添加到 with 列表。',
        );
      }
      if (controllerIndex > mixinIndex || queryIndex > mixinIndex) {
        _fail(
          'FieldControllerMixin / QueryVersionMixin 必须在 $mixinName 之前。',
          element,
          '调整 with 顺序：FieldControllerMixin, QueryVersionMixin, ..., $mixinName。',
        );
      }
    }

    return ListGenerationModel(
      className: className,
      entityClassName: entityElement.name!,
      briefEntityClassName: methods.briefEntityClassName,
      repositoryClassName: repositoryClassName,
      mixinName: mixinName,
      fields: List.unmodifiable(fields),
      getBriefMethodName: methods.getBriefMethodName,
      countMethodName: methods.countMethodName,
      copyMethodName: methods.copyMethodName,
      keyType: methods.keyType,
    );
  }

  InterfaceElement _readEntity(
    ConstantReader annotation,
    String className,
    Element element,
  ) {
    final entityType = annotation.read('entity').typeValue;
    if (entityType is! InterfaceType) {
      _fail(
        '$className 的 @FoxyListViewModel 参数不是 Entity class。',
        element,
        '传入具体的 Full Entity 类型。',
      );
    }
    final entityElement = entityType.element;
    if (!entityElement.name!.endsWith('Entity')) {
      _fail('$className 绑定的类型必须以 Entity 结尾。', element, '传入具体的 Full Entity 类型。');
    }
    final entityAnnotations = _fullEntityChecker
        .annotationsOf(entityElement)
        .toList();
    if (entityAnnotations.length != 1) {
      _fail(
        '${entityElement.name} 必须且只能声明一个 @FoxyFullEntity。',
        entityElement,
        '只绑定已迁移的生成型 Full Entity。',
      );
    }
    return entityElement;
  }

  InterfaceElement _readRepository(
    ConstantReader annotation,
    String className,
    InterfaceElement entityElement,
    Element element,
  ) {
    final repositoryType = annotation.read('repository').typeValue;
    if (repositoryType is! InterfaceType) {
      _fail(
        '$className 的 @FoxyListViewModel 参数不是 Repository class。',
        element,
        '传入具体的 Repository 类型。',
      );
    }
    final repositoryElement = repositoryType.element;
    final repositoryClassName = repositoryElement.name!;
    if (!repositoryClassName.endsWith('Repository')) {
      _fail(
        '$className 绑定的类型必须以 Repository 结尾。',
        element,
        '传入具体的 Repository 类型。',
      );
    }
    final entityBaseName = entityElement.name!.substring(
      0,
      entityElement.name!.length - 'Entity'.length,
    );
    final repositoryBaseName = repositoryClassName.substring(
      0,
      repositoryClassName.length - 'Repository'.length,
    );
    if (repositoryBaseName != entityBaseName) {
      _fail(
        '$repositoryClassName 与 ${entityElement.name} 不符合一对一命名约定。',
        element,
        'Repository 和 Entity 使用相同 base name。',
      );
    }
    final repositoryAnnotations = _repositoryChecker
        .annotationsOf(repositoryElement)
        .toList();
    if (repositoryAnnotations.length != 1) {
      _fail(
        '$repositoryClassName 必须且只能声明一个 @FoxyRepository。',
        repositoryElement,
        '只绑定已迁移的生成型 Repository。',
      );
    }
    final boundEntityName = ConstantReader(
      repositoryAnnotations.single,
    ).read('entity').typeValue.element?.name;
    if (boundEntityName != entityElement.name) {
      _fail(
        '$repositoryClassName 的 @FoxyRepository 绑定的实体是 '
            '$boundEntityName，与注解传入的 ${entityElement.name} 不一致。',
        element,
        '让 @FoxyListViewModel 的 repository 与 entity 匹配。',
      );
    }
    return repositoryElement;
  }

  List<ListFilterFieldModel> _readFilterFields(
    InterfaceElement repositoryElement,
    String filterClassName,
    Element element,
  ) {
    final fields = <ListFilterFieldModel>[];
    final names = <String>{};
    for (final object in _filterChecker.annotationsOf(repositoryElement)) {
      final reader = ConstantReader(object);
      final name = reader.read('name').stringValue;
      if (!names.add(name)) {
        _fail(
          '$filterClassName 重复声明字段 $name。',
          element,
          '确保每个 @FoxyFilter 字段名唯一。',
        );
      }
      if (!RegExp(r'^[a-z][A-Za-z0-9]*_?$').hasMatch(name)) {
        _fail(
          '$filterClassName 的字段名 $name 不是合法 lowerCamelCase 标识符。',
          element,
          '使用 lowerCamelCase；Dart 保留字允许追加单个下划线。',
        );
      }
      final typeIndex = reader
          .read('type')
          .objectValue
          .getField('index')
          ?.toIntValue();
      final type =
          typeIndex != null &&
              typeIndex >= 0 &&
              typeIndex < FoxyFilterType.values.length
          ? FoxyFilterType.values[typeIndex]
          : null;
      if (type != FoxyFilterType.text) {
        _fail(
          '$filterClassName.$name 的筛选类型是 ${type?.name ?? '未知'}。',
          element,
          'List ViewModel 当前只支持 @FoxyFilter.text 文本筛选字段；'
              '移除该筛选或改用 text。',
        );
      }
      fields.add(ListFilterFieldModel(name: name));
    }
    return fields;
  }

  /// 方法匹配结果:getBrief/count 方法、可选的 copy 方法与 Key 类型。
  /// 从 entity 的 `@FoxyFullField(key: true)` 推断 Key 类型:
  /// 单 key 为字段类型,复合 key 为 `XxxKey`(生成类,仅类名可推断)。
  String _readEntityKeyType(InterfaceElement entityElement) {
    final keyFieldTypes = <String>[];
    for (final field in entityElement.fields.where(
      (field) => !field.isStatic && !field.isSynthetic,
    )) {
      final annotations = _fullFieldChecker.annotationsOf(field).toList();
      if (annotations.length != 1) continue;
      if (!(ConstantReader(annotations.single).peek('key')?.boolValue ??
          false)) {
        continue;
      }
      keyFieldTypes.add(field.type.getDisplayString());
    }
    if (keyFieldTypes.isEmpty) {
      return '';
    }
    if (keyFieldTypes.length == 1) return keyFieldTypes.single;
    final baseName = entityElement.name!.substring(
      0,
      entityElement.name!.length - 'Entity'.length,
    );
    return '${baseName}Key';
  }

  _ListMethods _readMethods(
    String repositorySource,
    InterfaceElement repositoryElement,
    String baseName,
    String fallbackKeyType,
    Element element,
  ) {
    // 元素只做存在性校验:防止源码注释/文档中的示例签名被文本正则误匹配。
    final methodNames = {
      for (final method in repositoryElement.methods.where(
        (method) => !method.isStatic && !method.isSynthetic,
      ))
        method.name,
    };

    // getBrief:返回 Future<List<BriefXxxEntity>> 且参数含 filter,且 Brief
    // 类名与 entity base name 严格匹配(排除 reference 的 Entry 投影等)。
    final expectedBrief = 'Brief${baseName}Entity';
    final getBriefCandidates = <_MethodCandidate>[];
    final briefRegex = RegExp(
      r'Future<List<(Brief[A-Za-z0-9]+Entity)>>\s+([A-Za-z0-9_]+)\s*\(',
    );
    for (final match in briefRegex.allMatches(repositorySource)) {
      if (match.group(1) != expectedBrief) continue;
      final name = match.group(2)!;
      if (!methodNames.contains(name)) continue;
      final params = _balancedParams(repositorySource, match.end - 1);
      if (_hasFilterParameter(params)) {
        getBriefCandidates.add(_MethodCandidate(name, params));
      }
    }
    _dedupe(getBriefCandidates);
    if (getBriefCandidates.length != 1) {
      _fail(
        '${repositoryElement.name} 必须且只能有一个返回 '
            'Future<List<BriefXxxEntity>> 且带 filter 具名参数的方法。'
            '当前 ${getBriefCandidates.length} 个。',
        element,
        '确认列表查询方法返回 Brief 列表并接收 filter 具名参数。',
      );
    }
    final getBrief = getBriefCandidates.single;

    final countCandidates = <_MethodCandidate>[];
    final countRegex = RegExp(r'Future<int>\s+([A-Za-z0-9_]+)\s*\(');
    for (final match in countRegex.allMatches(repositorySource)) {
      final name = match.group(1)!;
      if (!methodNames.contains(name)) continue;
      final params = _balancedParams(repositorySource, match.end - 1);
      if (_hasFilterParameter(params)) {
        countCandidates.add(_MethodCandidate(name, params));
      }
    }
    _dedupe(countCandidates);
    if (countCandidates.isEmpty) {
      _fail(
        '${repositoryElement.name} 没有返回 Future<int> 且带 filter '
            '具名参数的统计方法。',
        element,
        '提供 count 方法，如 count$baseName({filter})。',
      );
    }
    final count = countCandidates.length == 1
        ? countCandidates.single
        : _disambiguateCount(countCandidates, getBrief, element);

    // copy:单参数 `key`(int 或 XxxKey),返回 Future<int>/Future<XxxKey>/
    // Future<void>(reference 的 copyLootTemplate 返回 void)。
    final copyCandidates = <_MethodCandidate>[];
    final copyRegex = RegExp(
      r'Future<(void|int|[A-Za-z0-9]+Key)>\s+(copy[A-Za-z0-9_]+)'
      r'\s*\(\s*(int|[A-Za-z0-9]+Key)\s+key\s*\)',
    );
    for (final match in copyRegex.allMatches(repositorySource)) {
      final name = match.group(2)!;
      if (!methodNames.contains(name)) continue;
      final returnType = match.group(1)!;
      final keyType = match.group(3)!;
      if (returnType != 'void' && returnType != keyType) continue;
      copyCandidates.add(_MethodCandidate(name, keyType));
    }
    _dedupe(copyCandidates);
    if (copyCandidates.length > 1) {
      _fail(
        '${repositoryElement.name} 有多个 copy 方法，无法确定复制入口。',
        element,
        '只保留一个返回 Key 类型的 copy 方法。',
      );
    }
    final copy = copyCandidates.isEmpty ? null : copyCandidates.single;

    // destroy 由 Repository 生成器按命名约定输出(destroy$baseName,
    // 在 .g.dart 的 mixin 里,build 期对元素不可见),生成器不校验其
    // 存在性——编译期兜底。Key 类型取 copy 参数或 entity key 推断。
    final keyType = copy?.params ?? fallbackKeyType;
    if (keyType.isEmpty) {
      _fail(
        '${repositoryElement.name} 无法推断 Key 类型。',
        element,
        '提供 copy 方法,或让 Entity 声明 key 字段(@FoxyFullField key: true)。',
      );
    }

    return _ListMethods(
      briefEntityClassName: expectedBrief,
      getBriefMethodName: getBrief.name,
      countMethodName: count.name,
      copyMethodName: copy?.name,
      keyType: keyType,
    );
  }

  /// 多个 count 候选时,用 getBrief 方法名去掉 `getBrief` 前缀消歧:
  /// `getBriefLootTemplateRows` → `countLootTemplateRows`。
  _MethodCandidate _disambiguateCount(
    List<_MethodCandidate> candidates,
    _MethodCandidate getBrief,
    Element element,
  ) {
    final suffix = getBrief.name.substring('getBrief'.length);
    final matched = candidates.where((c) => c.name == 'count$suffix').toList();
    if (matched.length != 1) {
      _fail(
        '${getBrief.name} 有 ${candidates.length} 个对应 count 方法，'
            '无法确定哪个是列表统计入口。',
        element,
        '提供与 getBrief 同后缀的 count 方法，如 count$suffix。',
      );
    }
    return matched.single;
  }

  /// 从方法名后的 `(` 开始配平括号,返回参数块文本(可能跨行)。
  String _balancedParams(String source, int openParenIndex) {
    var depth = 0;
    for (var index = openParenIndex; index < source.length; index++) {
      if (source[index] == '(') depth++;
      if (source[index] == ')') {
        depth--;
        if (depth == 0) return source.substring(openParenIndex + 1, index);
      }
    }
    return '';
  }

  /// 参数块文本中是否存在具名参数 `filter`。
  bool _hasFilterParameter(String params) =>
      RegExp(r'\bfilter\b').hasMatch(params);

  void _dedupe(List<_MethodCandidate> candidates) {
    final seen = <String>{};
    candidates.removeWhere((candidate) => !seen.add(candidate.name));
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\n修复方式：$correction',
      element: element,
    );
  }
}

final class _ListMethods {
  final String briefEntityClassName;
  final String getBriefMethodName;
  final String countMethodName;
  final String? copyMethodName;
  final String keyType;

  const _ListMethods({
    required this.briefEntityClassName,
    required this.getBriefMethodName,
    required this.countMethodName,
    required this.copyMethodName,
    required this.keyType,
  });
}

/// 文本解析出的方法候选:方法名 + 参数块(或 copy 的 Key 类型)。
final class _MethodCandidate {
  final String name;
  final String params;

  const _MethodCandidate(this.name, this.params);
}
