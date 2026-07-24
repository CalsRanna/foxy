import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'creature_default_trainer_entity.g.dart';

/// 生物默认训练师映射 — 对应 creature_default_trainer 表。

@FoxyFullEntity(table: 'creature_default_trainer')
class CreatureDefaultTrainerEntity with _CreatureDefaultTrainerEntityMixin {
  @FoxyFullField('CreatureId', key: true)
  final int creatureId;

  @FoxyFullField('TrainerId')
  final int trainerId;

  const CreatureDefaultTrainerEntity({this.creatureId = 0, this.trainerId = 0});

  factory CreatureDefaultTrainerEntity.fromJson(Map<String, dynamic> json) =>
      _CreatureDefaultTrainerEntityMixin.fromJson(json);
}
