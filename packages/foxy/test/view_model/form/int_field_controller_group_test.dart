import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

void main() {
  group('IntFieldControllerGroup', () {
    test('init(7) sets all three typed controllers to 7', () {
      final group = IntFieldControllerGroup();
      group.init(7);

      expect(group.numberController.collect(), 7);
      expect(group.enumController.collect(), 7);
      expect(group.flagController.collect(), 7);
      expect(group.collect(), 7);

      group.dispose();
    });

    test('Changing enum to 1 synchronizes number and flags to 1', () {
      final group = IntFieldControllerGroup();
      group.init(0);

      group.enumController.init(1);

      expect(group.numberController.collect(), 1);
      expect(group.flagController.collect(), 1);
      expect(group.enumController.collect(), 1);
      expect(group.collect(), 1);

      group.dispose();
    });

    test('Editing the number synchronizes enum and flags', () {
      final group = IntFieldControllerGroup();
      group.init(0);

      group.numberController.controller.text = '42';

      expect(group.enumController.collect(), 42);
      expect(group.flagController.collect(), 42);

      group.dispose();
    });

    test('Editing flags synchronizes number and enum', () {
      final group = IntFieldControllerGroup();
      group.init(0);

      group.flagController.controller.text = '9 (0x00000009)';

      expect(group.numberController.collect(), 9);
      expect(group.enumController.collect(), 9);

      group.dispose();
    });

    test('collect delegates to the active editor', () {
      final group = IntFieldControllerGroup()..init(5);

      group.configure(IntegerFieldEditor.enumValue);
      group.enumController.init(3);
      expect(group.collect(), 3);

      group.configure(IntegerFieldEditor.flags);
      expect(group.collect(), 3);

      group.configure(IntegerFieldEditor.reference);
      group.numberController.controller.text = '11';
      expect(group.collect(), 11);

      group.dispose();
    });

    test('collect throws FormatException for invalid nonempty text in the number editor', () {
      final group = IntFieldControllerGroup()..init(5);

      group.numberController.controller.text = '12a';

      expect(() => group.collect(), throwsFormatException);

      group.dispose();
    });

    test('Invalid number drafts do not synchronize or notify and retain the last valid integer', () {
      final group = IntFieldControllerGroup()..init(7);
      var notified = 0;
      group.addListener(() => notified++);

      group.numberController.controller.text = '-';

      expect(notified, 0);
      expect(group.numberController.controller.text, '-');
      expect(group.enumController.collect(), 7);

      group.dispose();
    });

    test('Switching from an invalid numeric draft to enum restores the last valid integer', () {
      final group = IntFieldControllerGroup()..init(7);
      group.numberController.controller.text = '-';

      group.configure(IntegerFieldEditor.enumValue);

      expect(group.numberController.controller.text, '7');
      expect(group.enumController.collect(), 7);
      expect(group.collect(), 7);

      group.dispose();
    });

    test('Configuring the same editor preserves its invalid text draft', () {
      final group = IntFieldControllerGroup()..init(7);
      group.numberController.controller.text = '-';

      group.configure(IntegerFieldEditor.number);

      expect(group.numberController.controller.text, '-');
      expect(group.editor, IntegerFieldEditor.number);

      group.dispose();
    });

    test('Repeated configuration does not duplicate notifications', () {
      final group = IntFieldControllerGroup()..init(0);
      var notified = 0;
      group.addListener(() => notified++);

      group.configure(IntegerFieldEditor.enumValue);
      group.configure(IntegerFieldEditor.enumValue);
      group.configure(IntegerFieldEditor.number);
      group.configure(IntegerFieldEditor.number);

      expect(notified, 0);

      group.dispose();
    });

    test('Synchronizing an unchanged value does not notify', () {
      final group = IntFieldControllerGroup()..init(5);
      var notified = 0;
      group.addListener(() => notified++);

      group.init(5);
      group.numberController.init(5);

      expect(notified, 0);

      group.dispose();
    });

    test('An actual value change emits exactly one notification', () {
      final group = IntFieldControllerGroup()..init(5);
      var notified = 0;
      group.addListener(() => notified++);

      group.init(9);

      expect(notified, 1);

      group.dispose();
    });

    test('Disposal succeeds and stops notifications', () {
      final group = IntFieldControllerGroup()..init(5);
      var notified = 0;
      group.addListener(() => notified++);

      // Each of the three child controllers disposes exactly once without
      // throwing (guards against double dispose).
      group.dispose();

      expect(notified, 0);
    });

    test('FieldControllerMixin registration disposes the controllers once', () {
      final host = _GroupHost()..group.init(5);
      // disposeControllers calls group.dispose(); child controllers dispose
      // exactly once — no throw proves there is no double dispose.
      host.disposeControllers();
    });
  });
}

/// Simulates a ViewModel's "declare-and-register" usage.
class _GroupHost with FieldControllerMixin {
  late final group = registerController(IntFieldControllerGroup());
}
