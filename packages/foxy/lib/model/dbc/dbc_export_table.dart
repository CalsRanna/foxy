import 'package:foxy/constant/dbc_definitions.dart';

final class DbcExportTable {
  final DbcDefinition definition;
  final int? recordCount;
  final Object? countError;

  const DbcExportTable({
    required this.definition,
    this.recordCount,
    this.countError,
  });
}
