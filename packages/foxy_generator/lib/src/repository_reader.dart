// ignore_for_file: depend_on_referenced_packages, experimental_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:foxy_generator/src/naming.dart';
import 'package:foxy_generator/src/repository_filter_model.dart';
import 'package:foxy_generator/src/repository_filter_reader.dart';
import 'package:foxy_generator/src/repository_model.dart';

const _briefEntityChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyBriefEntity',
);
const _briefFieldChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyBriefField',
);
const _filterChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/repository_annotations.dart#FoxyFilter',
);
const _fullEntityChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullEntity',
);
const _fullFieldChecker = TypeChecker.fromUrl(
  'package:foxy_annotation/entity_annotations.dart#FoxyFullField',
);

final class RepositoryReader {
  const RepositoryReader();

  Future<RepositoryGenerationModel> read(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      _fail(
        '@FoxyRepository 只能标注 Repository class。',
        element,
        '把注解移动到具体 Repository class。',
      );
    }
    final repositoryClassName = element.name;
    if (repositoryClassName == null ||
        !repositoryClassName.endsWith('Repository')) {
      _fail(
        '@FoxyRepository 只能标注以 Repository 结尾的 class。',
        element,
        '使用具体 Repository class。',
      );
    }

    final inputFileName = buildStep.inputId.pathSegments.last;
    final expectedFileName = '${toSnakeCase(repositoryClassName)}.dart';
    if (inputFileName != expectedFileName) {
      _fail(
        '$repositoryClassName 必须位于 $expectedFileName，'
            '当前文件是 $inputFileName。',
        element,
        '让 Repository class 与文件名保持一致。',
      );
    }

    final entityType = annotation.read('entity').typeValue;
    if (entityType is! InterfaceType) {
      _fail(
        '$repositoryClassName 的 @FoxyRepository 参数不是 Entity class。',
        element,
        '传入具体的 Full Entity 类型。',
      );
    }
    final entityElement = entityType.element;
    final entityClassName = entityElement.name;
    if (entityClassName == null || !entityClassName.endsWith('Entity')) {
      _fail(
        '$repositoryClassName 绑定的类型必须以 Entity 结尾。',
        element,
        '传入具体的 Full Entity 类型。',
      );
    }
    final expectedRepositoryClassName =
        '${entityClassName.substring(0, entityClassName.length - 'Entity'.length)}'
        'Repository';
    if (repositoryClassName != expectedRepositoryClassName) {
      _fail(
        '$repositoryClassName 与 $entityClassName 不符合一对一命名约定。',
        element,
        'Repository 和 Entity 使用相同 base name。',
      );
    }

    final entityAnnotations = _fullEntityChecker
        .annotationsOf(entityElement)
        .toList();
    if (entityAnnotations.length != 1) {
      _fail(
        '$entityClassName 必须且只能声明一个 @FoxyFullEntity。',
        entityElement,
        '只绑定已迁移的生成型 Full Entity。',
      );
    }
    final table = ConstantReader(
      entityAnnotations.single,
    ).read('table').stringValue;

    final baseName = entityClassName.substring(
      0,
      entityClassName.length - 'Entity'.length,
    );
    final entityParameterName =
        '${baseName[0].toLowerCase()}${baseName.substring(1)}';

    // The query layer (create/copy/getBrief/count/_applyFilter) is generated
    // for two kinds of repositories: main-table ones with a list page, and
    // child-table ones declaring linkKey (detail-page tabs).
    final listViewModelPresent = await buildStep.canRead(
      AssetId(
        buildStep.inputId.package,
        'lib/view_model/${toSnakeCase(baseName)}_list_view_model.dart',
      ),
    );
    final declaredLinkKeys = <String>[];
    final linkKeyReader = annotation.peek('linkKey');
    if (linkKeyReader != null && !linkKeyReader.isNull) {
      for (final value in linkKeyReader.listValue) {
        declaredLinkKeys.add(value.toStringValue()!);
      }
    }
    final queryLayerEnabled =
        listViewModelPresent || declaredLinkKeys.isNotEmpty;

