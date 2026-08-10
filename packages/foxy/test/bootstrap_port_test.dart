import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/page/bootstrap/bootstrap_port.dart';

void main() {
  group('BootstrapPort.parse', () {
    test('accepts valid ports', () {
      expect(BootstrapPort.parse('3306'), 3306);
      expect(BootstrapPort.parse('1'), 1);
      expect(BootstrapPort.parse('65535'), 65535);
      expect(BootstrapPort.parse('  3306  '), 3306);
    });

    test('rejects non-numeric input', () {
      expect(BootstrapPort.parse(''), isNull);
      expect(BootstrapPort.parse('abc'), isNull);
      expect(BootstrapPort.parse('33a6'), isNull);
      expect(BootstrapPort.parse('3.14'), isNull);
    });

    test('rejects out-of-range ports', () {
      expect(BootstrapPort.parse('0'), isNull);
      expect(BootstrapPort.parse('-1'), isNull);
      expect(BootstrapPort.parse('65536'), isNull);
      expect(BootstrapPort.parse('99999'), isNull);
    });
  });
}
