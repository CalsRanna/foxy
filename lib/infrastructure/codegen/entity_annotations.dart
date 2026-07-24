import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class FoxyBriefEntity {
  const FoxyBriefEntity();
}

enum FoxyBriefFieldType { boolean, decimal, integer, text }

@Target({TargetKind.classType, TargetKind.field})
class FoxyBriefField {
  final Object? defaultValue;
  final String? name;
  final FoxyBriefFieldType? type;

  const FoxyBriefField() : defaultValue = null, name = null, type = null;

  const FoxyBriefField.boolean(this.name, {bool this.defaultValue = false})
    : type = FoxyBriefFieldType.boolean;

  const FoxyBriefField.decimal(this.name, {double this.defaultValue = 0.0})
    : type = FoxyBriefFieldType.decimal;

  const FoxyBriefField.integer(this.name, {int this.defaultValue = 0})
    : type = FoxyBriefFieldType.integer;

  const FoxyBriefField.text(this.name, {String this.defaultValue = ''})
    : type = FoxyBriefFieldType.text;
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
