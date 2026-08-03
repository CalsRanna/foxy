import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';

/// H1 回归:laconic_mysql 把 tinyint(1) 列解码成 Dart bool,
/// 生成实体的 fromJson 必须双容忍 bool/num 两种形态,
/// 否则读真实数据即抛 TypeError(creature_onkill_reputation 读取即崩)。
void main() {
  group('CreatureOnKillReputationEntity.fromJson tinyint(1) 双容忍', () {
    test('bool 形态(驱动解码 tinyint(1) 的真实形态)不抛 TypeError', () {
      final entity = CreatureOnKillReputationEntity.fromJson({
        'creature_id': 1,
        'TeamDependent': true,
        'IsTeamAward1': false,
        'RewOnKillRepValue1': 5,
      });
      expect(entity.teamDependent, 1);
      expect(entity.isTeamAward1, false);
    });

    test('num 形态(旧驱动/文本协议)依旧兼容', () {
      final entity = CreatureOnKillReputationEntity.fromJson({
        'creature_id': 1,
        'TeamDependent': 1,
        'IsTeamAward1': 0,
      });
      expect(entity.teamDependent, 1);
      expect(entity.isTeamAward1, false);
    });

    test('缺失字段回落默认值', () {
      final entity = CreatureOnKillReputationEntity.fromJson({
        'creature_id': 1,
      });
      expect(entity.teamDependent, 0);
    });

    test('toJson 写路径保持 1/0 数值形态', () {
      final entity = CreatureOnKillReputationEntity.fromJson({
        'creature_id': 1,
        'TeamDependent': true,
      });
      final json = entity.toJson();
      expect(json['TeamDependent'], 1);
      expect(json['IsTeamAward1'], isA<int>());
    });
  });
}
