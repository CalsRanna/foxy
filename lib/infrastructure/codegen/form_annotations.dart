import 'package:meta/meta_meta.dart';

/// 标注 Detail ViewModel,声明其表单对应的实体与例外字段。
///
/// 生成器按「默认推断 + 例外驱动」工作:
/// - 普通字段由 Dart 类型推断 controller:`int → IntFieldController`、
///   `double → DoubleFieldController`、`String → StringFieldController`、
///   `bool → SelectFieldController<int>(fallback: 0)`(配合 `collect() == 1` 转换)。
/// - 例外字段(select/flag/exclude)必须在此显式声明,字段名拼错会在
///   生成阶段被 validator 拦下。
@Target({TargetKind.classType})
class FoxyDetailViewModel {
  /// 表单对应的 Full Entity 类型。
  final Type entity;

  /// 例外:controller 名 → `SelectFieldController` 的 fallback(int 或 String)。
  final Map<String, Object> selects;

  /// 例外:controller 名 → `FlagFieldController`。
  final Set<String> flags;

  /// 例外:controller 名 → `IntFieldControllerGroup`(动态字段编辑)。
  final Set<String> groups;

  /// 例外:controller 名 → `NullableStringFieldController`(nullable String)。
  final Set<String> nullable;

  /// 不进表单的字段(不生成 controller,也不出现在 collect/apply)。
  final Set<String> exclude;

  /// 提供 store/update/get/create 的 Repository。声明后才生成行为骨架
  /// (信号/initSignals/persist/dispose/_logActivity 钩子);只声明实体
  /// 时仅生成 controller 样板(向后兼容)。
  final Type? repository;

  const FoxyDetailViewModel({
    required this.entity,
    this.selects = const {},
    this.flags = const {},
    this.groups = const {},
    this.nullable = const {},
    this.exclude = const {},
    this.repository,
  });
}

/// 标注子表 Collection Editor ViewModel(父详情页 Tab 的行编辑列表)。
///
/// 生成 controller 样板 + 全套编辑器骨架:父键子集信号、分页、竞态 token、
/// copy/create/destroy/edit/persist/setParentKey/_refresh。Repository 必须
/// 声明 `@FoxyRepository(..., parentKey: [...])`(构建期校验)。
@Target({TargetKind.classType})
class FoxyCollectionEditorViewModel {
  /// 表单对应的 Full Entity 类型。
  final Type entity;

  /// 提供 getBrief/count/create/copy/store/update 的 Repository 类型。
  final Type repository;

  /// 例外:controller 名 → `SelectFieldController` 的 fallback(int 或 String)。
  final Map<String, Object> selects;

  /// 例外:controller 名 → `FlagFieldController`。
  final Set<String> flags;

  /// 例外:controller 名 → `IntFieldControllerGroup`(动态字段编辑)。
  final Set<String> groups;

  /// 例外:controller 名 → `NullableStringFieldController`(nullable String)。
  final Set<String> nullable;

  /// 不进表单的字段(不生成 controller,也不出现在 collect/apply)。
  final Set<String> exclude;

  const FoxyCollectionEditorViewModel({
    required this.entity,
    required this.repository,
    this.selects = const {},
    this.flags = const {},
    this.groups = const {},
    this.nullable = const {},
    this.exclude = const {},
  });
}
