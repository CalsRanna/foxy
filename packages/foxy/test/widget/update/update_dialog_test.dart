/// Widget tests for the ready-to-restart state of [UpdateDialog].
///
/// Restart failures are reported through `errorMessage` while
/// `readyToRestart` stays set; the dialog must surface the failure instead
/// of silently keeping the ready view (regression: the restart button
/// appeared to do nothing).
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/update/update_service.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:foxy/widget/update/update_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  Widget wrap(Widget child) {
    return ShadApp(
      navigatorKey: FoxyRouter.router.navigatorKey,
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('检查更新和结果使用相同宽度，底部操作靠右', (tester) async {
    final vm = UpdateViewModel();
    vm.currentVersion.value = '1.0.0+628';
    vm.checking.value = true;

    await tester.pumpWidget(wrap(UpdateDialog(vm: vm)));
    expect(find.text('正在检查更新…'), findsOneWidget);
    final checkingFrame = _dialogFrame(tester);
    expect(checkingFrame.width, 480);

    vm.upToDate.value = true;
    vm.checking.value = false;
    await tester.pump();
    expect(find.text('已是最新版本'), findsOneWidget);
    _expectRightAligned(tester, '确定');

    vm.upToDate.value = false;
    vm.availableUpdate.value = UpdateManifestInfo(
      version: '1.1.0',
      buildNumber: '630',
      zipUrl: Uri.parse('https://example.com/foxy.zip'),
      sizeBytes: 42,
      sha256: 'a',
      notes: '更新说明',
    );
    await tester.pump();
    expect(find.text('发现新版本 1.1.0'), findsOneWidget);
    _expectRightAligned(tester, '下载并更新');

    vm.downloadProgress.value = 0.5;
    await tester.pump();
    expect(find.text('正在下载更新'), findsOneWidget);
    _expectRightAligned(tester, '取消下载');
  });

  testWidgets('检查更新失败 → 关闭错误框后，重试按钮靠右', (tester) async {
    final vm = UpdateViewModel();
    vm.errorMessage.value = '无法连接更新服务器，请检查网络后重试';

    await tester.pumpWidget(wrap(UpdateDialog(vm: vm)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();

    expect(find.text('检查更新'), findsOneWidget);
    _expectRightAligned(tester, '重试');
  });

  testWidgets('更新就绪 → 显示就绪视图与立即重启按钮', (tester) async {
    final vm = UpdateViewModel();
    vm.readyToRestart.value = true;

    await tester.pumpWidget(wrap(UpdateDialog(vm: vm)));
    await tester.pump();

    expect(find.text('更新已就绪'), findsOneWidget);
    _expectRightAligned(tester, '立即重启');
  });

  testWidgets('重启失败 → 显示失败原因并隐藏立即重启按钮', (tester) async {
    const error = '更新程序文件缺失，请重新下载完整版本';
    final vm = UpdateViewModel();
    vm.readyToRestart.value = true;
    vm.errorMessage.value = error;

    await tester.pumpWidget(wrap(UpdateDialog(vm: vm)));
    await tester.pumpAndSettle();
    expect(find.text('错误'), findsOneWidget);
    expect(find.text(error), findsOneWidget);

    await tester.tapAt(const Offset(5, 5));
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('错误'), findsOneWidget);

    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(find.text('软件更新'), findsOneWidget);
    expect(find.text(error), findsNothing);
    expect(find.text('立即重启'), findsNothing);

    await tester.pumpWidget(wrap(UpdateDialog(vm: vm)));
    await tester.pumpAndSettle();
    expect(find.text('错误'), findsNothing);

    vm.errorMessage.value = null;
    vm.errorMessage.value = error;
    vm.errorMessage.value = '启动更新程序失败，请重试';
    await tester.pumpAndSettle();
    expect(find.text(error), findsOneWidget);
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(find.text(error), findsNothing);
    expect(find.text('启动更新程序失败，请重试'), findsOneWidget);
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(find.text('错误'), findsNothing);
  });
}

Rect _dialogFrame(WidgetTester tester) {
  return tester.getRect(
    find
        .descendant(
          of: find.byType(ShadDialog),
          matching: find.byType(ConstrainedBox),
        )
        .first,
  );
}

void _expectRightAligned(WidgetTester tester, String buttonText) {
  final frame = _dialogFrame(tester);
  final button = tester.getRect(find.widgetWithText(ShadButton, buttonText));
  expect(frame.width, 480);
  expect(button.right, frame.right - 24);
}
