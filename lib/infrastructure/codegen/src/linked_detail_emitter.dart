import 'form_emitter.dart';
import 'form_model.dart';
import 'linked_detail_model.dart';

final class LinkedDetailEmitter {
  const LinkedDetailEmitter();

  /// 成员顺序遵循 "Sort Members" 规则:字段(_repository → 关联键/编辑键/
  /// entity 状态信号 → controller → 私有 token)在前,公开方法按名(destroy →
  /// dispose → initSignals → persist → setLinkKey),私有方法按名
  /// (_afterApplyCandidate → _applyCandidate → _collectCandidate → _refresh)。
  String emit(LinkedDetailGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName} on FieldControllerMixin {')
      ..writeln(
        '  final _repository = GetIt.instance.get<${model.repositoryClassName}>();',
      )
      ..writeln()
      ..writeln('  final linkKey = signal<${model.keyType}?>(null);')
      ..writeln()
      ..writeln('  final editingKey = signal<${model.keyType}?>(null);')
      ..writeln()
      ..writeln('  final entity = signal<${model.entityClassName}?>(null);')
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
      ..writeln('  int _linkToken = 0;')
      ..writeln()
      ..writeln('  Future<void> destroy() async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final key = editingKey.value;')
      ..writeln('    if (key == null) return;')
      ..writeln('    final linkSnapshot = linkKey.value;')
      ..writeln('    final linkToken = _linkToken;')
      ..writeln('    submitting.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      await _repository.destroy${model.baseName}(key);')
      ..writeln(
        '      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      editingKey.value = null;')
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {',
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
      ..writeln('  void dispose() {')
      ..writeln('    disposeControllers();')
      ..writeln('  }')
      ..writeln()
      ..writeln(
        '  Future<void> initSignals({required ${model.keyType} linkKey}) {',
      )
      ..writeln('    return setLinkKey(linkKey);')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> persist() async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final linkSnapshot = linkKey.value;')
      ..writeln('    if (linkSnapshot == null) {')
      ..writeln("      throw LinkNotLoadedException('link record not loaded');")
      ..writeln('    }')
      ..writeln('    final linkToken = _linkToken;')
      ..writeln('    final candidate = _collectCandidate();')
      ..writeln('    final originalKey = editingKey.value;')
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
        '      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      entity.value = candidate;')
      ..writeln(
        '      editingKey.value = candidate.${model.singleKeyFieldName};',
      )
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {',
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
        '  Future<void> setLinkKey(${model.keyType} linkKey) async {',
      )
      ..writeln('    if (this.linkKey.value == linkKey && entity.value != null) return;')
      ..writeln('    _linkToken++;')
      ..writeln('    this.linkKey.value = linkKey;')
      ..writeln('    editingKey.value = null;')
      ..writeln('    await _refresh();')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> _refresh() async {')
      ..writeln('    final token = ++_refreshToken;')
      ..writeln('    final linkSnapshot = linkKey.value;')
      ..writeln('    if (linkSnapshot == null) {')
      ..writeln('      entity.value = null;')
      ..writeln('      editingKey.value = null;')
      ..writeln('      return;')
      ..writeln('    }')
      ..writeln('    loading.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      final existing = await _repository.get${model.baseName}('
          'linkSnapshot);')
      ..writeln('      if (token != _refreshToken) return;')
      ..writeln('      final candidate =')
      ..writeln(
        '          existing ?? await _repository.create${model.baseName}('
        'linkSnapshot);',
      )
      ..writeln('      if (token != _refreshToken) return;')
      ..writeln('      entity.value = candidate;')
      ..writeln('      editingKey.value = existing == null ? null : linkSnapshot;')
      ..writeln('      _applyCandidate(candidate);')
      ..writeln('    } catch (error, stackTrace) {')
      ..writeln('      if (token != _refreshToken) return;')
      ..writeln('      errorMessage.value = foxyErrorMessage(error);')
      ..writeln(
        '      LoggerUtil.instance.e('
        "'加载单行编辑器失败', error: error, stackTrace: stackTrace);",
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
