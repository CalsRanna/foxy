enum LootTableType {
  creature('creature_loot_template'),
  pickpocket('pickpocketing_loot_template'),
  skinning('skinning_loot_template'),
  item('item_loot_template'),
  disenchant('disenchant_loot_template'),
  prospecting('prospecting_loot_template'),
  milling('milling_loot_template'),
  reference('reference_loot_template'),
  gameobject('gameobject_loot_template');

  final String tableName;

  const LootTableType(this.tableName);
}
