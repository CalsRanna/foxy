// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glyph_property_detail_view_model.dart';

mixin _GlyphPropertyDetailViewModelMixin on FieldControllerMixin {
  final _repository = GetIt.instance.get<GlyphPropertyRepository>();

  final entity = signal<GlyphPropertyEntity?>(null);

  final persistedKey = signal<int?>(null);

  final loading = signal(false);

  final submitting = signal(false);

  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final spellIdController = registerController(IntFieldController());
  late final glyphSlotFlagsController = registerController(
    SelectFieldController<int>(fallback: 0),
  );
  late final spellIconIdController = registerController(IntFieldController());

  void dispose() {
    disposeControllers();
  }

  Future<void> initSignals({int? key}) async {
    loading.value = true;
    errorMessage.value = null;
    try {
      if (key == null) {
        final blank = await _repository.createGlyphProperty();
        if (isDisposed) return;
        entity.value = blank;
        _applyCandidate(blank);
        persistedKey.value = null;
        return;
      }
      final result = await _repository.getGlyphProperty(key);
      if (result == null) {
        throw RecordNotFoundException('record not found');
      }
      if (isDisposed) return;
      entity.value = result;
      _applyCandidate(result);
      persistedKey.value = key;
    } catch (error, stackTrace) {
      errorMessage.value = FoxyExceptions.message(error);
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
        final storedKey = await _repository.storeGlyphProperty(candidate);
        persistedKey.value = storedKey;
      } else {
        await _repository.updateGlyphProperty(originalKey, candidate);
        persistedKey.value = candidate.id;
      }
      entity.value = candidate;
      _logActivity(action, candidate);
    } catch (error) {
      errorMessage.value = FoxyExceptions.message(error);
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  void _afterApplyCandidate(GlyphPropertyEntity glyphProperty) {}

  void _applyCandidate(GlyphPropertyEntity glyphProperty) {
    idController.init(glyphProperty.id);
    spellIdController.init(glyphProperty.spellId);
    glyphSlotFlagsController.init(glyphProperty.glyphSlotFlags);
    spellIconIdController.init(glyphProperty.spellIconId);
    _afterApplyCandidate(glyphProperty);
  }

  GlyphPropertyEntity _collectCandidate() {
    return GlyphPropertyEntity(
      id: idController.collect(),
      spellId: spellIdController.collect(),
      glyphSlotFlags: glyphSlotFlagsController.collect(),
      spellIconId: spellIconIdController.collect(),
    );
  }

  /// Fires the activity-log event after a write; persistence is handled by
  /// the single ActivityLogListener aspect.
  void _logActivity(
    ActivityActionType action,
    GlyphPropertyEntity glyphProperty,
  ) {
    GetIt.instance.get<EventBus>().fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'dbc_glyph_properties',
          actionType: action,
          entityName: 'GlyphProperty ${glyphProperty.id}',
          createdAt: DateTime.now(),
        ),
      ),
    );
  }
}
