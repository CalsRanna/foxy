import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/database/parse_util.dart';

void main() {
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
