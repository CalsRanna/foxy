import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/view_model/form/field_parser.dart';

void main() {
  group('FieldParser.parseIntField', () {
    test('empty becomes 0', () {
      expect(FieldParser.parseIntField(''), 0);
      expect(FieldParser.parseIntField('   '), 0);
    });

    test('parses valid integers', () {
      expect(FieldParser.parseIntField('42'), 42);
      expect(FieldParser.parseIntField('-7'), -7);
    });

    test('rejects illegal input instead of silent zero', () {
      expect(() => FieldParser.parseIntField('12a'), throwsFormatException);
      expect(() => FieldParser.parseIntField('1.5'), throwsFormatException);
      expect(
        () => FieldParser.parseIntField('abc', field: 'entry'),
        throwsFormatException,
      );
    });
  });

  group('FieldParser.parseDoubleField', () {
    test('empty becomes 0.0', () {
      expect(FieldParser.parseDoubleField(''), 0.0);
    });

    test('parses valid floats', () {
      expect(FieldParser.parseDoubleField('1.5'), 1.5);
      expect(FieldParser.parseDoubleField('-0.25'), -0.25);
    });

    test('rejects illegal input instead of silent zero', () {
      expect(() => FieldParser.parseDoubleField('12a'), throwsFormatException);
      expect(
        () => FieldParser.parseDoubleField('x', field: 'x'),
        throwsFormatException,
      );
    });
  });
}
