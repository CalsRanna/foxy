import 'package:foxy_game_definition/foxy_game_definition.dart';
import 'package:test/test.dart';

void main() {
  test('Talent Flags uses the addToSpellBook-specific values 0 and 1', () {
    expect(TalentConstants.talentAddToSpellBookOptions, {
      0: '不直接加入法术书',
      1: '直接加入法术书',
    });
    expect(TalentConstants.talentAddToSpellBookOptions, isNot(contains(2)));
  });
}
