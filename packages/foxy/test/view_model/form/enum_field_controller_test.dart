import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/view_model/form/field_controller.dart';

void main() {
  test('未选择时返回 fallback，但不将其写入状态', () {
    final controller = EnumFieldController<int>(fallback: 7);
    addTearDown(controller.dispose);

    expect(controller.controller.value, isNull);
    expect(controller.collect(), 7);
    expect(controller.controller.value, isNull);

    controller.init(0);
    expect(controller.controller.value, 0);
    expect(controller.collect(), 0);
  });

  test('字符串选择保留空字符串，清空选择后恢复 fallback', () {
    final controller = EnumFieldController<String>(fallback: 'default');
    addTearDown(controller.dispose);

    controller.init('zhCN');
    expect(controller.collect(), 'zhCN');
    controller.init('');
    expect(controller.collect(), '');

    controller.controller.value = null;
    expect(controller.collect(), 'default');
  });

  test('值变化通知一次，相同值不通知，移除监听后不再通知', () {
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
