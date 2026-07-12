import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
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
  final _repository = GetIt.instance.get<PageTextRepository>();

  final idController = TextEditingController();
  final textController = TextEditingController();
  final nextPageIdController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final page = signal<PageTextEntity?>(null);
  final locales = signal<List<PageTextLocaleEntity>>([]);
  String _fmt(num v) => formatNum(v);

  int _pi(String t, [String field = '']) => parseIntField(t, field: field);

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      final entity = await _repository.getPageText(id);
      if (entity == null) return;
      page.value = entity;
      _initControllers(entity);
      locales.value = await _repository.getPageTextLocales(id);
    } catch (e, s) {
      LoggerUtil.instance.e('加载页面文本(ID=$id)失败', error: e, stackTrace: s);
    }
  }

  void _initControllers(PageTextEntity pt) {
    idController.text = _fmt(pt.id);
    textController.text = pt.text;
    nextPageIdController.text = _fmt(pt.nextPageId);
    verifiedBuildController.text = _fmt(pt.verifiedBuild);
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collect();
      final existing = page.value;
      if (existing != null) {
        final updated = data.copyWith(id: existing.id);
        await _repository.updatePageText(updated);
        page.value = updated;
        _logActivity(ActivityActionType.update, updated);
      } else {
        final id = await _repository.storePageText(data);
        idController.text = '$id';
        page.value = data.copyWith(id: id);
        _logActivity(ActivityActionType.create, data);
      }
      if (!context.mounted) return;
      ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  PageTextEntity _collect() {
    return PageTextEntity(
      id: _pi(idController.text),
      text: textController.text,
      nextPageId: _pi(nextPageIdController.text),
      verifiedBuild: _pi(verifiedBuildController.text),
    );
  }

  void dispose() {
    idController.dispose();
    nextPageIdController.dispose();
    textController.dispose();
    verifiedBuildController.dispose();
  }
}
