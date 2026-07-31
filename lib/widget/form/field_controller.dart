import 'package:flutter/widgets.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/infrastructure/util/format_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
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
    return parseIntField(text.split(' ').first);
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

/// 可空文本字段：通过独立的 NULL 状态保留数据库 `NULL` 与空字符串的区别。
class NullableStringFieldController extends TextBackedFieldController<String?> {
  final isNull = ValueNotifier(false);

  @override
  void init(String? value) {
    isNull.value = value == null;
    controller.text = value ?? '';
  }

  @override
  String? collect() => isNull.value ? null : controller.text;

  void setNull(bool value) => isNull.value = value;

  @override
  void addListener(VoidCallback listener) {
    controller.addListener(listener);
    isNull.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    controller.removeListener(listener);
    isNull.removeListener(listener);
  }

  @override
  void dispose() {
    isNull.dispose();
    super.dispose();
  }

  @override
  String format(String? value) => value ?? '';

  @override
  String? parse(String text) => text;
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

/// 同一物理整数列的 typed controller 组。
///
/// 动态字段的编辑语义随判别字段切换（数字/枚举/Flags/引用），单个
/// [IntFieldController] 无法直接交给 `FoxyShadSelect`/`FoxyFlagPicker`。
/// 本类持有三个现有 typed controller，按当前 [editor] 转发读写，
/// 解决「一个物理 int 字段需要多个现有 typed controller」的适配问题；
/// 不承担 label、options、引用解析或 Widget 构建。
class IntFieldControllerGroup extends FieldController<int> {
  final IntFieldController numberController = IntFieldController();
  final SelectFieldController<int> selectController =
      SelectFieldController<int>(fallback: 0);
  final FlagFieldController flagController = FlagFieldController();

  IntegerFieldEditor _editor;
  int _lastValidValue = 0;
  bool _syncing = false;
  final _listeners = <VoidCallback>[];

  IntFieldControllerGroup({
    IntegerFieldEditor editor = IntegerFieldEditor.number,
  }) : _editor = editor {
    numberController.addListener(_onNumberChanged);
    selectController.addListener(_onSelectChanged);
    flagController.addListener(_onFlagChanged);
  }

  IntegerFieldEditor get editor => _editor;

  /// 切换当前编辑器。
  ///
  /// 幂等：editor 未变化时直接返回，不触碰任何文本状态——GameObject 类型
  /// 切换会对全部 24 个组调用本方法，不能把用户正在输入的其他字段草稿清掉。
  ///
  /// editor 真正变化且旧编辑器是数字输入时，若正处于非法临时文本（如裸负号
  /// `-`），丢弃该草稿并恢复最后一次合法整数。这是唯一可预测的行为，因为
  /// 非法文本不是可持久化的字段值。
  void configure(IntegerFieldEditor editor) {
    if (editor == _editor) return;
    if (_editor == IntegerFieldEditor.number ||
        _editor == IntegerFieldEditor.reference) {
      final text = numberController.controller.text.trim();
      final valid = text.isEmpty ? 0 : int.tryParse(text);
      if (valid == null) _setAll(_lastValidValue);
    }
    _editor = editor;
  }

  @override
  void init(int value) {
    final changed = value != _lastValidValue;
    _setAll(value);
    if (changed) _notify();
  }

  @override
  int collect() {
    return switch (_editor) {
      IntegerFieldEditor.number ||
      IntegerFieldEditor.reference => numberController.collect(),
      IntegerFieldEditor.select => selectController.collect(),
      IntegerFieldEditor.flags => flagController.collect(),
    };
  }

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  @override
  void dispose() {
    numberController.dispose();
    selectController.dispose();
    flagController.dispose();
    _listeners.clear();
  }

  void _onNumberChanged() {
    if (_syncing) return;
    final text = numberController.controller.text.trim();
    final value = text.isEmpty ? 0 : int.tryParse(text);
    // 非法非空文本（如 `-`）是编辑草稿，不同步、不通知；保存时 collect()
    // 仍抛 FormatException 由校验层拦截。
    if (value == null) return;
    _syncFromValue(value);
  }

  void _onSelectChanged() {
    if (_syncing) return;
    _syncFromValue(selectController.collect());
  }

  void _onFlagChanged() {
    if (_syncing) return;
    final text = flagController.controller.text.trim();
    final value = text.isEmpty ? 0 : int.tryParse(text.split(' ').first);
    if (value == null) return;
    _syncFromValue(value);
  }

  /// 当前可见 controller 的合法变化同步到另外两个 typed controller，
  /// 并用 `_syncing` 防重入；与最后一次合法整数相同时不产生空通知。
  void _syncFromValue(int value) {
    if (value == _lastValidValue) return;
    _setAll(value);
    _notify();
  }

  void _setAll(int value) {
    _lastValidValue = value;
    _syncing = true;
    try {
      numberController.init(value);
      selectController.init(value);
      flagController.init(value);
    } finally {
      _syncing = false;
    }
  }

  void _notify() {
    for (final listener in List.of(_listeners)) {
      listener();
    }
  }
}
