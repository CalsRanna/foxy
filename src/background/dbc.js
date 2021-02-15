import { ipcMain } from "electron";

import {
  INIT_DBC_CONFIG,
  SEARCH_DBC_FACTIONS,
  SEARCH_DBC_FACTION_TEMPLATES,
  SEARCH_DBC_ITEM_DISPLAY_INFOS,
  SEARCH_DBC_ITEMS,
  SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS,
  SEARCH_DBC_SCALING_STAT_VALUES,
  SEARCH_DBC_SPELLS,
  EXPORT_SPELL_DBC,
  SEARCH_DBC_SPELL_DURATIONS,
  RELOAD_APP,
  EXPORT_ITEM_DBC,
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
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_FACTIONS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(SEARCH_DBC_FACTIONS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_FACTIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_FACTION_TEMPLATES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(SEARCH_DBC_FACTION_TEMPLATES);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_FACTION_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_ITEMS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(SEARCH_DBC_ITEMS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_ITEMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(SEARCH_DBC_ITEM_DISPLAY_INFOS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_SPELLS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(SEARCH_DBC_SPELLS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SPELLS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_SPELL_DURATIONS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(SEARCH_DBC_SPELL_DURATIONS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SPELL_DURATIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
                event.reply(GLOBAL_MESSAGE_BOX, error);
              });
          })
          .catch((error) => {
            event.reply(`${SEARCH_DBC_SCALING_STAT_VALUES}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          });
      } else {
        event.reply(SEARCH_DBC_SCALING_STAT_VALUES);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SCALING_STAT_VALUES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
          event.reply(GLOBAL_MESSAGE_BOX, error);
        });
    })
    .catch((error) => {
      event.reply(`${EXPORT_ITEM_DBC}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
          event.reply(GLOBAL_MESSAGE_BOX, error);
        });
    })
    .catch((error) => {
      event.reply(`${EXPORT_SPELL_DBC}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
