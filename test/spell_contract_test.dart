import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/spell_enums.dart';
import 'package:foxy/constant/spell_flags.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/entity/spell_custom_attr_entity.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/entity/spell_group_entity.dart';
import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';
import 'package:foxy/repository/spell_loot_template_repository.dart';
import 'package:foxy/repository/spell_rank_repository.dart';

void main() {
  test('dbc_spell Entity 精确覆盖 234 个物理列且重复槽位均为标量字段', () {
    final json = const SpellEntity().toJson();
    expect(json, hasLength(234));
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(
      json.keys,
      containsAll(<String>{
        'ShapeshiftMask0',
        'ShapeshiftMask1',
        'ShapeshiftExclude0',
        'ShapeshiftExclude1',
        'Reagent0',
        'Reagent7',
        'ReagentCount0',
        'ReagentCount7',
        'Effect0',
        'Effect1',
        'Effect2',
      }),
    );
    expect(SpellEntity.fromJson(json).toJson(), json);
  });

  test('七张关联表 Entity 仅写出各自物理列', () {
    expect(const SpellBonusDataEntity().toJson().keys.toSet(), {
      'entry',
      'direct_bonus',
      'dot_bonus',
      'ap_bonus',
      'ap_dot_bonus',
      'comments',
    });
    expect(const SpellCustomAttrEntity().toJson().keys.toSet(), {
      'spell_id',
      'attributes',
    });
    expect(const SpellAreaEntity().toJson().keys.toSet(), {
      'spell',
      'area',
      'quest_start',
      'quest_end',
      'aura_spell',
      'racemask',
      'gender',
      'autocast',
      'quest_start_status',
      'quest_end_status',
    });
    expect(const SpellGroupEntity().toJson().keys.toSet(), {'id', 'spell_id'});
    expect(const SpellLinkedSpellEntity().toJson().keys.toSet(), {
      'spell_trigger',
      'spell_effect',
      'type',
      'comment',
    });
    expect(const SpellRankEntity().toJson().keys.toSet(), {
      'first_spell_id',
      'spell_id',
      'rank',
    });
    expect(const SpellLootTemplateEntity().toJson().keys.toSet(), {
      'Entry',
      'Item',
      'Reference',
      'Chance',
      'QuestRequired',
      'LootMode',
      'GroupId',
      'MinCount',
      'MaxCount',
      'Comment',
    });
  });

  test('关联表默认值与 core base SQL 一致', () {
    const area = SpellAreaEntity();
    expect(area.gender, 2);
    expect(area.questStartStatus, 64);
    expect(area.questEndStatus, 11);

    const loot = SpellLootTemplateEntity();
    expect(loot.chance, 100);
    expect(loot.lootMode, 1);
    expect(loot.minCount, 1);
    expect(loot.maxCount, 1);
  });

  test('SpellCustomAttributes 覆盖全部独立位且不加入组合别名', () {
    final values = kSpellCustomAttributeOptions.map((item) => item.value);
    expect(values.toSet(), hasLength(32));
    expect(
      values.every((value) => value > 0 && value & (value - 1) == 0),
      isTrue,
    );
    expect(values.fold(0, (mask, value) => mask | value), 0xFFFFFFFF);
    expect(values, isNot(contains(0x20000800)));
  });

  test('关联表闭集值严格来自对应核心枚举', () {
    expect(kSpellAreaGenderOptions.keys, orderedEquals([0, 1, 2]));
    expect(kSpellLinkedTypeOptions.keys, orderedEquals([0, 1, 2]));
    expect(
      kSpellAreaQuestStatusOptions.map((item) => item.value),
      orderedEquals([0x01, 0x02, 0x08, 0x20, 0x40]),
    );
    expect(kSpellPowerTypeOptions.keys, containsAll([127, 0xFFFFFFFE]));
  });

  test('服务端加载期关键约束在写库前被拒绝', () {
    expect(() => const SpellAreaEntity(gender: 3).validate(), throwsRangeError);
    expect(
      () => const SpellAreaEntity(spell: 1, auraSpell: -1).validate(),
      throwsArgumentError,
    );
    expect(
      () => const SpellLinkedSpellEntity(
        spellTrigger: 1,
        spellEffect: 2,
        type: 3,
      ).validate(),
      throwsRangeError,
    );
    expect(
      () => const SpellGroupEntity(id: 1000, spellId: 1).validate(),
      throwsArgumentError,
    );
    expect(
      () => const SpellRankEntity(
        firstSpellId: 1,
        spellId: 2,
        rank: 1,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const SpellCustomAttrEntity(
        spellId: 1,
        attributes: 0x02001000,
      ).validate(),
      throwsArgumentError,
    );
    expect(
      () => const SpellLootTemplateEntity(chance: 0, groupId: 0).validate(),
      throwsStateError,
    );
  });

  test('父键型关联记录禁止通过 MAX+1 复制出无效引用', () async {
    await expectLater(
      SpellBonusDataRepository().copySpellBonusData(1),
      throwsA(isA<UnsupportedError>()),
    );
    await expectLater(
      SpellCustomAttrRepository().copySpellCustomAttr(1),
      throwsA(isA<UnsupportedError>()),
    );
    await expectLater(
      SpellAreaRepository().copySpellArea(1, 1, 0, 0, 0, 2),
      throwsA(isA<UnsupportedError>()),
    );
    await expectLater(
      SpellRankRepository().copySpellRank(1, 1),
      throwsA(isA<UnsupportedError>()),
    );
    await expectLater(
      SpellLootTemplateRepository().copySpellLootTemplate(1, 1),
      throwsA(isA<UnsupportedError>()),
    );
  });
}
