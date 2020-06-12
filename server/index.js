import express from "express";
import {
  CreatureTemplate,
  CreatureTemplateLocale,
  CreatureTemplateAddon,
  CreatureOnKillReputation,
  CreatureEquipTemplate,
  NpcTrainer,
} from "./database/creature.js";
import { ItemTemplate, ItemTemplateLocale } from "./database/item.js";
import { sequelize } from "./database/sequelize.js";
import { Sequelize } from "sequelize";

// import socketIO from "socket.io";

export default (app, http) => {
  // app.use(express.json());
  //

  app.get("/creature-template", (req, res) => {
    let query = req.query;
    let sql =
      "select ct.`entry`, ct.`name`,ct.`subname`,ct.`minlevel`,ct.`maxlevel`, ctl.`Name` as localeName,ctl.`Title` as localeTitle,ctl.`locale` from creature_template as ct left join creature_template_locale as ctl on ct.entry=ctl.`entry` and ctl.locale='zhCN'";
    let where = "where 1=1";
    if (query.entry) {
      where = `${where} and ct.entry like '%${query.entry}%'`;
    }
    if (query.name) {
      where = `${where} and (ct.name like '%${query.name}%' or ctl.Name like '%${query.name}%')`;
    }
    if (query.subname) {
      where = `${where} and (ct.subname like '%${query.subname}%' or ctl.Title like '%${query.subname}%')`;
    }
    let page = query.page;
    let offset = 0;
    if (page !== undefined) {
      offset = (page - 1) * 50;
    }
    let limit = `limit ${offset}, 50`;
    sequelize
      .query(`${sql} ${where} ${limit};`, { type: Sequelize.QueryTypes.SELECT })
      .then((values) => {
        res.json(values);
      });
  });

  app.get("/creature-template/quantity", (req, res) => {
    let query = req.query;
    let sql =
      "select count(*) as total from creature_template as ct left join creature_template_locale as ctl on ct.entry=ctl.`entry` and ctl.locale='zhCN'";
    let where = "where 1=1";
    if (query.entry) {
      where = `${where} and ct.entry like '%${query.entry}%'`;
    }
    if (query.name) {
      where = `${where} and (ct.name like '%${query.name}%' or ctl.Name like '%${query.name}%')`;
    }
    if (query.subname) {
      where = `${where} and (ct.subname like '%${query.subname}%' or ctl.Title like '%${query.subname}%')`;
    }
    sequelize
      .query(`${sql} ${where};`, { type: Sequelize.QueryTypes.SELECT })
      .then((values) => {
        res.json({ total: values[0].total });
      });
  });

  app.get("/creature-template/:id", (request, response) => {
    let id = request.params.id;
    CreatureTemplate.findOne({
      where: {
        entry: id,
      },
      include: [
        {
          all: true,
          required: false,
          where: {
            locale: "zhCN",
          },
        },
      ],
    }).then((creatureTemplate) => {
      response.json(creatureTemplate);
    });
  });

  app.get(
    "/creature-template/:id/creature-loot-template",
    (request, response) => {
      let id = request.params.id;
      let sql = `select clt.*,it.displayid,it.name,itl.Name, qt.LogTitle,qtl.Title from creature_loot_template as clt left join item_template as it on clt.Item=it.entry left join item_template_locale as itl on clt.Item=itl.ID and itl.locale='zhCN' left join quest_template as qt on clt.QuestRequired=qt.ID left join quest_template_locale as qtl on clt.QuestRequired=qtl.ID and qtl.locale='zhCN' where clt.Entry=${id}`;
      sequelize
        .query(sql, { type: Sequelize.QueryTypes.SELECT })
        .then((values) => {
          response.json(values);
        });
    }
  );

  app.get("/creature-template-addon/:id", (request, response) => {
    let id = request.params.id;
    CreatureTemplateAddon.findOne({
      where: {
        entry: id,
      },
    }).then((creatureTemplateAddon) => {
      response.json(creatureTemplateAddon);
    });
  });

  app.get(
    "/creature-template/:id/creature-onkill-reputation",
    (request, response) => {
      let id = request.params.id;
      CreatureOnKillReputation.findOne({
        where: {
          creature_id: id,
        },
      }).then((creatureOnKillReputation) => {
        response.json(creatureOnKillReputation);
      });
    }
  );

  app.get(
    "/creature-template/:id/creature-equip-template",
    (request, response) => {
      let id = request.params.id;
      let sql = `select cet.*,it1.displayid as displayid1,it1.name as name1,itl1.Name as Name1,it2.displayid as displayid2,it2.name as name2, itl2.Name as Name2,it3.displayid as displayid3,it3.name as name3, itl3.Name as Name3 from creature_equip_template as cet left join item_template as it1 on cet.ItemID1=it1.entry left join item_template_locale as itl1 on cet.ItemID1=itl1.ID and itl1.locale="zhCN" left join item_template as it2 on cet.ItemID2=it2.entry left join item_template_locale as itl2 on cet.ItemID2=itl2.ID and itl2.locale="zhCN" left join item_template as it3 on cet.ItemID3=it3.entry left join item_template_locale as itl3 on cet.ItemID3=itl3.ID and itl3.locale="zhCN" where CreatureID=${id}`;
      sequelize
        .query(sql, { type: Sequelize.QueryTypes.SELECT })
        .then((creatureOnKillReputations) => {
          response.json(creatureOnKillReputations);
        });
    }
  );

  app.get("/creature-template/:id/creature-questitem", (request, response) => {
    let id = request.params.id;
    let sql = `select cq.*,it.displayid,it.name,itl.Name from creature_questitem as cq left join item_template as it on cq.ItemId=it.entry left join item_template_locale as itl on cq.ItemId=itl.ID and itl.locale='zhCN' where cq.CreatureEntry=${id}`;
    sequelize
      .query(sql, { type: Sequelize.QueryTypes.SELECT })
      .then((values) => {
        response.json(values);
      });
  });

  app.get("/npc-vendor/:id", (request, response) => {
    let id = request.params.id;
    let sql = `select nv.*,it.displayid,it.name,itl.Name from npc_vendor as nv left join item_template as it on nv.item=it.entry left join item_template_locale as itl on nv.item=itl.ID and itl.locale='zhCN' where nv.entry=${id}`;
    sequelize
      .query(sql, { type: Sequelize.QueryTypes.SELECT })
      .then((values) => {
        response.json(values);
      });
  });

  app.get("/creature-template/:id/npc-trainer", (request, response) => {
    let id = request.params.id;
    NpcTrainer.findAll({
      where: {
        ID: id,
      },
    }).then((values) => {
      response.json(values);
    });
  });

  app.get(
    "/creature-template/:id/pickpocketing-loot-template",
    (request, response) => {
      let id = request.params.id;
      let sql = `select plt.*, it.displayid,it.name,itl.Name,qt.LogTitle,qtl.Title from pickpocketing_loot_template as plt left join item_template as it on plt.Item=it.entry left join item_template_locale as itl on plt.Item=itl.ID and itl.locale='zhCN' left join quest_template as qt on plt.QuestRequired=qt.ID left join quest_template_locale as qtl on plt.QuestRequired=qtl.ID and qtl.locale='zhCN' where plt.Entry=${id}`;
      sequelize
        .query(sql, { type: Sequelize.QueryTypes.SELECT })
        .then((values) => {
          response.json(values);
        });
    }
  );

  app.get(
    "/creature-template/:id/skinning-loot-template",
    (request, response) => {
      let id = request.params.id;
      let sql = `select slt.*, it.displayid,it.name,itl.Name,qt.LogTitle,qtl.Title from skinning_loot_template as slt left join item_template as it on slt.Item=it.entry left join item_template_locale as itl on slt.Item=itl.ID and itl.locale='zhCN' left join quest_template as qt on slt.QuestRequired=qt.ID left join quest_template_locale as qtl on slt.QuestRequired=qtl.ID and qtl.locale='zhCN' where slt.Entry=${id}`;
      sequelize
        .query(sql, { type: Sequelize.QueryTypes.SELECT })
        .then((values) => {
          response.json(values);
        });
    }
  );

  app.get("/item-template", (request, response) => {
    let query = request.query;
    let sql =
      "select it.`entry`, it.`class`, it.`subclass`, it.`name`, itl.`Name` as localeName, it.`displayid`, it.`Quality`, it.`InventoryType`, it.`ItemLevel`, it.`RequiredLevel` from item_template as it left join item_template_locale as itl on it.`entry`=itl.`ID` and itl.`locale`='zhCN'";
    let where = "where 1=1";
    if (query.class) {
      where = `${where} and it.class = ${query.class}`;
    }
    if (query.subclass) {
      where = `${where} and it.subclass = ${query.subclass}`;
    }
    if (query.inventoryType) {
      where = `${where} and it.inventoryType = ${query.inventoryType}`;
    }
    if (query.entry) {
      where = `${where} and it.entry like '%${query.entry}%'`;
    }
    if (query.name) {
      where = `${where} and (it.name like '%${query.name}%' or itl.Name like '%${query.name}%')`;
    }
    let page = query.page;
    let offset = 0;
    if (page !== undefined) {
      offset = (page - 1) * 50;
    }
    let limit = `limit ${offset}, 50`;
    sequelize
      .query(`${sql} ${where} ${limit};`, { type: Sequelize.QueryTypes.SELECT })
      .then((values) => {
        response.json(values);
      });
  });

  app.get("/item-template/quantity", (request, response) => {
    let query = request.query;
    let sql =
      "select count(*) as total from item_template as it left join item_template_locale as itl on it.`entry`=itl.`ID` and itl.`locale`='zhCN'";
    let where = "where 1=1";
    if (query.class) {
      where = `${where} and it.class = ${query.class}`;
    }
    if (query.subclass) {
      where = `${where} and it.subclass = ${query.subclass}`;
    }
    if (query.inventoryType) {
      where = `${where} and it.inventoryType = ${query.inventoryType}`;
    }
    if (query.entry) {
      where = `${where} and it.entry like '%${query.entry}%'`;
    }
    if (query.name) {
      where = `${where} and (it.name like '%${query.name}%' or itl.Name like '%${query.name}%')`;
    }
    sequelize
      .query(`${sql} ${where};`, { type: Sequelize.QueryTypes.SELECT })
      .then((values) => {
        response.json({ total: values[0].total });
      });
  });

  app.get("/item-template/:id", (request, response) => {
    let id = request.params.id;
    ItemTemplate.findOne({
      where: {
        entry: id
      },
      include: [
        {
          all: true,
          required: false,
          where: {
            locale: "zhCN",
          },
        },
      ],
    }).then((itemTemplate) => {
      response.json(itemTemplate);
    })
  });
};
