import 'package:flutter/widgets.dart';
import 'package:foxy/entity/spell_area_entity.dart';
import 'package:foxy/repository/spell_area_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class SpellAreaViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();

  final spellId = signal(0);
  final items = signal<List<SpellAreaEntity>>([]);
  final selectedIndex = signal<int?>(null);
  final areaController = TextEditingController();
  final questStartController = TextEditingController();
  final questEndController = TextEditingController();
  final auraSpellController = TextEditingController();
  final racemaskController = TextEditingController();
  final genderController = TextEditingController();
  final autocastController = TextEditingController();
  final questStartStatusController = TextEditingController();
  final questEndStatusController = TextEditingController();

  final _repository = GetIt.instance.get<SpellAreaRepository>();

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

  Future<void> load() async {
    final data = await _repository.getSpellAreas(spellId.value);
    items.value = data;
    selectedIndex.value = null;
  }

  void resetForm() {
    areaController.text = _fmt(0);
    questStartController.text = _fmt(0);
    questEndController.text = _fmt(0);
    auraSpellController.text = _fmt(0);
    racemaskController.text = _fmt(0);
    genderController.text = _fmt(0);
    autocastController.text = _fmt(0);
    questStartStatusController.text = _fmt(0);
    questEndStatusController.text = _fmt(0);
  }

  void fillForm(SpellAreaEntity data) {
    areaController.text = _fmt(data.area);
    questStartController.text = _fmt(data.questStart);
    questEndController.text = _fmt(data.questEnd);
    auraSpellController.text = _fmt(data.auraSpell);
    racemaskController.text = _fmt(data.racemask);
    genderController.text = _fmt(data.gender);
    autocastController.text = _fmt(data.autocast);
    questStartStatusController.text = _fmt(data.questStartStatus);
    questEndStatusController.text = _fmt(data.questEndStatus);
  }

  SpellAreaEntity collectFromForm() {
    return SpellAreaEntity(
      spell: spellId.value,
      area: _pi(areaController.text),
      questStart: _pi(questStartController.text),
      questEnd: _pi(questEndController.text),
      auraSpell: _pi(auraSpellController.text),
      racemask: _pi(racemaskController.text),
      gender: _pi(genderController.text),
      autocast: _pi(autocastController.text),
      questStartStatus: _pi(questStartStatusController.text),
      questEndStatus: _pi(questEndStatusController.text),
    );
  }

  Future<void> create() async {
    try {
      resetForm();
      selectedIndex.value = null;
    } catch (e) {
      LoggerUtil.instance.e('法术区域-创建失败: $e');
      DialogUtil.instance.error('法术区域-创建失败: $e');
    }
  }

  void edit() {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final area = items.value[index];
    fillForm(area);
  }

  Future<void> copy(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final area = items.value[index];
    try {
      await _repository.copySpellArea(area);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('复制成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  Future<void> delete(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    final area = items.value[index];
    final confirmed = await showShadDialog<bool>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text('确认删除'),
        description: Text('确定要删除这条区域技能记录吗？'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('取消'),
          ),
          ShadButton.destructive(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await _repository.destroySpellArea(
          area.spell,
          area.area,
          area.questStart,
          area.auraSpell,
          area.racemask,
          area.gender,
        );
        await load();
        if (!context.mounted) return;
        var toast = ShadToast(description: Text('删除成功'));
        ShadSonner.of(context).show(toast);
      } catch (e) {
        if (!context.mounted) return;
        var toast = ShadToast(description: Text(e.toString()));
        ShadSonner.of(context).show(toast);
      }
    }
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = collectFromForm();
      await _repository.storeSpellArea(data);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('保存成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  Future<void> update(BuildContext context) async {
    final index = selectedIndex.value;
    if (index == null || index < 0 || index >= items.value.length) return;
    try {
      final oldData = items.value[index];
      final newData = collectFromForm();
      await _repository.updateSpellArea(oldData, newData);
      await load();
      if (!context.mounted) return;
      var toast = ShadToast(description: Text('更新成功'));
      ShadSonner.of(context).show(toast);
    } catch (e) {
      if (!context.mounted) return;
      var toast = ShadToast(description: Text(e.toString()));
      ShadSonner.of(context).show(toast);
    }
  }

  void selectRow(int index) {
    if (index >= 0 && index < items.value.length) {
      selectedIndex.value = index;
    }
  }

  Future<void> initSignals({required int spellId}) async {
    try {
      this.spellId.value = spellId;
      await load();
    } catch (e) {
      LoggerUtil.instance.e('法术区域-初始化失败: $e');
      DialogUtil.instance.error('法术区域-初始化失败: $e');
    }
  }

  void pop() {
    routerFacade.goBack();
  }

  void dispose() {
    areaController.dispose();
    auraSpellController.dispose();
    autocastController.dispose();
    genderController.dispose();
    questEndController.dispose();
    questEndStatusController.dispose();
    questStartController.dispose();
    questStartStatusController.dispose();
    racemaskController.dispose();
  }
}
