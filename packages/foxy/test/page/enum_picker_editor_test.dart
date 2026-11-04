import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:foxy/entity/item_template_entity.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/entity/spell_entity.dart';
import 'package:foxy/page/condition/condition_view.dart';
import 'package:foxy/page/item/item_template_view.dart';
import 'package:foxy/page/smart_script/smart_script_view.dart';
import 'package:foxy/page/spell/spell_view.dart';
import 'package:foxy/repository/condition_repository.dart';
import 'package:foxy/repository/item_template_repository.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:foxy/repository/spell_repository.dart';
import 'package:foxy/view_model/condition_detail_view_model.dart';
import 'package:foxy/view_model/foxy_state_view_model.dart';
import 'package:foxy/view_model/item_template_detail_view_model.dart';
import 'package:foxy/view_model/smart_script_detail_view_model.dart';
import 'package:foxy/view_model/spell_detail_view_model.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:foxy/widget/picker/foxy_enum_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  setUp(() {
    GetIt.instance.registerSingleton(FoxyStateViewModel());
  });

  tearDown(() => GetIt.instance.reset());

  testWidgets('物品类别确认后更新子类别选项，取消保持原类别', (tester) async {
    GetIt.instance.registerSingleton<ItemTemplateRepository>(_ItemRepository());
    final vm = ItemTemplateDetailViewModel();
    await vm.initSignals();
    await _pumpEditor(tester, ItemTemplateView(viewModel: vm));
    await _pick(tester, '类别', 2, confirm: false);
    expect(vm.classNameController.collect(), 0);
    await _pick(tester, '类别', 2);
    expect(vm.classNameController.collect(), 2);
    final subclass = tester.widget<FoxyEnumPicker<int>>(_picker('子类别'));
    expect(subclass.options, ItemConstants.itemSubclasses[2].asMap());
    await _pick(tester, '子类别', 1);
    expect(vm.subclassController.collect(), 1);
    await tester.pumpWidget(const SizedBox());
    vm.dispose();
  });

  testWidgets('SmartAI 动作确认后切换动态枚举并回写参数组', (tester) async {
    GetIt.instance.registerSingleton<SmartScriptRepository>(_SmartRepository());
    final vm = SmartScriptDetailViewModel();
    await vm.initSignals();
    await _pumpEditor(tester, SmartScriptView(viewModel: vm));
    await _pick(tester, '动作类型', 1, confirm: false);
    expect(vm.selectedActionType.value, 0);
    expect(_picker('使用动作目标'), findsNothing);
    await _pick(tester, '动作类型', 1);
    expect(vm.selectedActionType.value, 1);
    expect(vm.actionParam3Controller.editor, IntegerFieldEditor.enumValue);
    await _pick(tester, '使用动作目标', 1);
    expect(vm.actionParam3Controller.collect(), 1);
    await _pick(tester, '动作类型', 4);
    expect(_picker('使用动作目标'), findsNothing);
    expect(_picker('仅自身'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    vm.dispose();
  });

  testWidgets('条件类型切换为枚举后提交值，切回数值保留参数', (tester) async {
    GetIt.instance.registerSingleton<ConditionRepository>(
      ConditionRepository(),
    );
    final vm = ConditionDetailViewModel();
    await vm.initSignals();
    await _pumpEditor(tester, ConditionView(viewModel: vm));
    await _pick(tester, '条件类型', 6);
    expect(vm.selectedConditionType.value, 6);
    expect(vm.conditionValue1Controller.editor, IntegerFieldEditor.enumValue);
    await _pick(tester, '阵营', 469);
    expect(vm.conditionValue1Controller.collect(), 469);
    await _pick(tester, '条件类型', 27);
    expect(vm.conditionValue1Controller.editor, IntegerFieldEditor.number);
    expect(vm.conditionValue1Controller.collect(), 469);
    expect(_picker('阵营'), findsNothing);
    await tester.pumpWidget(const SizedBox());
    vm.dispose();
  });

  testWidgets('法术杂项枚举确认后通过适配控制器回写原字段', (tester) async {
    GetIt.instance.registerSingleton<SpellRepository>(_SpellRepository());
    final vm = SpellDetailViewModel();
    await vm.initSignals();
    await _pumpEditor(tester, SpellView(viewModel: vm));
    await _pick(tester, '效果1 · 类型', 30);
    expect(_picker('效果1 · 能量类型'), findsOneWidget);
    await _pick(tester, '效果1 · 能量类型', 1, confirm: false);
    expect(vm.effectMiscValue0Controller.collect(), 0);
    await _pick(tester, '效果1 · 能量类型', 1);
    expect(vm.effectMiscValue0Controller.collect(), 1);
    await _pick(tester, '效果1 · 类型', 0);
    expect(_picker('效果1 · 能量类型'), findsNothing);
    expect(vm.effectMiscValue0Controller.collect(), 1);
    await tester.pumpWidget(const SizedBox());
    vm.dispose();
  });
}

Finder _picker(String title) => find.byWidgetPredicate(
  (widget) => widget is FoxyEnumPicker<int> && widget.title == title,
);

Future<void> _pumpEditor(WidgetTester tester, Widget editor) async {
  tester.view.physicalSize = const Size(1600, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(ShadApp(home: Scaffold(body: editor)));
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull);
}

Future<void> _pick(
  WidgetTester tester,
  String title,
  int value, {
  bool confirm = true,
}) async {
  final picker = _picker(title);
  final label = tester.widget<FoxyEnumPicker<int>>(picker).options[value]!;
  await tester.ensureVisible(picker);
  await tester.pumpAndSettle();
  await tester.tap(
    find.descendant(of: picker, matching: find.byIcon(LucideIcons.list)),
  );
  await tester.pumpAndSettle();
  await tester.enterText(
    find.descendant(
      of: find.byType(ShadDialog),
      matching: find.byType(EditableText),
    ),
    label,
  );
  await tester.pumpAndSettle();
  await tester.tap(
    find.descendant(
      of: find.byType(FoxyDataTable<MapEntry<int, String>>),
      matching: find.text(label),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(
    find.descendant(
      of: find.byType(ShadDialog),
      matching: find.text(confirm ? '确定' : '取消'),
    ),
  );
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull);
}

class _ItemRepository extends ItemTemplateRepository {
  @override
  Future<ItemTemplateEntity> createItemTemplate() async =>
      const ItemTemplateEntity();
}

class _SmartRepository extends SmartScriptRepository {
  @override
  Future<SmartScriptEntity> createSmartScript({
    int entryOrGuid = 0,
    int sourceType = 0,
  }) async => const SmartScriptEntity();
}

class _SpellRepository extends SpellRepository {
  @override
  Future<SpellEntity> createSpell() async => const SpellEntity();
}
