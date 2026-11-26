import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  const flags = [
    FlagItem(0x01, '人类'),
    FlagItem(0x02, '兽人'),
    FlagItem(0x04, '矮人'),
  ];

  test('Matching flags expand to labels in declaration order', () {
    expect(FlagItem.maskLabel(0x01 | 0x04, flags), '人类, 矮人');
  });

  test('An unmatched mask falls back to its original value', () {
    expect(FlagItem.maskLabel(0x00, flags), '0');
    expect(FlagItem.maskLabel(0x08, flags), '8');
  });

  test('An empty flag list returns the original mask', () {
    expect(FlagItem.maskLabel(5, const []), '5');
  });
}
