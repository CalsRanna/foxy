import 'package:foxy/repository/creature_default_trainer_repository.dart';

class ResolveNpcTrainerParentUseCase {
  final CreatureDefaultTrainerRepository _repository;

  const ResolveNpcTrainerParentUseCase({required this._repository});

  Future<int?> execute(int creatureId) async {
    final relation = await _repository.getCreatureDefaultTrainer(creatureId);
    return relation?.trainerId;
  }
}
