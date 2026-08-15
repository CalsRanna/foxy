import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/foxy_tab.dart';

/// Harness that grows the tab list at runtime, exercising FoxyTab's
/// didUpdateWidget tab-state rebuild.
class _DynamicTabsHarness extends StatefulWidget {
  const _DynamicTabsHarness();

  @override
  State<_DynamicTabsHarness> createState() => _DynamicTabsHarnessState();
}

class _DynamicTabsHarnessState extends State<_DynamicTabsHarness> {
  var extraTab = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () => setState(() => extraTab = true),
              child: const Text('加 tab'),
            ),
            Expanded(
              child: FoxyTab(
                tabs: [
                  const Text('A'),
                  const Text('B'),
                  if (extraTab) const Text('C'),
                ],
                contents: [
                  const SizedBox(key: ValueKey('a')),
                  const SizedBox(key: ValueKey('b')),
                  if (extraTab) const SizedBox(key: ValueKey('c')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  testWidgets('tabs 列表变长后点击新 tab 不越界', (tester) async {
    await tester.pumpWidget(const _DynamicTabsHarness());
    await tester.pump();

    await tester.tap(find.text('加 tab'));
    await tester.pump();

    // The rebuilt tab state must index the new tab without going out of
    // range, and the fade animation must complete cleanly.
    await tester.tap(find.text('C'));
    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.takeException(), isNull);
  });
}
