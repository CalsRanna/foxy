import 'dart:math';

import 'package:foxy/constant/page_text_constants.dart';
import 'package:foxy/entity/page_text_locale_entity.dart';
import 'package:foxy/repository/page_text_locale_repository.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/form/validation/page_text_locale_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

class PageTextLocaleCollectionEditorViewModel
    with
        ViewModelValidationMixin,
        PageTextLocaleValidationMixin,
        FieldControllerMixin {
  final _repository = GetIt.instance.get<PageTextLocaleRepository>();

  final parentKey = signal<int?>(null);
  final items = signal<List<BriefPageTextLocaleEntity>>([]);
  final editingKey = signal<PageTextLocaleKey?>(null);
  final selectedKey = signal<PageTextLocaleKey?>(null);
  final page = signal(1);
  final total = signal(0);
  final loading = signal(false);
  final submitting = signal(false);
  final errorMessage = signal<String?>(null);

  late final idController = registerController(IntFieldController());
  late final localeController = registerController(
    SelectFieldController<String>(fallback: 'zhCN'),
  );
  late final textController = registerController(StringFieldController());
  late final verifiedBuildController = registerController(IntFieldController());

  int _refreshToken = 0;
  int _interactionToken = 0;

  Future<void> initSignals({required int parentKey}) => setParentKey(parentKey);

  Future<void> setParentKey(int parentKey) async {
    _interactionToken++;
    if (this.parentKey.value != parentKey) page.value = 1;
    this.parentKey.value = parentKey;
    editingKey.value = null;
    selectedKey.value = null;
    _applyCandidate(PageTextLocaleEntity(id: parentKey, locale: 'zhCN'));
    await _refresh();
  }

  Future<void> create() async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    errorMessage.value = null;
    try {
      final usedLocales = items.value.map((item) => item.locale).toSet();
      final availableLocales = kPageTextLocaleOptions.keys.where(
        (locale) => !usedLocales.contains(locale),
      );
      if (availableLocales.isEmpty) {
        throw StateError('所有支持的本地化语言均已存在');
      }
      final candidate = await _repository.createPageTextLocale(
        id: parent,
        locale: availableLocales.first,
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

  Future<void> edit(PageTextLocaleKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    editingKey.value = key;
    selectedKey.value = key;
    loading.value = true;
    errorMessage.value = null;
    try {
      final candidate = await _repository.getPageTextLocale(key);
      if (token != _interactionToken || parentKey.value != parent) return;
      if (candidate == null) {
        throw StateError('原本地化记录不存在，可能已被其他操作修改或删除');
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
    validatePageTextLocaleFields(candidate);
    final originalKey = editingKey.value;
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      if (originalKey == null) {
        await _repository.storePageTextLocale(candidate);
      } else {
        await _repository.updatePageTextLocale(originalKey, candidate);
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

  Future<void> destroy(PageTextLocaleKey key) async {
    if (submitting.value) throw StateError('正在提交，请稍候');
    final parent = parentKey.value;
    if (parent == null) throw StateError('父记录尚未加载');
    final token = ++_interactionToken;
    submitting.value = true;
    errorMessage.value = null;
    try {
      await _repository.destroyPageTextLocale(key);
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

  PageTextLocaleEntity _collectCandidate() {
    return PageTextLocaleEntity(
      id: idController.collect(),
      locale: localeController.collect(),
      text: textController.collect(),
      verifiedBuild: verifiedBuildController.collect(),
    );
  }

  void _applyCandidate(PageTextLocaleEntity candidate) {
    idController.init(candidate.id);
    localeController.init(candidate.locale);
    textController.init(candidate.text);
    verifiedBuildController.init(candidate.verifiedBuild);
  }

  Future<void> _refresh() async {
    final parent = parentKey.value;
    if (parent == null) return;
    final currentPage = page.value;
    final token = ++_refreshToken;
    loading.value = true;
    errorMessage.value = null;
    try {
      final count = await _repository.countPageTextLocales(parent);
      if (token != _refreshToken) return;
      final lastPage = max(1, (count / _repository.kPageSize).ceil());
      final nextPage = min(currentPage, lastPage);
      final data = await _repository.getBriefPageTextLocales(
        id: parent,
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
