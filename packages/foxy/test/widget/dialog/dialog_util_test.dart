import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/widget/dialog/dialog_util.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('短文案确认框的宽度为 480，按钮组靠右', (tester) async {
    await tester.pumpWidget(_host());

    final result = DialogUtil.instance.confirm(
      title: '确认复制',
      description: '确定要复制这条记录吗？',
      confirmText: '复制',
    );
    await tester.pumpAndSettle();

    final frame = tester.getRect(_dialogFrame());
    final cancel = tester.getRect(find.widgetWithText(ShadButton, '取消'));
    final copy = find.widgetWithText(ShadButton, '复制');
    final copyButton = tester.getRect(copy);
    expect(frame.width, 480);
    expect(copyButton.right, frame.right - 24);
    expect(copyButton.left, cancel.right + 8);
    expect(copyButton.center.dy, cancel.center.dy);

    await tester.tap(copy);
    await tester.pumpAndSettle();
    expect(await result, isTrue);
  });

  testWidgets('长文案错误提示框的宽度为 480', (tester) async {
    await tester.pumpWidget(_host());

    final message = List.filled(8, '保存失败，请检查数据库连接和当前用户的写入权限。').join();
    DialogUtil.instance.error(message);
    await tester.pumpAndSettle();

    expect(tester.getSize(_dialogFrame()).width, 480);
    await tester.tap(find.text('确定'));
    await tester.pumpAndSettle();
    expect(find.byType(ShadDialog), findsNothing);
  });

  testWidgets('短文案错误提示框的确定按钮靠右', (tester) async {
    await tester.pumpWidget(_host());

    DialogUtil.instance.error('保存失败');
    await tester.pumpAndSettle();

    final frame = tester.getRect(_dialogFrame());
    final ok = find.widgetWithText(ShadButton, '确定');
    expect(tester.getRect(ok).right, frame.right - 24);
    await tester.tap(ok);
    await tester.pumpAndSettle();
  });
}

Finder _dialogFrame() {
  return find
      .descendant(
        of: find.byType(ShadDialog),
        matching: find.byType(ConstrainedBox),
      )
      .first;
}

Widget _host() {
  return ShadApp(
    navigatorKey: FoxyRouter.router.navigatorKey,
    home: const Scaffold(),
  );
}
