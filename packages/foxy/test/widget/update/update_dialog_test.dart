/// Widget tests for the ready-to-restart state of [UpdateDialog].
///
/// Restart failures are reported through `errorMessage` while
/// `readyToRestart` stays set; the dialog must surface the failure instead
/// of silently keeping the ready view (regression: the restart button
/// appeared to do nothing).
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  testWidgets('更新就绪 → 显示就绪视图与立即重启按钮', (tester) async {
    final vm = UpdateViewModel();
    vm.readyToRestart.value = true;

    await tester.pumpWidget(wrap(UpdateDialog(vm: vm)));
    await tester.pump();

    expect(find.text('更新已就绪'), findsOneWidget);
    expect(find.text('立即重启'), findsOneWidget);
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
