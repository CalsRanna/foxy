import 'package:meta/meta_meta.dart';

enum FoxyFilterType { boolean, decimal, integer, text }

@Target({TargetKind.classType})
final class FoxyFilter {
  final Object defaultValue;
  final String name;
  final FoxyFilterType type;

  const FoxyFilter.boolean(this.name, {bool this.defaultValue = false})
    : type = FoxyFilterType.boolean;

  const FoxyFilter.decimal(this.name, {double this.defaultValue = 0.0})
    : type = FoxyFilterType.decimal;

  const FoxyFilter.integer(this.name, {int this.defaultValue = 0})
    : type = FoxyFilterType.integer;

  const FoxyFilter.text(this.name, {String this.defaultValue = ''})
    : type = FoxyFilterType.text;
}

@Target({TargetKind.classType})
final class FoxyRepository {
  final Type entity;

  const FoxyRepository(this.entity);
}
