/// `quest_template.QuestType` maps to AzerothCore `Quest::Method`.
/// It is not the `QuestTypes` enum used by `QuestInfoID`.
const kQuestMethodOptions = <int, String>{0: '0（自动完成）', 1: '1', 2: '2（默认）'};

/// Both reward difficulty fields index fixed arrays with ten slots.
const kQuestRewardDifficultyOptions = <int, String>{
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
