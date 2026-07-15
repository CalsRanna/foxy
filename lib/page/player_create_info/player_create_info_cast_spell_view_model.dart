import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/player_create_info_cast_spell_repository.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoCastSpellViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoCastSpellValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<PlayerCreateInfoCastSpellRepository>();
  final spells = signal(<PlayerCreateInfoCastSpellEntity>[]);

  int? _race;
  int? _playerClass;
  PlayerCreateInfoCastSpellEntity? _editing;

  late final raceMaskController = registerController(FlagFieldController());
  late final classMaskController = registerController(FlagFieldController());
  late final spellController = registerController(IntFieldController());
  late final noteController = registerController(StringFieldController());

  Future<void> initSignals({int? race, int? playerClass}) async {
    _race = race;
    _playerClass = playerClass;
    if (race == null || playerClass == null) return;
    await _refresh();
  }

  Future<void> create() async {
    if (_race == null || _playerClass == null) return;
    _editing = null;
    _initControllers(
      await _repository.createPlayerCreateInfoCastSpell(_race!, _playerClass!),
    );
  }

  void edit(PlayerCreateInfoCastSpellEntity entity) {
    _editing = entity;
    _initControllers(entity);
  }

  Future<void> save(BuildContext context) async {
    try {
      final entity = _collect();
      validatePlayerCreateInfoCastSpellFields(entity);
      if (_editing == null) {
        final existing = await _repository.getPlayerCreateInfoCastSpell(
          entity.raceMask,
          entity.classMask,
          entity.spell,
        );
        if (existing != null) throw StateError('该掩码/法术组合已存在');
        await _repository.storePlayerCreateInfoCastSpell(entity);
      } else {
        await _repository.updatePlayerCreateInfoCastSpell(
          _editing!.raceMask,
          _editing!.classMask,
          _editing!.spell,
          entity,
        );
      }
      await _refresh();
      if (context.mounted) {
        ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
      }
    } catch (e, s) {
      LoggerUtil.instance.e('保存登录施法失败', error: e, stackTrace: s);
      if (context.mounted) DialogUtil.instance.error(e.toString());
      rethrow;
    }
  }

  Future<void> delete(
    BuildContext context,
    PlayerCreateInfoCastSpellEntity entity,
  ) async {
    await _repository.destroyPlayerCreateInfoCastSpell(
      entity.raceMask,
      entity.classMask,
      entity.spell,
    );
    await _refresh();
    if (context.mounted) {
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    }
  }

  Future<void> _refresh() async {
    if (_race == null || _playerClass == null) return;
    spells.value = await _repository.getBriefPlayerCreateInfoCastSpells(
      _race!,
      _playerClass!,
    );
  }

  void _initControllers(PlayerCreateInfoCastSpellEntity entity) {
    raceMaskController.init(entity.raceMask);
    classMaskController.init(entity.classMask);
    spellController.init(entity.spell);
    noteController.init(entity.note);
  }

  PlayerCreateInfoCastSpellEntity _collect() => PlayerCreateInfoCastSpellEntity(
    raceMask: raceMaskController.collect(),
    classMask: classMaskController.collect(),
    spell: spellController.collect(),
    note: noteController.collect(),
  );

  void dispose() => disposeControllers();
}
