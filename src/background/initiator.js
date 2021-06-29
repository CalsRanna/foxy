import { ipcMain } from "electron";
import {
  LOAD_MYSQL_CONFIG,
  LOAD_DBC_CONFIG,
  INITIALIZE_MYSQL_CONNECTION,
  LOAD_DBC_CREATURE_DISPLAY_INFOS,
  LOAD_DBC_CREATURE_MODEL_DATAS,
  LOAD_DBC_CREATURE_SPELL_DATAS,
  LOAD_DBC_FACTIONS,
  LOAD_DBC_FACTION_TEMPLATES,
  LOAD_DBC_ITEMS,
  LOAD_DBC_ITEM_DISPLAY_INFOS,
  LOAD_DBC_ITEM_RANDOM_PROPERTITIES,
  LOAD_DBC_ITEM_RANDOM_SUFFIXES,
  LOAD_DBC_ITEM_SETS,
  LOAD_DBC_SCALING_STAT_DISTRIBUTIONS,
  LOAD_DBC_SCALING_STAT_VALUES,
  LOAD_DBC_SPELLS,
  LOAD_DBC_SPELL_CAST_TIMES,
  LOAD_DBC_SPELL_DURATIONS,
  LOAD_DBC_SPELL_ICONS,
  LOAD_DBC_SPELL_ITEM_ENCHANTMENTS,
  LOAD_DBC_SPELL_MECHANICS,
  LOAD_DBC_SPELL_RANGES,
  LOAD_DBC_TALENTS,
  LOAD_DBC_TALENT_TABS,
  LOAD_DBC_CHR_CLASSES,
  LOAD_DBC_CHR_RACES,
  LOAD_DBC_LOCKS,
  LOAD_DBC_LOCK_TYPES,
  LOAD_DBC_CHAR_TITLES,
  LOAD_DBC_EMOTES,
  LOAD_DBC_EMOTES_TEXTS,
  TEST_MYSQL_CONNECTION,
  GLOBAL_MESSAGE_BOX,
} from "../constants";

const DBC = require("warcrafty");
const {
  dbcDatabaseSql,
  dbcSpellSql,
  dbcFactionSql,
  dbcFactionTemplateSql,
  dbcItemSql,
  dbcItemDisplayInfoSql,
  dbcSpellDurationSql,
  dbcScalingStatDistributionSql,
  dbcScalingStatValuesSql,
  dbcCreatureSpellDataSql,
  dbcCreatureDisplayInfoSql,
  dbcCreatureModelDataSql,
  dbcItemSetSql,
  dbcSpellItemEnchantmentSql,
  dbcItemRandomPropertiesSql,
  dbcItemRandomSuffixSql,
  dbcSpellIconSql,
  dbcSpellCastTimesSql,
  dbcSpellRangeSql,
  dbcSpellMechanicSql,
  dbcTalentSql,
  dbcTalentTabSql,
  dbcChrClassesSql,
  dbcChrRacesSql,
  dbcLockSql,
  dbcLockTypeSql,
  dbcCharTitleSql,
  dbcEmotesSql,
  dbcEmotesTextSql,
} = require("../libs/mysql");

ipcMain.on(LOAD_MYSQL_CONFIG, (event, payload) => {
  global.mysqlConfig = payload;
});

ipcMain.on(LOAD_DBC_CONFIG, (event, payload) => {
  global.dbcConfig = payload;
  global.path = payload.path;
});

