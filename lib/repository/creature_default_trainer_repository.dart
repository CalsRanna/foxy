import 'package:foxy/entity/creature_default_trainer_entity.dart';
import 'package:foxy/infrastructure/codegen/repository_annotations.dart';
import 'package:foxy/infrastructure/database/mysql_error_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:laconic/laconic.dart';

part 'creature_default_trainer_repository.g.dart';

@FoxyRepository(CreatureDefaultTrainerEntity)
class CreatureDefaultTrainerRepository
    with RepositoryMixin, _CreatureDefaultTrainerRepositoryMixin {
  // ignore: unused_field
  static const _table = 'creature_default_trainer';
  static const primaryKeyColumns = {'CreatureId'};

  Future<CreatureDefaultTrainerEntity> createCreatureDefaultTrainer(
    int creatureId,
  ) async {
    return CreatureDefaultTrainerEntity(creatureId: creatureId);
  }
}
