import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/util/table_layout_util.dart';

void main() {
  test('全部 badge 放得下时不生成 +N', () {
    expect(TableLayoutUtil.fittingBadgeCount([50, 50], (h) => 30, 4, 104), 2);
    expect(TableLayoutUtil.fittingBadgeCount([], (h) => 30, 4, 104), 0);
  });

  test('放不下时让出位置给 +N', () {
    expect(TableLayoutUtil.fittingBadgeCount([50, 50], (h) => 30, 4, 100), 1);
    expect(TableLayoutUtil.fittingBadgeCount([50, 50, 50], (h) => 30, 4, 150), 2);
  });

  test('一个 badge 都放不下时返回 0', () {
    expect(TableLayoutUtil.fittingBadgeCount([50], (h) => 30, 4, 40), 0);
    expect(TableLayoutUtil.fittingBadgeCount([50, 50], (h) => 40, 4, 92), 0);
  });

  test('+N 宽度随隐藏数量变化', () {
    expect(TableLayoutUtil.fittingBadgeCount([50, 50, 50], (h) => 20 + h * 10, 4, 150), 2);
    expect(TableLayoutUtil.fittingBadgeCount([50, 50, 50], (h) => 40 + h * 10, 4, 150), 1);
  });
}
