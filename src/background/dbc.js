import { ipcMain } from "electron";

import {
  INIT_DBC_CONFIG,
  SEARCH_DBC_FACTIONS,
  SEARCH_DBC_FACTION_TEMPLATES,
  SEARCH_DBC_CREATURE_SPELL_DATAS,
  SEARCH_DBC_CREATURE_DISPLAY_INFOS,
  SEARCH_DBC_CREATURE_MODEL_DATAS,
  SEARCH_DBC_ITEM_DISPLAY_INFOS,
  SEARCH_DBC_ITEMS,
  SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS,
  SEARCH_DBC_SCALING_STAT_VALUES,
  SEARCH_DBC_SPELLS,
  EXPORT_SPELL_DBC,
  SEARCH_DBC_SPELL_DURATIONS,
  SEARCH_DBC_ITEM_SETS,
  SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS,
  SEARCH_DBC_ITEM_RANDOM_PROPERTITIES,
  SEARCH_DBC_ITEM_RANDOM_SUFFIXES,
  SEARCH_DBC_SPELL_CAST_TIMES,
  RELOAD_APP,
  EXPORT_ITEM_DBC,
  EXPORT_SCALING_STAT_DISTRIBUTION_DBC,
  GLOBAL_MESSAGE_BOX,
} from "../constants";

const DBC = require("warcrafty");
const { knex } = require("../libs/mysql");

let path;

ipcMain.on(INIT_DBC_CONFIG, (event, payload) => {
  path = payload.path;
  event.reply(INIT_DBC_CONFIG);
});

