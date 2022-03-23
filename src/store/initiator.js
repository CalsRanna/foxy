const ipcRenderer = window.ipcRenderer;

import axios from "axios";
import {
  LOAD_DEVELOPER_CONFIG,
  LOAD_ADVANCE_CONFIG,
  LOAD_MYSQL_CONFIG,
  LOAD_DBC_CONFIG,
  INITIALIZE_MYSQL_CONNECTION,
  LOAD_DBC_ACHIEVEMENTS,
  LOAD_DBC_ACHIEVEMENT_CATEGORIES,
  LOAD_DBC_ACHIEVEMENT_CRITERIAS,
  LOAD_DBC_AREA_TABLES,
  LOAD_DBC_CHAR_TITLES,
  LOAD_DBC_CHR_CLASSES,
  LOAD_DBC_CHR_RACES,
  LOAD_DBC_CREATURE_DISPLAY_INFOS,
  LOAD_DBC_CREATURE_MODEL_DATAS,
  LOAD_DBC_CREATURE_SPELL_DATAS,
  LOAD_DBC_EMOTES,
  LOAD_DBC_EMOTES_TEXTS,
  LOAD_DBC_FACTIONS,
  LOAD_DBC_FACTION_TEMPLATES,
  LOAD_DBC_GAME_OBJECT_DISPLAY_INFOS,
  LOAD_DBC_GLYPH_PROPERTIES,
  LOAD_DBC_ITEMS,
  LOAD_DBC_ITEM_DISPLAY_INFOS,
  LOAD_DBC_ITEM_RANDOM_PROPERTITIES,
  LOAD_DBC_ITEM_RANDOM_SUFFIXES,
  LOAD_DBC_ITEM_SETS,
  LOAD_DBC_LOCKS,
  LOAD_DBC_LOCK_TYPES,
  LOAD_DBC_MAPS,
  LOAD_DBC_QUEST_FACTION_REWARDS,
  LOAD_DBC_QUEST_INFOS,
  LOAD_DBC_QUEST_SORTS,
  LOAD_DBC_SCALING_STAT_DISTRIBUTIONS,
  LOAD_DBC_SCALING_STAT_VALUES,
  LOAD_DBC_SPELLS,
  LOAD_DBC_SPELL_CAST_TIMES,
  LOAD_DBC_SPELL_CATEGORIES,
  LOAD_DBC_SPELL_DESCRIPTION_VARIABLES,
  LOAD_DBC_SPELL_DIFFICULTIES,
  LOAD_DBC_SPELL_DISPEL_TYPES,
  LOAD_DBC_SPELL_DURATIONS,
  LOAD_DBC_SPELL_ICONS,
  LOAD_DBC_SPELL_ITEM_ENCHANTMENTS,
  LOAD_DBC_SPELL_MECHANICS,
  LOAD_DBC_SPELL_RANGES,
  LOAD_DBC_TALENTS,
  LOAD_DBC_TALENT_TABS,
  CHECK_VERSION,
  TEST_MYSQL_CONNECTION,
  LOAD_DBC_CURRENCY_TYPES,
  LOAD_DBC_CURRENCY_CATEGORIES,
  LOAD_DBC_ITEM_EXTENDED_COSTS,
} from "../constants";

const GITHUB_RELEASE_URL =
  "https://api.github.com/repos/CalsRanna/foxy/releases";
const NET_DISK_URL =
  "https://service-10eupx2f-1257886063.cd.apigw.tencentcs.com/release/APIService-GetNetDiskUrl";

