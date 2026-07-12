import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/util/format_util.dart';

void main() {
  group('formatNum', () {
    test('integers stay unchanged', () {
      expect(formatNum(1), '1');
      expect(formatNum(0), '0');
      expect(formatNum(-7), '-7');
    });

    test('trims trailing zeros on ordinary decimals', () {
      expect(formatNum(2.0), '2');
      expect(formatNum(1.50), '1.5');
      expect(formatNum(1.2300), '1.23');
      expect(formatNum(-3.1400), '-3.14');
    });

    test('preserves scientific notation exponents', () {
      // 使用 Dart double.toString() 本身会输出科学计数法的量级，
      // 避免断言依赖当前 VM 的具体指数写法之外的表示。
      expect(formatNum(1.5e-10), '1.5e-10');
      expect(formatNum(1.5e+30), '1.5e+30');
      expect(formatNum(-1.5e-10), '-1.5e-10');
      expect(formatNum(-1.5e+30), '-1.5e+30');
      // 回归：旧实现对含 e 的串从末尾裁 0，会把 e-10 / e+30 裁坏
      expect(formatNum(1.5e-10), isNot('1.5e-1'));
      expect(formatNum(1.5e+30), isNot('1.5e+3'));
    });

    test('keeps Dart special double string semantics', () {
      expect(formatNum(double.nan), double.nan.toString());
      expect(formatNum(double.infinity), double.infinity.toString());
      expect(
        formatNum(double.negativeInfinity),
        double.negativeInfinity.toString(),
      );
    });
  });
}
