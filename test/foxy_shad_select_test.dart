import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/form/field_controller.dart';
import 'package:foxy/widget/foxy_shad_select.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('选中项始终单行显示并在超宽时省略', (tester) async {
    final controller = SelectFieldController<int>(fallback: 0)..init(1);

    await tester.pumpWidget(
      ShadApp(
        home: SizedBox(
          width: 80,
          child: FoxyShadSelect<int>(
            controller: controller,
            options: const {1: '这是一个很长的下拉选项'},
            placeholder: const Text('请选择'),
          ),
        ),
      ),
    );

    final selectedText = tester
        .widgetList<Text>(find.text('这是一个很长的下拉选项'))
        .singleWhere((text) => text.maxLines == 1);
    expect(selectedText.softWrap, isFalse);
    expect(selectedText.overflow, TextOverflow.ellipsis);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox());
    controller.dispose();
  });
}
