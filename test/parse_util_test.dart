import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/util/parse_util.dart';

void main() {
  group('parseIntField', () {
    test('empty becomes 0', () {
      expect(parseIntField(''), 0);
      expect(parseIntField('   '), 0);
    });

    test('parses valid integers', () {
      expect(parseIntField('42'), 42);
      expect(parseIntField('-7'), -7);
    });

    test('rejects illegal input instead of silent zero', () {
      expect(() => parseIntField('12a'), throwsFormatException);
      expect(() => parseIntField('1.5'), throwsFormatException);
      expect(() => parseIntField('abc', field: 'entry'), throwsFormatException);
    });
  });

  group('parseDoubleField', () {
    test('empty becomes 0.0', () {
      expect(parseDoubleField(''), 0.0);
    });

    test('parses valid floats', () {
      expect(parseDoubleField('1.5'), 1.5);
      expect(parseDoubleField('-0.25'), -0.25);
    });

    test('rejects illegal input instead of silent zero', () {
      expect(() => parseDoubleField('12a'), throwsFormatException);
      expect(() => parseDoubleField('x', field: 'x'), throwsFormatException);
    });
  });
}
