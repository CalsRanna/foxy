import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/skill_line_entity.dart';
import 'package:foxy/repository/skill_line_repository.dart';
import 'package:foxy/widget/foxy_entity_picker.dart';
import 'package:foxy/widget/foxy_entity_picker_delegates.dart';
import 'package:foxy/widget/foxy_icon_text.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('专业技能 picker 的名称列显示法术图标', (tester) async {
    GetIt.instance.registerSingleton<SkillLineRepository>(
      _FakeSkillLineRepository(),
    );

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: FoxyEntityPicker<BriefSkillLineEntity>(
            controller: IntFieldController(),
            delegate: FoxyEntityPickerDelegates.skillLine,
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byIcon(LucideIcons.search));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);

    final iconText = tester.widget<FoxyIconText>(find.byType(FoxyIconText));
    expect(iconText.iconPath, 'Interface\\Icons\\Trade_BlackSmithing');
    expect(iconText.name, '锻造');

    await tester.pumpWidget(const SizedBox());
  });
}

class _FakeSkillLineRepository extends SkillLineRepository {
  @override
  Future<int> countSkillLines({SkillLineFilter? filter}) async => 1;

  @override
  Future<List<BriefSkillLineEntity>> getBriefSkillLines({
    int page = 1,
    SkillLineFilter? filter,
  }) async => const [
    BriefSkillLineEntity(
      id: 164,
      displayNameZhCN: '锻造',
      textureFilename: 'Interface\\Icons\\Trade_BlackSmithing',
    ),
  ];
}
