import { ipcMain } from "electron";

const DBC = require("warcrafty");
const { knex } = require("../libs/mysql");

ipcMain.on("SEARCH_ITEM_DBC", (event) => {
  let queryBuilder = knex().select().from("foxy.dbc_item");

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

ipcMain.on("SEARCH_SPELL_DBC", (event) => {
  let queryBuilder = knex().select().from("foxy.dbc_spell");

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

ipcMain.on("SEARCH_SCALING_STAT_DISTRIBUTION_DBC", (event) => {
  let queryBuilder = knex().select().from("foxy.dbc_scaling_stat_distribution");

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

ipcMain.on("SEARCH_ITEM_SET_DBC", (event) => {
  let queryBuilder = knex().select().from("foxy.dbc_item_set");

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

ipcMain.on("SEARCH_TALENT_DBC", (event) => {
  let queryBuilder = knex().select().from("foxy.dbc_talent");

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
  let queryBuilder = knex().select().from("foxy.dbc_talent_TAB");

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

ipcMain.on("WRITE_ITEM_DBC", (event) => {
  DBC.write(`${global.path}/Item.dbc`, global.items)
    .then(() => {
      event.reply("WRITE_ITEM_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_ITEM_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_SPELL_DBC", (event) => {
  DBC.write(`${global.path}/Spell.dbc`, global.spells)
    .then(() => {
      event.reply("WRITE_SPELL_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_SPELL_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_SCALING_STAT_DISTRIBUTION_DBC", (event) => {
  DBC.write(
    `${global.path}/ScalingStatDistribution.dbc`,
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

ipcMain.on("WRITE_ITEM_SET_DBC", (event) => {
  DBC.write(`${global.path}/ItemSet.dbc`, global.itemSets)
    .then(() => {
      event.reply("WRITE_ITEM_SET_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_ITEM_SET_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_TALENT_DBC", (event) => {
  DBC.write(`${global.path}/Talent.dbc`, global.talents)
    .then(() => {
      event.reply("WRITE_TALENT_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_TALENT_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});

ipcMain.on("WRITE_TALENT_TAB_DBC", (event) => {
  DBC.write(`${global.path}/TalentTab.dbc`, global.talentTabs)
    .then(() => {
      event.reply("WRITE_TALENT_TAB_DBC");
    })
    .catch((error) => {
      event.reply("WRITE_TALENT_TAB_DBC_REJECT", error);
      event.reply("GLOBAL_MESSAGE_BOX", JSON.stringify(error));
    });
});
