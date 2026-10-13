import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The picker dialog runs the list query and the count query side by side,
/// driven by delegates whose completion the test controls explicitly.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('同一次搜索并行发起列表与总数查询', (tester) async {
    final rec = _RecordingDelegate();
    await _openPicker(tester, rec);
    _completeSearch(rec, 0, rows: const [111], total: 1);
    await tester.pumpAndSettle();
    expect(find.text('111'), findsOneWidget);

    await tester.tap(find.widgetWithText(ShadButton, '查询'));
    await tester.pump();

    // Both queries of the second search are already in flight while neither
    // has returned — a serial implementation would not have started `count`
    // yet (it awaits `fetch` first).
    expect(rec.pendingFetches, hasLength(2));
    expect(rec.pendingCounts, hasLength(2));

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('过期搜索结果不覆盖最新结果', (tester) async {
    final rec = _RecordingDelegate();
    await _openPicker(tester, rec);
    _completeSearch(rec, 0, rows: const [111], total: 1);
    await tester.pumpAndSettle();

    // Search #2 (stale) and #3 (fresh) are both issued; #3 returns first.
    await tester.tap(find.widgetWithText(ShadButton, '查询'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ShadButton, '查询'));
    await tester.pump();

    _completeSearch(rec, 2, rows: const [777], total: 7);
    await tester.pumpAndSettle();
    expect(find.text('777'), findsOneWidget);

    // The slow, earlier search lands last but must be discarded.
    _completeSearch(rec, 1, rows: const [888], total: 3);
    await tester.pumpAndSettle();
    expect(find.text('777'), findsOneWidget);
    expect(find.text('888'), findsNothing);

    await tester.pumpWidget(const SizedBox());
  });
}

Future<void> _openPicker(WidgetTester tester, _RecordingDelegate rec) async {
  await tester.pumpWidget(
    ShadApp(
      home: Scaffold(
        body: FoxyEntityPicker<int>(
          controller: IntFieldController(),
          delegate: rec.delegate,
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.tap(find.byIcon(LucideIcons.search));
  await tester.pumpAndSettle();
}

void _completeSearch(
  _RecordingDelegate rec,
  int index, {
  required List<int> rows,
  required int total,
}) {
  rec.pendingFetches[index].complete(rows);
  rec.pendingCounts[index].complete(total);
}

/// Delegate whose list/count queries each hand back a [Completer], so a test
/// can control which search returns first and hold one in flight.
class _RecordingDelegate {
  final pendingFetches = <Completer<List<int>>>[];
  final pendingCounts = <Completer<int>>[];

  late final FoxyEntityPickerDelegate<int> delegate =
      FoxyEntityPickerDelegate<int>(
        title: '测试',
        errorLabel: '搜索失败',
        filters: const [FoxyEntityPickerFilter('ID')],
        columns: [
          FoxyEntityPickerColumn<int>(
            header: '编号',
            width: 120,
            text: (value) => value.toString(),
          ),
        ],
        idOf: (value) => value,
        fetch: (page, values) {
          final completer = Completer<List<int>>();
          pendingFetches.add(completer);
          return completer.future;
        },
        count: (values) {
          final completer = Completer<int>();
          pendingCounts.add(completer);
          return completer.future;
        },
      );
}
