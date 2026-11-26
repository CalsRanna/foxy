import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_locale_fields.dart';
import 'package:foxy/infrastructure/dbc/dbc_locale_field_codec.dart';
import 'package:foxy/model/dbc/dbc_locale.dart';
import 'package:foxy/model/locale/database_locale_changes.dart';
import 'package:foxy/model/locale/foxy_locale_editor_delegate.dart';
import 'package:foxy/repository/locale_query_settings.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy/view_model/foxy_state_view_model.dart';
import 'package:foxy/widget/picker/locale/database_locale_editor.dart';
import 'package:foxy/widget/picker/locale/dbc_locale_field_editor.dart';
import 'package:foxy/widget/picker/locale/foxy_locale_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  late FoxyStateViewModel stateVm;

  setUp(() {
    GetIt.instance.registerSingleton(LocaleQuerySettings());
    stateVm = FoxyStateViewModel();
    GetIt.instance.registerSingleton(stateVm);
    stateVm.setLocaleSettings(hasLocaleTables: true, localeEnabled: true);
  });

  tearDown(() => GetIt.instance.reset());

  for (final composite in [false, true]) {
    testWidgets(
      '${composite ? 'Composite-key' : 'Single-key'} database button follows the locale toggle and preserves input',
      (tester) async {
        stateVm.setLocaleSettings(hasLocaleTables: true, localeEnabled: false);
        final controller = StringFieldController()..init('主表内容');
        addTearDown(controller.dispose);
        var loads = 0;
        final FoxyLocaleEditorDelegate delegate = composite
            ? CompositeKeyLocaleEditorDelegate(
                fields: ['locale', 'name'],
                fieldLabels: ['语言', '名称'],
                onLoad: (key) async {
                  loads++;
                  return [];
                },
                onSave: (key, changes) async {},
              )
            : DatabaseLocaleEditorDelegate(
                fields: ['locale', 'name'],
                fieldLabels: ['语言', '名称'],
                onLoad: (entry) async {
                  loads++;
                  return [];
                },
                onSave: (entry, changes) async {},
              );
        await tester.pumpWidget(
          _wrap(
            FoxyLocalePicker(
              entry: composite ? null : 1,
              ownerKey: composite ? (1, 2) : null,
              controller: controller,
              title: '名称',
              delegate: delegate,
            ),
          ),
        );

        expect(find.byIcon(LucideIcons.globe), findsNothing);
        expect(
          tester.widget<ShadInput>(find.byType(ShadInput)).trailing,
          isNull,
        );
        await tester.enterText(find.byType(ShadInput), '未保存的输入');

        stateVm.setLocaleSettings(hasLocaleTables: true, localeEnabled: true);
        await tester.pumpAndSettle();
        expect(find.byIcon(LucideIcons.globe), findsOneWidget);
        expect(
          tester.widget<ShadButton>(find.byType(ShadButton)).enabled,
          isTrue,
        );
        expect(controller.collect(), '未保存的输入');

        stateVm.setLocaleSettings(hasLocaleTables: true, localeEnabled: false);
        await tester.pumpAndSettle();
        expect(find.byIcon(LucideIcons.globe), findsNothing);
        expect(controller.collect(), '未保存的输入');
        expect(loads, 0);
      },
    );
  }

  testWidgets('The standard database delegate opens a dynamic row editor', (
    tester,
  ) async {
    final delegate = DatabaseLocaleEditorDelegate(
      fields: ['locale', 'name'],
      fieldLabels: ['语言', '名称'],
      onLoad: (entry) async => [
        DatabaseLocaleRow.persisted({'locale': 'zhCN', 'name': '测试'}),
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
    // Two-column table: one row = language column + the field's value
    // column
    final inputs = find.descendant(
      of: find.byType(DatabaseLocaleEditor),
      matching: find.byType(ShadInput),
    );
    expect(inputs, findsNWidgets(2));
    expect(find.text('语言'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(DatabaseLocaleEditor),
        matching: find.text('测试'),
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'Changing a database row locale preserves its original identity',
    (tester) async {
      DatabaseLocaleChanges? saved;
      final delegate = DatabaseLocaleEditorDelegate(
        fields: ['locale', 'name'],
        fieldLabels: ['语言', '名称'],
        onLoad: (entry) async => [
          DatabaseLocaleRow.persisted({'locale': 'zhCN', 'name': '测试'}),
        ],
        onSave: (entry, changes) async => saved = changes,
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
      await tester.enterText(find.widgetWithText(ShadInput, 'zhCN'), 'deDE');
      await tester.tap(find.widgetWithText(ShadButton, '保存'));
      await tester.pumpAndSettle();

      expect(saved, isNotNull);
      expect(saved!.rows.single.originalLocale, 'zhCN');
      expect(saved!.rows.single.values['locale'], 'deDE');
      expect(saved!.deletedLocales, isEmpty);
    },
  );

  testWidgets(
    'The standard database editor reports the original locale of a deleted row',
    (tester) async {
      DatabaseLocaleChanges? saved;
      final delegate = DatabaseLocaleEditorDelegate(
        fields: ['locale', 'name'],
        fieldLabels: ['语言', '名称'],
        onLoad: (entry) async => [
          DatabaseLocaleRow.persisted({'locale': 'zhCN', 'name': '测试'}),
        ],
        onSave: (entry, changes) async => saved = changes,
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
      await tester.tap(find.byIcon(LucideIcons.trash));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ShadButton, '保存'));
      await tester.pumpAndSettle();

      expect(saved, isNotNull);
      expect(saved!.rows, isEmpty);
      expect(saved!.deletedLocales, ['zhCN']);
    },
  );

  testWidgets(
    'Disabling the locale join still opens the fixed-row DBC editor without add or delete controls',
    (tester) async {
      stateVm.setLocaleSettings(hasLocaleTables: false, localeEnabled: false);
      final field = DbcLocaleFields.areaTableAreaName;
      final initial = DbcLocaleFieldCodec.empty();
      initial[4] = initial[4].copyWith(value: '艾尔文森林');

      final delegate = DbcLocaleFieldEditorDelegate(
        field: field,
        onLoad: (entry) async => initial,
        onSave: (entry, values) async {},
      );

      // The fixed 16-row editor must be fully visible; enlarge the viewport
      // so 0.8×screen height fits all rows
      tester.view.physicalSize = const Size(1200, 1100);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

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
        expect(find.text(locale.code), findsOneWidget);
      }
    },
  );

  testWidgets('The locale button is disabled for a new record without an ID', (
    tester,
  ) async {
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

  testWidgets('Saving zhCN invokes onSaved synchronously', (tester) async {
    List<DbcLocaleFieldValue>? saved;
    final field = DbcLocaleFields.spellName;
    final initial = DbcLocaleFieldCodec.empty();

    final delegate = DbcLocaleFieldEditorDelegate(
      field: field,
      onLoad: (entry) async => initial,
      onSave: (entry, values) async {},
    );

    // The fixed 16-row editor must be fully visible; enlarge the viewport
    // so 0.8×screen height fits all rows
    tester.view.physicalSize = const Size(1200, 1100);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

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

  testWidgets(
    'A load failure shows one error and leaves the original page open',
    (tester) async {
      final delegate = DbcLocaleFieldEditorDelegate(
        field: DbcLocaleFields.spellName,
        onLoad: (entry) async => throw StateError('DBC record not found'),
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
      expect(find.text('错误'), findsOneWidget);
      expect(find.textContaining('加载失败'), findsOneWidget);
      await tester.tap(find.text('确定'));
      await tester.pumpAndSettle();
      expect(find.text('错误'), findsNothing);
    },
  );

  testWidgets('A save failure keeps the dialog open and displays an error', (
    tester,
  ) async {
    final delegate = DbcLocaleFieldEditorDelegate(
      field: DbcLocaleFields.spellName,
      onLoad: (entry) async => DbcLocaleFieldCodec.empty(),
      onSave: (entry, values) async {
        throw StateError('DBC record not found, cannot save locale');
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

    expect(find.text('错误'), findsOneWidget);
    expect(find.textContaining('保存失败'), findsOneWidget);
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(find.byType(DbcLocaleFieldEditor), findsOneWidget);
    expect(find.textContaining('保存失败'), findsNothing);
  });

  testWidgets(
    'Opening the locale dialog merges the unsaved primary input draft into zhCN',
    (tester) async {
      List<DbcLocaleFieldValue>? persisted;
      final field = DbcLocaleFields.spellName;

      // Old value in the database
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

      // The fixed 16-row editor must be fully visible; enlarge the viewport
      // so 0.8×screen height fits all rows
      tester.view.physicalSize = const Size(1200, 1100);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

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

      // The dialog's zhCN row should show the main-box draft, not the old
      // DB value
      final inputs = find.descendant(
        of: find.byType(DbcLocaleFieldEditor),
        matching: find.byType(ShadInput),
      );
      expect(inputs, findsNWidgets(16));
      final zhCnInput = tester.widget<ShadInput>(inputs.at(4));
      expect(zhCnInput.controller?.text, '主框草稿');

      // Change only enUS and save
      await tester.enterText(inputs.at(0), 'Fireball');
      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      expect(persisted, isNotNull);
      expect(persisted!.zhCN, '主框草稿');
      expect(persisted!.valueOf('enUS'), 'Fireball');
      // The main input keeps its draft, not overwritten by the old DB value
      expect(controller.collect(), '主框草稿');
    },
  );
}

Widget _wrap(Widget child) {
  return ShadApp(
    navigatorKey: FoxyRouter.router.navigatorKey,
    home: Scaffold(body: child),
  );
}
