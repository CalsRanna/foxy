import { ipcMain } from "electron";

const DBC = require("warcrafty");

ipcMain.on("SEARCH_ACHIEVEMENT_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_achievement");

  queryBuilder
    .then((rows) => {
      global.achievements = rows;
      event.reply("SEARCH_ACHIEVEMENT_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_ACHIEVEMENT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_ACHIEVEMENT_CATEGORY_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_achievement_category");

  queryBuilder
    .then((rows) => {
      global.achievementCategoris = rows;
      event.reply("SEARCH_ACHIEVEMENT_CATEGORY_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_ACHIEVEMENT_CATEGORY_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_ACHIEVEMENT_CRITERIA_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_achievement_criteria");

  queryBuilder
    .then((rows) => {
      global.achievementCriterias = rows;
      event.reply("SEARCH_ACHIEVEMENT_CRITERIA_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_ACHIEVEMENT_CRITERIA_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_AREA_TABLE_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_area_table");

  queryBuilder
    .then((rows) => {
      global.areaTables = rows;
      event.reply("SEARCH_AREA_TABLE_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_AREA_TABLE_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_CURRENCY_CATEGORY_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_currency_category");

  queryBuilder
    .then((rows) => {
      global.currencyCategories = rows;
      event.reply("SEARCH_CURRENCY_CATEGORY_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_CURRENCY_CATEGORY_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_CURRENCY_TYPE_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_currency_types");

  queryBuilder
    .then((rows) => {
      global.currencyTypes = rows;
      event.reply("SEARCH_CURRENCY_TYPE_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_CURRENCY_TYPE_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_EMOTES_TEXT_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_emotes_text");

  queryBuilder
    .then((rows) => {
      global.emotesTexts = rows;
      event.reply("SEARCH_EMOTES_TEXT_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_EMOTES_TEXT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_ITEM_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_item");

  queryBuilder
    .then((rows) => {
      global.items = rows;
      event.reply("SEARCH_ITEM_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_ITEM_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_ITEM_EXTENDED_COST_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_item_extended_cost");

  queryBuilder
    .then((rows) => {
      global.itemExtendedCosts = rows;
      event.reply("SEARCH_ITEM_EXTENDED_COST_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_ITEM_EXTENDED_COST_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_ITEM_SET_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_item_set");

  queryBuilder
    .then((rows) => {
      global.itemSets = rows;
      event.reply("SEARCH_ITEM_SET_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_ITEM_SET_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_QUEST_FACTION_REWARD_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_quest_faction_reward");

  queryBuilder
    .then((rows) => {
      global.questFactionRewards = rows;
      event.reply("SEARCH_QUEST_FACTION_REWARD_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_QUEST_FACTION_REWARD_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_QUEST_INFO_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_quest_info");

  queryBuilder
    .then((rows) => {
      global.questInfos = rows;
      event.reply("SEARCH_QUEST_INFO_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_QUEST_INFO_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_QUEST_SORT_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_quest_sort");

  queryBuilder
    .then((rows) => {
      global.questSorts = rows;
      event.reply("SEARCH_QUEST_SORT_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_QUEST_SORT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_SCALING_STAT_DISTRIBUTION_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_scaling_stat_distribution");

  queryBuilder
    .then((rows) => {
      global.scalingStatDistributions = rows;
      event.reply("SEARCH_SCALING_STAT_DISTRIBUTION_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_SCALING_STAT_DISTRIBUTION_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_SCALING_STAT_VALUES_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_scaling_stat_values");

  queryBuilder
    .then((rows) => {
      global.scalingStatValues = rows;
      event.reply("SEARCH_SCALING_STAT_VALUES_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_SCALING_STAT_VALUES_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_SPELL_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_spell");

  queryBuilder
    .then((rows) => {
      global.spells = rows;
      event.reply("SEARCH_SPELL_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_SPELL_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_SPELL_ITEM_ENCHANTMENT_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_spell_item_enchantment");

  queryBuilder
    .then((rows) => {
      global.spellItemEnchantments = rows;
      event.reply("SEARCH_SPELL_ITEM_ENCHANTMENT_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_SPELL_ITEM_ENCHANTMENT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_TALENT_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_talent");

  queryBuilder
    .then((rows) => {
      global.talents = rows;
      event.reply("SEARCH_TALENT_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_TALENT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("SEARCH_TALENT_TAB_DBC", (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_talent_tab");

  queryBuilder
    .then((rows) => {
      global.talentTabs = rows;
      event.reply("SEARCH_TALENT_TAB_DBC", rows.length);
    })
    .catch((error) => {
      event.reply("SEARCH_TALENT_TAB_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    })
    .finally(() => {
      event.reply("GLOBAL_MESSAGE", queryBuilder.toString());
    });
});

ipcMain.on("WRITE_ACHIEVEMENT_DBC", (event) => {
  DBC.write(`${path}/Achievement.dbc`, global.achievements)
    .then(() => {
      event.reply("WRITE_ACHIEVEMENT_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_ACHIEVEMENT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_ACHIEVEMENT_CATEGORY_DBC", (event) => {
  DBC.write(`${path}/AchievementCategory.dbc`, global.achievementCategoris)
    .then(() => {
      event.reply("WRITE_ACHIEVEMENT_CATEGORY_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_ACHIEVEMENT_CATEGORY_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_ACHIEVEMENT_CRITERIA_DBC", (event) => {
  DBC.write(`${path}/Achievement_Criteria.dbc`, global.achievementCriterias)
    .then(() => {
      event.reply("WRITE_ACHIEVEMENT_CRITERIA_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_ACHIEVEMENT_CRITERIA_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_AREA_TABLE_DBC", (event) => {
  DBC.write(`${path}/AreaTable.dbc`, global.areaTables)
    .then(() => {
      event.reply("WRITE_AREA_TABLE_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_AREA_TABLE_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_CURRENCY_CATEGORY_DBC", (event) => {
  DBC.write(`${path}/CurrencyCategory.dbc`, global.currencyCategories)
    .then(() => {
      event.reply("WRITE_CURRENCY_CATEGORY_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_CURRENCY_CATEGORY_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_CURRENCY_TYPE_DBC", (event) => {
  DBC.write(`${path}/CurrencyTypes.dbc`, global.currencyTypes)
    .then(() => {
      event.reply("WRITE_CURRENCY_TYPE_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_CURRENCY_TYPE_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_EMOTES_TEXT_DBC", (event) => {
  DBC.write(`${path}/EmotesText.dbc`, global.emotesTexts)
    .then(() => {
      event.reply("WRITE_EMOTES_TEXT_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_EMOTES_TEXT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_ITEM_DBC", (event) => {
  DBC.write(`${path}/Item.dbc`, global.items)
    .then(() => {
      event.reply("WRITE_ITEM_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_ITEM_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_ITEM_EXTENDED_COST_DBC", (event) => {
  DBC.write(`${path}/ItemExtendedCost.dbc`, global.itemExtendedCosts)
    .then(() => {
      event.reply("WRITE_ITEM_EXTENDED_COST_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_ITEM_EXTENDED_COST_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_ITEM_SET_DBC", (event) => {
  DBC.write(`${path}/ItemSet.dbc`, global.itemSets)
    .then(() => {
      event.reply("WRITE_ITEM_SET_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_ITEM_SET_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_QUEST_FACTION_REWARD_DBC", (event) => {
  DBC.write(`${path}/QuestFactionReward.dbc`, global.questFactionRewards)
    .then(() => {
      event.reply("WRITE_QUEST_FACTION_REWARD_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_QUEST_FACTION_REWARD_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_QUEST_INFO_DBC", (event) => {
  DBC.write(`${path}/QuestInfo.dbc`, global.questInfos)
    .then(() => {
      event.reply("WRITE_QUEST_INFO_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_QUEST_INFO_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_QUEST_SORT_DBC", (event) => {
  DBC.write(`${path}/QuestSort.dbc`, global.questSorts)
    .then(() => {
      event.reply("WRITE_QUEST_SORT_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_QUEST_SORT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_SCALING_STAT_DISTRIBUTION_DBC", (event) => {
  DBC.write(
    `${path}/ScalingStatDistribution.dbc`,
    global.scalingStatDistributions
  )
    .then(() => {
      event.reply("WRITE_SCALING_STAT_DISTRIBUTION_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_SCALING_STAT_DISTRIBUTION_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_SCALING_STAT_VALUES_DBC", (event) => {
  DBC.write(`${path}/ScalingStatValues.dbc`, global.scalingStatValues)
    .then(() => {
      event.reply("WRITE_SCALING_STAT_VALUES_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_SCALING_STAT_VALUES_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_SPELL_DBC", (event) => {
  DBC.write(`${path}/Spell.dbc`, global.spells)
    .then(() => {
      event.reply("WRITE_SPELL_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_SPELL_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_SPELL_ITEM_ENCHANTMENT_DBC", (event) => {
  DBC.write(`${path}/SpellItemEnchantment.dbc`, global.spellItemEnchantments)
    .then(() => {
      event.reply("WRITE_SPELL_ITEM_ENCHANTMENT_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_SPELL_ITEM_ENCHANTMENT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_TALENT_DBC", (event) => {
  DBC.write(`${path}/Talent.dbc`, global.talents)
    .then(() => {
      event.reply("WRITE_TALENT_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_TALENT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_TALENT_TAB_DBC", (event) => {
  DBC.write(`${path}/TalentTab.dbc`, global.talentTabs)
    .then(() => {
      event.reply("WRITE_TALENT_TAB_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_TALENT_TAB_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});
