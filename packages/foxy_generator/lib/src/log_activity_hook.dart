/// Activity-log hook rendering shared by the list-style emitters (List /
/// Linked List / Linked Detail).
///
/// The hook is generated as `_logActivity`. With candidate name fields it
/// becomes async: the record is looked up from the database via the
/// generated query layer (`_repository.<getMethodName>(key)`), the entity's
/// candidate name fields are chained with the key as the final fallback,
/// and an optional pre-fetched [record] skips the lookup (used by destroy,
/// where the row is gone after the delete). Overriding the hook in the
/// hand-written class replaces the whole default.
class LogActivityHookEmitter {
  /// Full Entity class name (`CreatureTemplateEntity`); the type of the
  /// optional pre-fetched record parameter.
  final String entityClassName;

  /// Hook key parameter, e.g. `int key` or `CreatureTemplateKey key`.
  final String keyParameter;

  /// Repository query method resolving the full record, e.g.
  /// `getCreatureTemplate`.
  final String getMethodName;

  /// Activity-log module name (physical table name without the `foxy.`
  /// prefix).
  final String moduleName;

  /// Candidate name fields in priority order; empty → key-only hook.
  final List<String> logNameFields;

  const LogActivityHookEmitter({
    required this.entityClassName,
    required this.keyParameter,
    required this.getMethodName,
    required this.moduleName,
    required this.logNameFields,
  });

  /// Doc comment of the hook. The name-resolving variant documents the DB
  /// lookup and the override extension point.
  String get documentation {
    if (logNameFields.isEmpty) {
      return '  /// Fires the activity-log event after a write; persistence is handled by\n'
          '  /// the single ActivityLogListener aspect.';
    }
    return '  /// Fires the activity-log event after a write; persistence is handled by\n'
        '  /// the single ActivityLogListener aspect. The default resolves the\n'
        "  /// record's name from the database via the generated query layer\n"
        '  /// (pass [record] to skip the lookup, e.g. after a delete); override\n'
        '  /// in the hand-written class when the business log content differs.';
  }

  /// Signature of the hook: the name-resolving variant is async and takes
  /// the optional pre-fetched record (used by destroy, where the row is
  /// gone after the delete).
  String get signature {
    if (logNameFields.isEmpty) {
      return '  void _logActivity(ActivityActionType action, $keyParameter) {';
    }
    return '  Future<void> _logActivity(ActivityActionType action, '
        '$keyParameter, [$entityClassName? record]) async {';
  }

  /// Body of the hook: the name-resolving variant looks the record up by
  /// key (or uses the pre-fetched [record]) and picks the first non-empty
  /// candidate name field (empty strings fall through to the key); the
  /// fallback variant logs the key.
  String get body {
    final fire = '    GetIt.instance.get<EventBus>().fire(EntityWrittenEvent(ActivityLogEntity(\n'
        '      module: \'$moduleName\',\n'
        '      actionType: action,\n'
        '      entityName: ${logNameFields.isEmpty ? 'key.toString()' : 'entityName'},\n'
        '      createdAt: DateTime.now(),\n'
        '    )));';
    if (logNameFields.isEmpty) return fire;
    final chain = StringBuffer()
      ..writeln('    final entityName = resolved == null')
      ..writeln('        ? key.toString()');
    for (var i = 0; i < logNameFields.length; i++) {
      final field = logNameFields[i];
      chain.writeln(
        '${' '.padLeft(8 + 6 * i, ' ')}: resolved.$field.isNotEmpty',
      );
      chain.writeln(
        '${' '.padLeft(8 + 6 * (i + 1), ' ')}? resolved.$field',
      );
    }
    chain.write(
      '${' '.padLeft(8 + 6 * logNameFields.length, ' ')}: key.toString();',
    );
    return '    final resolved = record ?? '
        'await _repository.$getMethodName(key);\n'
        '$chain\n'
        '$fire';
  }
}
