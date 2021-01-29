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
  GLOBAL_NOTICE,
} from "../constants";

const DBC = require("warcrafty");
const { foxyKnex } = require("../libs/mysql");

let path;

ipcMain.on(INIT_DBC_CONFIG, (event, payload) => {
  path = payload.path;
  event.reply(INIT_DBC_CONFIG);
});

ipcMain.on(SEARCH_DBC_FACTIONS, (event) => {
  let queryBuilder = foxyKnex()
    .count("* as total")
    .from("dbc_faction");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        try {
          let dbc = DBC.read(`${path}/Faction.dbc`);
          foxyKnex()
            .batchInsert("dbc_faction", dbc.records)
            .then(() => {
              event.reply(SEARCH_DBC_FACTIONS);
            })
            .catch((error) => {
              event.reply(`${SEARCH_DBC_FACTIONS}_REJECT`, error);
            });
        } catch (error) {
          event.reply(`${SEARCH_DBC_FACTIONS}_REJECT`, error);
        }
      } else {
        event.reply(SEARCH_DBC_FACTIONS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_FACTIONS}_REJECT`, error);
    });
});

ipcMain.on(SEARCH_DBC_FACTION_TEMPLATES, (event) => {
  let queryBuilder = foxyKnex()
    .count("* as total")
    .from("dbc_faction_template");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        try {
          let dbc = DBC.read(`${path}/FactionTemplate.dbc`);
          foxyKnex()
            .batchInsert("dbc_faction_template", dbc.records)
            .then(() => {
              event.reply(SEARCH_DBC_FACTION_TEMPLATES);
            })
            .catch((error) => {
              event.reply(`${SEARCH_DBC_FACTION_TEMPLATES}_REJECT`, error);
            });
        } catch (error) {
          event.reply(`${SEARCH_DBC_FACTION_TEMPLATES}_REJECT`, error);
        }
      } else {
        event.reply(SEARCH_DBC_FACTION_TEMPLATES);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_FACTION_TEMPLATES}_REJECT`, error);
    });
});

ipcMain.on(SEARCH_DBC_ITEMS, (event) => {
  let queryBuilder = foxyKnex()
    .count("* as total")
    .from("dbc_item");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        try {
          let dbc = DBC.read(`${path}/Item.dbc`);
          foxyKnex()
            .batchInsert("dbc_item", dbc.records)
            .then(() => {
              event.reply(SEARCH_DBC_ITEMS);
            })
            .catch((error) => {
              event.reply(`${SEARCH_DBC_ITEMS}_REJECT`, error);
            });
        } catch (error) {
          event.reply(`${SEARCH_DBC_ITEMS}_REJECT`, error);
        }
      } else {
        event.reply(SEARCH_DBC_ITEMS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_ITEMS}_REJECT`, error);
    });
});

ipcMain.on(SEARCH_DBC_ITEM_DISPLAY_INFOS, (event) => {
  let queryBuilder = foxyKnex()
    .count("* as total")
    .from("dbc_item_display_info");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        try {
          let dbc = DBC.read(`${path}/ItemDisplayInfo.dbc`);
          foxyKnex()
            .batchInsert("dbc_item_display_info", dbc.records)
            .then(() => {
              event.reply(SEARCH_DBC_ITEM_DISPLAY_INFOS);
            })
            .catch((error) => {
              event.reply(`${SEARCH_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
            });
        } catch (error) {
          event.reply(`${SEARCH_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
        }
      } else {
        event.reply(SEARCH_DBC_ITEM_DISPLAY_INFOS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_ITEM_DISPLAY_INFOS}_REJECT`, error);
    });
});

ipcMain.on(SEARCH_DBC_SPELLS, (event) => {
  let queryBuilder = foxyKnex()
    .count("* as total")
    .from("dbc_spell");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        try {
          let dbc = DBC.read(`${path}/Spell.dbc`);
          foxyKnex()
            .batchInsert("dbc_spell", dbc.records)
            .then(() => {
              event.reply(SEARCH_DBC_SPELLS);
            })
            .catch((error) => {
              event.reply(`${SEARCH_DBC_SPELLS}_REJECT`, error);
            });
        } catch (error) {
          event.reply(`${SEARCH_DBC_SPELLS}_REJECT`, error);
        }
      } else {
        event.reply(SEARCH_DBC_SPELLS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SPELLS}_REJECT`, error);
    });
});

ipcMain.on(SEARCH_DBC_SPELL_DURATIONS, (event) => {
  let queryBuilder = foxyKnex()
    .count("* as total")
    .from("dbc_spell_duration");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        try {
          let dbc = DBC.read(`${path}/SpellDuration.dbc`);
          foxyKnex()
            .batchInsert("dbc_spell_duration", dbc.records)
            .then(() => {
              event.reply(SEARCH_DBC_SPELL_DURATIONS);
            })
            .catch((error) => {
              event.reply(`${SEARCH_DBC_SPELL_DURATIONS}_REJECT`, error);
            });
        } catch (error) {
          event.reply(`${SEARCH_DBC_SPELL_DURATIONS}_REJECT`, error);
        }
      } else {
        event.reply(SEARCH_DBC_SPELL_DURATIONS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SPELL_DURATIONS}_REJECT`, error);
    });
});

ipcMain.on(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, (event) => {
  let queryBuilder = foxyKnex()
    .count("* as total")
    .from("dbc_scaling_stat_distribution");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        try {
          let dbc = DBC.read(`${path}/ScalingStatDistribution.dbc`);
          foxyKnex()
            .batchInsert("dbc_scaling_stat_distribution", dbc.records)
            .then(() => {
              event.reply(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS);
            })
            .catch((error) => {
              event.reply(
                `${SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`,
                error
              );
            });
        } catch (error) {
          event.reply(`${SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`, error);
        }
      } else {
        event.reply(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`, error);
    });
});

ipcMain.on(SEARCH_DBC_SCALING_STAT_VALUES, (event) => {
  let queryBuilder = foxyKnex()
    .count("* as total")
    .from("dbc_scaling_stat_values");

  queryBuilder
    .then((rows) => {
      if (rows[0].total == 0) {
        try {
          let dbc = DBC.read(`${path}/ScalingStatValues.dbc`);
          foxyKnex()
            .batchInsert("dbc_scaling_stat_values", dbc.records)
            .then(() => {
              event.reply(SEARCH_DBC_SCALING_STAT_VALUES);
            })
            .catch((error) => {
              event.reply(`${SEARCH_DBC_SCALING_STAT_VALUES}_REJECT`, error);
            });
        } catch (error) {
          event.reply(`${SEARCH_DBC_SCALING_STAT_VALUES}_REJECT`, error);
        }
      } else {
        event.reply(SEARCH_DBC_SCALING_STAT_VALUES);
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_DBC_SCALING_STAT_VALUES}_REJECT`, error);
    });
});

ipcMain.on(EXPORT_SPELL_DBC, (event) => {
  let queryBuilder = foxyKnex()
    .select()
    .from("dbc_spell");

  queryBuilder
    .then((rows) => {
      try {
        DBC.write(`${path}/Spell.dbc`, rows);
        event.reply(EXPORT_SPELL_DBC);
      } catch (error) {
        event.reply(`${EXPORT_SPELL_DBC}_REJECT`, error);
      }
    })
    .catch((error) => {
      event.reply(`${EXPORT_SPELL_DBC}_REJECT`, error);
    });
});
