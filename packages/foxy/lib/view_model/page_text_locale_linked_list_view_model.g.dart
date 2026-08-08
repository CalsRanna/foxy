// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_locale_linked_list_view_model.dart';

mixin _PageTextLocaleLinkedListViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final localeController = registerController(
    SelectFieldController<String>(fallback: 'zhCN'),
  );
  late final textController = registerController(StringFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void _afterApplyCandidate(PageTextLocaleEntity pageTextLocale) {}

  void _applyCandidate(PageTextLocaleEntity pageTextLocale) {
    idController.init(pageTextLocale.id);
    localeController.init(pageTextLocale.locale);
    textController.init(pageTextLocale.text);
    verifiedBuildController.init(pageTextLocale.verifiedBuild);
    _afterApplyCandidate(pageTextLocale);
  }

  PageTextLocaleEntity _collectCandidate() {
    return PageTextLocaleEntity(
      id: idController.collect(),
      locale: localeController.collect(),
      text: textController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    PageTextLocaleEntity pageTextLocale,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'page_text_locale',
          actionType: action,
          entityName: 'PageTextLocale',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
