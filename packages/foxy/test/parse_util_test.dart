import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';

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

  group('escapeLike', () {
    test('通配符按字面量转义', () {
      expect(escapeLike('100%'), r'100\%');
      expect(escapeLike('a_b'), r'a\_b');
      expect(escapeLike('%_'), r'\%\_');
      expect(escapeLike('plain'), 'plain');
      expect(escapeLike(''), '');
    });

    test('反斜杠先转义,与 %/_ 组合不二次转义', () {
      // Escape order: \\ first, then %/_ — in reverse order, the backslash
      // in \% would be re-escaped.
      // Input `100\%` → `\`→`\\` gives `100\\%`, then `%`→`\%` gives
      // `100\\\%`.
      expect(escapeLike(r'100\%'), r'100\\\%');
      expect(escapeLike(r'\'), r'\\');
      expect(escapeLike(r'\%_'), r'\\\%\_');
      expect(escapeLike(r'a\b%c'), r'a\\b\%c');
    });
  });
}
