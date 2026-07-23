import 'package:foxy/entity/spell_bonus_data_entity.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/spell_bonus_data_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class SpellBonusDataSingleEditorViewModel with FieldControllerMixin {
  final _repository = GetIt.instance.get<SpellBonusDataRepository>();

  final parentKey = signal<int?>(null);
  final editingKey = signal<int?>(null);
  final entity = signal<SpellBonusDataEntity?>(null);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final spellIdController = registerController(IntFieldController());
  late final directBonusController = registerController(
    DoubleFieldController(),
  );
  late final dotBonusController = registerController(DoubleFieldController());
  late final apBonusController = registerController(DoubleFieldController());
  late final apDotBonusController = registerController(DoubleFieldController());
  late final commentsController = registerController(StringFieldController());

  int _refreshToken = 0;
  int _parentToken = 0;

  Future<void> initSignals({required int parentKey}) {
    return setParentKey(parentKey);
  }

  Future<void> setParentKey(int parentKey) async {
    if (this.parentKey.value == parentKey && entity.value != null) return;
    _parentToken++;
    this.parentKey.value = parentKey;
    editingKey.value = null;
    await _refresh();
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在保存，请稍候');
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) throw StateError('父记录尚未加载');
    final parentToken = _parentToken;
    final candidate = _collectCandidate();
    final originalKey = editingKey.value;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storeSpellBonusData(candidate);
      } else {
        await _repository.updateSpellBonusData(originalKey, candidate);
      }
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      entity.value = candidate;
      editingKey.value = candidate.entry;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final key = editingKey.value;
    if (key == null) return;
    final parentSnapshot = parentKey.value;
    final parentToken = _parentToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroySpellBonusData(key);
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      editingKey.value = null;
      await _refresh();
    } catch (error) {
      if (parentToken != _parentToken ||
          parentKey.value != parentSnapshot) {
        return;
      }
      errorMessage.value = error.toString();
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

SpellBonusDataEntity _collectCandidate() {
    return SpellBonusDataEntity(
      entry: spellIdController.collect(),
      directBonus: directBonusController.collect(),
      dotBonus: dotBonusController.collect(),
      apBonus: apBonusController.collect(),
      apDotBonus: apDotBonusController.collect(),
      comments: commentsController.collect(),
    );
  }

void _applyCandidate(SpellBonusDataEntity data) {
    spellIdController.init(data.entry);
    directBonusController.init(data.directBonus);
    dotBonusController.init(data.dotBonus);
    apBonusController.init(data.apBonus);
    apDotBonusController.init(data.apDotBonus);
    commentsController.init(data.comments);
  }

  Future<void> _refresh() async {
    final token = ++_refreshToken;
    final parentSnapshot = parentKey.value;
    if (parentSnapshot == null) {
      entity.value = null;
      editingKey.value = null;
      return;
    }
    loading.value = true;
    errorMessage.value = null;
    try {
      final existing = await _repository.getSpellBonusData(parentSnapshot);
      if (token != _refreshToken) return;
      final candidate =
          existing ?? await _repository.createSpellBonusData(parentSnapshot);
      if (token != _refreshToken) return;
      entity.value = candidate;
      editingKey.value = existing == null ? null : parentSnapshot;
      _applyCandidate(candidate);
    } catch (error, stackTrace) {
      if (token != _refreshToken) return;
      errorMessage.value = error.toString();
      LoggerUtil.instance.e('加载单行编辑器失败', error: error, stackTrace: stackTrace);
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() {
    disposeControllers();
  }
}
