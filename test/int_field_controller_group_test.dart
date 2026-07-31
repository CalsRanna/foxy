import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/integer_field_spec.dart';
import 'package:foxy/widget/form/field_controller.dart';

/// 模拟 ViewModel 的「声明即注册」用法。
class _GroupHost with FieldControllerMixin {
  late final group = registerController(IntFieldControllerGroup());
}

void main() {
  group('IntFieldControllerGroup', () {
    test('init(7) 后三个 typed controller 都是 7', () {
      final group = IntFieldControllerGroup();
      group.init(7);

      expect(group.numberController.collect(), 7);
      expect(group.selectController.collect(), 7);
      expect(group.flagController.collect(), 7);
      expect(group.collect(), 7);

      group.dispose();
    });

    test('select 修改为 1 后 number/flags 同步为 1', () {
      final group = IntFieldControllerGroup();
      group.init(0);

      group.selectController.init(1);

      expect(group.numberController.collect(), 1);
      expect(group.flagController.collect(), 1);
      expect(group.selectController.collect(), 1);
      expect(group.collect(), 1);

      group.dispose();
    });

    test('number 输入修改后 select/flags 同步', () {
      final group = IntFieldControllerGroup();
      group.init(0);

      group.numberController.controller.text = '42';

      expect(group.selectController.collect(), 42);
      expect(group.flagController.collect(), 42);

      group.dispose();
    });

    test('flags 修改后 number/select 同步', () {
      final group = IntFieldControllerGroup();
      group.init(0);

      group.flagController.controller.text = '9 (0x00000009)';

      expect(group.numberController.collect(), 9);
      expect(group.selectController.collect(), 9);

      group.dispose();
    });

    test('collect() 按当前 editor 转发', () {
      final group = IntFieldControllerGroup()..init(5);

      group.configure(IntegerFieldEditor.select);
      group.selectController.init(3);
      expect(group.collect(), 3);

      group.configure(IntegerFieldEditor.flags);
      expect(group.collect(), 3);

      group.configure(IntegerFieldEditor.reference);
      group.numberController.controller.text = '11';
      expect(group.collect(), 11);

      group.dispose();
    });

    test('number 非法非空文本在 number editor 下 collect() 抛 FormatException', () {
      final group = IntFieldControllerGroup()..init(5);

      group.numberController.controller.text = '12a';

      expect(() => group.collect(), throwsFormatException);

      group.dispose();
    });

    test('number 非法草稿不同步、不通知，最后合法整数保留', () {
      final group = IntFieldControllerGroup()..init(7);
      var notified = 0;
      group.addListener(() => notified++);

      group.numberController.controller.text = '-';

      expect(notified, 0);
      expect(group.numberController.controller.text, '-');
      expect(group.selectController.collect(), 7);

      group.dispose();
    });

    test('从非法 number 草稿切到 select 时恢复最后合法整数', () {
      final group = IntFieldControllerGroup()..init(7);
      group.numberController.controller.text = '-';

      group.configure(IntegerFieldEditor.select);

      expect(group.numberController.controller.text, '7');
      expect(group.selectController.collect(), 7);
      expect(group.collect(), 7);

      group.dispose();
    });

    test('editor 不变时 configure 幂等，不丢弃非法文本', () {
      final group = IntFieldControllerGroup()..init(7);
      group.numberController.controller.text = '-';

      group.configure(IntegerFieldEditor.number);

      expect(group.numberController.controller.text, '-');
      expect(group.editor, IntegerFieldEditor.number);

      group.dispose();
    });

    test('多次 configure 不产生重复通知', () {
      final group = IntFieldControllerGroup()..init(0);
      var notified = 0;
      group.addListener(() => notified++);

      group.configure(IntegerFieldEditor.select);
      group.configure(IntegerFieldEditor.select);
      group.configure(IntegerFieldEditor.number);
      group.configure(IntegerFieldEditor.number);

      expect(notified, 0);

      group.dispose();
    });

    test('同步不产生空通知（值未变化的 init 不通知）', () {
      final group = IntFieldControllerGroup()..init(5);
      var notified = 0;
      group.addListener(() => notified++);

      group.init(5);
      group.numberController.init(5);

      expect(notified, 0);

      group.dispose();
    });

    test('值实际变化时通知一次', () {
      final group = IntFieldControllerGroup()..init(5);
      var notified = 0;
      group.addListener(() => notified++);

      group.init(9);

      expect(notified, 1);

      group.dispose();
    });

    test('dispose 无异常且之后无通知', () {
      final group = IntFieldControllerGroup()..init(5);
      var notified = 0;
      group.addListener(() => notified++);

      // 三个子 controller 各释放一次，不抛异常（防重复 dispose）。
      group.dispose();

      expect(notified, 0);
    });

    test('通过 FieldControllerMixin 注册时统一释放且不双重 dispose', () {
      final host = _GroupHost()..group.init(5);
      // disposeControllers 调用 group.dispose()；子 controller 只释放一次，
      // 不抛异常即证明无重复 dispose。
      host.disposeControllers();
    });
  });
}
