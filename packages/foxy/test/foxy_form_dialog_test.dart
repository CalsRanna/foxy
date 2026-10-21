import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/foxy_form_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals.dart';

/// Guards the dialog footer invariant: sub-table dialogs put their buttons in
/// [ShadDialog.actions] (right-aligned, pinned while the content scrolls)
/// instead of at the end of `child`, where they scroll out of view.
void main() {
  Widget wrap(Widget Function(BuildContext) build) {
    return ShadApp(
      home: Scaffold(body: Builder(builder: (context) => build(context))),
    );
  }

  testWidgets('新增态 footer 为「取消」+「保存」', (tester) async {
    final submitting = signal(false);

    await tester.pumpWidget(
      wrap(
        (context) => FoxyFormDialog(
          title: '新增记录',
          actions: FoxyFormDialog.saveActions(
            context: context,
            submitting: submitting,
            onSubmit: () async {},
          ),
          child: const SizedBox(height: 40),
        ),
      ),
    );
    await tester.pump();

    expect(find.widgetWithText(ShadButton, '取消'), findsOneWidget);
    expect(find.widgetWithText(ShadButton, '保存'), findsOneWidget);
  });

  testWidgets('编辑态主按钮文案为「更新」', (tester) async {
    final submitting = signal(false);

    await tester.pumpWidget(
      wrap(
        (context) => FoxyFormDialog(
          title: '编辑记录',
          actions: FoxyFormDialog.saveActions(
            context: context,
            submitting: submitting,
            onSubmit: () async {},
            editing: true,
          ),
          child: const SizedBox(height: 40),
        ),
      ),
    );
    await tester.pump();

    expect(find.widgetWithText(ShadButton, '更新'), findsOneWidget);
    expect(find.widgetWithText(ShadButton, '保存'), findsNothing);
  });

  testWidgets('提交中禁用保存，且随 signal 恢复', (tester) async {
    final submitting = signal(true);

    await tester.pumpWidget(
      wrap(
        (context) => FoxyFormDialog(
          title: '新增记录',
          actions: FoxyFormDialog.saveActions(
            context: context,
            submitting: submitting,
            onSubmit: () async {},
          ),
          child: const SizedBox(height: 40),
        ),
      ),
    );
    await tester.pump();

    expect(
      tester.widget<ShadButton>(find.widgetWithText(ShadButton, '保存')).enabled,
      isFalse,
    );

    submitting.value = false;
    await tester.pump();

    expect(
      tester.widget<ShadButton>(find.widgetWithText(ShadButton, '保存')).enabled,
      isTrue,
    );
  });

  // The save path itself is not unit-tested here: `onSubmit` success reports
  // through `DialogUtil.instance.success`, which resolves its context from the
  // app-level router (`FoxyRouter.router.navigatorKey`) and therefore has no
  // host in a bare widget test. The button wiring (text, enabled state) is
  // covered above; the save sequence is covered by the view/dialog tests that
  // mount the real router.

  test('页面视图不得在 child 末尾手写 footer 按钮行', () {
    // Repository-wide check: the drift is a copy-paste behaviour, so a new
    // view copied from an old one carries the old hand-rolled footer with it.
    final pageDir = _pageDir();
    final offenders = <String>[];

    for (final file in pageDir.listSync(recursive: true).whereType<File>()) {
      if (!file.path.endsWith('.dart')) continue;
      final source = file.readAsStringSync();
      if (!source.contains('FoxyFormDialog(')) continue;

      // A cancel button popping `dialogContext` can only be a footer row:
      // through saveActions the dialog context is passed as `context:`.
      if (source.contains('Navigator.of(dialogContext).pop()')) {
        offenders.add('${file.path}: 手写取消按钮');
      }
      // `onSubmit: viewModel.persist,` is the sanctioned form; a call with
      // parentheses means the view still owns the save sequence.
      if (source.contains('viewModel.persist()')) {
        offenders.add('${file.path}: 手写 persist 调用');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason: '这些文件仍自己拼 footer，请改用 FoxyFormDialog.saveActions',
    );
  });
}

/// Locates `lib/page` from the package root (flutter test runs there).
Directory _pageDir() {
  for (final candidate in ['lib/page', 'packages/foxy/lib/page']) {
    final dir = Directory(candidate);
    if (dir.existsSync()) return dir;
  }
  fail('找不到 lib/page，无法执行 footer 一致性检查');
}
