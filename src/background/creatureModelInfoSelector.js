import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR,
  COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "DisplayID",
      "Gender",
      "dcmd_1.ModelName as ModelName_1",
      "dcmd_2.ModelName as ModelName_2",
    ])
    .from("creature_model_info")
    .leftJoin(
      "foxy.dbc_creature_display_info as dcdi_1",
      "DisplayID",
      "dcdi_1.ID"
    )
    .leftJoin(
      "foxy.dbc_creature_display_info as dcdi_2",
      "DisplayID_Other_Gender",
      "dcdi_2.ID"
    )
    .leftJoin(
      "foxy.dbc_creature_model_data as dcmd_1",
      "dcdi_1.ModelID",
      "dcmd_1.ID"
    )
    .leftJoin(
      "foxy.dbc_creature_model_data as dcmd_2",
      "dcdi_2.ModelID",
      "dcmd_2.ID"
    );
  if (payload.DisplayID) {
    queryBuilder = queryBuilder.where(
      "DisplayID",
      "like",
      `%${payload.DisplayID}%`
    );
  }
  if (payload.ModelName) {
    queryBuilder = queryBuilder
      .where("dcmd_1.ModelName", "like", `%${payload.ModelName}%`)
      .orWhere("dcmd_2.ModelName", "like", `%${payload.ModelName}%`);
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_MODEL_INFOS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("creature_model_info")
    .leftJoin(
      "foxy.dbc_creature_display_info as dcdi_1",
      "DisplayID",
      "dcdi_1.ID"
    )
    .leftJoin(
      "foxy.dbc_creature_display_info as dcdi_2",
      "DisplayID_Other_Gender",
      "dcdi_2.ID"
    )
    .leftJoin(
      "foxy.dbc_creature_model_data as dcmd_1",
      "dcdi_1.ModelID",
      "dcmd_1.ID"
    )
    .leftJoin(
      "foxy.dbc_creature_model_data as dcmd_2",
      "dcdi_2.ModelID",
      "dcmd_2.ID"
    );
  if (payload.DisplayID) {
    queryBuilder = queryBuilder.where(
      "DisplayID",
      "like",
      `%${payload.DisplayID}%`
    );
  }
  if (payload.ModelName) {
    queryBuilder = queryBuilder
      .where("dcmd_1.ModelName", "like", `%${payload.ModelName}%`)
      .orWhere("dcmd_2.ModelName", "like", `%${payload.ModelName}%`);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_CREATURE_MODEL_INFOS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
