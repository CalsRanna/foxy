import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/smart_script_entity.dart';
import 'package:foxy/page/smart_script/smart_script_list_page.dart';
import 'package:foxy/view_model/smart_script_list_view_model.dart';
import 'package:foxy/repository/smart_script_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() async => GetIt.instance.reset());

  testWidgets('窄窗口下脚本列表的备注列保持有效宽度', (tester) async {
    tester.view.physicalSize = const Size(900, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    GetIt.instance.registerSingleton<SmartScriptRepository>(
      _FakeSmartScriptRepository(),
    );
    GetIt.instance.registerFactory(() => SmartScriptListViewModel());

    await tester.pumpWidget(
      const ShadApp(home: Scaffold(body: SmartScriptListPage())),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('脚本列表'), findsOneWidget);
  });
}

class _FakeSmartScriptRepository extends SmartScriptRepository {
  @override
  Future<int> countSmartScripts({SmartScriptFilter? filter}) async => 0;

  @override
  Future<List<BriefSmartScriptEntity>> getBriefSmartScripts({
    int page = 1,
    SmartScriptFilter? filter,
  }) async => const [];
}
