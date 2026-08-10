import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/util/parse_util.dart';

void main() {
  group('ParseUtil.parseIntField', () {
    test('empty becomes 0', () {
      expect(ParseUtil.parseIntField(''), 0);
      expect(ParseUtil.parseIntField('   '), 0);
    });

    test('parses valid integers', () {
      expect(ParseUtil.parseIntField('42'), 42);
      expect(ParseUtil.parseIntField('-7'), -7);
    });

    test('rejects illegal input instead of silent zero', () {
      expect(() => ParseUtil.parseIntField('12a'), throwsFormatException);
      expect(() => ParseUtil.parseIntField('1.5'), throwsFormatException);
      expect(() => ParseUtil.parseIntField('abc', field: 'entry'), throwsFormatException);
    });
  });

  group('ParseUtil.parseDoubleField', () {
    test('empty becomes 0.0', () {
      expect(ParseUtil.parseDoubleField(''), 0.0);
    });

    test('parses valid floats', () {
      expect(ParseUtil.parseDoubleField('1.5'), 1.5);
      expect(ParseUtil.parseDoubleField('-0.25'), -0.25);
    });

    test('rejects illegal input instead of silent zero', () {
      expect(() => ParseUtil.parseDoubleField('12a'), throwsFormatException);
      expect(() => ParseUtil.parseDoubleField('x', field: 'x'), throwsFormatException);
    });
  });

  group('ParseUtil.escapeLike', () {
    test('通配符按字面量转义', () {
      expect(ParseUtil.escapeLike('100%'), r'100\%');
      expect(ParseUtil.escapeLike('a_b'), r'a\_b');
      expect(ParseUtil.escapeLike('%_'), r'\%\_');
      expect(ParseUtil.escapeLike('plain'), 'plain');
      expect(ParseUtil.escapeLike(''), '');
    });

    test('反斜杠先转义,与 %/_ 组合不二次转义', () {
      // Escape order: \\ first, then %/_ — in reverse order, the backslash
      // in \% would be re-escaped.
      // Input `100\%` → `\`→`\\` gives `100\\%`, then `%`→`\%` gives
      // `100\\\%`.
      expect(ParseUtil.escapeLike(r'100\%'), r'100\\\%');
      expect(ParseUtil.escapeLike(r'\'), r'\\');
      expect(ParseUtil.escapeLike(r'\%_'), r'\\\%\_');
      expect(ParseUtil.escapeLike(r'a\b%c'), r'a\\b\%c');
    });
  });
}
