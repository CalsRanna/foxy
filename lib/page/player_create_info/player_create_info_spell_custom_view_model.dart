import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:foxy/entity/brief_player_create_info_spell_custom_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/entity/player_create_info_spell_custom_key.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_spell_custom_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoSpellCustomViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoSpellCustomValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance
      .get<PlayerCreateInfoSpellCustomRepository>();

  final editingKey = signal<PlayerCreateInfoSpellCustomKey?>(null);
  final page = signal(1);
  final spells = signal<List<BriefPlayerCreateInfoSpellCustomEntity>>([]);
  final total = signal(0);

  int? _race;
  int? _class_;
  int _refreshToken = 0;

  late final racemaskController = registerController(FlagFieldController());
  late final classmaskController = registerController(FlagFieldController());
  late final spellController = registerController(IntFieldController());
  late final noteController = registerController(StringFieldController());

  Future<bool> create() async {
    final race = _race;
    final class_ = _class_;
    if (race == null || class_ == null) return false;
    try {
      final candidate = await _repository.createPlayerCreateInfoSpellCustom(
        race,
        class_,
      );
      editingKey.value = null;
      _initControllers(candidate);
      return true;
    } catch (error) {
      LoggerUtil.instance.e('创建角色自定义法术失败: $error');
      DialogUtil.instance.error('创建角色自定义法术失败: $error');
      return false;
    }
  }

  Future<void> delete(
    BuildContext context,
    BriefPlayerCreateInfoSpellCustomEntity item,
  ) async {
    try {
      await _repository.destroyPlayerCreateInfoSpellCustom(item.key);
      await _refresh();
      if (!context.mounted) return;
      ShadSonner.of(context).show(const ShadToast(description: Text('删除成功')));
    } catch (error) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
    }
  }

  void dispose() => disposeControllers();

  Future<bool> edit(BriefPlayerCreateInfoSpellCustomEntity item) async {
    final key = item.key;
    editingKey.value = key;
    try {
      final entity = await _repository.getPlayerCreateInfoSpellCustom(key);
      if (entity == null) {
        throw StateError('原自定义法术记录不存在，可能已被其他操作修改或删除');
      }
      _initControllers(entity);
      return true;
    } catch (error) {
      editingKey.value = null;
      LoggerUtil.instance.e('加载角色自定义法术失败: $error');
      DialogUtil.instance.error('加载角色自定义法术失败: $error');
      return false;
    }
  }

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      await setParent(race: race, class_: class_);
    } catch (error) {
      LoggerUtil.instance.e('加载角色自定义法术失败: $error');
      DialogUtil.instance.error('加载角色自定义法术失败: $error');
    }
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    await _refresh();
  }

  Future<void> persist() async {
    final candidate = _collect();
    validatePlayerCreateInfoSpellCustomFields(candidate);
    final originalKey = editingKey.value;
    if (originalKey == null) {
      await _repository.storePlayerCreateInfoSpellCustom(candidate);
    } else {
      await _repository.updatePlayerCreateInfoSpellCustom(
        originalKey,
        candidate,
      );
    }
    editingKey.value = PlayerCreateInfoSpellCustomKey.fromEntity(candidate);
    await _refresh();
  }

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (!context.mounted) return true;
      ShadSonner.of(context).show(const ShadToast(description: Text('保存成功')));
      return true;
    } catch (error) {
      if (!context.mounted) return false;
      ShadSonner.of(context).show(ShadToast(description: Text('$error')));
      return false;
    }
  }

  Future<void> setParent({int? race, int? class_}) async {
    if (_race != race || _class_ != class_) page.value = 1;
    _race = race;
    _class_ = class_;
    editingKey.value = null;
    if (race == null || class_ == null) {
      spells.value = [];
      total.value = 0;
      return;
    }
    await _refresh();
  }

  PlayerCreateInfoSpellCustomEntity _collect() =>
      PlayerCreateInfoSpellCustomEntity(
        racemask: racemaskController.collect(),
        classmask: classmaskController.collect(),
        spell: spellController.collect(),
        note: noteController.collect(),
      );

  void _initControllers(PlayerCreateInfoSpellCustomEntity item) {
    racemaskController.init(item.racemask);
    classmaskController.init(item.classmask);
    spellController.init(item.spell);
    noteController.init(item.note);
  }

  Future<void> _refresh() async {
    final race = _race;
    final class_ = _class_;
    if (race == null || class_ == null) return;
    final token = ++_refreshToken;
    final count = await _repository.countPlayerCreateInfoSpellCustoms(
      race,
      class_,
    );
    if (token != _refreshToken) return;
    final lastPage = max(1, (count / _repository.kPageSize).ceil());
    if (page.value > lastPage) page.value = lastPage;
    final data = await _repository.getBriefPlayerCreateInfoSpellCustoms(
      race,
      class_,
      page: page.value,
    );
    if (token != _refreshToken) return;
    spells.value = data;
    total.value = count;
    editingKey.value = null;
  }
}
