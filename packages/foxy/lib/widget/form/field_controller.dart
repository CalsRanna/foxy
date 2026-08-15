import 'package:flutter/widgets.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/infrastructure/util/format_util.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// Exported for generated parts: the view-model .g.dart is `part of` the
// parent library and cannot import on its own; the generated code's
// FoxyException/FoxyExceptions.message resolve through this file's import scope
// (AGENTS.md requires every generated-VM shell to mix in
// FieldControllerMixin).
export 'package:foxy/infrastructure/errors/foxy_exceptions.dart';

/// Floating-point field: empty string counts as 0.0; invalid input throws
/// [FormatException].
class DoubleFieldController extends NumberFieldController<double> {
  @override
  String format(double value) => FormatUtil.formatNum(value);

  @override
  double parse(String text) => ParseUtil.parseDoubleField(text);
}

/// Detail-form field controllers: co-locate "field type → format/parse
/// rules" at the field declaration.
///
/// [FieldControllerMixin] provides "declare-and-register": controllers
/// auto-register when declared and are disposed uniformly, eliminating
/// manual lists and missed-dispose risks:
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
  /// Listens to the underlying control's changes.
  void addListener(VoidCallback listener);

  /// Reads the underlying control and parses it into a field value;
  /// invalid input throws [FormatException].
  T collect();

  void dispose();

  /// Initializes the underlying control with an entity value.
  void init(T value);

  /// Removes the underlying control's listener.
  void removeListener(VoidCallback listener);
}

/// ViewModel-side FieldController lifecycle management.
///
/// Provides "declare-and-register", replacing manual [FieldController]
/// lists and dispose loops:
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

  /// Disposed flag: when a slow initSignals query (cold connection/remote
  /// DB) returns after the page is destroyed, writing to a disposed
  /// TextEditingController throws FlutterError in debug. Both generated and
  /// hand-written initSignals check this flag after await before touching
  /// controllers/signals.
  bool _disposed = false;

  /// Whether already disposed (true after disposeControllers).
  bool get isDisposed => _disposed;

  void disposeControllers() {
    _disposed = true;
    for (final controller in _fieldControllers) {
      controller.dispose();
    }
  }

  T registerController<T extends FieldController>(T controller) {
    _fieldControllers.add(controller);
    return controller;
  }
}

/// Bit-flag field: formats and parses bit-flag values for display.
class FlagFieldController extends TextBackedFieldController<int> {
  @override
  String format(int value) => formatFlagValue(value);

  @override
  int parse(String text) => parseFlagValue(text);

  /// Formats a flag integer as display text, e.g. `123 (0x0000007B)`.
  static String formatFlagValue(int value) {
    final hex = value.toRadixString(16).toUpperCase().padLeft(8, '0');
    return '$value (0x$hex)';
  }

  /// Parses the display text produced by [formatFlagValue] back into an
  /// integer.
  static int parseFlagValue(String text) {
    return ParseUtil.parseIntField(text.split(' ').first);
  }
}

/// Integer field: empty string counts as 0; invalid input throws
/// [FormatException].
class IntFieldController extends NumberFieldController<int> {
  @override
  String format(int value) => FormatUtil.formatNum(value);

  @override
  int parse(String text) => ParseUtil.parseIntField(text);
}

