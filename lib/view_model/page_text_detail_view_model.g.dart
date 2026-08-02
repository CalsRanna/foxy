// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_text_detail_view_model.dart';

mixin _PageTextDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<PageTextRepository>();

  final entity = signal<PageTextEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final textController = registerController(StringFieldController());
  late final nextPageIdController = registerController(IntFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createPageText();
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getPageText(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = foxyErrorMessage(error);
      LoggerUtil.instance.e('加载详情失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) {
      throw BusyException('operation already in progress');
    }
    submitting.value = true;
    errorMessage.value = null;
    try {
      final candidate = _collectCandidate();
      final originalKey = persistedKey.value;
      final action = originalKey == null
          ? ActivityActionType.create
          : ActivityActionType.update;
      if (originalKey == null) {
        await _repository.storePageText(candidate);
      } else {
        await _repository.updatePageText(originalKey, candidate);
      }
      persistedKey.value = candidate.id;
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = foxyErrorMessage(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

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

  void _logActivity(ActivityActionType action, PageTextEntity pageText) {}
}
