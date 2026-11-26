import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/model/activity_log_details.dart';
import 'package:foxy/page/dashboard/component/trend.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets(
    'Clicking an activity opens a dismissible dialog with line-by-line differences',
    (tester) async {
      final activity = ActivityLogEntity(
        module: 'creature_template',
        actionType: ActivityActionType.update,
        entityName: '巡逻兵',
        createdAt: DateTime(2026, 11, 23, 12, 34, 56),
        details: const ActivityLogDetails([
          ActivityRowChange(
            table: 'creature_template',
            beforeKey: {'entry': 123},
            afterKey: {'entry': 123},
            changes: {
              'minlevel': ActivityFieldChange(12, 15),
              'description': ActivityFieldChange('common\nold', 'common\nnew'),
            },
          ),
        ]),
      );
      await tester.pumpWidget(
        ShadApp(
          home: Scaffold(body: Trend(activities: [activity])),
        ),
      );

      final summary = find.text('更新 巡逻兵 · 2 个字段');
      final dialog = find.byType(ShadDialog);
      expect(dialog, findsNothing);
      expect(find.text('最低等级  12 → 15'), findsNothing);
      await tester.tap(summary);
      await tester.pumpAndSettle();

      expect(dialog, findsOneWidget);
      expect(
        find.descendant(of: dialog, matching: find.text('最低等级  12 → 15')),
        findsOneWidget,
      );
      expect(find.text('creature_template · entry=123'), findsOneWidget);
      expect(
        find.text('creature_template · 2026-11-23 12:34:56'),
        findsOneWidget,
      );
      expect(find.textContaining('− old\n+ new'), findsOneWidget);

      await tester.tap(find.text('关闭'));
      await tester.pumpAndSettle();

      expect(dialog, findsNothing);
      expect(find.text('最低等级  12 → 15'), findsNothing);
      expect(summary, findsOneWidget);
    },
  );

  testWidgets(
    'Long diffs scroll in narrow windows and the close button remains clickable',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 320));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final activity = ActivityLogEntity(
        module: 'creature_template',
        actionType: ActivityActionType.update,
        entityName: '巡逻兵',
        createdAt: DateTime(2026, 11, 23),
        details: ActivityLogDetails([
          ActivityRowChange(
            table: 'creature_template',
            beforeKey: const {'entry': 123},
            afterKey: const {'entry': 123},
            changes: {
              'description': ActivityFieldChange(
                List.filled(40, '旧行').join('\n'),
                List.filled(40, '新行').join('\n'),
              ),
            },
          ),
        ]),
      );
      await tester.pumpWidget(
        ShadApp(
          home: Scaffold(body: Trend(activities: [activity])),
        ),
      );
      await tester.tap(find.text('更新 巡逻兵 · 1 个字段'));
      await tester.pumpAndSettle();

      final scrollable = find.descendant(
        of: find.byType(ShadDialog),
        matching: find.byType(Scrollable),
      );
      final position = tester.state<ScrollableState>(scrollable).position;
      expect(position.maxScrollExtent, greaterThan(0));
      await tester.drag(scrollable, const Offset(0, -150));
      await tester.pumpAndSettle();
      expect(position.pixels, greaterThan(0));

      await tester.tap(find.text('关闭'));
      await tester.pumpAndSettle();
      expect(find.byType(ShadDialog), findsNothing);
    },
  );
}
