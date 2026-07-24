import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import './support/local_dart_library_source.dart';

void main() {
  test('Repository 分配调用点不再手写 MAX 聚合', () {
    final offenders = Directory('lib/repository')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .where((file) => !file.path.endsWith('repository_mixin.dart'))
        .where(
          (file) => RegExp(
            r'\bMAX\s*\(',
            caseSensitive: false,
          ).hasMatch(file.readAsStringSync()),
        )
        .map((file) => file.path)
        .toList();

    expect(offenders, isEmpty, reason: 'ID/序号分配必须统一调用 nextMaxPlusOne()');
  });

  test('原手写分配点均调用 nextMaxPlusOne 并保留空表起始值', () {
    const repositoryPaths = [
      'lib/repository/creature_on_kill_reputation_repository.dart',
      'lib/repository/gossip_menu_repository.dart',
      'lib/repository/reference_loot_template_repository.dart',
      'lib/repository/spell_group_repository.dart',
      'lib/repository/npc_vendor_repository.dart',
      'lib/repository/creature_equip_template_repository.dart',
      'lib/repository/creature_model_info_repository.dart',
      'lib/repository/creature_quest_item_repository.dart',
    ];

    for (final path in repositoryPaths) {
      expect(
        File(path).readAsStringSync(),
        contains('nextMaxPlusOne('),
        reason: path,
      );
    }

    final mixin = File(
      'lib/repository/repository_mixin.dart',
    ).readAsStringSync();
    final npcVendor = readLocalDartLibrarySource(
      'lib/repository/npc_vendor_repository.dart',
    );
    expect(mixin, contains('int firstValue = 1'));
    expect(mixin, contains('if (raw == null) return firstValue;'));
    expect(npcVendor, contains('firstValue: 0'));
  });

  test('Repository 不保留仅转发 nextMaxPlusOne 的私有薄封装', () {
    final thinWrapperPattern = RegExp(
      r'Future<int>\s+_getNext\w*\([^)]*\)\s*'
      r'(?:=>\s*nextMaxPlusOne\(|async\s*\{\s*return\s+nextMaxPlusOne\()',
      multiLine: true,
    );
    final offenders = Directory('lib/repository')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .where((file) => thinWrapperPattern.hasMatch(file.readAsStringSync()))
        .map((file) => file.path)
        .toList();

    expect(offenders, isEmpty, reason: '应在调用点直接使用 nextMaxPlusOne()');
  });
}
