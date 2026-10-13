import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:foxy_generator/src/dart_literal.dart';
import 'package:test/test.dart';

void main() {
  group('dartStringLiteral', () {
    for (final codeUnit in [...List.generate(0x20, (index) => index), 0x7f]) {
      test('round-trips control character $codeUnit', () {
        final value = 'A${String.fromCharCode(codeUnit)}B';
        final literal = dartStringLiteral(value);
        final result = parseString(
          content: 'const value = $literal;',
          throwIfDiagnostics: false,
        );

        expect(result.errors, isEmpty, reason: literal);
        final declaration =
            result.unit.declarations.single as TopLevelVariableDeclaration;
        final initializer =
            declaration.variables.variables.single.initializer as StringLiteral;
        expect(initializer.stringValue, value);
      });
    }
  });
}
