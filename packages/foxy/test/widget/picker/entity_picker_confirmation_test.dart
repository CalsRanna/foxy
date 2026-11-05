import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/model/picker/signed_entity_source.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/widget/picker/foxy_entity_picker.dart';
import 'package:foxy/widget/picker/foxy_signed_entity_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  for (final kind in ['普通实体', '正数实体', '负数实体']) {
    testWidgets('$kind 查询、重置和翻页后不能确认旧选中值', (tester) async {
      final controller = IntFieldController()
        ..init(kind == '负数实体' ? -999 : 999);
      final pending = <Completer<List<int>>>[];
      Future<List<int>> fetch() {
        final result = Completer<List<int>>();
        pending.add(result);
        return result.future;
      }

      final source = SignedEntitySource(
        title: '选择实体',
        errorLabel: '查询失败',
        fetch: (_, _, _) async => (await fetch())
            .map((id) => SignedEntityBrief(id: id, name: '记录$id'))
            .toList(),
        count: (_, _) async => 100,
      );
      final picker = kind == '普通实体'
          ? FoxyEntityPicker<int>(
              controller: controller,
              delegate: FoxyEntityPickerDelegate<int>(
                title: '选择实体',
                errorLabel: '查询失败',
                filters: const [FoxyEntityPickerFilter('ID')],
                columns: [
                  FoxyEntityPickerColumn<int>(
                    header: '名称',
                    text: (id) => '记录$id',
                  ),
                ],
                idOf: (id) => id,
                fetch: (_, _) => fetch(),
                count: (_) async => 100,
              ),
            )
          : FoxySignedEntityPicker(
              controller: controller,
              positiveSource: source,
              negativeSource: source,
            );
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox());
        controller.dispose();
      });
      await tester.pumpWidget(ShadApp(home: Scaffold(body: picker)));
      await tester.tap(find.byIcon(LucideIcons.search));
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isFalse);

      pending[0].complete([111]);
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isFalse);
      await tester.tap(find.text('记录111'));
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isTrue);

      await tester.tap(find.text('查询'));
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isFalse);
      expect(find.text('记录111'), findsNothing);
      pending[1].complete([222]);
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isFalse);

      await tester.tap(find.text('重置'));
      await tester.pumpAndSettle();
      pending[2].complete([111]);
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isFalse);
      await tester.tap(find.text('记录111'));
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isTrue);

      await tester.tap(find.byIcon(LucideIcons.chevronRight));
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isFalse);
      pending[3].complete([333]);
      await tester.pumpAndSettle();
      expect(_confirmButton(tester).enabled, isFalse);
      await tester.tap(find.text('确定'), warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.byType(ShadDialog), findsOneWidget);

      await tester.tap(find.text('记录333'));
      await tester.pumpAndSettle();
      expect(controller.collect(), kind == '负数实体' ? -999 : 999);
      await tester.tap(find.text('确定'));
      await tester.pumpAndSettle();
      expect(controller.collect(), kind == '负数实体' ? -333 : 333);

      await tester.tap(find.byIcon(LucideIcons.search));
      await tester.pumpAndSettle();
      pending[4].complete([444]);
      await tester.pumpAndSettle();
      await tester.tap(find.text('记录444'));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.text('记录444'));
      await tester.pumpAndSettle();
      expect(controller.collect(), kind == '负数实体' ? -444 : 444);
      expect(find.byType(ShadDialog), findsNothing);
    });
  }
}

ShadButton _confirmButton(WidgetTester tester) =>
    tester.widget<ShadButton>(find.widgetWithText(ShadButton, '确定'));
