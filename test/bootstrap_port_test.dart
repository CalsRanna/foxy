import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/page/bootstrap/bootstrap_port.dart';

void main() {
  group('parseMysqlPort', () {
    test('accepts valid ports', () {
      expect(parseMysqlPort('3306'), 3306);
      expect(parseMysqlPort('1'), 1);
      expect(parseMysqlPort('65535'), 65535);
      expect(parseMysqlPort('  3306  '), 3306);
    });

    test('rejects non-numeric input', () {
      expect(parseMysqlPort(''), isNull);
      expect(parseMysqlPort('abc'), isNull);
      expect(parseMysqlPort('33a6'), isNull);
      expect(parseMysqlPort('3.14'), isNull);
    });

    test('rejects out-of-range ports', () {
      expect(parseMysqlPort('0'), isNull);
      expect(parseMysqlPort('-1'), isNull);
      expect(parseMysqlPort('65536'), isNull);
      expect(parseMysqlPort('99999'), isNull);
    });
  });
}
