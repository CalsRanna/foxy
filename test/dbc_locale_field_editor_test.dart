import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/entity/dbc_locale.dart';
import 'package:foxy/infrastructure/dbc/dbc_locale_field_codec.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/dbc_locale_field_editor.dart';
import 'package:foxy/widget/foxy_locale_crud_dialog.dart';
import 'package:foxy/widget/foxy_locale_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) {
  return ShadApp(home: Scaffold(body: child));
}

void main() {
  testWidgets('普通数据库 Delegate 打开动态行编辑器', (tester) async {
    final delegate = DatabaseLocaleEditorDelegate(
      fields: ['locale', 'name'],
      fieldLabels: ['语言', '名称'],
      onLoad: (entry) async => [
        {'locale': 'zhCN', 'name': '测试'},
      ],
      onSave: (entry, data) async {},
    );

    await tester.pumpWidget(
      _wrap(
        FoxyLocalePicker(
          entry: 1,
          controller: StringFieldController()..init('测试'),
          title: '名称',
          delegate: delegate,
        ),
      ),
    );

    await tester.tap(find.byIcon(LucideIcons.globe));
    await tester.pumpAndSettle();

    expect(find.byType(DatabaseLocaleEditor), findsOneWidget);
    expect(find.text('添加'), findsOneWidget);
    expect(find.byIcon(LucideIcons.trash), findsOneWidget);
  });

  testWidgets('DBC Delegate 打开固定行编辑器且无添加删除', (tester) async {
    final field = DbcLocaleFields.areaTableAreaName;
    final initial = DbcLocaleFieldCodec.empty();
    initial[4] = initial[4].copyWith(value: '艾尔文森林');

    final delegate = DbcLocaleFieldEditorDelegate(
      field: field,
      onLoad: (entry) async => initial,
      onSave: (entry, values) async {},
    );

    await tester.pumpWidget(
      _wrap(
        FoxyLocalePicker(
          entry: 12,
          controller: StringFieldController()..init('艾尔文森林'),
          title: '区域名称本地化',
          delegate: delegate,
        ),
      ),
    );

    await tester.tap(find.byIcon(LucideIcons.globe));
    await tester.pumpAndSettle();

    expect(find.byType(DbcLocaleFieldEditor), findsOneWidget);
    expect(find.text('添加'), findsNothing);
    expect(find.byIcon(LucideIcons.trash), findsNothing);
    expect(find.text('语言编号'), findsOneWidget);
    expect(find.text('区域名称'), findsOneWidget);

    for (final locale in DbcLocale.values) {
      expect(find.text(locale.displayCode), findsOneWidget);
    }
  });

  testWidgets('新记录尚无 ID 时地球按钮不可用', (tester) async {
    final delegate = DbcLocaleFieldEditorDelegate(
      field: DbcLocaleFields.spellName,
      onLoad: (entry) async => DbcLocaleFieldCodec.empty(),
      onSave: (entry, values) async {},
    );

    await tester.pumpWidget(
      _wrap(
        FoxyLocalePicker(
          entry: null,
          controller: StringFieldController(),
          title: '法术名称本地化',
          delegate: delegate,
        ),
      ),
    );

    final button = tester.widget<ShadButton>(find.byType(ShadButton));
    expect(button.enabled, isFalse);

    await tester.tap(find.byIcon(LucideIcons.globe), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byType(DbcLocaleFieldEditor), findsNothing);
  });

  testWidgets('长文本字段使用多行输入', (tester) async {
    final field = DbcLocaleFields.spellDescription;
    expect(field.multiline, isTrue);

    await tester.pumpWidget(
      _wrap(
        DbcLocaleFieldEditor(
          title: '法术描述本地化',
          entry: 1,
          field: field,
          initialValues: DbcLocaleFieldCodec.empty(),
          onSave: (values) async {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    final inputs = tester.widgetList<ShadInput>(find.byType(ShadInput));
    expect(inputs, isNotEmpty);
    expect(inputs.every((input) => (input.maxLines ?? 1) > 1), isTrue);
  });

  testWidgets('保存 zhCN 后 onSaved 同步回调', (tester) async {
    List<DbcLocaleFieldValue>? saved;
    final field = DbcLocaleFields.spellName;
    final initial = DbcLocaleFieldCodec.empty();

    final delegate = DbcLocaleFieldEditorDelegate(
      field: field,
      onLoad: (entry) async => initial,
      onSave: (entry, values) async {},
    );

    await tester.pumpWidget(
      _wrap(
        FoxyLocalePicker(
          entry: 133,
          controller: StringFieldController(),
          title: '法术名称本地化',
          delegate: delegate,
          onSaved: (values) => saved = values,
        ),
      ),
    );

    await tester.tap(find.byIcon(LucideIcons.globe));
    await tester.pumpAndSettle();

    final zhCnFinder = find.descendant(
      of: find.byType(DbcLocaleFieldEditor),
      matching: find.byType(ShadInput),
    );
    expect(zhCnFinder, findsNWidgets(16));
    await tester.enterText(zhCnFinder.at(4), '寒冰箭');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    expect(saved, isNotNull);
    expect(saved!.zhCN, '寒冰箭');
  });

  testWidgets('加载失败时不打开弹窗并返回 null', (tester) async {
    final delegate = DbcLocaleFieldEditorDelegate(
      field: DbcLocaleFields.spellName,
      onLoad: (entry) async => throw StateError('DBC 记录不存在'),
      onSave: (entry, values) async {},
    );

    await tester.pumpWidget(
      _wrap(
        FoxyLocalePicker(
          entry: 1,
          controller: StringFieldController(),
          title: '法术名称本地化',
          delegate: delegate,
        ),
      ),
    );

    await tester.tap(find.byIcon(LucideIcons.globe));
    await tester.pumpAndSettle();

    expect(find.byType(DbcLocaleFieldEditor), findsNothing);
  });

  testWidgets('保存失败时保留弹窗并显示错误', (tester) async {
    final delegate = DbcLocaleFieldEditorDelegate(
      field: DbcLocaleFields.spellName,
      onLoad: (entry) async => DbcLocaleFieldCodec.empty(),
      onSave: (entry, values) async {
        throw StateError('DBC 记录不存在，无法保存本地化');
      },
    );

    await tester.pumpWidget(
      _wrap(
        FoxyLocalePicker(
          entry: 1,
          controller: StringFieldController()..init('草稿'),
          title: '法术名称本地化',
          delegate: delegate,
        ),
      ),
    );

    await tester.tap(find.byIcon(LucideIcons.globe));
    await tester.pumpAndSettle();
    expect(find.byType(DbcLocaleFieldEditor), findsOneWidget);

    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    // 弹窗仍在，错误信息可见（弹窗内 banner + 可能的 Toast 各一份）
    expect(find.byType(DbcLocaleFieldEditor), findsOneWidget);
    expect(find.textContaining('保存失败'), findsAtLeastNWidgets(1));
  });

  testWidgets('主输入框未保存草稿在打开弹窗时合并进 zhCN', (tester) async {
    List<DbcLocaleFieldValue>? persisted;
    final field = DbcLocaleFields.spellName;

    // 数据库里的旧值
    final fromDb = [
      for (final locale in DbcLocale.values)
        DbcLocaleFieldValue(
          locale: locale,
          value: locale.code == 'zhCN' ? '库中旧值' : 'en_slot_${locale.code}',
        ),
    ];

    final delegate = DbcLocaleFieldEditorDelegate(
      field: field,
      onLoad: (entry) async => fromDb,
      onSave: (entry, values) async {
        persisted = values;
      },
    );

    final controller = StringFieldController()..init('主框草稿');

    await tester.pumpWidget(
      _wrap(
        FoxyLocalePicker(
          entry: 42,
          controller: controller,
          title: '法术名称本地化',
          delegate: delegate,
          onSaved: (values) {
            controller.init(values.zhCN);
          },
        ),
      ),
    );

    await tester.tap(find.byIcon(LucideIcons.globe));
    await tester.pumpAndSettle();

    // 弹窗 zhCN 行应显示主框草稿，而非库中旧值
    final inputs = find.descendant(
      of: find.byType(DbcLocaleFieldEditor),
      matching: find.byType(ShadInput),
    );
    expect(inputs, findsNWidgets(16));
    final zhCnInput = tester.widget<ShadInput>(inputs.at(4));
    expect(zhCnInput.controller?.text, '主框草稿');

    // 只改 enUS，保存
    await tester.enterText(inputs.at(0), 'Fireball');
    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    expect(persisted, isNotNull);
    expect(persisted!.zhCN, '主框草稿');
    expect(persisted!.valueOf('enUS'), 'Fireball');
    // 主输入框保持草稿，未被库中旧值冲掉
    expect(controller.collect(), '主框草稿');
  });
}
