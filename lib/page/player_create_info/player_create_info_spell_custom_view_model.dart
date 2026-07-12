import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/player_create_info_spell_custom_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';
import 'package:get_it/get_it.dart';

class PlayerCreateInfoSpellCustomViewModel with FieldControllerMixin {
  final _repository = GetIt.instance
      .get<PlayerCreateInfoSpellCustomRepository>();

  final spells = signal<List<PlayerCreateInfoSpellCustomEntity>>([]);
  int? _race;
  int? _class_;

  late final racemaskController = registerController(IntFieldController());
  late final classmaskController = registerController(IntFieldController());
  late final spellController = registerController(IntFieldController());
  late final noteController = registerController(StringFieldController());

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      _race = race;
      _class_ = class_;
      if (race == null || class_ == null) return;
      spells.value = await _repository.getBriefPlayerCreateInfoSpellCustoms(
        race,
        class_,
      );
    } catch (e) {
      LoggerUtil.instance.e('加载角色自定义法术失败: $e');
      DialogUtil.instance.error('加载角色自定义法术失败: $e');
    }
  }

  void create() {
    racemaskController.init(0);
    classmaskController.init(0);
    spellController.init(0);
    noteController.init('');
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = PlayerCreateInfoSpellCustomEntity(
        racemask: racemaskController.collect(),
        classmask: classmaskController.collect(),
        spell: spellController.collect(),
        note: noteController.collect(),
      );
      await _repository.storePlayerCreateInfoSpellCustom(item);
      spells.value = await _repository.getBriefPlayerCreateInfoSpellCustoms(
        _race!,
        _class_!,
      );
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> delete(
    BuildContext context,
    PlayerCreateInfoSpellCustomEntity item,
  ) async {
    if (_race == null || _class_ == null) return;
    try {
      await _repository.destroyPlayerCreateInfoSpellCustom(
        item.racemask,
        item.classmask,
        item.spell,
      );
      spells.value = await _repository.getBriefPlayerCreateInfoSpellCustoms(
        _race!,
        _class_!,
      );
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void dispose() {
    disposeControllers();
  }
}
