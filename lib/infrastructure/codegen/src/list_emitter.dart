import 'list_model.dart';

final class ListEmitter {
  const ListEmitter();

  /// 成员顺序遵循 "Sort Members" 规则:字段(保持原序,状态信号 → 筛选
  /// controller → 私有 token)在前,公开方法按名(copy → destroy → dispose
  /// → initSignals → paginate → reset → search),私有方法按名
  /// (_collectFilter → _logActivity → _refresh)。
  String emit(ListGenerationModel model) {
    final buffer = StringBuffer()
      ..writeln('mixin ${model.mixinName}')
      ..writeln('    on FieldControllerMixin, QueryVersionMixin {');
    _emitFields(buffer, model);
    buffer.writeln();
    _emitCopy(buffer, model);
    buffer
      ..writeln()
      ..writeln('  Future<void> destroy(${model.keyParameter}) async {')
      ..writeln("    if (submitting.value) throw StateError('正在提交，请稍候');")
      ..writeln('    submitting.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      await _repository.destroy${_baseName(model)}(key);')
      ..writeln('      _logActivity(ActivityActionType.delete, key);')
      ..writeln('      normalizePageAfterDelete(total.value - 1);')
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln("      errorMessage.value = '\$error';")
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
      ..writeln('  Future<void> initSignals() async {')
      ..writeln('    await _refresh();')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> paginate(int page) async {')
      ..writeln('    this.page.value = page;')
      ..writeln('    markQueryVersion();')
      ..writeln('    await _refresh();')
      ..writeln('  }')
      ..writeln()
      ..writeln('  Future<void> reset() async {');
    for (final field in model.fields) {
      buffer.writeln("    ${field.controllerName}Controller.init('');");
    }
    buffer
      ..writeln('    page.value = 1;')
      ..writeln('    markQueryVersion();')
      ..writeln('    await _refresh();')
      ..writeln('  }');
    buffer
      ..writeln()
      ..writeln('  Future<void> search() async {')
      ..writeln('    page.value = 1;')
      ..writeln('    markQueryVersion();')
      ..writeln('    await _refresh();')
      ..writeln('  }')
      ..writeln()
      ..writeln('  ${model.filterClassName} _collectFilter() {')
      ..writeln('    return ${model.filterClassName}(');
    for (final field in model.fields) {
      buffer.writeln(
        '      ${field.name}: ${field.controllerName}Controller.collect(),',
      );
    }
    buffer
      ..writeln('    );')
      ..writeln('  }')
      ..writeln()
      ..writeln('  /// 覆写点:记录复制/删除活动日志,entityName 各页不同。')
      ..writeln(
        '  void _logActivity(ActivityActionType action, ${model.keyParameter}) {}',
      )
      ..writeln()
      ..writeln('  Future<void> _refresh() async {')
      ..writeln('    final token = ++_refreshToken;')
      ..writeln('    final filter = _collectFilter();')
      ..writeln('    final currentPage = page.value;')
      ..writeln('    loading.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      final (nextItems, nextTotal) = await (')
      ..writeln('        _repository.${model.getBriefMethodName}(')
      ..writeln('          page: currentPage,')
      ..writeln('          filter: filter,')
      ..writeln('        ),')
      ..writeln('        _repository.${model.countMethodName}(filter: filter),')
      ..writeln('      ).wait;')
      ..writeln('      if (token != _refreshToken) return;')
      ..writeln('      items.value = nextItems;')
      ..writeln('      total.value = nextTotal;')
      ..writeln('    } catch (error) {')
      ..writeln('      if (token != _refreshToken) return;')
      ..writeln("      LoggerUtil.instance.e('刷新列表失败: \$error');")
      ..writeln("      errorMessage.value = '刷新列表失败: \$error';")
      ..writeln('    } finally {')
      ..writeln('      if (token == _refreshToken) loading.value = false;')
      ..writeln('    }')
      ..writeln('  }')
      ..writeln('}');
    return buffer.toString();
  }

  void _emitFields(StringBuffer buffer, ListGenerationModel model) {
    buffer
      ..writeln(
        '  final _repository = '
        'GetIt.instance.get<${model.repositoryClassName}>();',
      )
      ..writeln()
      ..writeln('  final items = signal(<${model.briefEntityClassName}>[]);')
      ..writeln()
      ..writeln('  @override')
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
    for (final field in model.fields) {
      buffer.writeln(
        '  late final ${field.controllerName}Controller = '
        'registerController(StringFieldController());',
      );
      buffer.writeln();
    }
    buffer.writeln('  int _refreshToken = 0;');
  }

  void _emitCopy(StringBuffer buffer, ListGenerationModel model) {
    buffer
      ..writeln('  Future<void> copy(${model.keyParameter}) async {')
      ..writeln("    if (submitting.value) throw StateError('正在提交，请稍候');")
      ..writeln('    submitting.value = true;')
      ..writeln('    errorMessage.value = null;')
      ..writeln('    try {')
      ..writeln('      await _repository.${model.copyMethodName}(key);')
      ..writeln('      _logActivity(ActivityActionType.copy, key);')
      ..writeln('      await _refresh();')
      ..writeln('    } catch (error) {')
      ..writeln("      errorMessage.value = '\$error';")
      ..writeln('      rethrow;')
      ..writeln('    } finally {')
      ..writeln('      submitting.value = false;')
      ..writeln('    }')
      ..writeln('  }');
  }

  String _baseName(ListGenerationModel model) => model.repositoryClassName
      .substring(0, model.repositoryClassName.length - 'Repository'.length);
}
