import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_skill_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoSkillViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoSkillValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoSkillRepository>();
  final skills = signal(<PlayerCreateInfoSkillEntity>[]);

  int? _race;
  int? _playerClass;
  PlayerCreateInfoSkillEntity? _editing;

  late final raceMaskController = registerController(FlagFieldController());
  late final classMaskController = registerController(FlagFieldController());
  late final skillController = registerController(IntFieldController());
  late final rankController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  Future<void> initSignals({int? race, int? playerClass}) async {
    _race = race;
    _playerClass = playerClass;
    if (race == null || playerClass == null) return;
    await _refresh();
  }

  Future<void> create() async {
    if (_race == null || _playerClass == null) return;
    _editing = null;
    final entity = await _repository.createPlayerCreateInfoSkill(
      _race!,
      _playerClass!,
    );
    _initControllers(entity);
  }

  void edit(PlayerCreateInfoSkillEntity entity) {
    _editing = entity;
    _initControllers(entity);
  }

  Future<void> save(BuildContext context) async {
    try {
      final entity = _collect();
      validatePlayerCreateInfoSkillFields(entity);
      if (_editing == null) {
        await _repository.storePlayerCreateInfoSkill(entity);
      } else {
        await _repository.updatePlayerCreateInfoSkill(
          _editing!.raceMask,
          _editing!.classMask,
          _editing!.skill,
          entity,
        );
      }
      await _refresh();
      if (context.mounted) {
        ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
      }
    } catch (e, s) {
      LoggerUtil.instance.e('保存出生技能失败', error: e, stackTrace: s);
      if (context.mounted) DialogUtil.instance.error(e.toString());
      rethrow;
    }
  }

  Future<void> delete(
    BuildContext context,
    PlayerCreateInfoSkillEntity entity,
  ) async {
    await _repository.destroyPlayerCreateInfoSkill(
      entity.raceMask,
      entity.classMask,
      entity.skill,
    );
    await _refresh();
    if (context.mounted) {
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    }
  }

  Future<void> _refresh() async {
    if (_race == null || _playerClass == null) return;
    skills.value = await _repository.getBriefPlayerCreateInfoSkills(
      _race!,
      _playerClass!,
    );
  }

  void _initControllers(PlayerCreateInfoSkillEntity entity) {
    raceMaskController.init(entity.raceMask);
    classMaskController.init(entity.classMask);
    skillController.init(entity.skill);
    rankController.init(entity.rank);
    commentController.init(entity.comment);
  }

  PlayerCreateInfoSkillEntity _collect() => PlayerCreateInfoSkillEntity(
    raceMask: raceMaskController.collect(),
    classMask: classMaskController.collect(),
    skill: skillController.collect(),
    rank: rankController.collect(),
    comment: commentController.collect(),
  );

  void dispose() => disposeControllers();
}
