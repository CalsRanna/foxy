import 'package:foxy_generator/src/form_emitter.dart';
import 'package:foxy_generator/src/form_model.dart';
import 'package:foxy_generator/src/linked_list_model.dart';
import 'package:foxy_generator/src/log_activity_hook.dart';
import 'package:foxy_generator/src/naming.dart';

final class LinkedListEmitter {
  const LinkedListEmitter();

  /// Member order follows the "Sort Members" rule: fields (_repository →
  /// link-key/list state signals → controllers → private token) first,
  /// public methods by name (copy → create → destroy → dispose → edit →
  /// initSignals → paginate → persist → setLinkKey), private methods by
  /// name (_afterApplyCandidate → _applyCandidate → _collectCandidate →
  /// _logActivity → _refresh).
  String emit(LinkedListGenerationModel model) {
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
      ..writeln('  final linkKey = signal<${model.linkKeyType}?>(null);')
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
      ..writeln('  int _interactionToken = 0;')
      ..writeln()
      ..writeln('  Future<void> copy(${model.keyType} key) async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final link = linkKey.value;')
      ..writeln('    if (link == null) {')
      ..writeln("      throw LinkNotLoadedException('link record not loaded');")
      ..writeln('    }')
      ..writeln('    final token = ++_interactionToken;')
      ..writeln('    submitting.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      await _repository.copy${model.baseName}(key);')
      ..writeln(
        '      if (token != _interactionToken || linkKey.value != link) return;',
      )
      ..writeln('      try {')
      ..writeln(
        model.logNameFields.isEmpty
            ? '        _logActivity(ActivityActionType.copy, key);'
            : '        await _logActivity(ActivityActionType.copy, key);',
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
        '      if (token != _interactionToken || linkKey.value != link) {',
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
      ..writeln('  Future<void> create() async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final link = linkKey.value;')
      ..writeln('    if (link == null) {')
      ..writeln("      throw LinkNotLoadedException('link record not loaded');")
      ..writeln('    }')
      ..writeln('    final token = ++_interactionToken;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln(
        '      final candidate = await _repository.create${model.baseName}(link);',
      )
      ..writeln(
        '      if (token != _interactionToken || linkKey.value != link) return;',
      )
      ..writeln('      editingKey.value = null;')
      ..writeln('      selectedKey.value = null;')
      ..writeln('      _applyCandidate(candidate);')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token != _interactionToken || linkKey.value != link) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      errorMessage.value = FoxyExceptions.message(error);')
      ..writeln('      rethrow;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> destroy(${model.keyType} key) async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final link = linkKey.value;')
      ..writeln('    if (link == null) {')
      ..writeln("      throw LinkNotLoadedException('link record not loaded');")
      ..writeln('    }')
      ..writeln('    final token = ++_interactionToken;')
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
        '      if (token != _interactionToken || linkKey.value != link) return;',
      )
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
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token != _interactionToken || linkKey.value != link) {',
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
      ..writeln('  void dispose() => disposeControllers();')
      ..writeln()
      ..writeln('  Future<void> edit(${model.keyType} key) async {')
      ..writeln(
        "    if (submitting.value) throw BusyException('operation already in progress');",
      )
      ..writeln('    final link = linkKey.value;')
      ..writeln('    if (link == null) {')
      ..writeln("      throw LinkNotLoadedException('link record not loaded');")
      ..writeln('    }')
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
        '      if (token != _interactionToken || linkKey.value != link) return;',
      )
      ..writeln('      if (candidate == null) {')
      ..writeln("        throw RecordNotFoundException('record not found');")
      ..writeln('      }')
      ..writeln('      _applyCandidate(candidate);')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token != _interactionToken || linkKey.value != link) {',
      )
      ..writeln('        return;')
      ..writeln('      }')
      ..writeln('      editingKey.value = null;')
      ..writeln('      errorMessage.value = FoxyExceptions.message(error);')
      ..writeln('      rethrow;')
      ..writeln('    } finally {')
      ..writeln('      if (token == _interactionToken) loading.value = false;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln()
      ..writeln(
        '  Future<void> initSignals({required ${model.linkKeyType} linkKey}) '
        '=> setLinkKey(linkKey);',
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
      ..writeln('    final link = linkKey.value;')
      ..writeln('    if (link == null) {')
      ..writeln("      throw LinkNotLoadedException('link record not loaded');")
      ..writeln('    }')
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
      ..writeln('      final action = originalKey == null')
      ..writeln('          ? ActivityActionType.create')
      ..writeln('          : ActivityActionType.update;')
      ..writeln('      try {')
      ..writeln(
        '        ${model.logNameFields.isEmpty ? '' : 'await '}_logActivity(action, '
        '${model.singleKeyFieldName != null ? 'originalKey ?? candidate.${model.singleKeyFieldName}' : 'originalKey ?? ${model.baseName}Key.fromEntity(candidate)'});',
      )
      ..writeln('      } catch (_) {')
      ..writeln(
        '        // Activity log is best-effort; failure (e.g. not registered in\n'
        '        // tests) must not affect the main flow.',
      )
      ..writeln('      }')
      ..writeln(
        '      if (token != _interactionToken || linkKey.value != link) return;',
      )
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln(
        '      if (token != _interactionToken || linkKey.value != link) {',
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
        '  Future<void> setLinkKey(${model.linkKeyType} linkKey) async {',
      )
      ..writeln('    _interactionToken++;')
      ..writeln('    if (this.linkKey.value != linkKey) page.value = 1;')
      ..writeln('    this.linkKey.value = linkKey;')
      ..writeln('    final link = linkKey;')
      ..writeln('    editingKey.value = null;')
      ..writeln('    selectedKey.value = null;')
      ..writeln(
        '    _applyCandidate(${model.entityClassName}('
        '${model.linkFieldName}: link));',
      )
      ..writeln('    await _refresh();')
      ..writeln('  }')
      ..writeln()
      ..writeln(hook.documentation)
      ..writeln(hook.signature)
      ..writeln(hook.body)
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> _refresh() async {')
      ..writeln('    final link = linkKey.value;')
      ..writeln('    if (link == null) return;')
      ..writeln('    final currentPage = page.value;')
      ..writeln('    final token = ++_refreshToken;')
      ..writeln('    loading.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      // count runs first by design: the page clamp (lastPage/nextPage)
      // depends on it, so unlike the main-table list VM the two queries
      // cannot be issued in parallel via .wait.
      ..writeln(
        '      final count = await _repository.count${pluralize(model.baseName)}(link);',
      )
      ..writeln('      if (token != _refreshToken) return;')
      ..writeln(
        '      final lastPage = max(1, (count / _repository.kPageSize).ceil());',
      )
      ..writeln('      final nextPage = min(currentPage, lastPage);')
      ..writeln(
        '      final data = await _repository.getBrief${pluralize(model.baseName)}('
        'link, page: nextPage);',
      )
      ..writeln('      if (token != _refreshToken) return;')
      ..writeln('      page.value = nextPage;')
      ..writeln('      items.value = data;')
      ..writeln('      total.value = count;')
      ..writeln('      editingKey.value = null;')
      ..writeln('      selectedKey.value = null;')
      ..writeln('    } catch (error) {')
      ..writeln('      if (token == _refreshToken) {')
      ..writeln(
        '        errorMessage.value = FoxyExceptions.message(error);',
      )
      ..writeln("        LoggerUtil.instance.e('刷新子表列表失败: \$error');")
      ..writeln('      }')
      ..writeln('    } finally {')
      ..writeln('      if (token == _refreshToken) loading.value = false;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }
}
