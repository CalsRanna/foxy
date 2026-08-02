import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
final class FoxyFilter {
  /// 物理列名；缺省时由生成器按「filter 名 → 同名实体字段 → 该字段
  /// `@FoxyFullField` 列名」推断，无法推断时构建期报错。
  final String? column;
  final Object defaultValue;
  final String name;
  final FoxyFilterType type;

  const FoxyFilter.boolean(
    this.name, {
    bool this.defaultValue = false,
    this.column,
  }) : type = FoxyFilterType.boolean;

  const FoxyFilter.decimal(
    this.name, {
    double this.defaultValue = 0.0,
    this.column,
  }) : type = FoxyFilterType.decimal;

  const FoxyFilter.integer(this.name, {int this.defaultValue = 0, this.column})
    : type = FoxyFilterType.integer;

  const FoxyFilter.text(this.name, {String this.defaultValue = '', this.column})
    : type = FoxyFilterType.text;
}

enum FoxyFilterType { boolean, decimal, integer, text }

@Target({TargetKind.classType})
final class FoxyRepository {
  final Type entity;

  /// 父键字段(实体 dart 名列表)。声明后查询层生成父键形态:
  /// `getBrief*`/`count*`/`create*` 以父键为首个位置参数,列表只查
  /// 该父记录的子集合(如「生物详情页的掉落 Tab」)。多数子表一个
  /// 父键;player_create_info 系列按 (race, class) 两个父键。
  final List<String> parentKey;

  const FoxyRepository(this.entity, {this.parentKey = const []});
}
