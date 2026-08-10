import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/spell_enums.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/constant/spell_flags.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/entity/spell_linked_spell_entity.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/entity/spell_rank_entity.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/repository/spell_custom_attr_repository.dart';
import 'package:foxy/repository/spell_loot_template_repository.dart';
import 'package:foxy/repository/spell_rank_repository.dart';

void main() {
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
    final values = SpellFlags.spellCustomAttributeOptions.map((item) => item.value);
    expect(values.toSet(), hasLength(32));
    expect(
      values.every((value) => value > 0 && value & (value - 1) == 0),
      isTrue,
    );
    expect(values.fold(0, (mask, value) => mask | value), 0xFFFFFFFF);
    expect(values, isNot(contains(0x20000800)));
  });

  test('关联表闭集值严格来自对应核心枚举', () {
    expect(SpellEnums.spellAreaGenderOptions.keys, orderedEquals([0, 1, 2]));
    expect(SpellEnums.spellLinkedTypeOptions.keys, orderedEquals([0, 1, 2]));
    expect(
      SpellFlags.spellAreaQuestStatusOptions.map((item) => item.value),
      orderedEquals([0x01, 0x02, 0x08, 0x20, 0x40]),
    );
    expect(SpellEnums.spellPowerTypeOptions.keys, containsAll([127, 0xFFFFFFFE]));
  });

  test('父键型关联记录禁止通过 MAX+1 复制出无效引用', () async {
    await expectLater(
      SpellBonusDataRepository().copySpellBonusData(1),
      throwsA(isA<CopyNotSupportedException>()),
    );
    await expectLater(
      SpellCustomAttrRepository().copySpellCustomAttr(1),
      throwsA(isA<CopyNotSupportedException>()),
    );
    await expectLater(
      SpellAreaRepository().copySpellArea(
        const SpellAreaKey(
          spell: 1,
          area: 1,
          questStart: 0,
          auraSpell: 0,
          racemask: 0,
          gender: 2,
        ),
      ),
      throwsA(isA<CopyNotSupportedException>()),
    );
    await expectLater(
      SpellRankRepository().copySpellRank(
        const SpellRankKey(firstSpellId: 1, rank: 1),
      ),
      throwsA(isA<CopyNotSupportedException>()),
    );
    await expectLater(
      SpellLootTemplateRepository().copySpellLootTemplate(
        const SpellLootTemplateKey(entry: 1, item: 1),
      ),
      throwsA(isA<CopyNotSupportedException>()),
    );
  });

  test('spell_linked_spell 类型映射为标签，未知值回退', () {
    const linked = BriefSpellLinkedSpellEntity(type: 1);
    expect(linked.typeLabel, '命中');
    expect(const BriefSpellLinkedSpellEntity(type: 9).typeLabel, '9');
  });

  test('spell_area 任务状态掩码展开为标签，未命中回退', () {
    const area = BriefSpellAreaEntity(
      questStartStatus: 0x01 | 0x08,
      questEndStatus: 0,
    );
    expect(area.questStartStatusLabel, '未接取, 进行中');
    expect(area.questEndStatusLabel, '0');
  });
}
