import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_player_create_info_cast_spell_entity.dart';
import 'package:foxy/entity/player_create_info_cast_spell_key.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/widget/form/field_controller.dart';

void main() {
  test('全行 Key 和 Brief 覆盖四个物理列并区分 NULL 与空串', () {
    const nullEntity = PlayerCreateInfoCastSpellEntity(
      raceMask: 1,
      classMask: 2,
      spell: 3,
    );
    const emptyEntity = PlayerCreateInfoCastSpellEntity(
      raceMask: 1,
      classMask: 2,
      spell: 3,
      note: '',
    );
    expect(PlayerCreateInfoCastSpellKey.fromEntity(nullEntity).note, isNull);
    expect(
      PlayerCreateInfoCastSpellKey.fromEntity(nullEntity),
      isNot(PlayerCreateInfoCastSpellKey.fromEntity(emptyEntity)),
    );
    expect(
      const BriefPlayerCreateInfoCastSpellEntity(
        raceMask: 1,
        classMask: 2,
        spell: 3,
      ).key,
      PlayerCreateInfoCastSpellKey.fromEntity(nullEntity),
    );
    expect(
      PlayerCreateInfoCastSpellEntity.fromJson({
        'raceMask': 1,
        'classMask': 2,
        'spell': 3,
        'note': null,
      }).toJson()['note'],
      isNull,
    );
  });

  test('可空字符串 Controller 明确保留 NULL 与空串', () {
    final controller = NullableStringFieldController();
    addTearDown(controller.dispose);

    controller.init(null);
    expect(controller.collect(), isNull);
    controller.setNull(false);
    expect(controller.collect(), '');
    controller.controller.text = 'note';
    expect(controller.collect(), 'note');
    controller.setNull(true);
    expect(controller.collect(), isNull);
  });

  test('Repository 使用绑定参数、二进制 null-safe 比较和 LIMIT 1', () {
    final source = File(
      'lib/repository/player_create_info_cast_spell_repository.dart',
    ).readAsStringSync();
    expect(source, contains('PlayerCreateInfoCastSpellKey originalKey'));
    expect(source, contains('BINARY `note` <=> BINARY ? LIMIT 1'));
    expect(source, contains("'UPDATE `playercreateinfo_cast_spell` '"));
    expect(source, contains("'DELETE FROM `playercreateinfo_cast_spell` '"));
    expect(source, contains('laconic.affectingStatement(sql, ['));
    expect(source, contains('originalKey.note'));
    expect(source, contains('if (matchedRows == 0)'));
    expect(source, contains('if (deletedRows == 0)'));
    expect(source, isNot(contains('savePlayerCreateInfoCastSpell(')));
  });

  test('内嵌编辑器使用全行 Brief、editingKey、分页和可空输入', () {
    final repository = File(
      'lib/repository/player_create_info_cast_spell_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/player_create_info/player_create_info_cast_spell_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/player_create_info/player_create_info_cast_spell_view.dart',
    ).readAsStringSync();
    expect(
      repository,
      contains('Future<List<BriefPlayerCreateInfoCastSpellEntity>>'),
    );
    expect(repository, contains('.limit(kPageSize)'));
    expect(
      viewModel,
      contains('editingKey = signal<PlayerCreateInfoCastSpellKey?>'),
    );
    expect(viewModel, contains('final originalKey = editingKey.value'));
    expect(viewModel, contains('entity.key'));
    expect(viewModel, contains('NullableStringFieldController()'));
    expect(view, contains('FoxyNullableStringInput('));
    expect(view, contains('FoxyPagination('));
  });

  test('Brief 登录施法实体不暴露写模型 API', () {
    final source = File(
      'lib/entity/brief_player_create_info_cast_spell_entity.dart',
    ).readAsStringSync();
    expect(source, isNot(contains('toJson(')));
    expect(source, isNot(contains('copyWith(')));
  });
}
