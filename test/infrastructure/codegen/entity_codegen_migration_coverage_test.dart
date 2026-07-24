import 'dart:io';

import 'package:test/test.dart';

void main() {
  const intentionallyHandwritten = {
    // App-owned rows with DateTime/enum conversion or no persisted row identity.
    'activity_log_entity.dart',
    'feature_entity.dart',
    'version_entity.dart',
  };

  final fullFiles =
      Directory('lib/entity')
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('_entity.dart'))
          .where((file) => !file.path.endsWith('.g.dart'))
          .where((file) => !file.uri.pathSegments.last.startsWith('brief_'))
          .toList()
        ..sort((left, right) => left.path.compareTo(right.path));

  test('所有标准 Full Entity 已迁移，手写清单只包含设计边界例外', () {
    final handwritten = {
      for (final file in fullFiles)
        if (!file.readAsStringSync().contains('@FoxyFullEntity'))
          file.uri.pathSegments.last,
    };

    expect(handwritten, intentionallyHandwritten);
    expect(fullFiles.length - handwritten.length, 125);
  });

  test('拆分完成后每个 Full Entity 文件只声明一个 Full Entity class', () {
    for (final file in fullFiles) {
      final source = file.readAsStringSync();
      final classes = RegExp(
        r'\bclass\s+(?!Brief)\w+Entity\b',
      ).allMatches(source);
      expect(classes.length, 1, reason: '${file.path} 必须只声明一个 Full Entity');
    }
  });

  test('生成型 Full Entity 的独立 Brief 只保留非标量投影例外', () {
    final independentBriefsForGeneratedOwners = {
      for (final file
          in Directory('lib/entity').listSync().whereType<File>().where(
            (file) =>
                file.uri.pathSegments.last.startsWith('brief_') &&
                file.path.endsWith('_entity.dart'),
          ))
        if (_generatedOwnerForBrief(file) != null) file.uri.pathSegments.last,
    };

    expect(independentBriefsForGeneratedOwners, {
      'brief_item_enchantment_template_entity.dart',
    });
  });

  test('Brief 投影 alias 只用于 SELECT，不进入 Repository 查询条件', () {
    final violations = <String>[];
    final queryClause = RegExp(
      r'\b(?:where|orWhere|whereAny)\s*\(([\s\S]*?)\);',
    );
    final alias = RegExp(r'\sAS\s', caseSensitive: false);

    for (final file
        in Directory('lib/repository').listSync().whereType<File>().where(
          (file) => file.path.endsWith('_repository.dart'),
        )) {
      final source = file.readAsStringSync();
      for (final match in queryClause.allMatches(source)) {
        if (alias.hasMatch(match.group(1)!)) {
          violations.add(file.uri.pathSegments.last);
        }
      }
    }

    expect(violations, isEmpty);
  });

  test('生成型 Full Entity 不依赖抽象字段 getter 或 lint 忽略', () {
    for (final file in fullFiles) {
      final source = file.readAsStringSync();
      if (!source.contains('@FoxyFullEntity')) continue;

      expect(
        source,
        isNot(contains('ignore_for_file: annotate_overrides')),
        reason: '${file.path} 不应通过文件级忽略隐藏 Mixin 字段覆盖',
      );

      final className = RegExp(
        r'class\s+(\w+Entity)\s+with\s+_\w+EntityMixin',
      ).firstMatch(source)?.group(1);
      expect(className, isNotNull, reason: '${file.path} 缺少约定 Mixin');

      final generated = File(
        file.path.replaceFirst(RegExp(r'\.dart$'), '.g.dart'),
      ).readAsStringSync();
      expect(
        generated,
        isNot(
          contains(
            RegExp(
              r'^\s+(?:int|double|String|bool)\??\s+get\s+\w+;\s*$',
              multiLine: true,
            ),
          ),
        ),
        reason: '${file.path} 的 Full Mixin 不应生成抽象字段 getter',
      );
      expect(
        generated,
        contains('final self = this as $className;'),
        reason: '${file.path} 的实例方法应在生成代码内部转换具体 Entity',
      );
    }
  });

  test('三个历史多实体文件完成独立文件拆分', () {
    for (final path in const [
      'lib/entity/player_create_info_action_entity.dart',
      'lib/entity/player_create_info_cast_spell_entity.dart',
      'lib/entity/player_create_info_item_entity.dart',
      'lib/entity/player_create_info_skill_entity.dart',
      'lib/entity/player_create_info_spell_custom_entity.dart',
      'lib/entity/quest_offer_reward_locale_entity.dart',
      'lib/entity/quest_request_items_locale_entity.dart',
    ]) {
      expect(File(path).existsSync(), isTrue, reason: '$path 尚未拆分');
    }
  });

  test('迁移工具不会重新创建旧 Brief/Key/Filter 生成壳', () {
    final source = File('tool/entity_codegen_migrate.dart').readAsStringSync();

    expect(
      source,
      isNot(contains("_generatedName(migration.fullFile, 'brief')")),
    );
    expect(
      source,
      isNot(contains("_generatedName(migration.fullFile, 'key')")),
    );
    expect(source, isNot(contains('FoxyFilterEntity')));
    expect(source, isNot(contains('FoxyFilterField')));
    expect(source, isNot(contains('_filter_entity.dart')));
    expect(source, isNot(contains('.filter.g.dart')));
    expect(source, contains('file.deleteSync();'));
  });

  test('Repository 专属 Filter 全部由 Repository 注解生成', () {
    final repositories =
        Directory('lib/repository')
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith('_repository.dart'))
            .where(
              (file) =>
                  file.readAsStringSync().contains('@FoxyRepositoryFilter'),
            )
            .toList()
          ..sort((left, right) => left.path.compareTo(right.path));

    expect(repositories, hasLength(76));
    for (final repository in repositories) {
      final source = repository.readAsStringSync();
      final fileName = repository.uri.pathSegments.last;
      final generatedName = fileName.replaceFirst('.dart', '.g.dart');
      final generated = File('lib/repository/$generatedName');

      expect(
        source,
        contains("part '$generatedName';"),
        reason: '${repository.path} 必须声明 Repository 生成 part',
      );
      expect(generated.existsSync(), isTrue, reason: '${generated.path} 尚未生成');
      expect(
        generated.readAsStringSync(),
        contains(RegExp(r'final class \w+Filter\b')),
        reason: '${generated.path} 必须包含不带 Entity 后缀的 Filter',
      );
    }
  });

  test('旧 Entity Filter 生成路径已移除，共享 Loot Filter 保持独立', () {
    final oldFiles = Directory('lib/entity').listSync().whereType<File>().where(
      (file) =>
          file.path.endsWith('_filter_entity.dart') ||
          file.path.endsWith('.filter.g.dart'),
    );
    expect(oldFiles, isEmpty);

    for (final file in [
      File('lib/infrastructure/codegen/entity_annotations.dart'),
      File('lib/infrastructure/codegen/builder.dart'),
      File('build.yaml'),
    ]) {
      final source = file.readAsStringSync();
      expect(source, isNot(contains('FoxyFilterEntity')));
      expect(source, isNot(contains('foxy_filter_entity')));
      expect(source, isNot(contains('.filter.g.dart')));
    }

    final shared = File(
      'lib/repository/loot_template_filter.dart',
    ).readAsStringSync();
    expect(shared, contains('final class LootTemplateFilter'));
    expect(shared, isNot(contains('LootTemplateFilterEntity')));
  });
}

File? _generatedOwnerForBrief(File briefFile) {
  final briefName = briefFile.uri.pathSegments.last;
  final owner = File('lib/entity/${briefName.substring('brief_'.length)}');
  if (!owner.existsSync()) return null;
  return owner.readAsStringSync().contains('@FoxyFullEntity') ? owner : null;
}
