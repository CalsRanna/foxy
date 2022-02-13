import { ipcMain } from "electron";

import {
  SEARCH_GLYPH_PROPERTIES,
  COUNT_GLYPH_PROPERTIES,
  STORE_GLYPH_PROPERTY,
  FIND_GLYPH_PROPERTY,
  UPDATE_GLYPH_PROPERTY,
  DESTROY_GLYPH_PROPERTY,
  CREATE_GLYPH_PROPERTY,
  COPY_GLYPH_PROPERTY,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_GLYPH_PROPERTIES, (event, payload) => {
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
      event.reply(SEARCH_GLYPH_PROPERTIES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_GLYPH_PROPERTIES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_GLYPH_PROPERTIES, (event, payload) => {
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
      event.reply(COUNT_GLYPH_PROPERTIES, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_GLYPH_PROPERTIES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_GLYPH_PROPERTY, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_glyph_properties");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_GLYPH_PROPERTY, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_GLYPH_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_GLYPH_PROPERTY, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("foxy.dbc_glyph_properties")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_GLYPH_PROPERTY, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_GLYPH_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_GLYPH_PROPERTY, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_glyph_properties")
    .where(payload.credential)
    .update(payload.glyphProperty);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_GLYPH_PROPERTY, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_GLYPH_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_GLYPH_PROPERTY, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_glyph_properties")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_GLYPH_PROPERTY, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_GLYPH_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_GLYPH_PROPERTY, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_glyph_properties")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_GLYPH_PROPERTY, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_GLYPH_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_GLYPH_PROPERTY, (event, payload) => {
  let ID = undefined;
  let glyphProperty = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_glyph_properties")
    .orderBy("ID", "desc");
  let findGlyphPropertyQueryBuilder = knex
    .select()
    .from("foxy.dbc_glyph_properties")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findGlyphPropertyQueryBuilder.then((rows) => {
      glyphProperty = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      glyphProperty.ID = ID + 1;
      let queryBuilder = knex
        .insert(glyphProperty)
        .into("foxy.dbc_glyph_properties");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_GLYPH_PROPERTY, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_GLYPH_PROPERTY}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_GLYPH_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
