import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_player_create_info_cast_spell_entity.dart';
import 'package:foxy/entity/player_create_info_cast_spell_key.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_cast_spell_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoCastSpellViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoCastSpellValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoCastSpellRepository>();

  final editingKey = signal<PlayerCreateInfoCastSpellKey?>(null);
  final page = signal(1);
  final spells = signal(<BriefPlayerCreateInfoCastSpellEntity>[]);
  final total = signal(0);

  int? _race;
  int? _playerClass;
  int _refreshToken = 0;

  late final raceMaskController = registerController(FlagFieldController());
  late final classMaskController = registerController(FlagFieldController());
  late final spellController = registerController(IntFieldController());
  late final noteController = registerController(
    NullableStringFieldController(),
  );

  Future<bool> create() async {
    if (_race == null || _playerClass == null) return false;
    try {
      final candidate = await _repository.createPlayerCreateInfoCastSpell(
        _race!,
        _playerClass!,
      );
      editingKey.value = null;
      _initControllers(candidate);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建登录施法失败: $error');
      DialogUtil.instance.error('创建登录施法失败: $error');
      return false;
    }
  }

  Future<void> delete(
    BuildContext context,
    BriefPlayerCreateInfoCastSpellEntity entity,
  ) async {
    try {
      await _repository.destroyPlayerCreateInfoCastSpell(entity.key);
      await _refresh();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('删除成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
    }
  }

  void dispose() => disposeControllers();

  Future<bool> edit(BriefPlayerCreateInfoCastSpellEntity entity) async {
    final key = entity.key;
    editingKey.value = key;
    try {
      final full = await _repository.getPlayerCreateInfoCastSpell(key);
      if (full == null) {
        throw StateError('原登录施法记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(full);
      return true;
    } catch (error) {
      editingKey.value = null;
      LoggerUtil.instance.e('加载登录施法失败: $error');
      DialogUtil.instance.error('加载登录施法失败: $error');
      return false;
    }
  }

  Future<void> initSignals({int? race, int? playerClass}) async {
    await setParent(race: race, playerClass: playerClass);
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = _collect();
    validatePlayerCreateInfoCastSpellFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storePlayerCreateInfoCastSpell(candidate);
    } else {
      await _repository.updatePlayerCreateInfoCastSpell(originalKey, candidate);
    }
    editingKey.value = PlayerCreateInfoCastSpellKey.fromEntity(candidate);
    await _refresh();
  }

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return true;
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
      return true;
    } catch (error, stackTrace) {
      LoggerUtil.instance.e('保存登录施法失败', error: error, stackTrace: stackTrace);
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
      spells.value = [];
      total.value = 0;
      return;
    }
    await _refresh();
  }

  PlayerCreateInfoCastSpellEntity _collect() => PlayerCreateInfoCastSpellEntity(
    raceMask: raceMaskController.collect(),
    classMask: classMaskController.collect(),
    spell: spellController.collect(),
    note: noteController.collect(),
  );

  void _initControllers(PlayerCreateInfoCastSpellEntity entity) {
    raceMaskController.init(entity.raceMask);
    classMaskController.init(entity.classMask);
    spellController.init(entity.spell);
    noteController.init(entity.note);
  }

  Future<void> _refresh() async {
    final race = _race;
    final playerClass = _playerClass;
    if (race == null || playerClass == null) return;
    final token = ++_refreshToken;
    final count = await _repository.countPlayerCreateInfoCastSpells(
      race,
      playerClass,
    );
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final rows = await _repository.getBriefPlayerCreateInfoCastSpells(
      race,
      playerClass,
      page: page.value,
    );
    if (token != _refreshToken) return;
    spells.value = rows;
    total.value = count;
    editingKey.value = null;
  }
}
