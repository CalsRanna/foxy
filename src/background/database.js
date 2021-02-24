const {
  knex,
  init,
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
} = require("../libs/mysql");

import { ipcMain } from "electron";
import {
  GLOBAL_MESSAGE_BOX,
  INIT_MYSQL_CONNECTION,
  TEST_MYSQL_CONNECTION,
} from "../constants";

ipcMain.on(INIT_MYSQL_CONNECTION, (event, payload) => {
  init(payload);
  knex()
    .raw("SHOW TABLES")
    .then(() => {
      knex()
        .raw(
          "CREATE DATABASE IF NOT EXISTS foxy DEFAULT CHARSET utf8 COLLATE utf8_general_ci"
        )
        .then(() => {
          Promise.all([
            knex()
              .raw(dbcSpellSql)
              .then(() => {}),
            knex()
              .raw(dbcFactionSql)
              .then(() => {}),
            knex()
              .raw(dbcFactionTemplateSql)
              .then(() => {}),
            knex()
              .raw(dbcItemSql)
              .then(() => {}),
            knex()
              .raw(dbcItemDisplayInfoSql)
              .then(() => {}),
            knex()
              .raw(dbcSpellDurationSql)
              .then(() => {}),
            knex()
              .raw(dbcScalingStatDistributionSql)
              .then(() => {}),
            knex()
              .raw(dbcScalingStatValuesSql)
              .then(() => {}),
            knex()
              .raw(dbcCreatureSpellDataSql)
              .then(() => {}),
            knex()
              .raw(dbcCreatureDisplayInfoSql)
              .then(() => {}),
            knex()
              .raw(dbcCreatureModelDataSql)
              .then(() => {}),
            knex()
              .raw(dbcItemSetSql)
              .then(() => {}),
            knex()
              .raw(dbcSpellItemEnchantmentSql)
              .then(() => {}),
            knex()
              .raw(dbcItemRandomPropertiesSql)
              .then(() => {}),
            knex()
              .raw(dbcItemRandomSuffixSql)
              .then(() => {}),
          ]).then(() => {
            event.reply(INIT_MYSQL_CONNECTION);
          });
        });
    })
    .catch((error) => {
      event.reply(`${INIT_MYSQL_CONNECTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(TEST_MYSQL_CONNECTION, (event, payload) => {
  init(payload);
  knex()
    .select("guid")
    .from("creature")
    .first()
    .then((rows) => {
      event.reply(TEST_MYSQL_CONNECTION);
    })
    .catch((error) => {
      event.reply(`${TEST_MYSQL_CONNECTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
