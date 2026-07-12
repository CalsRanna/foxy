import 'package:flutter/widgets.dart';
import 'package:foxy/util/format_util.dart';
import 'package:foxy/util/parse_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// 详情表单字段控制器：把「字段类型 → 格式化/解析规则」内聚到字段声明处。
///
/// 此前每个 detail view model 都手写三段式仪式：
/// 1. 声明几十个裸 [TextEditingController] / [ShadSelectController]；
/// 2. `_initControllers`：entity → `_fmt()` → `.text`；
/// 3. `_collectFromControllers`：`.text` → `_pi()`/`_pd()`/`parseFlagValue()`；
/// 4. 手写几十行 `dispose()` 清单。
///
/// 字段是 int、double、flag 还是 string 的知识散落在 init/collect 两处调用点，
/// 改一个字段要动三处，漏一处就是静默 bug（类型错配、漏 dispose）。
///
/// 本类族将该知识只声明一次：
///
/// ```dart
/// final minLevelField = IntFieldController('最低等级');
/// final speedWalkField = DoubleFieldController('行走速度');
///
/// late final _fields = <FieldController>[minLevelField, speedWalkField];
///
/// void _initControllers(Entity t) {
///   minLevelField.init(t.minLevel);
///   speedWalkField.init(t.speedWalk);
/// }
///
/// Entity _collect() => Entity(
///   minLevel: minLevelField.collect(),
///   speedWalk: speedWalkField.collect(),
/// );
///
/// void dispose() {
///   for (final field in _fields) {
///     field.dispose();
///   }
/// }
/// ```
///
/// [label] 用于解析失败时的错误消息（如「最低等级」不是有效整数）。
sealed class FieldController<T> {
  final String label;

  FieldController(this.label);

  /// 用 entity 值初始化底层控件。
  void init(T value);

  /// 从底层控件读取并解析为字段值；非法输入抛 [FormatException]。
  T collect();

  void dispose();
}

/// 文本框族：持有 [TextEditingController]，负责字符串双向转换。
sealed class TextBackedFieldController<T> extends FieldController<T> {
  final controller = TextEditingController();

  TextBackedFieldController(super.label);

  @override
  void init(T value) => controller.text = format(value);

  @override
  T collect() => parse(controller.text);

  @override
  void dispose() => controller.dispose();

  String format(T value);

  T parse(String text);
}

/// 整数字段：空串视为 0，非法输入抛 [FormatException]。
class IntFieldController extends TextBackedFieldController<int> {
  IntFieldController(super.label);

  @override
  String format(int value) => formatNum(value);

  @override
  int parse(String text) => parseIntField(text, field: label);
}

/// 浮点字段：空串视为 0.0，非法输入抛 [FormatException]。
class DoubleFieldController extends TextBackedFieldController<double> {
  DoubleFieldController(super.label);

  @override
  String format(double value) => formatNum(value);

  @override
  double parse(String text) => parseDoubleField(text, field: label);
}

/// 位标记字段：负责位标记值的显示格式化与解析。
class FlagFieldController extends TextBackedFieldController<int> {
  FlagFieldController(super.label);

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
class TextFieldController extends TextBackedFieldController<String> {
  TextFieldController(super.label);

  @override
  String format(String value) => value;

  @override
  String parse(String text) => text;
}

/// 下拉字段：持有 [ShadSelectController]，未选中时回落 [fallback]。
///
/// [fallback] 显式化了此前散落各处的 `?? 0` 语义，每个字段的默认值有据可查。
class SelectFieldController<T> extends FieldController<T> {
  final controller = ShadSelectController<T>();
  final T fallback;

  SelectFieldController(super.label, {required this.fallback});

  @override
  void init(T value) => controller.value = {value};

  @override
  T collect() => controller.value.firstOrNull ?? fallback;

  @override
  void dispose() => controller.dispose();
}