    final keyFields = <RepositoryKeyFieldModel>[];
    final briefProjectionColumns = <String>[];
    // Filter name → physical column name of the entity field with the same
    // name.
    final fieldColumnByName = <String, String>{};
    for (final field in entityElement.fields.where(
      (field) => !field.isStatic && !field.isSynthetic,
    )) {
      final annotations = _fullFieldChecker.annotationsOf(field).toList();
      if (annotations.length != 1) continue;
      final fieldAnnotation = ConstantReader(annotations.single);
      final columnName = fieldAnnotation.read('name').stringValue;
      fieldColumnByName[field.name!] = columnName;
      final isKey = fieldAnnotation.peek('key')?.boolValue ?? false;
      if (isKey) {
        final dartType = field.type.getDisplayString();
        if (dartType.endsWith('?')) {
          _fail(
            '$entityClassName.${field.name} 是 nullable，不能作为生成 CRUD 的物理 Key。',
            field,
            'SQL 中 `列 = NULL` 恒不成立，生成的 _whereKey 会静默匹配 0 行并'
                '误报「原记录不存在」。把该列改成 non-nullable，'
                '或让该 Repository 保持手写并用 `<=>` 做 NULL 安全比较。',
          );
        }
        keyFields.add(
          RepositoryKeyFieldModel(
            columnName: columnName,
            dartName: field.name!,
            dartType: dartType,
          ),
        );
      }
      if (_isPhysicalBriefField(field)) {
        briefProjectionColumns.add(columnName);
      }
    }
    if (keyFields.isEmpty) {
      _fail(
        '$entityClassName 没有可用于 Repository 的物理 Key。',
        entityElement,
        '在至少一个 @FoxyFullField 上设置 key: true。',
      );
    }
    final linkKeyFields = <RepositoryKeyFieldModel>[];
    for (final declared in declaredLinkKeys) {
      RepositoryKeyFieldModel? matched;
      for (final field in keyFields) {
        if (field.dartName == declared) {
          matched = field;
          break;
        }
      }
      if (matched == null) {
        _fail(
          '$repositoryClassName 的 linkKey: \'$declared\' '
              '不是 $entityClassName 的 key 字段。',
          element,
          'linkKey 必须是实体上 @FoxyFullField(key: true) 的字段名。',
        );
      }
      linkKeyFields.add(matched);
    }
    if (queryLayerEnabled) {
      final briefAnnotations = _briefEntityChecker
          .annotationsOf(entityElement)
          .toList();
      if (briefAnnotations.length != 1) {
        _fail(
          '$entityClassName 必须声明 @FoxyBriefEntity 才能生成列表查询层。',
          entityElement,
          '给 Entity 加上 @FoxyBriefEntity，或在仓库保留手写查询方法。',
        );
      }
      if (briefProjectionColumns.isEmpty) {
        _fail(
          '$entityClassName 没有 @FoxyBriefField 标记的投影列。',
          entityElement,
          '至少把一个物理字段标记为 @FoxyBriefField()，'
              '否则 Brief 列表查询无法选择展示列。',
        );
      }
    }

    final filterFields = _readFilterFields(
      element,
      baseName,
      fieldColumnByName,
      // Child-table repositories (declaring linkKey) do not generate
      // _applyFilter; their filter fields may be non-inferable (the Filter
      // class is still generated, as a query-input object only).
      listViewModelPresent,
    );

    final source = await buildStep.readAsString(buildStep.inputId);
    final repositoryTable = RegExp(
      r'''static\s+const\s+_table\s*=\s*['"]([^'"]+)['"]\s*;''',
    ).firstMatch(source)?.group(1);
    if (repositoryTable != table) {
      _fail(
        '$repositoryClassName._table 与 $entityClassName 的物理表不一致：'
            '${repositoryTable ?? '未声明'} != $table。',
        element,
        '让 Repository._table 与 @FoxyFullEntity.table 完全一致。',
      );
    }
    final partName = inputFileName.replaceFirst(RegExp(r'\.dart$'), '.g.dart');
    if (!source.contains("part '$partName';") &&
        !source.contains('part "$partName";')) {
      _fail(
        '$repositoryClassName 缺少 part \'$partName\';。',
        element,
        '在 Repository imports 后声明生成 part。',
      );
    }
    // Locale-helper delegates need DbcLocaleRepositoryMixin's
    // loadDbcLocaleField/storeDbcLocaleField and dbcLocaleTableName.
    final localeHelpersEnabled =
        RegExp(r'\bDbcLocaleRepositoryMixin\b').hasMatch(source) &&
        RegExp(r'\bdbcLocaleTableName\b').hasMatch(source);
    final mixinName = '_${repositoryClassName}Mixin';
    if (!RegExp(
      'class\\s+$repositoryClassName\\s+with\\s+[^\\{;]*\\b$mixinName\\b',
    ).hasMatch(source)) {
      _fail(
        '$repositoryClassName 必须混入 $mixinName。',
        element,
        '把 $mixinName 添加到 Repository 的 with 列表末尾。',
      );
    }

