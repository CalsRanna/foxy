abstract final class TalentConstants {
  static const talentTierMinimum = 0;

  static const talentTierMaximum = 10;

  static const talentColumnMinimum = 0;

  static const talentColumnMaximum = 3;

  /// Talent.dbc `Flags` / AzerothCore `addToSpellBook` values for 3.3.5a.
  static const talentAddToSpellBookOptions = <int, String>{
    0: '不直接加入法术书',
    1: '直接加入法术书',
  };
}
