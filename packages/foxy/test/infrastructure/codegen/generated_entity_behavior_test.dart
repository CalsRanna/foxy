import 'package:foxy/entity/char_title_entity.dart';
import 'package:foxy/entity/glyph_property_entity.dart';
import 'package:foxy/entity/pickpocketing_loot_template_entity.dart';
import 'package:test/test.dart';

void main() {
  test('Glyph 生成结果保持完整物理行、copyWith 与值语义', () {
    final row = <String, dynamic>{
      'ID': 7,
      'SpellID': 8,
      'GlyphSlotFlags': 9,
      'SpellIconID': 10,
    };
    final left = GlyphPropertyEntity.fromJson(row);
    final right = GlyphPropertyEntity.fromJson(row);

    expect(left.toJson(), row);
    expect(left.copyWith(spellId: 80).toJson(), {...row, 'SpellID': 80});
    expect(left, right);
    expect(left.hashCode, right.hashCode);
    expect(left.toString(), contains('spellIconId: 10'));
  });

  test('复杂标量试点转换 double/bool/非零默认值并生成复合 Key', () {
    final entity = PickpocketingLootTemplateEntity.fromJson({
      'Entry': 11,
      'Item': 22,
      'Chance': 25,
      'QuestRequired': 1,
    });

    expect(entity.chance, 25.0);
    expect(entity.questRequired, isTrue);
    expect(entity.lootMode, 1);
    expect(entity.minCount, 1);
    expect(entity.toJson()['QuestRequired'], 1);
    expect(
      PickpocketingLootTemplateKey.fromEntity(entity),
      const PickpocketingLootTemplateKey(entry: 11, item: 22),
    );
  });

  test('大型 DBC 试点保留 37 个字段顺序并使用生成值语义', () {
    const left = CharTitleEntity(id: 1, nameLangZhCN: '勇士', maskId: 37);
    const right = CharTitleEntity(id: 1, nameLangZhCN: '勇士', maskId: 37);

    expect(left.toJson(), hasLength(37));
    expect(left.toJson().keys.first, 'ID');
    expect(left.toJson().keys.last, 'Mask_ID');
    expect(left, right);
    expect(left.hashCode, right.hashCode);
    expect(left.toString(), contains('nameLangZhCN: 勇士'));
  });
}
