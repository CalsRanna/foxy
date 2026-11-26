import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/widget/table/table_layout_util.dart';

void main() {
  test('No overflow badge is added when all badges fit', () {
    expect(TableLayoutUtil.fittingBadgeCount([50, 50], (h) => 30, 4, 104), 2);
    expect(TableLayoutUtil.fittingBadgeCount([], (h) => 30, 4, 104), 0);
  });

  test('Space is reserved for the overflow badge when badges do not fit', () {
    expect(TableLayoutUtil.fittingBadgeCount([50, 50], (h) => 30, 4, 100), 1);
    expect(
      TableLayoutUtil.fittingBadgeCount([50, 50, 50], (h) => 30, 4, 150),
      2,
    );
  });

  test('Returns zero when no badges fit', () {
    expect(TableLayoutUtil.fittingBadgeCount([50], (h) => 30, 4, 40), 0);
    expect(TableLayoutUtil.fittingBadgeCount([50, 50], (h) => 40, 4, 92), 0);
  });

  test('Overflow badge width changes with the hidden count', () {
    expect(
      TableLayoutUtil.fittingBadgeCount(
        [50, 50, 50],
        (h) => 20 + h * 10,
        4,
        150,
      ),
      2,
    );
    expect(
      TableLayoutUtil.fittingBadgeCount(
        [50, 50, 50],
        (h) => 40 + h * 10,
        4,
        150,
      ),
      1,
    );
  });
}
