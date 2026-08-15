import 'package:foxy_generator/src/form_emitter.dart';
import 'package:foxy_generator/src/form_model.dart';
import 'package:foxy_generator/src/linked_detail_model.dart';
import 'package:foxy_generator/src/log_activity_hook.dart';

final class LinkedDetailEmitter {
  const LinkedDetailEmitter();

  /// Member order follows the "Sort Members" rule: fields (_repository →
  /// link-key/editing-key/entity state signals → controllers → private
  /// token) first, public methods by name (destroy → dispose → initSignals
  /// → persist → setLinkKey), private methods by name
  /// (_afterApplyCandidate → _applyCandidate → _collectCandidate →
  /// _logActivity → _refresh).
  String emit(LinkedDetailGenerationModel model) {
    final hook = LogActivityHookEmitter(
      entityClassName: model.entityClassName,
      keyParameter: '${model.keyType} key',
      getMethodName: 'get${model.baseName}',
      moduleName: model.moduleName,
      logNameFields: model.logNameFields,
    );
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

    // Controller boilerplate reuses FormEmitter (with the behavior skeleton
    // disabled). The body is spliced in structurally via emitBody, keeping
    // the output stable against shape changes in the form emitter.
    final form = FormGenerationModel(
      className: model.className,
      entityClassName: model.entityClassName,
      mixinName: model.mixinName,
      fields: model.fields,
      skeletonEnabled: false,
      repositoryClassName: '',
      keyType: '',
      singleKeyFieldName: null,
      table: model.table,
      emitLogActivity: false,
    );
    buffer.writeln();
    buffer.write(const FormEmitter().emitBody(form));

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
      ..writeln(
        model.logNameFields.isEmpty
            ? '      await _repository.destroy${model.baseName}(key);'
            // The row is gone after the destroy; capture its name first so
            // the activity log can record it.
            : '      final record = '
                'await _repository.get${model.baseName}(key);\n'
                '      await _repository.destroy${model.baseName}(key);',
      )
      ..writeln(
        '      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      try {')
      ..writeln(
        model.logNameFields.isEmpty
            ? '        _logActivity(ActivityActionType.delete, key);'
            : '        await _logActivity(ActivityActionType.delete, key, record);',
      )
      ..writeln('      } catch (_) {')
      ..writeln(
        '        // Activity log is best-effort; failure (e.g. not registered in\n'
        '        // tests) must not affect the main flow.',
      )
      ..writeln('      }')
      ..writeln('      editingKey.value = null;')
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      errorMessage.value = FoxyExceptions.message(error);')
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
      ..writeln('      final action = originalKey == null')
      ..writeln('          ? ActivityActionType.create')
      ..writeln('          : ActivityActionType.update;')
      ..writeln('      try {')
      ..writeln(
        '        ${model.logNameFields.isEmpty ? '' : 'await '}_logActivity(action, '
        'originalKey ?? candidate.${model.singleKeyFieldName});',
      )
      ..writeln('      } catch (_) {')
      ..writeln(
        '        // Activity log is best-effort; failure (e.g. not registered in\n'
        '        // tests) must not affect the main flow.',
      )
      ..writeln('      }')
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (linkToken != _linkToken || linkKey.value != linkSnapshot) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      errorMessage.value = FoxyExceptions.message(error);')
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
      ..writeln(hook.documentation)
      ..writeln(hook.signature)
      ..writeln(hook.body)
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
      // When a slow query returns, the page may already be disposed
      // (disposeControllers); writing to a TextEditingController then throws
      // a FlutterError in debug mode.
      ..writeln('      if (token != _refreshToken || isDisposed) return;')
      ..writeln('      final candidate =')
      ..writeln(
        '          existing ?? await _repository.create${model.baseName}('
        'linkSnapshot);',
      )
      ..writeln('      if (token != _refreshToken || isDisposed) return;')
      ..writeln('      entity.value = candidate;')
      ..writeln('      editingKey.value = existing == null ? null : linkSnapshot;')
      ..writeln('      _applyCandidate(candidate);')
      ..writeln('    } catch (error, stackTrace) {')
      ..writeln('      if (token != _refreshToken || isDisposed) return;')
      ..writeln('      errorMessage.value = FoxyExceptions.message(error);')
      ..writeln(
        '      LoggerUtil.instance.e('
        "'加载单行编辑器失败', error: error, stackTrace: stackTrace);",
      )
      ..writeln('    } finally {')
      ..writeln(
        '      if (token == _refreshToken && !isDisposed) loading.value = false;',
      )
      ..writeln('    }')
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }
}
