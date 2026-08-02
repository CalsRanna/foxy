import 'collection_editor_model.dart';
import 'naming.dart';
import 'form_emitter.dart';
import 'form_model.dart';

final class CollectionEditorEmitter {
  const CollectionEditorEmitter();

  /// 成员顺序遵循 "Sort Members" 规则:字段(_repository → 父键/列表
  /// 状态信号 → controller → 私有 token)在前,公开方法按名(copy →
  /// create → destroy → dispose → edit → initSignals → paginate →
  /// persist → setParentKey),私有方法按名(_afterApplyCandidate →
  /// _applyCandidate → _collectCandidate → _refresh)。
  String emit(CollectionEditorGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} on FieldControllerMixin {')
      ..writeln(
        '  final _repository = GetIt.instance.get<${model.repositoryClassName}>();',
      )
      ..writeln()
      ..writeln('  final parentKey = signal<${model.parentKeyType}?>(null);')
      ..writeln()
      ..writeln('  final items = signal(<${model.briefEntityClassName}>[]);')
      ..writeln()
      ..writeln('  final editingKey = signal<${model.keyType}?>(null);')
      ..writeln()
      ..writeln('  final selectedKey = signal<${model.keyType}?>(null);')
      ..writeln()
      ..writeln('  final page = signal(1);')
      ..writeln()
      ..writeln('  final total = signal(0);')
      ..writeln()
      ..writeln('  final loading = signal(false);')
      ..writeln()
      ..writeln('  final submitting = signal(false);')
      ..writeln()
      ..writeln('  final errorMessage = signal<String?>(null);')
      ..writeln();

    // controller 样板复用 FormEmitter(关闭行为骨架)。
    final form = FormGenerationModel(
      className: model.className,
      entityClassName: model.entityClassName,
      mixinName: model.mixinName,
      fields: model.fields,
      skeletonEnabled: false,
      repositoryClassName: '',
      keyType: '',
      singleKeyFieldName: null,
    );
    final formMixin = const FormEmitter().emit(form);
    final bodyStart = formMixin.indexOf('{') + 1;
    final bodyEnd = formMixin.lastIndexOf('}');
    buffer.write(formMixin.substring(bodyStart, bodyEnd));

    buffer
      ..writeln('  int _refreshToken = 0;')
      ..writeln('  int _interactionToken = 0;')
      ..writeln()
      ..writeln('  Future<void> copy(${model.keyType} key) async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final parent = parentKey.value;')
      ..writeln(
        "    if (parent == null) throw ParentNotLoadedException('parent record not loaded');",
      )
      ..writeln('    final token = ++_interactionToken;')
      ..writeln('    submitting.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      await _repository.copy${model.baseName}(key);')
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) return;',
      )
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      errorMessage.value = foxyErrorMessage(error);')
      ..writeln('      rethrow;')
      ..writeln('    } finally {')
      ..writeln('      submitting.value = false;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> create() async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final parent = parentKey.value;')
      ..writeln(
        "    if (parent == null) throw ParentNotLoadedException('parent record not loaded');",
      )
      ..writeln('    final token = ++_interactionToken;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln(
        '      final candidate = await _repository.create${model.baseName}(parent);',
      )
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) return;',
      )
      ..writeln('      editingKey.value = null;')
      ..writeln('      selectedKey.value = null;')
      ..writeln('      _applyCandidate(candidate);')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      errorMessage.value = foxyErrorMessage(error);')
      ..writeln('      rethrow;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> destroy(${model.keyType} key) async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final parent = parentKey.value;')
      ..writeln(
        "    if (parent == null) throw ParentNotLoadedException('parent record not loaded');",
      )
      ..writeln('    final token = ++_interactionToken;')
      ..writeln('    submitting.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      await _repository.destroy${model.baseName}(key);')
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) return;',
      )
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      errorMessage.value = foxyErrorMessage(error);')
      ..writeln('      rethrow;')
      ..writeln('    } finally {')
      ..writeln('      submitting.value = false;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln()
      ..writeln('  void dispose() => disposeControllers();')
      ..writeln()
      ..writeln('  Future<void> edit(${model.keyType} key) async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final parent = parentKey.value;')
      ..writeln(
        "    if (parent == null) throw ParentNotLoadedException('parent record not loaded');",
      )
      ..writeln('    final token = ++_interactionToken;')
      ..writeln('    editingKey.value = key;')
      ..writeln('    selectedKey.value = key;')
      ..writeln('    loading.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln(
        '      final candidate = await _repository.get${model.baseName}(key);',
      )
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) return;',
      )
      ..writeln('      if (candidate == null) {')
      ..writeln("        throw RecordNotFoundException('record not found');")
      ..writeln('      }')
      ..writeln('      _applyCandidate(candidate);')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      editingKey.value = null;')
      ..writeln('      errorMessage.value = foxyErrorMessage(error);')
      ..writeln('      rethrow;')
      ..writeln('    } finally {')
      ..writeln('      if (token == _interactionToken) loading.value = false;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln()
      ..writeln(
        '  Future<void> initSignals({required ${model.parentKeyType} parentKey}) '
        '=> setParentKey(parentKey);',
      )
      ..writeln()
      ..writeln('  Future<void> paginate(int page) async {')
      ..writeln('    _interactionToken++;')
      ..writeln('    this.page.value = page;')
      ..writeln('    await _refresh();')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> persist() async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final parent = parentKey.value;')
      ..writeln(
        "    if (parent == null) throw ParentNotLoadedException('parent record not loaded');",
      )
      ..writeln('    final candidate = _collectCandidate();')
      ..writeln('    final originalKey = editingKey.value;')
      ..writeln('    final token = ++_interactionToken;')
      ..writeln('    submitting.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      if (originalKey == null) {')
      ..writeln('        await _repository.store${model.baseName}(candidate);')
      ..writeln('      } else {')
      ..writeln(
        '        await _repository.update${model.baseName}('
        'originalKey, candidate);',
      )
      ..writeln('      }')
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) return;',
      )
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token != _interactionToken || parentKey.value != parent) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      errorMessage.value = foxyErrorMessage(error);')
      ..writeln('      rethrow;')
      ..writeln('    } finally {')
      ..writeln('      submitting.value = false;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln()
      ..writeln(
        '  Future<void> setParentKey(${model.parentKeyType} parentKey) async {',
      )
      ..writeln('    _interactionToken++;')
      ..writeln('    if (this.parentKey.value != parentKey) page.value = 1;')
      ..writeln('    this.parentKey.value = parentKey;')
      ..writeln('    final parent = parentKey;')
      ..writeln('    editingKey.value = null;')
      ..writeln('    selectedKey.value = null;')
      ..writeln(
        '    _applyCandidate(${model.entityClassName}('
        '${model.parentFieldName}: parent));',
      )
      ..writeln('    await _refresh();')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> _refresh() async {')
      ..writeln('    final parent = parentKey.value;')
      ..writeln('    if (parent == null) return;')
      ..writeln('    final currentPage = page.value;')
      ..writeln('    final token = ++_refreshToken;')
      ..writeln('    loading.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln(
        '      final count = await _repository.count${pluralize(model.baseName)}(parent);',
      )
      ..writeln('      if (token != _refreshToken) return;')
      ..writeln(
        '      final lastPage = max(1, (count / _repository.kPageSize).ceil());',
      )
      ..writeln('      final nextPage = min(currentPage, lastPage);')
      ..writeln(
        '      final data = await _repository.getBrief${pluralize(model.baseName)}('
        'parent, page: nextPage);',
      )
      ..writeln('      if (token != _refreshToken) return;')
      ..writeln('      page.value = nextPage;')
      ..writeln('      items.value = data;')
      ..writeln('      total.value = count;')
      ..writeln('      editingKey.value = null;')
      ..writeln('      selectedKey.value = null;')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token == _refreshToken) errorMessage.value = '
        'foxyErrorMessage(error);',
      )
      ..writeln('      rethrow;')
      ..writeln('    } finally {')
      ..writeln('      if (token == _refreshToken) loading.value = false;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }
}
