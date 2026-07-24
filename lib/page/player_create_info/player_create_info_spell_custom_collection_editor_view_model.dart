import 'dart:math';
import 'package:foxy/entity/player_create_info_spell_custom_entity.dart';
import 'package:foxy/entity/player_create_info_entity.dart';
import 'package:foxy/repository/player_create_info_spell_custom_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/player_create_info_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PlayerCreateInfoSpellCustomCollectionEditorViewModel
    with
        ViewModelValidationMixin,
        PlayerCreateInfoSpellCustomValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance
      .get<PlayerCreateInfoSpellCustomRepository>();

  final parentKey = signal<PlayerCreateInfoKey?>(null);
  final items = signal<List<BriefPlayerCreateInfoSpellCustomEntity>>([]);
  final editingKey = signal<PlayerCreateInfoSpellCustomKey?>(null);
  final selectedKey = signal<PlayerCreateInfoSpellCustomKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final racemaskController = registerController(FlagFieldController());
  late final classmaskController = registerController(FlagFieldController());
  late final spellController = registerController(IntFieldController());
  late final noteController = registerController(StringFieldController());

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> initSignals({required PlayerCreateInfoKey parentKey}) =>
      setParentKey(parentKey);

  Future<void> setParentKey(PlayerCreateInfoKey parentKey) async {
    _interactionToken++;
    if (this.parentKey.value != parentKey) page.value = 1;
    this.parentKey.value = parentKey;
    final parent = parentKey;
    editingKey.value = null;
    selectedKey.value = null;
    _applyCandidate(
      PlayerCreateInfoSpellCustomEntity(
        raceMask: parent.race,
        classMask: parent.class_,
      ),
    );
    await _refresh();
  }

  Future<void> create() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final candidate = await _repository.createPlayerCreateInfoSpellCustom(
        parent.race,
        parent.class_,
      );
      if (token != _interactionToken || parentKey.value != parent) return;
      editingKey.value = null;
      selectedKey.value = null;
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    }
  }

  Future<void> edit(PlayerCreateInfoSpellCustomKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getPlayerCreateInfoSpellCustom(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      if (candidate == null) {
        throw StateError('原记录不存在，可能已被其他操作修改或删除');
      }
      _applyCandidate(candidate);
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      editingKey.value = null;
      errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _interactionToken) loading.value = false;
    }
  }

  Future<void> persist() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final candidate = _collectCandidate();
    validatePlayerCreateInfoSpellCustomFields(candidate);
    final originalKey = editingKey.value;
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storePlayerCreateInfoSpellCustom(candidate);
      } else {
        await _repository.updatePlayerCreateInfoSpellCustom(
          originalKey,
          candidate,
        );
      }
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> destroy(PlayerCreateInfoSpellCustomKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyPlayerCreateInfoSpellCustom(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      await _refresh();
    } catch (error) {
      if (token != _interactionToken || parentKey.value != parent) {
        return;
      }
      errorMessage.value = '$error';
      rethrow;
    } finally {
      submitting.value = false;
    }
  }

  Future<void> paginate(int page) async {
    _interactionToken++;
    this.page.value = page;
    await _refresh();
  }

  PlayerCreateInfoSpellCustomEntity _collectCandidate() =>
      PlayerCreateInfoSpellCustomEntity(
        raceMask: racemaskController.collect(),
        classMask: classmaskController.collect(),
        spell: spellController.collect(),
        note: noteController.collect(),
      );

  void _applyCandidate(PlayerCreateInfoSpellCustomEntity item) {
    racemaskController.init(item.raceMask);
    classmaskController.init(item.classMask);
    spellController.init(item.spell);
    noteController.init(item.note);
  }

  Future<void> _refresh() async {
    final parent = parentKey.value;
    if (parent == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countPlayerCreateInfoSpellCustoms(
        parent.race,
        parent.class_,
      );
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefPlayerCreateInfoSpellCustoms(
        parent.race,
        parent.class_,
        page: nextPage,
      );
      if (token != _refreshToken) return;
      page.value = nextPage;
      items.value = data;
      total.value = count;
      editingKey.value = null;
      selectedKey.value = null;
    } catch (error) {
      if (token == _refreshToken) errorMessage.value = '$error';
      rethrow;
    } finally {
      if (token == _refreshToken) loading.value = false;
    }
  }

  void dispose() => disposeControllers();
}