ipcMain.on(INITIALIZE_MYSQL_CONNECTION, (event) => {
  global.knex = require("knex")({
    client: "mysql",
    connection: global.mysqlConfig,
  });
  knex
    .raw(dbcDatabaseSql)
    .then(() => {
      Promise.all([
        knex.raw(dbcSpellSql).then(() => {}),
        knex.raw(dbcFactionSql).then(() => {}),
        knex.raw(dbcFactionTemplateSql).then(() => {}),
        knex.raw(dbcItemSql).then(() => {}),
        knex.raw(dbcItemDisplayInfoSql).then(() => {}),
        knex.raw(dbcSpellDurationSql).then(() => {}),
        knex.raw(dbcScalingStatDistributionSql).then(() => {}),
        knex.raw(dbcScalingStatValuesSql).then(() => {}),
        knex.raw(dbcCreatureSpellDataSql).then(() => {}),
        knex.raw(dbcCreatureDisplayInfoSql).then(() => {}),
        knex.raw(dbcCreatureModelDataSql).then(() => {}),
        knex.raw(dbcItemSetSql).then(() => {}),
        knex.raw(dbcSpellItemEnchantmentSql).then(() => {}),
        knex.raw(dbcItemRandomPropertiesSql).then(() => {}),
        knex.raw(dbcItemRandomSuffixSql).then(() => {}),
        knex.raw(dbcSpellCastTimesSql).then(() => {}),
        knex.raw(dbcSpellIconSql).then(() => {}),
        knex.raw(dbcSpellRangeSql).then(() => {}),
        knex.raw(dbcSpellMechanicSql).then(() => {}),
        knex.raw(dbcTalentSql).then(() => {}),
        knex.raw(dbcTalentTabSql).then(() => {}),
        knex.raw(dbcChrClassesSql).then(() => {}),
        knex.raw(dbcChrRacesSql).then(() => {}),
        knex.raw(dbcLockSql).then(() => {}),
        knex.raw(dbcLockTypeSql).then(() => {}),
        knex.raw(dbcCharTitleSql).then(() => {}),
        knex.raw(dbcEmotesSql).then(() => {}),
        knex.raw(dbcEmotesTextSql).then(() => {}),
      ])
        .then(() => {
          event.reply(INITIALIZE_MYSQL_CONNECTION);
        })
        .catch((error) => {
          event.reply(`${INITIALIZE_MYSQL_CONNECTION}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        });
    })
    .catch((error) => {
      event.reply(`${INITIALIZE_MYSQL_CONNECTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_CHAR_TITLES, (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_char_titles");

  queryBuilder
    .then((rows) => {
      if (rows.length == 0) {
        DBC.read(`${path}/CharTitles.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_char_titles", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_CHAR_TITLES);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_CHAR_TITLES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_CHAR_TITLES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_CHAR_TITLES);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_CHAR_TITLES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_EMOTES, (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_emotes");

  queryBuilder
    .then((rows) => {
      if (rows.length == 0) {
        DBC.read(`${path}/Emotes.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_emotes", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_EMOTES);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_EMOTES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_EMOTES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_EMOTES);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_CHAR_TITLES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_EMOTES_TEXTS, (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_emotes_text");

  queryBuilder
    .then((rows) => {
      if (rows.length == 0) {
        DBC.read(`${path}/EmotesText.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_emotes_text", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_EMOTES_TEXTS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_EMOTES_TEXTS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_EMOTES_TEXTS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_EMOTES_TEXTS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_CHAR_TITLES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_LOCKS, (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_lock");

  queryBuilder
    .then((rows) => {
      if (rows.length == 0) {
        DBC.read(`${path}/Lock.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_lock", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_LOCKS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_LOCKS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_LOCKS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_LOCKS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_LOCKS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_LOCK_TYPES, (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_lock_type");

  queryBuilder
    .then((rows) => {
      if (rows.length == 0) {
        DBC.read(`${path}/LockType.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_lock_type", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_LOCK_TYPES, dbc.records);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_LOCK_TYPES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_LOCK_TYPES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_LOCK_TYPES, rows);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_LOCK_TYPES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_CHR_CLASSES, (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_chr_classes");

  queryBuilder
    .then((rows) => {
      if (rows.length == 0) {
        DBC.read(`${path}/ChrClasses.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_chr_classes", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_CHR_CLASSES, dbc.records);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_CHR_CLASSES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_CHR_CLASSES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_CHR_CLASSES, rows);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_CHR_CLASSES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_CHR_RACES, (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_chr_races");

  queryBuilder
    .then((rows) => {
      if (rows.length == 0) {
        DBC.read(`${path}/ChrRaces.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_chr_races", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_CHR_RACES, dbc.records);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_CHR_RACES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_CHR_RACES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_CHR_RACES, rows);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_CHR_RACES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_CREATURE_DISPLAY_INFOS, (event) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_creature_display_info");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/CreatureDisplayInfo.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_creature_display_info", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_CREATURE_DISPLAY_INFOS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_CREATURE_DISPLAY_INFOS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_CREATURE_DISPLAY_INFOS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_CREATURE_DISPLAY_INFOS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_CREATURE_DISPLAY_INFOS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_CREATURE_MODEL_DATAS, (event) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_creature_model_data");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/CreatureModelData.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_creature_model_data", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_CREATURE_MODEL_DATAS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_CREATURE_MODEL_DATAS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_CREATURE_MODEL_DATAS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_CREATURE_MODEL_DATAS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_CREATURE_MODEL_DATAS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_CREATURE_SPELL_DATAS, (event) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_creature_spell_data");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/CreatureSpellData.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_creature_spell_data", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_CREATURE_SPELL_DATAS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_CREATURE_SPELL_DATAS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_CREATURE_SPELL_DATAS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_CREATURE_SPELL_DATAS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_CREATURE_SPELL_DATAS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_FACTIONS, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_faction");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/Faction.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_faction", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_FACTIONS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_FACTIONS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_FACTIONS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_FACTIONS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_FACTIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_FACTION_TEMPLATES, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_faction_template");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/FactionTemplate.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_faction_template", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_FACTION_TEMPLATES);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_FACTION_TEMPLATES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_FACTION_TEMPLATES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_FACTION_TEMPLATES);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_FACTION_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_ITEMS, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_item");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/Item.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_item", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_ITEMS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_ITEMS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_ITEMS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_ITEMS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_ITEMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_ITEM_DISPLAY_INFOS, (event) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_item_display_info");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ItemDisplayInfo.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_item_display_info", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_ITEM_DISPLAY_INFOS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_ITEM_DISPLAY_INFOS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_ITEM_RANDOM_PROPERTITIES, (event) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_item_random_properties");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ItemRandomProperties.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_item_random_properties", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_ITEM_RANDOM_PROPERTITIES);
              })
              .catch((error) => {
                event.reply(
                  `${LOAD_DBC_ITEM_RANDOM_PROPERTITIES}_REJECT`,
                  error
                );
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_ITEM_RANDOM_PROPERTITIES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_ITEM_RANDOM_PROPERTITIES);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_ITEM_RANDOM_PROPERTITIES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_ITEM_RANDOM_SUFFIXES, (event) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_item_random_suffix");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ItemRandomSuffix.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_item_random_suffix", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_ITEM_RANDOM_SUFFIXES);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_ITEM_RANDOM_SUFFIXES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_ITEM_RANDOM_SUFFIXES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_ITEM_RANDOM_SUFFIXES);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_ITEM_RANDOM_SUFFIXES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_ITEM_SETS, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_item_set");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ItemSet.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_item_set", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_ITEM_SETS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_ITEM_SETS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_ITEM_SETS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_ITEM_SETS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_ITEM_SETS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_SCALING_STAT_DISTRIBUTIONS, (event) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_scaling_stat_distribution");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ScalingStatDistribution.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_scaling_stat_distribution", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_SCALING_STAT_DISTRIBUTIONS);
              })
              .catch((error) => {
                event.reply(
                  `${LOAD_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`,
                  error
                );
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`, error);
          });
      } else {
        event.reply(LOAD_DBC_SCALING_STAT_DISTRIBUTIONS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_SCALING_STAT_VALUES, (event) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_scaling_stat_values");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ScalingStatValues.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_scaling_stat_values", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_SCALING_STAT_VALUES);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_SCALING_STAT_VALUES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_SCALING_STAT_VALUES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_SCALING_STAT_VALUES);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_SCALING_STAT_VALUES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_SPELLS, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_spell");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/Spell.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_spell", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_SPELLS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_SPELLS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_SPELLS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_SPELLS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_SPELLS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_SPELL_CAST_TIMES, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_spell_cast_times");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/SpellCastTimes.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_spell_cast_times", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_SPELL_CAST_TIMES);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_SPELL_CAST_TIMES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_SPELL_CAST_TIMES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_SPELL_CAST_TIMES);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_SPELL_CAST_TIMES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_SPELL_DURATIONS, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_spell_duration");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/SpellDuration.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_spell_duration", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_SPELL_DURATIONS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_SPELL_DURATIONS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_SPELL_DURATIONS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_SPELL_DURATIONS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_SPELL_DURATIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_SPELL_ICONS, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_spell_icon");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/SpellIcon.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_spell_icon", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_SPELL_ICONS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_SPELL_ICONS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_SPELL_ICONS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_SPELL_ICONS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_SPELL_ICONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_SPELL_ITEM_ENCHANTMENTS, (event) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_spell_item_enchantment");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/SpellItemEnchantment.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_spell_item_enchantment", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_SPELL_ITEM_ENCHANTMENTS);
              })
              .catch((error) => {
                event.reply(
                  `${LOAD_DBC_SPELL_ITEM_ENCHANTMENTS}_REJECT`,
                  error
                );
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_SPELL_ITEM_ENCHANTMENTS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_SPELL_ITEM_ENCHANTMENTS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_SPELL_ITEM_ENCHANTMENTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_SPELL_MECHANICS, (event) => {
  let queryBuilder = knex.select().from("foxy.dbc_spell_mechanic");

  queryBuilder
    .then((rows) => {
      if (rows.length == 0) {
        DBC.read(`${path}/SpellMechanic.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_spell_mechanic", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_SPELL_MECHANICS, dbc.records);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_SPELL_MECHANICS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_SPELL_MECHANICS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_SPELL_MECHANICS, rows);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_SPELL_MECHANICS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_SPELL_RANGES, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_spell_range");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/SpellRange.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_spell_range", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_SPELL_RANGES);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_SPELL_RANGES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_SPELL_RANGES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_SPELL_RANGES);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_SPELL_RANGES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_TALENTS, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_talent");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/Talent.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_talent", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_TALENTS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_TALENTS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_TALENTS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_TALENTS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_TALENTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(LOAD_DBC_TALENT_TABS, (event) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_talent_tab");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/TalentTab.dbc`)
          .then((dbc) => {
            knex
              .batchInsert("foxy.dbc_talent_tab", dbc.records)
              .then(() => {
                event.reply(LOAD_DBC_TALENT_TABS);
              })
              .catch((error) => {
                event.reply(`${LOAD_DBC_TALENT_TABS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${LOAD_DBC_TALENT_TABS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(LOAD_DBC_TALENT_TABS);
      }
    })
    .catch((error) => {
      event.reply(`${LOAD_DBC_TALENT_TABS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(TEST_MYSQL_CONNECTION, (event, payload) => {
  let testKnex = require("knex")({
    client: "mysql",
    connection: payload,
  });
  testKnex
    .select("guid")
    .from("creature")
    .first()
    .then((rows) => {
      event.reply(TEST_MYSQL_CONNECTION);
    })
    .catch((error) => {
      event.reply(`${TEST_MYSQL_CONNECTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
