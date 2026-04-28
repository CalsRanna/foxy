import 'package:flutter/widgets.dart';
import 'package:foxy/model/player_create_info.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoSpellCustomViewModel {
  final repository = PlayerCreateInfoRepository();

  final spells = signal<List<PlayerCreateInfoSpellCustom>>([]);
  int? _race;
  int? _class_;

  final racemaskController = TextEditingController();
  final classmaskController = TextEditingController();
  final spellController = TextEditingController();
  final noteController = TextEditingController();

  Future<void> initSignals({int? race, int? class_}) async {
    _race = race;
    _class_ = class_;
    if (race == null || class_ == null) return;
    spells.value = await repository.getSpellCustoms(race, class_);
  }

  void create() {
    racemaskController.clear();
    classmaskController.clear();
    spellController.clear();
    noteController.clear();
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = PlayerCreateInfoSpellCustom()
        ..racemask = _parseInt(racemaskController.text)
        ..classmask = _parseInt(classmaskController.text)
        ..spell = _parseInt(spellController.text)
        ..note = noteController.text;
      await repository.storeSpellCustom(item);
      spells.value = await repository.getSpellCustoms(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> onDelete(BuildContext context, PlayerCreateInfoSpellCustom item) async {
    if (_race == null || _class_ == null) return;
    try {
      await repository.deleteSpellCustom(item.racemask, item.classmask, item.spell);
      spells.value = await repository.getSpellCustoms(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  int _parseInt(String text) {
    if (text.isEmpty) return 0;
    final value = int.tryParse(text);
    if (value == null) throw Exception('输入值 "$text" 不是有效数字');
    return value;
  }

  void dispose() {
    racemaskController.dispose();
    classmaskController.dispose();
    spellController.dispose();
    noteController.dispose();
  }
}
