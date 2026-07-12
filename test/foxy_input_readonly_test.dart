import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/foxy_input_readonly.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  Widget wrap(Widget child) {
    return ShadApp(
      home: Directionality(textDirection: TextDirection.ltr, child: child),
    );
  }

  testWidgets('editable returns null presentation', (tester) async {
    late FoxyReadonlyInput resolved;
    await tester.pumpWidget(
      wrap(
        Builder(
          builder: (context) {
            resolved = FoxyReadonlyInput.resolve(context, readOnly: false);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(resolved.readOnly, isFalse);
    expect(resolved.style, isNull);
    expect(resolved.decoration, isNull);
    expect(resolved.mouseCursor, isNull);
    expect(resolved.showCursor, isNull);
  });

  testWidgets('display role uses muted look and forbidden cursor', (
    tester,
  ) async {
    late FoxyReadonlyInput resolved;
    await tester.pumpWidget(
      wrap(
        Builder(
          builder: (context) {
            resolved = FoxyReadonlyInput.resolve(
              context,
              readOnly: true,
              role: FoxyReadonlyInputRole.display,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(resolved.readOnly, isTrue);
    expect(resolved.style, isNotNull);
    expect(resolved.decoration?.color, isNotNull);
    expect(resolved.mouseCursor, SystemMouseCursors.forbidden);
    expect(resolved.showCursor, isFalse);
  });

  testWidgets('interactive role uses click cursor', (tester) async {
    late FoxyReadonlyInput resolved;
    await tester.pumpWidget(
      wrap(
        Builder(
          builder: (context) {
            resolved = FoxyReadonlyInput.resolve(
              context,
              readOnly: true,
              role: FoxyReadonlyInputRole.interactive,
            );
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(resolved.mouseCursor, SystemMouseCursors.click);
    expect(resolved.showCursor, isFalse);
    expect(resolved.decoration?.color, isNotNull);
  });

  testWidgets('wrap is identity when editable, MouseRegion when readOnly', (
    tester,
  ) async {
    late Widget editableWrapped;
    late Widget readonlyWrapped;
    await tester.pumpWidget(
      wrap(
        Builder(
          builder: (context) {
            final editable = FoxyReadonlyInput.resolve(
              context,
              readOnly: false,
            );
            final readonly = FoxyReadonlyInput.resolve(context, readOnly: true);
            const child = SizedBox.shrink();
            editableWrapped = editable.wrap(child);
            readonlyWrapped = readonly.wrap(child);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(editableWrapped, isA<SizedBox>());
    expect(readonlyWrapped, isA<MouseRegion>());
    expect(
      (readonlyWrapped as MouseRegion).cursor,
      SystemMouseCursors.forbidden,
    );
  });
}
