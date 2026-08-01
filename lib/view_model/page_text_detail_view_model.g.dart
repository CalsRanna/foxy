// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_detail_view_model.dart';

mixin _PageTextDetailViewModelMixin on FieldControllerMixin {
  late final idController = registerController(IntFieldController());
  late final textController = registerController(StringFieldController());
  late final nextPageIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void _afterApplyCandidate(PageTextEntity pageText) {}

  void _applyCandidate(PageTextEntity pageText) {
    idController.init(pageText.id);
    textController.init(pageText.text);
    nextPageIdController.init(pageText.nextPageId);
    verifiedBuildController.init(pageText.verifiedBuild);
    _afterApplyCandidate(pageText);
  }

  PageTextEntity _collectCandidate() {
    return PageTextEntity(
      id: idController.collect(),
      text: textController.collect(),
      nextPageId: nextPageIdController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }
}
