import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/view_model/form/field_controller.dart';

void main() {
  test(
    'An empty selection returns the fallback without writing it to state',
    () {
      final controller = EnumFieldController<int>(fallback: 7);
      addTearDown(controller.dispose);

      expect(controller.controller.value, isNull);
      expect(controller.collect(), 7);
      expect(controller.controller.value, isNull);

      controller.init(0);
      expect(controller.controller.value, 0);
      expect(controller.collect(), 0);
    },
  );

  test(
    'String selection keeps an empty string and clearing restores the fallback',
    () {
      final controller = EnumFieldController<String>(fallback: 'default');
      addTearDown(controller.dispose);

      controller.init('zhCN');
      expect(controller.collect(), 'zhCN');
      controller.init('');
      expect(controller.collect(), '');

      controller.controller.value = null;
      expect(controller.collect(), 'default');
    },
  );

  test('Listeners fire once for changes, never for equal values, and stop after removal', () {
    final controller = EnumFieldController<int>(fallback: 0);
    addTearDown(controller.dispose);
    final values = <int?>[];
    void listener() => values.add(controller.controller.value);
    controller.addListener(listener);

    controller.init(1);
    controller.init(1);
    controller.init(2);
    controller.controller.value = null;
    expect(values, [1, 2, null]);

    controller.removeListener(listener);
    controller.init(3);
    expect(values, [1, 2, null]);
  });
}
