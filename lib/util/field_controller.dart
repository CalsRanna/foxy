import 'package:flutter/widgets.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 详情表单字段控制器：把「字段类型 → 格式化/解析规则」内聚到字段声明处。
///
/// [FieldControllerMixin] 提供「声明即注册」能力——声明 Controller 时自动入册，
/// 统一释放，消灭手工列表与漏 dispose 的风险：
///
/// ```dart
/// class MyViewModel with FieldControllerMixin {
///   late final entryController = registerController(IntFieldController());
///   late final nameController = registerController(StringFieldController());
///   late final speedController = registerController(DoubleFieldController());
///   late final flagsController = registerController(FlagFieldController());
///   late final typeController = registerController(SelectFieldController<int>(fallback: 0));
///
///   void initForm(Entity e) {
///     entryController.init(e.entry);
///     nameController.init(e.name);
///     speedController.init(e.speed);
///     flagsController.init(e.flags);
///     typeController.init(e.type);
///   }
///
///   Entity collect() => Entity(
///     entry: entryController.collect(),
///     name: nameController.collect(),
///     speed: speedController.collect(),
///     flags: flagsController.collect(),
///     type: typeController.collect(),
///   );
///
///   void dispose() => disposeControllers();
/// }
/// ```
sealed class FieldController<T> {
  /// 用 entity 值初始化底层控件。
  void init(T value);

  /// 从底层控件读取并解析为字段值；非法输入抛 [FormatException]。
  T collect();

  /// 监听底层控件变化。
  void addListener(VoidCallback listener);

  /// 移除底层控件监听。
  void removeListener(VoidCallback listener);

  void dispose();
}

/// 文本框族：持有 [TextEditingController]，负责字符串双向转换。
sealed class TextBackedFieldController<T> extends FieldController<T> {
  final controller = TextEditingController();

  @override
  void init(T value) => controller.text = format(value);

  @override
  T collect() => parse(controller.text);

  @override
  void addListener(VoidCallback listener) => controller.addListener(listener);

  @override
  void removeListener(VoidCallback listener) =>
      controller.removeListener(listener);

  @override
  void dispose() => controller.dispose();

  String format(T value);

  T parse(String text);
}

/// 整数字段：空串视为 0，非法输入抛 [FormatException]。
sealed class NumberFieldController<T extends num>
    extends TextBackedFieldController<T> {}

/// 整数字段：空串视为 0，非法输入抛 [FormatException]。
class IntFieldController extends NumberFieldController<int> {
  @override
  String format(int value) => formatNum(value);

  @override
  int parse(String text) => parseIntField(text);
}

/// 浮点字段：空串视为 0.0，非法输入抛 [FormatException]。
class DoubleFieldController extends NumberFieldController<double> {
  @override
  String format(double value) => formatNum(value);

  @override
  double parse(String text) => parseDoubleField(text);
}

/// 位标记字段：负责位标记值的显示格式化与解析。
class FlagFieldController extends TextBackedFieldController<int> {
  /// 格式化标志位整数值为显示文本，如 `123 (0x0000007B)`。
  static String formatFlagValue(int value) {
    final hex = value.toRadixString(16).toUpperCase().padLeft(8, '0');
    return '$value (0x$hex)';
  }

  /// 将 [formatFlagValue] 产生的显示文本解析回整数值。
  static int parseFlagValue(String text) {
    return int.tryParse(text.split(' ').first) ?? 0;
  }

  @override
  String format(int value) => formatFlagValue(value);

  @override
  int parse(String text) => parseFlagValue(text);
}

/// 纯文本字段：原样透传。
class StringFieldController extends TextBackedFieldController<String> {
  @override
  String format(String value) => value;

  @override
  String parse(String text) => text;
}

/// ViewModel 侧 FieldController 生命周期管理。
///
/// 提供「声明即注册」能力，替代手工 [FieldController] 列表与 dispose 循环：
///
/// ```dart
/// class MyViewModel with FieldControllerMixin {
///   late final entryController = registerController(IntFieldController());
///   late final nameController = registerController(StringFieldController());
///
///   void dispose() => disposeControllers();
/// }
/// ```
mixin FieldControllerMixin {
  final _fieldControllers = <FieldController>[];

  T registerController<T extends FieldController>(T controller) {
    _fieldControllers.add(controller);
    return controller;
  }

  void disposeControllers() {
    for (final controller in _fieldControllers) {
      controller.dispose();
    }
  }
}

/// 下拉字段：持有 [ShadSelectController]，未选中时回落 [fallback]。
///
/// [fallback] 显式化了此前散落各处的 `?? 0` 语义，每个字段的默认值有据可查。
class SelectFieldController<T> extends FieldController<T> {
  final controller = ShadSelectController<T>();
  final T fallback;

  SelectFieldController({required this.fallback});

  @override
  void init(T value) => controller.value = {value};

  @override
  T collect() => controller.value.firstOrNull ?? fallback;

  @override
  void addListener(VoidCallback listener) => controller.addListener(listener);

  @override
  void removeListener(VoidCallback listener) =>
      controller.removeListener(listener);

  @override
  void dispose() => controller.dispose();
}
