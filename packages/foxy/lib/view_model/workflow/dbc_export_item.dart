import 'package:foxy/constant/dbc_definitions.dart';

class DbcExportItem {
  final DbcDefinition definition;
  final int? recordCount;
  final String? countError;
  final bool selected;

  const DbcExportItem({
    required this.definition,
    this.recordCount,
    this.countError,
    this.selected = true,
  });

  bool get canSelect => !countFailed;
  bool get countFailed => countError != null;
  String get dbcFileName => definition.fileName;

  String get recordCountLabel {
    if (countFailed) return '计数失败';
    final count = recordCount ?? 0;
    if (count == 0) return '空表';
    return '$count 条';
  }

  String get tableName => definition.tableName;

  DbcExportItem copyWith({bool? selected}) {
    return DbcExportItem(
      definition: definition,
      recordCount: recordCount,
      countError: countError,
      selected: selected ?? this.selected,
    );
  }
}
