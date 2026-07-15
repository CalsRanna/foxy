import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:foxy/widget/form/validation/page_text_entity_validation_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

class PageTextDetailViewModel
    with
        ViewModelValidationMixin,
        PageTextValidationMixin,
        FieldControllerMixin {
  final routerFacade = GetIt.instance.get<RouterFacade>();
  final _repository = GetIt.instance.get<PageTextRepository>();

  late final idController = registerController(IntFieldController());
  late final textController = registerController(StringFieldController());
  late final nextPageIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  final page = signal<PageTextEntity?>(null);

  Future<void> initSignals({int? id}) async {
    try {
      if (id == null || id <= 0) {
        final blank = await _repository.createPageText();
        page.value = blank;
        _initControllers(blank);
        return;
      }
      final entity = await _repository.getPageText(id);
      if (entity == null) return;
      page.value = entity;
      _initControllers(entity);
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

  Future<int?> save(BuildContext context) async {
    try {
      final data = _collect();
      validatePageTextFields(data);
      final existed = await _repository.getPageText(data.id);
      late final PageTextEntity saved;
      if (existed == null) {
        final id = await _repository.storePageText(data);
        idController.init(id);
        saved = data.copyWith(id: id);
        page.value = saved;
        _logActivity(ActivityActionType.create, saved);
      } else {
        saved = data.copyWith(id: existed.id);
        await _repository.updatePageText(saved);
        page.value = saved;
        _logActivity(ActivityActionType.update, saved);
      }
      if (context.mounted) {
        ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
      }
      return saved.id;
    } catch (e) {
      if (context.mounted) {
        ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
      }
      return null;
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