/// A group of typed controllers for one physical integer column.
///
/// A dynamic field's edit semantics switch with the discriminator field
/// (number/enum/Flags/reference); a single [IntFieldController] cannot be
/// handed to `FoxyShadSelect`/`FoxyFlagPicker` directly.
/// This class holds three existing typed controllers and forwards reads/
/// writes by the current [editor], solving the "one physical int field
/// needs several existing typed controllers" adaptation; it takes no part
/// in labels, options, reference resolution or widget building.
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

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  int collect() {
    return switch (_editor) {
      IntegerFieldEditor.number ||
      IntegerFieldEditor.reference => numberController.collect(),
      IntegerFieldEditor.select => selectController.collect(),
      IntegerFieldEditor.flags => flagController.collect(),
    };
  }

  /// Switches the current editor.
  ///
  /// Idempotent: returns immediately when the editor is unchanged, touching
  /// no text state — a GameObject-type switch calls this on all 24 groups,
  /// so drafts the user is typing in other fields must not be cleared.
  ///
  /// When the editor truly changes and the old editor was a number input
  /// holding an invalid transient text (e.g. a bare minus `-`), drop that
  /// draft and restore the last valid integer. This is the only
  /// predictable behavior, since invalid text is not a persistable field
  /// value.
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
  void dispose() {
    numberController.dispose();
    selectController.dispose();
    flagController.dispose();
    _listeners.clear();
  }

  @override
  void init(int value) {
    final changed = value != _lastValidValue;
    _setAll(value);
    if (changed) _notify();
  }

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  void _notify() {
    for (final listener in List.of(_listeners)) {
      listener();
    }
  }

  void _onFlagChanged() {
    if (_syncing) return;
    final text = flagController.controller.text.trim();
    final value = text.isEmpty ? 0 : int.tryParse(text.split(' ').first);
    if (value == null) return;
    _syncFromValue(value);
  }

  void _onNumberChanged() {
    if (_syncing) return;
    final text = numberController.controller.text.trim();
    final value = text.isEmpty ? 0 : int.tryParse(text);
    // Invalid non-empty text (e.g. `-`) is an edit draft: not synced, not
    // notified; collect() on save still throws FormatException, caught by
    // the validation layer.
    if (value == null) return;
    _syncFromValue(value);
  }

  void _onSelectChanged() {
    if (_syncing) return;
    _syncFromValue(selectController.collect());
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

  /// Syncs the visible controller's valid changes into the other two typed
  /// controllers, guarded against re-entry with `_syncing`; equal-to-last
  /// valid integers produce no spurious notifications.
  void _syncFromValue(int value) {
    if (value == _lastValidValue) return;
    _setAll(value);
    _notify();
  }
}

/// Nullable text field: an explicit NULL state preserves the difference
/// between database `NULL` and an empty string.
class NullableStringFieldController extends TextBackedFieldController<String?> {
  final isNull = ValueNotifier(false);

  @override
  void addListener(VoidCallback listener) {
    controller.addListener(listener);
    isNull.addListener(listener);
  }

  @override
  String? collect() => isNull.value ? null : controller.text;

  @override
  void dispose() {
    isNull.dispose();
    super.dispose();
  }

  @override
  String format(String? value) => value ?? '';

  @override
  void init(String? value) {
    isNull.value = value == null;
    controller.text = value ?? '';
  }

  @override
  String? parse(String text) => text;

  @override
  void removeListener(VoidCallback listener) {
    controller.removeListener(listener);
    isNull.removeListener(listener);
  }

  void setNull(bool value) => isNull.value = value;
}

/// Integer field: empty string counts as 0; invalid input throws
/// [FormatException].
sealed class NumberFieldController<T extends num>
    extends TextBackedFieldController<T> {}

/// Dropdown field: holds a [ShadSelectController], falling back to
/// [fallback] when nothing is selected.
///
/// [fallback] makes the previously scattered `?? 0` semantics explicit, so
/// every field's default is documented.
class SelectFieldController<T> extends FieldController<T> {
  final controller = ShadSelectController<T>();
  final T fallback;

  SelectFieldController({required this.fallback});

  @override
  void addListener(VoidCallback listener) => controller.addListener(listener);

  @override
  T collect() => controller.value.firstOrNull ?? fallback;

  @override
  void dispose() => controller.dispose();

  @override
  void init(T value) => controller.value = {value};

  @override
  void removeListener(VoidCallback listener) =>
      controller.removeListener(listener);
}

/// Plain text field: passed through verbatim.
class StringFieldController extends TextBackedFieldController<String> {
  @override
  String format(String value) => value;

  @override
  String parse(String text) => text;
}

/// Text-controller family: holds a [TextEditingController], handling
/// two-way string conversion.
sealed class TextBackedFieldController<T> extends FieldController<T> {
  final controller = TextEditingController();

  @override
  void addListener(VoidCallback listener) => controller.addListener(listener);

  @override
  T collect() => parse(controller.text);

  @override
  void dispose() => controller.dispose();

  String format(T value);

  @override
  void init(T value) => controller.text = format(value);

  T parse(String text);

  @override
  void removeListener(VoidCallback listener) =>
      controller.removeListener(listener);
}
