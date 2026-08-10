abstract final class QuestEnums {
  /// Both reward difficulty fields index fixed arrays with ten slots.
  static const questRewardDifficultyOptions = <int, String>{
    0: '0',
    1: '1',
    2: '2',
    3: '3',
    4: '4',
    5: '5',
    6: '6',
    7: '7',
    8: '8',
    9: '9',
  };

  /// `quest_template.QuestType` maps to AzerothCore `Quest::Method`.
  /// It is not the `QuestTypes` enum used by `QuestInfoID`.
  static const questMethodOptions = <int, String>{
    0: '0（自动完成）',
    1: '1',
    2: '2（默认）',
  };
}
