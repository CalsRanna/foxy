import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoSpellCustomViewModel {
  final repository = PlayerCreateInfoRepository();

  final spells = signal<List<PlayerCreateInfoSpellCustomEntity>>([]);
  int? _race;
  int? _class_;

  final racemask = signal<int>(0);
  final classmask = signal<int>(0);
  final spell = signal<int>(0);
  final noteController = TextEditingController();

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      _race = race;
      _class_ = class_;
      if (race == null || class_ == null) return;
      spells.value = await repository.getSpellCustoms(race, class_);
    } catch (e) {
      LoggerUtil.instance.e('加载角色自定义法术失败: $e');
      DialogUtil.instance.error('加载角色自定义法术失败: $e');
    }
  }

  void create() {
    racemask.value = 0;
    classmask.value = 0;
    spell.value = 0;
    noteController.clear();
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = PlayerCreateInfoSpellCustomEntity(
        racemask: racemask.value,
        classmask: classmask.value,
        spell: spell.value,
        note: noteController.text,
      );
      await repository.storeSpellCustom(item);
      spells.value = await repository.getSpellCustoms(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> onDelete(
    BuildContext context,
    PlayerCreateInfoSpellCustomEntity item,
  ) async {
    if (_race == null || _class_ == null) return;
    try {
      await repository.deleteSpellCustom(
        item.racemask,
        item.classmask,
        item.spell,
      );
      spells.value = await repository.getSpellCustoms(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void dispose() {
    noteController.dispose();
  }
}
