import 'package:foxy_agent/src/agent_tool.dart';
import 'package:foxy_agent/src/tools/read_only_tool_input.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

/// Describes catalog references in either direction for one table.
///
/// Each edge names the source and target table/column so the model can build
/// `JOIN ... ON` conditions for `query_sql`.
final class DescribeReferencesTool extends AgentTool {
  final TableCatalog catalog;

  const DescribeReferencesTool(this.catalog);

  @override
  String get description =>
      'List incoming and outgoing catalog references for a table, including '
      'known logical relationships. Use the source and target columns to '
      'join related records or filter the referencing table.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'table': {
        'type': 'string',
        'description': 'Table name from list_tables.',
      },
    },
    'required': ['table'],
    'additionalProperties': false,
  };

  @override
  String get name => 'describe_references';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final resolved = resolveTable(catalog, arguments['table']);
    final table = resolved.table;
    if (table == null) return resolved.error!;
    final incoming = <Map<String, Object?>>[];
    final outgoing = <Map<String, Object?>>[];
    for (final source in catalog.tables) {
      for (final column in source.columns) {
        final reference = column.semantics?.reference;
        if (reference == null) continue;
        final target = catalog.find(reference.table);
        if (target == null || target.findColumn(reference.column) == null) {
          continue;
        }
        if (source != table && target != table) continue;
        final edge = {
          'sourceTable': source.qualifiedName,
          'sourceColumn': column.name,
          'targetTable': target.qualifiedName,
          'targetColumn': reference.column,
        };
        if (source == table) outgoing.add(edge);
        if (target == table) incoming.add(edge);
      }
    }
    return {
      'table': table.qualifiedName,
      'incoming': incoming,
      'outgoing': outgoing,
    };
  }
}
