import express from "express";
import {
  CreatureTemplate,
  CreatureTemplateLocale,
  sequelize,
} from "./database/creature.js";
import { Sequelize } from "sequelize";

// import socketIO from "socket.io";

export default (app, http) => {
  // app.use(express.json());
  //
  app.get("/foo", (req, res) => {
    res.json({ msg: "foo" });
  });

  app.get("/creature-template", (req, res) => {
    let query = req.query;
    let sql =
      "select ct.entry, ct.name,ct.subname,ct.minlevel,ct.maxlevel, ctl.Name as localeName,ctl.Title as localeTitle,ctl.locale from creature_template as ct left join creature_template_locale as ctl on ct.entry=ctl.`entry` and ctl.locale='zhCN'";
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
};
