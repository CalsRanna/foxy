import 'package:flutter/widgets.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/page_text_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/page_text_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/page_text_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
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
  final persistedKey = signal<int?>(null);

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    try {
      if (key == null) {
        persistedKey.value = null;
        final blank = await _repository.createPageText();
        page.value = blank;
        _initControllers(blank);
        return;
      }
      persistedKey.value = key;
      final entity = await _repository.getPageText(key);
      if (entity == null) {
        throw StateError('原页面文本不存在，可能已被其他操作修改或删除');
      }
      page.value = entity;
      _initControllers(entity);
    } catch (e, s) {
      LoggerUtil.instance.e('加载页面文本(key=$key)失败', error: e, stackTrace: s);
    }
  }

  void pop() => routerFacade.goBack();

  Future<void> persist() async {
    final data = _collect();
    validatePageTextFields(data);
    final originalKey = persistedKey.value;
    final action = originalKey == null
        ? ActivityActionType.create
        : ActivityActionType.update;
    if (originalKey == null) {
      await _repository.storePageText(data);
    } else {
      await _repository.updatePageText(originalKey, data);
    }
    final newKey = data.id;
    persistedKey.value = newKey;
    page.value = data;
    routerFacade.updateCurrentLabel(_labelFor(newKey));
    _logActivity(action, data);
  }

  Future<bool> save(BuildContext context) async {
    try {
      await persist();
      if (context.mounted) {
        ShadSonner.of(context).show(ShadToast(description: Text('保存成功')));
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        ShadSonner.of(context).show(ShadToast(description: Text(e.toString())));
      }
      return false;
    }
  }

  PageTextEntity _collect() {
    return PageTextEntity(
      id: idController.collect(),
      text: textController.collect(),
      nextPageId: nextPageIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _initControllers(PageTextEntity pt) {
    idController.init(pt.id);
    textController.init(pt.text);
    nextPageIdController.init(pt.nextPageId);
    verifiedBuildController.init(pt.verifiedBuild);
  }

  void _logActivity(ActivityActionType action, PageTextEntity t) {
    final log = ActivityLogEntity(
      module: 'page_text',
      actionType: action,
      entityName: t.text,
      createdAt: DateTime.now(),
    );
    GetIt.instance.get<ActivityLogRepository>().storeActivityLogBestEffort(log);
  }

  String _labelFor(int key) => '页面文本 $key';
}
