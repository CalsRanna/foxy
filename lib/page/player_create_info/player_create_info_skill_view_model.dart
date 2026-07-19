import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_player_create_info_skill_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_skill_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_skill_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoSkillViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoSkillValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoSkillRepository>();

  final editingKey = signal<PlayerCreateInfoSkillKey?>(null);
  final page = signal(1);
  final skills = signal(<BriefPlayerCreateInfoSkillEntity>[]);
  final total = signal(0);

  int? _race;
  int? _playerClass;
  int _refreshToken = 0;

  late final raceMaskController = registerController(FlagFieldController());
  late final classMaskController = registerController(FlagFieldController());
  late final skillController = registerController(IntFieldController());
  late final rankController = registerController(IntFieldController());
  late final commentController = registerController(StringFieldController());

  Future<bool> create() async {
    final race = _race;
    final playerClass = _playerClass;
    if (race == null || playerClass == null) return false;
    try {
      final entity = await _repository.createPlayerCreateInfoSkill(
        race,
        playerClass,
      );
      editingKey.value = null;
      _initControllers(entity);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建出生技能失败: $error');
      DialogUtil.instance.error('创建出生技能失败: $error');
      return false;
    }
  }

  Future<void> delete(
    BuildContext context,
    BriefPlayerCreateInfoSkillEntity entity,
  ) async {
    try {
      await _repository.destroyPlayerCreateInfoSkill(entity.key);
      await _refresh();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('删除成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
    }
  }

  void dispose() => disposeControllers();

  Future<bool> edit(BriefPlayerCreateInfoSkillEntity entity) async {
    final key = entity.key;
    editingKey.value = key;
    try {
      final full = await _repository.getPlayerCreateInfoSkill(key);
      if (full == null) {
        throw StateError('原出生技能记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(full);
      return true;
    } catch (error) {
      editingKey.value = null;
      LoggerUtil.instance.e('加载出生技能失败: $error');
      DialogUtil.instance.error('加载出生技能失败: $error');
      return false;
    }
  }

  Future<void> initSignals({int? race, int? playerClass}) async {
    try {
      await setParent(race: race, playerClass: playerClass);
    } catch (error) {
      LoggerUtil.instance.e('加载出生技能失败: $error');
      DialogUtil.instance.error('加载出生技能失败: $error');
    }
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = _collect();
    validatePlayerCreateInfoSkillFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storePlayerCreateInfoSkill(candidate);
    } else {
      await _repository.updatePlayerCreateInfoSkill(originalKey, candidate);
    }
    editingKey.value = PlayerCreateInfoSkillKey.fromEntity(candidate);
    await _refresh();
  }

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return true;
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
      return true;
    } catch (error, stackTrace) {
      LoggerUtil.instance.e('保存出生技能失败', error: error, stackTrace: stackTrace);
      if (context.mounted) DialogUtil.instance.error('$error');
      return false;
    }
  }

  Future<void> setParent({int? race, int? playerClass}) async {
    if (_race != race || _playerClass != playerClass) page.value = 1;
    _race = race;
    _playerClass = playerClass;
    editingKey.value = null;
    if (race == null || playerClass == null) {
      skills.value = [];
      total.value = 0;
      return;
    }
    await _refresh();
  }

  PlayerCreateInfoSkillEntity _collect() => PlayerCreateInfoSkillEntity(
    raceMask: raceMaskController.collect(),
    classMask: classMaskController.collect(),
    skill: skillController.collect(),
    rank: rankController.collect(),
    comment: commentController.collect(),
  );

  void _initControllers(PlayerCreateInfoSkillEntity entity) {
    raceMaskController.init(entity.raceMask);
    classMaskController.init(entity.classMask);
    skillController.init(entity.skill);
    rankController.init(entity.rank);
    commentController.init(entity.comment);
  }

  Future<void> _refresh() async {
    final race = _race;
    final playerClass = _playerClass;
    if (race == null || playerClass == null) return;
    final token = ++_refreshToken;
    final count = await _repository.countPlayerCreateInfoSkills(
      race,
      playerClass,
    );
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefPlayerCreateInfoSkills(
      race,
      playerClass,
      page: page.value,
    );
    if (token != _refreshToken) return;
    skills.value = data;
    total.value = count;
    editingKey.value = null;
  }
}
