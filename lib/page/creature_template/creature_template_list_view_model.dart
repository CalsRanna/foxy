import 'package:flutter/widgets.dart';
import 'package:foxy/model/creature_template.dart';
import 'package:foxy/model/creature_template_filter_entity.dart';
import 'package:foxy/repository/creature_template_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger.dart';
import 'package:signals_flutter/signals_core.dart';

class CreatureTemplateListViewModel {
  final entryController = TextEditingController();
  final nameController = TextEditingController();
  final subNameController = TextEditingController();
  final repository = CreatureTemplateRepository();

  final page = signal(1);
  final templates = signal(<BriefCreatureTemplate>[]);
  final total = signal(0);
  final selectedRowIndex = signal(-1);

  Future<void> copyCreatureTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制编号为 $entry 的生物模板？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copyCreatureTemplate(entry);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      await DialogUtil.instance.dismiss();
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteCreatureTemplate(int entry) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除编号为 $entry 的生物模板？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroyCreatureTemplate(entry);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      await DialogUtil.instance.dismiss();
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryController.dispose();
    nameController.dispose();
    subNameController.dispose();
  }

  Future<void> initSignals() async {
    templates.value = await repository.getBriefCreatureTemplates();
    total.value = await repository.count();
  }

  void navigateCreatureTemplateDetailPage(BuildContext context, {int? entry}) {
    CreatureTemplateDetailRoute(entry: entry).push(context);
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    templates.value = await repository.getBriefCreatureTemplates(page: page);
    total.value = await repository.count();
  }

  Future<void> reset() async {
    entryController.clear();
    nameController.clear();
    subNameController.clear();
    page.value = 1;
    templates.value = await repository.getBriefCreatureTemplates();
    total.value = await repository.count();
  }

  Future<void> search() async {
    page.value = 1;
    var filter = CreatureTemplateFilterEntity()
      ..entry = entryController.text
      ..name = nameController.text
      ..subName = subNameController.text;
    templates.value = await repository.getBriefCreatureTemplates(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.count(filter: filter);
  }

  Future<void> _refresh() async {
    var filter = CreatureTemplateFilterEntity()
      ..entry = entryController.text
      ..name = nameController.text
      ..subName = subNameController.text;
    templates.value = await repository.getBriefCreatureTemplates(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.count(filter: filter);
  }
}
