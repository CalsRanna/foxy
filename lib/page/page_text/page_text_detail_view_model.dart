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
  final _repository = GetIt.instance.get<PageTextRepository>();

  final idController = TextEditingController();
  final textController = TextEditingController();
  final nextPageIdController = TextEditingController();
  final verifiedBuildController = TextEditingController();

  final page = signal<PageTextEntity?>(null);
  final locales = signal<List<PageTextLocaleEntity>>([]);
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

  Future<void> initSignals({int? id}) async {
    if (id == null) return;
    try {
      page.value = await _repository.getPageText(id);
      _initControllers(page.value!);
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
        await _repository.updatePageText(existing.id, data);
        page.value = data;
        _logActivity(ActivityActionType.update, data);
      } else {
        await _repository.storePageText(data);
        page.value = data;
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
    GetIt.instance.get<ActivityLogRepository>().storeActivityLog(log);
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
