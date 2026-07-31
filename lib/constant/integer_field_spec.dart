import 'package:foxy/constant/flag_item.dart';

/// 一个整数物理列当前应使用的编辑器种类。
///
/// 四种状态互斥，由 [IntegerFieldSpec] 的具体子类型唯一决定，
/// 取代旧的 `reference/options/flags` nullable 组合推断。
enum IntegerFieldEditor { number, select, flags, reference }

/// 动态整数字段的编辑规格：描述一个整数列「用什么既有组件编辑」。
///
/// [R] 是引用枚举（如 [GameObjectDataReference]），仅 reference 子类真正使用。
/// 这是纯数据类，不依赖 Flutter，由 View 的 exhaustive switch 渲染为
/// 对应的既有组件。
sealed class IntegerFieldSpec<R> {
  final String label;
  final bool editable;

  const IntegerFieldSpec(this.label, {this.editable = true});

  IntegerFieldEditor get editor;
}

/// 普通整数输入框（[FoxyNumberInput]）。
final class IntegerNumberFieldSpec<R> extends IntegerFieldSpec<R> {
  const IntegerNumberFieldSpec(super.label, {super.editable});

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.number;
}

/// 严格枚举下拉（[FoxyShadSelect]）。
final class IntegerSelectFieldSpec<R> extends IntegerFieldSpec<R> {
  final Map<int, String> options;

  const IntegerSelectFieldSpec(
    super.label, {
    required this.options,
    super.editable,
  });

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.select;
}

/// 位标记选择器（[FoxyFlagPicker]）。
///
/// 当前所有 Flags 字段都可编辑，因此不开放 `editable: false`；
/// 若未来出现只读 Flags，应先为 [FoxyFlagPicker] 增加统一的禁用能力，
/// 再扩展此规格，不能让配置声明出 Widget 无法兑现的状态。
final class IntegerFlagsFieldSpec<R> extends IntegerFieldSpec<R> {
  final List<FlagItem> flags;

  const IntegerFlagsFieldSpec(super.label, {required this.flags});

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.flags;
}

/// 实体引用选择器（[FoxyEntityPicker]）。
final class IntegerReferenceFieldSpec<R> extends IntegerFieldSpec<R> {
  final R reference;

  const IntegerReferenceFieldSpec(
    super.label, {
    required this.reference,
    super.editable,
  });

  @override
  IntegerFieldEditor get editor => IntegerFieldEditor.reference;
}
