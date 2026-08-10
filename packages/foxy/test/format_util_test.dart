import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/util/format_util.dart';

void main() {
  group('FormatUtil.formatNum', () {
    test('integers stay unchanged', () {
      expect(FormatUtil.formatNum(1), '1');
      expect(FormatUtil.formatNum(0), '0');
      expect(FormatUtil.formatNum(-7), '-7');
    });

    test('trims trailing zeros on ordinary decimals', () {
      expect(FormatUtil.formatNum(2.0), '2');
      expect(FormatUtil.formatNum(1.50), '1.5');
      expect(FormatUtil.formatNum(1.2300), '1.23');
      expect(FormatUtil.formatNum(-3.1400), '-3.14');
    });

    test('preserves scientific notation exponents', () {
      // Use magnitudes where Dart's double.toString() itself outputs
      // scientific notation, so the assertions do not depend on the VM's
      // specific exponent rendering.
      expect(FormatUtil.formatNum(1.5e-10), '1.5e-10');
      expect(FormatUtil.formatNum(1.5e+30), '1.5e+30');
      expect(FormatUtil.formatNum(-1.5e-10), '-1.5e-10');
      expect(FormatUtil.formatNum(-1.5e+30), '-1.5e+30');
      // Regression: the old implementation trimmed trailing zeros from
      // strings containing e, mangling e-10 / e+30
      expect(FormatUtil.formatNum(1.5e-10), isNot('1.5e-1'));
      expect(FormatUtil.formatNum(1.5e+30), isNot('1.5e+3'));
    });

    test('keeps Dart special double string semantics', () {
      expect(FormatUtil.formatNum(double.nan), double.nan.toString());
      expect(FormatUtil.formatNum(double.infinity), double.infinity.toString());
      expect(
        FormatUtil.formatNum(double.negativeInfinity),
        double.negativeInfinity.toString(),
      );
    });
  });
}
