import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/util/field_controller.dart';
import 'package:foxy/util/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PageTextDetailViewModel with FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<PageTextRepository>();

  late final idController = registerController(IntFieldController());
  late final textController = registerController(StringFieldController());
  late final nextPageIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  final page = signal<PageTextEntity?>(null);
  final locales = signal<List<PageTextLocaleEntity>>([]);

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createPageText();
        page.value = blank;
        _initControllers(blank);
        locales.value = [];
        return;
      }
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
    idController.init(pt.id);
    textController.init(pt.text);
    nextPageIdController.init(pt.nextPageId);
    verifiedBuildController.init(pt.verifiedBuild);
  }

  Future<void> save(BuildContext context) async {
    try {
      final data = _collect();
      // create* 预填 id 后 page 非 null，必须用库内是否存在判断新建
      final existed = await _repository.getPageText(data.id);
      if (existed == null) {
        final id = await _repository.storePageText(data);
        idController.init(id);
        page.value = data.copyWith(id: id);
        _logActivity(ActivityActionType.create, page.value!);
      } else {
        final updated = data.copyWith(id: existed.id);
        await _repository.updatePageText(updated);
        page.value = updated;
        _logActivity(ActivityActionType.update, updated);
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
      id: idController.collect(),
      text: textController.collect(),
      nextPageId: nextPageIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void dispose() {
    disposeControllers();
  }
}
