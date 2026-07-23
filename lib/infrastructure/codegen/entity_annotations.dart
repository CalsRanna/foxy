import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class FoxyBriefEntity {
  const FoxyBriefEntity();
}

@Target({TargetKind.field})
class FoxyBriefField {
  const FoxyBriefField();
}

@Target({TargetKind.classType})
class FoxyFilterEntity {
  const FoxyFilterEntity();
}

enum FoxyFilterFieldType { boolean, decimal, integer, text }

@Target({TargetKind.field})
class FoxyFilterField {
  final Object? defaultValue;
  final FoxyFilterFieldType type;

  const FoxyFilterField({required this.defaultValue, required this.type});
}

@Target({TargetKind.classType})
class FoxyFullEntity {
  final String table;

  const FoxyFullEntity({required this.table});
}

@Target({TargetKind.field})
class FoxyFullField {
  final String name;
  final bool key;

  const FoxyFullField(this.name, {this.key = false});
}
