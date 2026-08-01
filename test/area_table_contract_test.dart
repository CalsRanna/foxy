import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/area_table_constants.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/entity/area_table_entity.dart';
import 'package:foxy/entity/light_entity.dart';
import 'package:foxy/entity/liquid_type_entity.dart';
import 'package:foxy/entity/sound_ambience_entity.dart';
import 'package:foxy/entity/sound_provider_preferences_entity.dart';
import 'package:foxy/entity/zone_intro_music_entity.dart';
import 'package:foxy/entity/zone_music_entity.dart';

void main() {
  test('AreaTable Entity 精确覆盖 36 个物理列且全部为标量', () {
    final json = const AreaTableEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'ContinentID',
      'ParentAreaID',
      'AreaBit',
      'Flags',
      'SoundProviderPref',
      'SoundProviderPrefUnderwater',
      'AmbienceID',
      'ZoneMusic',
      'IntroSound',
      'ExplorationLevel',
      'AreaName_lang_enUS',
      'AreaName_lang_koKR',
      'AreaName_lang_frFR',
      'AreaName_lang_deDE',
      'AreaName_lang_zhCN',
      'AreaName_lang_zhTW',
      'AreaName_lang_esES',
      'AreaName_lang_esMX',
      'AreaName_lang_ruRU',
      'AreaName_lang_jaJP',
      'AreaName_lang_ptPT',
      'AreaName_lang_ptBR',
      'AreaName_lang_itIT',
      'AreaName_lang_unk1',
      'AreaName_lang_unk2',
      'AreaName_lang_unk3',
      'AreaName_lang_Flags',
      'FactionGroupMask',
      'LiquidTypeID0',
      'LiquidTypeID1',
      'LiquidTypeID2',
      'LiquidTypeID3',
      'MinElevation',
      'Ambient_multiplier',
      'LightID',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
    expect(AreaTableEntity.fromJson({'MinElevation': 0}).minElevation, 0.0);
  });

  test('AreaTeams 与 AreaFlags 对应当前 core 和 3.3.5a DBC', () {
    expect(kAreaTeamOptions.keys.toList(), [0, 2, 4, 6]);
    expect(kAreaFlagOptions.map((item) => item.value).toList(), [
      0x00000001, 0x00000002, 0x00000004, 0x00000008, 0x00000010,
      0x00000020, 0x00000040, 0x00000080, 0x00000100, 0x00000200,
      0x00000400, 0x00000800, 0x00001000, 0x00002000, 0x00004000,
      0x00008000, 0x00010000, 0x00020000, 0x00040000, 0x00080000,
      0x00100000, 0x00200000, 0x00400000, 0x00800000, 0x01000000,
      0x02000000, 0x04000000, 0x08000000, 0x20000000, 0x40000000,
    ]);
    expect(kAreaTableKnownFlagMask, 0x6FFFFFFF);
  });

  test('六张引用 DBC Entity 精确覆盖 100 个物理列且无聚合字段', () {
    final rows = [
      const SoundProviderPreferencesEntity().toJson(),
      const SoundAmbienceEntity().toJson(),
      const ZoneMusicEntity().toJson(),
      const ZoneIntroMusicEntity().toJson(),
      const LiquidTypeEntity().toJson(),
      const LightEntity().toJson(),
    ];
    expect(rows.map((row) => row.length).toList(), [24, 3, 8, 5, 45, 15]);
    for (final row in rows) {
      expect(row.values.whereType<List<Object?>>(), isEmpty);
      expect(row.values.whereType<Map<Object?, Object?>>(), isEmpty);
    }
    expect(requiredDbcTableNames, containsAll([
      'dbc_sound_provider_preferences', 'dbc_sound_ambience',
      'dbc_zone_music', 'dbc_zone_intro_music_table',
      'dbc_liquid_type', 'dbc_light',
    ]));
  });
}
