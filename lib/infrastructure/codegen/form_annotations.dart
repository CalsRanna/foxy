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

  /// 例外:字段名 → `SelectFieldController<int>` 的 fallback。
  final Map<String, int> selects;

  /// 例外:字段名 → `FlagFieldController`。
  final Set<String> flags;

  /// 不进表单的字段(不生成 controller,也不出现在 collect/apply)。
  final Set<String> exclude;

  const FoxyDetailViewModel({
    required this.entity,
    this.selects = const {},
    this.flags = const {},
    this.exclude = const {},
  });
}
