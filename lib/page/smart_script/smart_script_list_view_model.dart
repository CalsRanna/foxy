import 'package:flutter/widgets.dart';
import 'package:foxy/model/smart_script.dart';
import 'package:foxy/model/smart_script_filter_entity.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/router/router.gr.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/util/dialog_util.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:signals_flutter/signals_core.dart';

class SmartScriptListViewModel {
  final entryOrGuidController = TextEditingController();
  final commentController = TextEditingController();
  final repository = SmartScriptRepository();

  final page = signal(1);
  final templates = signal(<BriefSmartScript>[]);
  final total = signal(0);
  final selectedRowIndex = signal(-1);

  Future<void> copySmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认复制',
        description: '是否复制该脚本行（entryorguid=$entryOrGuid, id=$id）？',
        confirmText: '复制',
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.copySmartScript(entryOrGuid, sourceType, id, link);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('复制成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('复制失败: ${e.toString()}');
    }
  }

  Future<void> deleteSmartScript(
    int entryOrGuid,
    int sourceType,
    int id,
    int link,
  ) async {
    try {
      final confirmed = await DialogUtil.instance.confirm(
        title: '确认删除',
        description: '是否删除脚本行（entryorguid=$entryOrGuid, id=$id）？此操作不可撤销。',
        confirmText: '删除',
        destructive: true,
      );
      if (!confirmed) return;
      DialogUtil.instance.loading();
      await repository.destroySmartScript(entryOrGuid, sourceType, id, link);
      await DialogUtil.instance.dismiss();
      DialogUtil.instance.success('删除成功');
      await _refresh();
    } catch (e) {
      logger.e(e.toString());
      DialogUtil.instance.error('删除失败: ${e.toString()}');
    }
  }

  void dispose() {
    entryOrGuidController.dispose();
    commentController.dispose();
  }

  Future<void> initSignals() async {
    templates.value = await repository.getBriefSmartScripts();
    total.value = await repository.count();
  }

  void navigateToDetail({
    int? entryOrGuid,
    int? sourceType,
    int? id,
    int? link,
  }) {
    final routerFacade = GetIt.instance.get<RouterFacade>();
    final isNew = entryOrGuid == null;
    final label = isNew ? '新建脚本' : '脚本 $entryOrGuid/$sourceType/$id/$link';
    final detailId = isNew
        ? 'smart_new'
        : 'smart_${entryOrGuid}_${sourceType}_${id}_$link';
    routerFacade.navigateToDetail(
      id: detailId,
      label: label,
      route: SmartScriptDetailRoute(
        entryOrGuid: entryOrGuid,
        sourceType: sourceType,
        id: id,
        link: link,
      ),
      parentMenu: RouterMenu.smartScript,
    );
  }

  Future<void> paginate(int page) async {
    this.page.value = page;
    var filter = SmartScriptFilterEntity()
      ..entryOrGuid = entryOrGuidController.text
      ..comment = commentController.text;
    templates.value = await repository.getBriefSmartScripts(
      page: page,
      filter: filter,
    );
    total.value = await repository.count(filter: filter);
  }

  Future<void> reset() async {
    entryOrGuidController.clear();
    commentController.clear();
    page.value = 1;
    templates.value = await repository.getBriefSmartScripts();
    total.value = await repository.count();
  }

  Future<void> search() async {
    page.value = 1;
    var filter = SmartScriptFilterEntity()
      ..entryOrGuid = entryOrGuidController.text
      ..comment = commentController.text;
    templates.value = await repository.getBriefSmartScripts(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.count(filter: filter);
  }

  Future<void> _refresh() async {
    var filter = SmartScriptFilterEntity()
      ..entryOrGuid = entryOrGuidController.text
      ..comment = commentController.text;
    templates.value = await repository.getBriefSmartScripts(
      page: page.value,
      filter: filter,
    );
    total.value = await repository.count(filter: filter);
  }
}