ipcMain.on(SEARCH_DBC_FACTIONS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_faction");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/Faction.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_faction", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_FACTIONS);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_FACTIONS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_FACTIONS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_FACTIONS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_FACTIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_FACTION_TEMPLATES, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_faction_template");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/FactionTemplate.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_faction_template", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_FACTION_TEMPLATES);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_FACTION_TEMPLATES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_FACTION_TEMPLATES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_FACTION_TEMPLATES);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_FACTION_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_CREATURE_SPELL_DATAS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_creature_spell_data");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/CreatureSpellData.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_creature_spell_data", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_CREATURE_SPELL_DATAS);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_CREATURE_SPELL_DATAS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_CREATURE_SPELL_DATAS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_CREATURE_SPELL_DATAS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_CREATURE_SPELL_DATAS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_CREATURE_DISPLAY_INFOS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_creature_display_info");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/CreatureDisplayInfo.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_creature_display_info", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_CREATURE_DISPLAY_INFOS);
              })
              .catch((error) => {
                event.reply(
                  `${SEARCH_DBC_CREATURE_DISPLAY_INFOS}_REJECT`,
                  error
                );
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_CREATURE_DISPLAY_INFOS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_CREATURE_DISPLAY_INFOS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_CREATURE_DISPLAY_INFOS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_CREATURE_MODEL_DATAS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_creature_model_data");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/CreatureModelData.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_creature_model_data", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_CREATURE_MODEL_DATAS);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_CREATURE_MODEL_DATAS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_CREATURE_MODEL_DATAS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_CREATURE_MODEL_DATAS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_CREATURE_MODEL_DATAS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_ITEMS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_item");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/Item.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_item", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_ITEMS);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_ITEMS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_ITEMS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_ITEMS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_ITEMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_ITEM_DISPLAY_INFOS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_item_display_info");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ItemDisplayInfo.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_item_display_info", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_ITEM_DISPLAY_INFOS);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_ITEM_DISPLAY_INFOS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_SPELLS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_spell");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/Spell.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_spell", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_SPELLS);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_SPELLS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_SPELLS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_SPELLS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SPELLS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_SPELL_DURATIONS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_spell_duration");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/SpellDuration.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_spell_duration", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_SPELL_DURATIONS);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_SPELL_DURATIONS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_SPELL_DURATIONS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_SPELL_DURATIONS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SPELL_DURATIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_scaling_stat_distribution");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ScalingStatDistribution.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_scaling_stat_distribution", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS);
              })
              .catch((error) => {
                event.reply(
                  `${SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`,
                  error
                );
              });
          })
          .catch((error) => {
            event.reply(
              `${SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`,
              error
            );
          });
      } else {
        event.reply(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_SCALING_STAT_VALUES, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_scaling_stat_values");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ScalingStatValues.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_scaling_stat_values", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_SCALING_STAT_VALUES);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_SCALING_STAT_VALUES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_SCALING_STAT_VALUES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_SCALING_STAT_VALUES);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SCALING_STAT_VALUES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_ITEM_SETS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_item_set");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ItemSet.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_item_set", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_ITEM_SETS);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_ITEM_SETS}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_ITEM_SETS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_ITEM_SETS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_ITEM_SETS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_spell_item_enchantment");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/SpellItemEnchantment.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_spell_item_enchantment", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS);
              })
              .catch((error) => {
                event.reply(
                  `${SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS}_REJECT`,
                  error
                );
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_ITEM_RANDOM_PROPERTITIES, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_item_random_properties");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ItemRandomProperties.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_item_random_properties", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_ITEM_RANDOM_PROPERTITIES);
              })
              .catch((error) => {
                event.reply(
                  `${SEARCH_DBC_ITEM_RANDOM_PROPERTITIES}_REJECT`,
                  error
                );
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_ITEM_RANDOM_PROPERTITIES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_ITEM_RANDOM_PROPERTITIES);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_ITEM_RANDOM_PROPERTITIES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_ITEM_RANDOM_SUFFIXES, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_item_random_suffix");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/ItemRandomSuffix.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_item_random_suffix", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_ITEM_RANDOM_SUFFIXES);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_ITEM_RANDOM_SUFFIXES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_ITEM_RANDOM_SUFFIXES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_ITEM_RANDOM_SUFFIXES);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_ITEM_RANDOM_SUFFIXES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_DBC_SPELL_CAST_TIMES, (event) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_spell_cast_times");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        DBC.read(`${path}/SpellCastTimes.dbc`)
          .then((dbc) => {
            knex()
              .batchInsert("foxy.dbc_spell_cast_times", dbc.records)
              .then(() => {
                event.reply(SEARCH_DBC_SPELL_CAST_TIMES);
              })
              .catch((error) => {
                event.reply(`${SEARCH_DBC_SPELL_CAST_TIMES}_REJECT`, error);
                event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_SPELL_CAST_TIMES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
          });
      } else {
        event.reply(SEARCH_DBC_SPELL_CAST_TIMES);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SPELL_CAST_TIMES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(EXPORT_ITEM_DBC, (event) => {
  let queryBuilder = knex()
    .select()
    .from("foxy.dbc_item");

  event.reply(`${EXPORT_ITEM_DBC}_PROGRESS`, "Searching database");
  queryBuilder
    .then((rows) => {
      event.reply(`${EXPORT_ITEM_DBC}_PROGRESS`, `Writing ${path}/Item.dbc`);
      DBC.write(`${path}/Item.dbc`, rows)
        .then(() => {
          event.reply(EXPORT_ITEM_DBC);
        })
        .catch((error) => {
          event.reply(`${EXPORT_ITEM_DBC}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        });
    })
    .catch((error) => {
      event.reply(`${EXPORT_ITEM_DBC}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(EXPORT_SPELL_DBC, (event) => {
  let queryBuilder = knex()
    .select()
    .from("foxy.dbc_spell");

  event.reply(`${EXPORT_SPELL_DBC}_PROGRESS`, "Searching database");
  queryBuilder
    .then((rows) => {
      event.reply(`${EXPORT_SPELL_DBC}_PROGRESS`, `Writing ${path}/Spell.dbc`);
      DBC.write(`${path}/Spell.dbc`, rows)
        .then(() => {
          event.reply(EXPORT_SPELL_DBC);
        })
        .catch((error) => {
          event.reply(`${EXPORT_SPELL_DBC}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        });
    })
    .catch((error) => {
      event.reply(`${EXPORT_SPELL_DBC}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(EXPORT_SCALING_STAT_DISTRIBUTION_DBC, (event) => {
  let queryBuilder = knex()
    .select()
    .from("foxy.dbc_scaling_stat_distribution");

  event.reply(
    `${EXPORT_SCALING_STAT_DISTRIBUTION_DBC}_PROGRESS`,
    "Searching database"
  );
  queryBuilder
    .then((rows) => {
      event.reply(
        `${EXPORT_SCALING_STAT_DISTRIBUTION_DBC}_PROGRESS`,
        `Writing ${path}/ScalingStatDistribution.dbc`
      );
      DBC.write(`${path}/ScalingStatDistribution.dbc`, rows)
        .then(() => {
          event.reply(EXPORT_SCALING_STAT_DISTRIBUTION_DBC);
        })
        .catch((error) => {
          event.reply(`${EXPORT_SCALING_STAT_DISTRIBUTION_DBC}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        });
    })
    .catch((error) => {
      event.reply(`${EXPORT_SCALING_STAT_DISTRIBUTION_DBC}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
