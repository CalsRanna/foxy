import 'package:flutter/widgets.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/player_create_info_repository.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';
import 'package:get_it/get_it.dart';

class PlayerCreateInfoSpellCustomViewModel {
  final _repository = GetIt.instance.get<PlayerCreateInfoRepository>();

  final spells = signal<List<PlayerCreateInfoSpellCustomEntity>>([]);
  int? _race;
  int? _class_;

  final racemaskController = TextEditingController();
  final classmaskController = TextEditingController();
  final spellController = TextEditingController();
  final noteController = TextEditingController();

  String _fmt(num v) {
    if (v is double) {
      final s = v.toString();
      if (s.contains('.') && s.endsWith('0')) {
        return s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return s;
    }
    return v.toString();
  }

  int _pi(String t) => int.tryParse(t) ?? 0;

  Future<void> initSignals({int? race, int? class_}) async {
    try {
      _race = race;
      _class_ = class_;
      if (race == null || class_ == null) return;
      spells.value = await _repository.getSpellCustoms(race, class_);
    } catch (e) {
      LoggerUtil.instance.e('加载角色自定义法术失败: $e');
      DialogUtil.instance.error('加载角色自定义法术失败: $e');
    }
  }

  void create() {
    racemaskController.text = _fmt(0);
    classmaskController.text = _fmt(0);
    spellController.text = _fmt(0);
    noteController.clear();
  }

  Future<void> save(BuildContext context) async {
    if (_race == null || _class_ == null) return;
    try {
      final item = PlayerCreateInfoSpellCustomEntity(
        racemask: _pi(racemaskController.text),
        classmask: _pi(classmaskController.text),
        spell: _pi(spellController.text),
        note: noteController.text,
      );
      await _repository.storeSpellCustom(item);
      spells.value = await _repository.getSpellCustoms(_race!, _class_!);
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
      await _repository.deleteSpellCustom(
        item.racemask,
        item.classmask,
        item.spell,
      );
      spells.value = await _repository.getSpellCustoms(_race!, _class_!);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('删除成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void dispose() {
    classmaskController.dispose();
    noteController.dispose();
    racemaskController.dispose();
    spellController.dispose();
  }
}
