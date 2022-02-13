import { ipcMain } from "electron";

import {
  SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR,
  COUNT_GLYPH_PROPERTIES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "gp.*",
      "ds.Name_Lang_zhCN",
      "dsi.TextureFilename",
      "si.TextureFilename as GlyphIconTextureFilename",
    ])
    .leftJoin("foxy.dbc_spell as ds", "gp.SpellID", "ds.ID")
    .leftJoin("foxy.dbc_spell_icon as dsi", "ds.SpellIconID", "dsi.ID")
    .leftJoin("foxy.dbc_spell_icon as si", "gp.SpellIconID", "si.ID")
    .from("foxy.dbc_glyph_properties as gp");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("gp.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "ds.Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_GLYPH_PROPERTIES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_GLYPH_PROPERTIES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_glyph_properties as gp")
    .leftJoin("foxy.dbc_spell as ds", "gp.SpellID", "ds.ID")
    .leftJoin("foxy.dbc_spell_icon as dsi", "ds.SpellIconID", "dsi.ID")
    .leftJoin("foxy.dbc_spell_icon as si", "gp.SpellIconID", "si.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("gp.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "ds.Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_GLYPH_PROPERTIES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_GLYPH_PROPERTIES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
