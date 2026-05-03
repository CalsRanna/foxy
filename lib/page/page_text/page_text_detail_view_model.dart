import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PageTextDetailViewModel {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final repository = PageTextRepository();

  final id = signal<int>(0);
  final textController = TextEditingController();
  final nextPageId = signal<int>(0);
  final verifiedBuild = signal<int>(0);

  final page = signal<PageTextEntity?>(null);
  final locales = signal<List<PageTextLocaleEntity>>([]);
  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      page.value = await repository.getPageText(id);
      _initControllers(page.value!);
      locales.value = await repository.getLocales(id);
    } catch (e, s) {
      LoggerUtil.instance.e('加载页面文本(ID=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(PageTextEntity pt) {
    id.value = pt.id;
    textController.text = pt.text;
    nextPageId.value = pt.nextPageId;
    verifiedBuild.value = pt.verifiedBuild;
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collect();
      await repository.storePageText(data);
      page.value = data;
      _logActivity(ActivityActionType.create, data);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('页面文本已保存')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  Future<void> update(BuildContext context) async {
    final id = page.value?.id ?? 0;
    if (id == 0) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('记录未加载，无法更新')));
      return;
    }
    try {
      final data = _collect();
      await repository.updatePageText(id, data);
      page.value = data;
      _logActivity(ActivityActionType.update, data);
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('更新成功')));
    } catch (e) {
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
    }
  }

  void pop() => routerFacade.goBack();

  void _logActivity(ActivityActionType action, PageTextEntity t) {
    final log = ActivityLogEntity(
      module: 'page_text',
      actionType: action,
      entityId: t.id,
      entityName: t.text,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
  }

  PageTextEntity _collect() {
    return PageTextEntity(
      id: id.value,
      text: textController.text,
      nextPageId: nextPageId.value,
      verifiedBuild: verifiedBuild.value,
    );
  }

  void dispose() {
    textController.dispose();
  }
}
