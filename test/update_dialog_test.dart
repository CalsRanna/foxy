/// Widget tests for the ready-to-restart state of [UpdateDialog].
///
/// Restart failures are reported through `errorMessage` while
/// `readyToRestart` stays set; the dialog must surface the failure instead
/// of silently keeping the ready view (regression: the restart button
/// appeared to do nothing).
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/page/setting/update_dialog.dart';
import 'package:foxy/view_model/update_view_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  Widget wrap(Widget child) {
    return ShadApp(home: Scaffold(body: Center(child: child)));
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
    final vm = UpdateViewModel();
    vm.readyToRestart.value = true;
    vm.errorMessage.value = '更新程序文件缺失，请重新下载完整版本';

    await tester.pumpWidget(wrap(UpdateDialog(vm: vm)));
    await tester.pump();

    expect(find.text('重启更新失败'), findsOneWidget);
    expect(find.text('更新程序文件缺失，请重新下载完整版本'), findsOneWidget);
    expect(find.text('立即重启'), findsNothing);
  });
}