    // autoIncrementKey: composite-key tables declare "the sequence column
    // that duplicate-key retries reallocate"; it must be an int key field,
    // and the scope must be key fields (dart names).
    final autoIncrementKey = annotation.peek('autoIncrementKey')?.stringValue;
    String? resolvedAutoIncrementKey;
    if (autoIncrementKey != null && autoIncrementKey.isNotEmpty) {
      final matched = keyFields.where((field) => field.dartName == autoIncrementKey);
      if (matched.isEmpty) {
        _fail(
          '$repositoryClassName 的 autoIncrementKey: \'$autoIncrementKey\' '
              '不是 $entityClassName 的 key 字段。',
          element,
          'autoIncrementKey 必须是实体上 @FoxyFullField(key: true) 的字段名。',
        );
      }
      if (matched.single.dartType != 'int') {
        _fail(
          '$repositoryClassName 的 autoIncrementKey: \'$autoIncrementKey\' '
              '类型是 ${matched.single.dartType},必须是 int。',
          element,
          '只有 int 主键列支持 MAX+1 自动重分配。',
        );
      }
      resolvedAutoIncrementKey = autoIncrementKey;
    }
    final declaredAutoIncrementScope = <String>[];
    final scopeReader = annotation.peek('autoIncrementScope');
    if (scopeReader != null && !scopeReader.isNull) {
      for (final value in scopeReader.listValue) {
        declaredAutoIncrementScope.add(value.toStringValue()!);
      }
    }
    for (final declared in declaredAutoIncrementScope) {
      final matched =
          keyFields.where((field) => field.dartName == declared).toList();
      if (matched.isEmpty) {
        _fail(
          '$repositoryClassName 的 autoIncrementScope: \'$declared\' '
              '不是 $entityClassName 的 key 字段。',
          element,
          'autoIncrementScope 必须是实体上 @FoxyFullField(key: true) 的字段名。',
        );
      }
    }

    return RepositoryGenerationModel(
      entityClassName: entityClassName,
      entityParameterName: entityParameterName,
      filterFields: List.unmodifiable(filterFields),
      keyFields: List.unmodifiable(keyFields),
      listViewModelPresent: listViewModelPresent,
      localeHelpersEnabled: localeHelpersEnabled,
      mixinName: mixinName,
      briefProjectionColumns: List.unmodifiable(briefProjectionColumns),
      linkKeyFields: List.unmodifiable(linkKeyFields),
      autoIncrementKey: resolvedAutoIncrementKey,
      autoIncrementScope: List.unmodifiable(declaredAutoIncrementScope),
      queryLayerEnabled: queryLayerEnabled,
      repositoryClassName: repositoryClassName,
      table: table,
    );
  }

  /// Whether the field carries the physical-projection marker
  /// `@FoxyBriefField()` (the default constructor without name/type;
  /// class-level `@FoxyBriefField.text/integer/...` are projection aliases
  /// provided by the query, not physical columns).
  bool _isPhysicalBriefField(FieldElement field) {
    final annotations = _briefFieldChecker.annotationsOf(field).toList();
    if (annotations.length > 1) {
      _fail(
        '${field.enclosingElement.name}.${field.name} 重复使用 @FoxyBriefField。',
        field,
        '只保留一个 @FoxyBriefField。',
      );
    }
    if (annotations.isEmpty) return false;
    return ConstantReader(annotations.single).peek('name')?.stringValue == null;
  }

  List<RepositoryFilterFieldModel> _readFilterFields(
    ClassElement element,
    String baseName,
    Map<String, String> fieldColumnByName,
    bool requireColumnInference,
  ) {
    final filterClassName = '${baseName}Filter';
    final fields = <RepositoryFilterFieldModel>[];
    final names = <String>{};
    for (final object in _filterChecker.annotationsOf(element)) {
      final field = readFilterField(object, filterClassName, element);
      if (!names.add(field.name)) {
        _fail(
          '$filterClassName 重复声明字段 ${field.name}。',
          element,
          '确保每个 @FoxyFilter 字段名唯一。',
        );
      }
      if (field.column.isNotEmpty) {
        fields.add(field);
        continue;
      }
      final inferred = fieldColumnByName[field.name];
      if (inferred == null) {
        if (requireColumnInference) {
          _fail(
            '$filterClassName.${field.name} 无法推断物理列：'
                'Entity 没有同名 ${field.name} 字段。',
            element,
            '给 @FoxyFilter.${field.type.name}('
                "'${field.name}') 显式声明 column: '物理列名'。",
          );
        }
        // Child-table repositories do not generate _applyFilter, so column
        // names are not consumed and may be undeclared.
        fields.add(field);
        continue;
      }
      fields.add(
        RepositoryFilterFieldModel(
          column: inferred,
          defaultValue: field.defaultValue,
          name: field.name,
          type: field.type,
        ),
      );
    }
    return fields;
  }

  Never _fail(String message, Element element, String correction) {
    throw InvalidGenerationSourceError(
      '$message\n修复方式：$correction',
      element: element,
    );
  }
}
