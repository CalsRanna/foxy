import 'package:meta/meta_meta.dart';

enum FoxyFilterFieldType { boolean, decimal, integer, text }

final class FoxyRepositoryFilterField {
  final Object defaultValue;
  final String name;
  final FoxyFilterFieldType type;

  const FoxyRepositoryFilterField({
    required this.name,
    required this.type,
    required this.defaultValue,
  });
}

@Target({TargetKind.classType})
final class FoxyRepositoryFilter {
  final List<FoxyRepositoryFilterField> fields;
  final String name;

  const FoxyRepositoryFilter({required this.name, required this.fields});
}