export default {
  namespaced: true,
  state: () => ({
    developerConfig: {},
    advanceConfig: {},
    mysqlConfig: {},
    dbcConfig: {},
    initialized: false,
    initializeSucceed: true,
    chrClasses: [],
    chrRaces: [],
    lockTypes: [],
    questFactionRewards: [],
    spellDispelTypes: [],
    spellMechanics: [],
  }),
  actions: {
    loadDeveloperConfig({ commit }) {
      return new Promise((resolve) => {
        let developerConfig = {
          debug: localStorage.getItem("debug") === "true" ? true : false,
        };
        commit(LOAD_DEVELOPER_CONFIG, developerConfig);
        resolve();
      });
    },
    loadAdvanceConfig({ commit }) {
      return new Promise((resolve) => {
        let advanceConfig = {
          size: parseInt(localStorage.getItem("size") ?? 50),
        };
        commit(LOAD_ADVANCE_CONFIG, advanceConfig);
        resolve();
      });
    },
    loadMysqlConfig({ commit }) {
      return new Promise((resolve) => {
        let mysqlConfig = {
          host: localStorage.getItem("host") ?? "127.0.0.1",
          user: localStorage.getItem("user") ?? "acore",
          password: localStorage.getItem("password") ?? "acore",
          database: localStorage.getItem("database") ?? "acore_world",
          port: localStorage.getItem("port") ?? 3306,
        };
        ipcRenderer.send(LOAD_MYSQL_CONFIG, mysqlConfig);
        commit(LOAD_MYSQL_CONFIG, mysqlConfig);
        resolve();
      });
    },
    loadDbcConfig({ commit }) {
      return new Promise((resolve) => {
        let dbcConfig = {
          path: localStorage.getItem("dbcPath"),
        };
        ipcRenderer.send(LOAD_DBC_CONFIG, dbcConfig);
        commit(LOAD_DBC_CONFIG, dbcConfig);
        resolve();
      });
    },
    initializeMysqlConnection(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(INITIALIZE_MYSQL_CONNECTION, payload);
        ipcRenderer.once(INITIALIZE_MYSQL_CONNECTION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${INITIALIZE_MYSQL_CONNECTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcAchievements() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ACHIEVEMENTS);
        ipcRenderer.once(LOAD_DBC_ACHIEVEMENTS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_ACHIEVEMENTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcAchievementCategories() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ACHIEVEMENT_CATEGORIES);
        ipcRenderer.once(LOAD_DBC_ACHIEVEMENT_CATEGORIES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_ACHIEVEMENT_CATEGORIES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcAchievementCriterias() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ACHIEVEMENT_CRITERIAS);
        ipcRenderer.once(LOAD_DBC_ACHIEVEMENT_CRITERIAS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_ACHIEVEMENT_CRITERIAS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcAreaTables() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_AREA_TABLES);
        ipcRenderer.once(LOAD_DBC_AREA_TABLES, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_AREA_TABLES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcCharTitles() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_CHAR_TITLES);
        ipcRenderer.once(LOAD_DBC_CHAR_TITLES, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_CHAR_TITLES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcChrClasses({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_CHR_CLASSES);
        ipcRenderer.once(LOAD_DBC_CHR_CLASSES, (event, response) => {
          commit(LOAD_DBC_CHR_CLASSES, response);
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_CHR_CLASSES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcChrRaces({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_CHR_RACES);
        ipcRenderer.once(LOAD_DBC_CHR_RACES, (event, response) => {
          commit(LOAD_DBC_CHR_RACES, response);
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_CHR_RACES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcCreatureDisplayInfos() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_CREATURE_DISPLAY_INFOS);
        ipcRenderer.once(LOAD_DBC_CREATURE_DISPLAY_INFOS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_CREATURE_DISPLAY_INFOS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcCreatureModelDatas() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_CREATURE_MODEL_DATAS);
        ipcRenderer.once(LOAD_DBC_CREATURE_MODEL_DATAS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_CREATURE_MODEL_DATAS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcCreatureSpellDatas() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_CREATURE_SPELL_DATAS);
        ipcRenderer.once(LOAD_DBC_CREATURE_SPELL_DATAS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_CREATURE_SPELL_DATAS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcCurrencyCategories() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_CURRENCY_CATEGORIES);
        ipcRenderer.once(LOAD_DBC_CURRENCY_CATEGORIES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_CURRENCY_CATEGORIES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcCurrencyTypes() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_CURRENCY_TYPES);
        ipcRenderer.once(LOAD_DBC_CURRENCY_TYPES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_CURRENCY_TYPES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcEmotes() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_EMOTES);
        ipcRenderer.once(LOAD_DBC_EMOTES, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_EMOTES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcEmotesTexts() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_EMOTES_TEXTS);
        ipcRenderer.once(LOAD_DBC_EMOTES_TEXTS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_EMOTES_TEXTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcFactions() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_FACTIONS);
        ipcRenderer.once(LOAD_DBC_FACTIONS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_FACTIONS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcFactionTemplates() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_FACTION_TEMPLATES);
        ipcRenderer.once(LOAD_DBC_FACTION_TEMPLATES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_FACTION_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcGameObjectDisplayInfos() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_GAME_OBJECT_DISPLAY_INFOS);
        ipcRenderer.once(LOAD_DBC_GAME_OBJECT_DISPLAY_INFOS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_GAME_OBJECT_DISPLAY_INFOS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    initDbcGemProperties() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("INIT_DBC_GEM_PROPERTIES");
        ipcRenderer.once("INIT_DBC_GEM_PROPERTIES", () => {
          resolve();
        });
        ipcRenderer.once("INIT_DBC_GEM_PROPERTIES_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcGlyphProperties() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_GLYPH_PROPERTIES);
        ipcRenderer.once(LOAD_DBC_GLYPH_PROPERTIES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_GLYPH_PROPERTIES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcItems() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ITEMS);
        ipcRenderer.once(LOAD_DBC_ITEMS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_ITEMS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcItemDisplayInfos() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ITEM_DISPLAY_INFOS);
        ipcRenderer.once(LOAD_DBC_ITEM_DISPLAY_INFOS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_ITEM_DISPLAY_INFOS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcItemExtendedCosts() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ITEM_EXTENDED_COSTS);
        ipcRenderer.once(LOAD_DBC_ITEM_EXTENDED_COSTS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_ITEM_EXTENDED_COSTS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcItemRandomProperties() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ITEM_RANDOM_PROPERTITIES);
        ipcRenderer.once(LOAD_DBC_ITEM_RANDOM_PROPERTITIES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_ITEM_RANDOM_PROPERTITIES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcItemRandomSuffixes() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ITEM_RANDOM_SUFFIXES);
        ipcRenderer.once(LOAD_DBC_ITEM_RANDOM_SUFFIXES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_ITEM_RANDOM_SUFFIXES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcItemSets() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ITEM_SETS);
        ipcRenderer.once(LOAD_DBC_ITEM_SETS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_ITEM_SETS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcLocks() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_LOCKS);
        ipcRenderer.once(LOAD_DBC_LOCKS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_LOCKS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcLockTypes({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_LOCK_TYPES);
        ipcRenderer.once(LOAD_DBC_LOCK_TYPES, (event, response) => {
          commit(LOAD_DBC_LOCK_TYPES, response);
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_LOCK_TYPES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcMaps() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_MAPS);
        ipcRenderer.once(LOAD_DBC_MAPS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_MAPS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcQuestFactionRewards({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_QUEST_FACTION_REWARDS);
        ipcRenderer.once(LOAD_DBC_QUEST_FACTION_REWARDS, (event, response) => {
          commit(LOAD_DBC_QUEST_FACTION_REWARDS, response);
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_QUEST_FACTION_REWARDS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcQuestInfos() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_QUEST_INFOS);
        ipcRenderer.once(LOAD_DBC_QUEST_INFOS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_QUEST_INFOS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcQuestSorts() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_QUEST_SORTS);
        ipcRenderer.once(LOAD_DBC_QUEST_SORTS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_QUEST_SORTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcScalingStatDistributions() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SCALING_STAT_DISTRIBUTIONS);
        ipcRenderer.once(LOAD_DBC_SCALING_STAT_DISTRIBUTIONS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcScalingStatValues() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SCALING_STAT_VALUES);
        ipcRenderer.once(LOAD_DBC_SCALING_STAT_VALUES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SCALING_STAT_VALUES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpells() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELLS);
        ipcRenderer.once(LOAD_DBC_SPELLS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_SPELLS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcSpellCastTimes() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_CAST_TIMES);
        ipcRenderer.once(LOAD_DBC_SPELL_CAST_TIMES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SPELL_CAST_TIMES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellCategories() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_CATEGORIES);
        ipcRenderer.once(LOAD_DBC_SPELL_CATEGORIES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SPELL_CATEGORIES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellDescriptionVariables() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_DESCRIPTION_VARIABLES);
        ipcRenderer.once(LOAD_DBC_SPELL_DESCRIPTION_VARIABLES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SPELL_DESCRIPTION_VARIABLES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellDifficulties() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_DIFFICULTIES);
        ipcRenderer.once(LOAD_DBC_SPELL_DIFFICULTIES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SPELL_DIFFICULTIES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellDispelTypes({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_DISPEL_TYPES);
        ipcRenderer.once(LOAD_DBC_SPELL_DISPEL_TYPES, (event, response) => {
          commit(LOAD_DBC_SPELL_DISPEL_TYPES, response);
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SPELL_DISPEL_TYPES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellDurations() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_DURATIONS);
        ipcRenderer.once(LOAD_DBC_SPELL_DURATIONS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SPELL_DURATIONS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellIcons() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_ICONS);
        ipcRenderer.once(LOAD_DBC_SPELL_ICONS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_SPELL_ICONS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcSpellItemEnchantments() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_ITEM_ENCHANTMENTS);
        ipcRenderer.once(LOAD_DBC_SPELL_ITEM_ENCHANTMENTS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SPELL_ITEM_ENCHANTMENTS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellMechanics({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_MECHANICS);
        ipcRenderer.once(LOAD_DBC_SPELL_MECHANICS, (event, response) => {
          commit(LOAD_DBC_SPELL_MECHANICS, response);
          resolve();
        });
        ipcRenderer.once(
          `${LOAD_DBC_SPELL_MECHANICS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellRanges() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_RANGES);
        ipcRenderer.once(LOAD_DBC_SPELL_RANGES, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_SPELL_RANGES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcTalents() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_TALENTS);
        ipcRenderer.once(LOAD_DBC_TALENTS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_TALENTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcTalentTabs() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_TALENT_TABS);
        ipcRenderer.once(LOAD_DBC_TALENT_TABS, () => {
          resolve();
        });
        ipcRenderer.once(`${LOAD_DBC_TALENT_TABS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    initializeSuccess({ commit }) {
      commit("INITIALIZE_SUCCESS");
    },
    initializeFailure({ commit }) {
      commit("INITIALIZE_FAILURE");
    },
    storeDeveloperConfig({ commit }, payload) {
      return new Promise((resolve) => {
        localStorage.setItem("debug", payload.debug);
        commit(LOAD_DEVELOPER_CONFIG, payload);
        resolve();
      });
    },
    storeAdvanceConfig({ commit }, payload) {
      return new Promise((resolve) => {
        localStorage.setItem("size", payload.size);
        commit(LOAD_ADVANCE_CONFIG, payload);
        resolve();
      });
    },
    storeMysqlConfig({ commit }, payload) {
      return new Promise((resolve) => {
        localStorage.setItem("host", payload.host);
        localStorage.setItem("user", payload.user);
        localStorage.setItem("password", payload.password);
        localStorage.setItem("database", payload.database);
        localStorage.setItem("port", payload.port);
        commit(LOAD_MYSQL_CONFIG, payload);
        resolve();
      });
    },
    storeDbcConfig({ commit }, payload) {
      return new Promise((resolve) => {
        localStorage.setItem("dbcPath", payload.path);
        commit(LOAD_DBC_CONFIG, payload);
        resolve();
      });
    },
    testMysqlConnection(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(TEST_MYSQL_CONNECTION, payload);
        ipcRenderer.once(TEST_MYSQL_CONNECTION, (event, response) => {
          resolve(response);
        });
        ipcRenderer.once(`${TEST_MYSQL_CONNECTION}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetFoxy({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("RESET_FOXY");
        ipcRenderer.once("RESET_FOXY", (event, response) => {
          commit("RESET_FOXY");
          resolve(response);
        });
        ipcRenderer.once("RESET_FOXY_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
  },
  mutations: {
    [LOAD_DEVELOPER_CONFIG](state, developerConfig) {
      state.developerConfig = developerConfig;
    },
    [LOAD_ADVANCE_CONFIG](state, advanceConfig) {
      state.advanceConfig = advanceConfig;
    },
    [LOAD_MYSQL_CONFIG](state, mysqlConfig) {
      state.mysqlConfig = mysqlConfig;
    },
    [LOAD_DBC_CONFIG](state, dbcConfig) {
      state.dbcConfig = dbcConfig;
    },
    [LOAD_DBC_CHR_CLASSES](state, chrClasses) {
      state.chrClasses = chrClasses;
    },
    [LOAD_DBC_CHR_RACES](state, chrRaces) {
      state.chrRaces = chrRaces;
    },
    [LOAD_DBC_LOCK_TYPES](state, lockTypes) {
      state.lockTypes = lockTypes;
    },
    [LOAD_DBC_QUEST_FACTION_REWARDS](state, questFactionRewards) {
      state.questFactionRewards = questFactionRewards;
    },
    [LOAD_DBC_SPELL_DISPEL_TYPES](state, spellDispelTypes) {
      state.spellDispelTypes = spellDispelTypes;
    },
    [LOAD_DBC_SPELL_MECHANICS](state, spellMechanics) {
      state.spellMechanics = spellMechanics;
    },
    [CHECK_VERSION](state, version) {
      state.version = version;
    },
    INITIALIZE_SUCCESS(state) {
      state.initialized = true;
    },
    INITIALIZE_FAILURE(state) {
      state.initialized = true;
      state.initializeSucceed = false;
    },
    RESET_FOXY(state) {
      state.initialized = false;
    },
  },
};
