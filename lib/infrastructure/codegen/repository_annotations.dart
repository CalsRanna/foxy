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

  /// 关联键字段(实体 dart 名列表)。声明后查询层生成关联键形态:
  /// `getBrief*`/`count*`/`create*` 以关联键为首个位置参数,列表只查
  /// 该关联值下的子集合(如「生物详情页的掉落 Tab」)。多数子表一个
  /// 关联键;player_create_info 系列按 (race, class) 两个关联键。
  final List<String> linkKey;

  /// store 遇到重复键时自动重分配的主键字段(实体 dart 名)。
  ///
  /// 复合主键表(如 smart_scripts 的 entryorguid/source_type/id/link)
  /// 里「粘贴已存在行」会触发 ER_DUP_ENTRY 重试:若不声明,生成代码对
  /// 全部非 link int 主键取全局 MAX+1,可能静默写入无关垃圾行。声明后
  /// 重试只重分配本列,并用 [autoIncrementScope] 限定作用域(与手写
  /// `copySmartScript` 只重算 `id`、scope `entryorguid+source_type` 一致)。
  /// 未声明且非 link int 主键多于一个时,重试直接抛 [DuplicateKeyException]
  /// 而不是改写多个键。
  final String? autoIncrementKey;

  /// [autoIncrementKey] 重分配时的作用域字段(实体 dart 名,须为 key 字段)。
  /// 与 [linkKey] 合并为 `nextMaxPlusOne` 的 where 条件。
  final List<String> autoIncrementScope;

  const FoxyRepository(
    this.entity, {
    this.linkKey = const [],
    this.autoIncrementKey,
    this.autoIncrementScope = const [],
  });
}
