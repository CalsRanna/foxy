import 'dart:io';

import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/page/setting/icon_extract_dialog.dart';
import 'package:foxy/view_model/icon_extract_workflow_view_model.dart';
import 'package:foxy/page/workflow/workflow_status.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:shadcn_ui/shadcn_ui.dart';

/// 同步 ConfigUtil：load 无真实 IO（测试环境不需要 runAsync）。
final class _SyncConfigUtil extends ConfigUtil {
  _SyncConfigUtil(this._dir);

  final String _dir;

  @override
  String get configPath => p.join(_dir, 'config.yaml');

  @override
  Future<Map<String, dynamic>> load() async => {};
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late ConfigUtil configUtil;
  late IconExtractWorkflowViewModel vm;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_icon_dialog_test_');
    configUtil = _SyncConfigUtil(tempDir.path);
    vm = IconExtractWorkflowViewModel(
      useCase: ExtractGameIconsUseCase(
        configUtil: configUtil,
        outputDir: p.join(tempDir.path, 'out'),
      ),
      configUtil: configUtil,
    );
  });

  tearDown(() {
    vm.dispose();
    tempDir.deleteSync(recursive: true);
  });

  Future<void> pumpDialog(WidgetTester tester) async {
    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: IconExtractDialog(vm: vm),
        ),
      ),
    );
    await tester.pump(); // 完成 _prepare（同步 config 微任务）
    await tester.pump();
  }

  testWidgets('提取中显示进度条与计数', (tester) async {
    await pumpDialog(tester);

    // 手动驱动 VM 信号，模拟 worker 进度事件
    vm.status.value = WorkflowStatus.running;
    vm.progress.value = 0.5;
    vm.progressLabel.value = 'inv_sword_01';
    vm.progressDetail.value = '已处理 3000 / 6000 个图标';
    await tester.pump();

    expect(find.text('正在提取图标'), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);
    expect(find.text('已处理 3000 / 6000 个图标'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.text('取消提取'), findsOneWidget);
  });

  testWidgets('扫描阶段（无比例）显示加载指示与状态文本', (tester) async {
    await pumpDialog(tester);

    vm.status.value = WorkflowStatus.running;
    vm.progress.value = null;
    vm.progressLabel.value = '正在扫描 zhCN 客户端归档...';
    vm.progressDetail.value = '';
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('正在扫描 zhCN 客户端归档...'), findsOneWidget);
  });
}
