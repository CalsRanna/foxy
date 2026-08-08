// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

/// Syntax-level source-shape checks shared by the readers.
///
/// The readers validate the hand-written source against the generated-part
/// contract: the `part '...g.dart'` directive, the conventional mixin in the
/// with clause, hand-written member declarations (e.g. query-method
/// overrides), and the `fromJson` factory delegation.
///
/// These checks parse the input with the analyzer's syntax-only
/// [parseString] and inspect the AST, so they are robust to formatting
/// variations (line breaks, quote style, body shape) and work even before
/// the generated part file exists — no symbol resolution involved.
final class SourceShape {
  const SourceShape();

  /// Parses the builder's current input file into a [CompilationUnit].
  ///
  /// [errorElement] anchors the diagnostic when the file cannot be read.
  Future<CompilationUnit> parseInput(
    BuildStep buildStep,
    Element errorElement,
  ) async {
    final source = await buildStep.readAsString(buildStep.inputId);
    final result = parseString(
      content: source,
      path: buildStep.inputId.path,
      // Parse errors surface through the class-lookup checks below (which
      // report precise conventions), not as a raw ArgumentError.
      throwIfDiagnostics: false,
    );
    return result.unit;
  }

  /// The class declaration named [className], or null when absent.
  ClassDeclaration? classDeclaration(CompilationUnit unit, String className) {
    for (final declaration in unit.declarations) {
      if (declaration is ClassDeclaration &&
          declaration.namePart.typeName.lexeme == className) {
        return declaration;
      }
    }
    return null;
  }

  /// The names of the mixins applied by the class's with clause, in order.
  List<String> withClauseTypeNames(ClassDeclaration cls) {
    final withClause = cls.withClause;
    if (withClause == null) return const [];
    return [
      for (final type in withClause.mixinTypes) type.name.lexeme,
    ];
  }

  /// Whether the library declares `part '<partName>';` (single or double
  /// quotes, any indentation).
  bool hasPartDirective(CompilationUnit unit, String partName) {
    for (final directive in unit.directives) {
      if (directive is PartDirective &&
          directive.uri.stringValue == partName) {
        return true;
      }
    }
    return false;
  }

  /// Whether the class itself declares a member (method, getter, setter, or
  /// field) named [memberName].
  ///
  /// Members contributed by mixed-in mixins are not counted: callers ask
  /// whether the *hand-written class* declares the member (e.g. to require
  /// a query-method override or to reject a hand-written `_table`).
  bool declaresMember(ClassDeclaration cls, String memberName) {
    for (final member in cls.members) {
      switch (member) {
        case MethodDeclaration():
          if (member.name.lexeme == memberName) return true;
        case FieldDeclaration():
          for (final variable in member.fields.variables) {
            if (variable.name.lexeme == memberName) return true;
          }
        default:
          break;
      }
    }
    return false;
  }

  /// The constructor named [ctorName] declared on [cls], or null.
  ConstructorDeclaration? constructor(
    ClassDeclaration cls,
    String ctorName,
  ) {
    for (final member in cls.members) {
      if (member is ConstructorDeclaration &&
          member.name?.lexeme == ctorName) {
        return member;
      }
    }
    return null;
  }

  /// Whether [ctor] is a factory constructor whose body delegates to
  /// `<mixinName>.fromJson(...)` with exactly one argument — either an arrow
  /// body or a block body ending in `return <mixinName>.fromJson(...);`.
  bool factoryDelegatesTo(ConstructorDeclaration ctor, String mixinName) {
    if (ctor.factoryKeyword == null) return false;
    final invocation = _delegationInvocation(ctor.body);
    if (invocation == null) return false;
    final target = invocation.target;
    return invocation.methodName.token.lexeme == 'fromJson' &&
        invocation.argumentList.arguments.length == 1 &&
        target is SimpleIdentifier &&
        target.token.lexeme == mixinName;
  }

  MethodInvocation? _delegationInvocation(FunctionBody body) {
    if (body is ExpressionFunctionBody) {
      final expression = body.expression;
      if (expression is MethodInvocation) return expression;
    } else if (body is BlockFunctionBody) {
      final statements = body.block.statements;
      if (statements.length == 1 && statements.single is ReturnStatement) {
        final returned = (statements.single as ReturnStatement).expression;
        if (returned is MethodInvocation) return returned;
      }
    }
    return null;
  }
}
