const ipcRenderer = window.ipcRenderer;

import axios from "axios";
import {
  LOAD_DEVELOPER_CONFIG,
  LOAD_MYSQL_CONFIG,
  LOAD_DBC_CONFIG,
  INITIALIZE_MYSQL_CONNECTION,
  LOAD_DBC_CREATURE_DISPLAY_INFOS,
  LOAD_DBC_CREATURE_MODEL_DATAS,
  LOAD_DBC_CREATURE_SPELL_DATAS,
  LOAD_DBC_FACTIONS,
  LOAD_DBC_FACTION_TEMPLATES,
  LOAD_DBC_ITEMS,
  LOAD_DBC_ITEM_DISPLAY_INFOS,
  LOAD_DBC_ITEM_RANDOM_PROPERTITIES,
  LOAD_DBC_ITEM_RANDOM_SUFFIXES,
  LOAD_DBC_ITEM_SETS,
  LOAD_DBC_SCALING_STAT_DISTRIBUTIONS,
  LOAD_DBC_SCALING_STAT_VALUES,
  LOAD_DBC_SPELLS,
  LOAD_DBC_SPELL_CAST_TIMES,
  LOAD_DBC_SPELL_DURATIONS,
  LOAD_DBC_SPELL_ITEM_ENCHANTMENTS,
  LOAD_DBC_SPELL_MECHANICS,
  LOAD_DBC_SPELL_RANGES,
  LOAD_DBC_TALENTS,
  LOAD_DBC_TALENT_TABS,
  CHECK_VERSION,
} from "../constants";

const GITHUB_RELEASE_URL =
  "https://api.github.com/repos/CalsRanna/foxy/releases";
const NET_DISK_URL =
  "https://service-10eupx2f-1257886063.cd.apigw.tencentcs.com/release/APIService-GetNetDiskUrl";

export default {
  namespaced: true,
  state: () => ({
    developerConfig: {},
    mysqlConfig: {},
    dbcConfig: {},
    version: {},
    initialized: false,
    initializeSucceed: true,
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
    loadMysqlConfig({ commit }) {
      return new Promise((resolve) => {
        let mysqlConfig = {
          host: localStorage.getItem("host"),
          user: localStorage.getItem("user"),
          password: localStorage.getItem("password"),
          database: localStorage.getItem("database"),
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
        ipcRenderer.on(INITIALIZE_MYSQL_CONNECTION, () => {
          resolve();
        });
        ipcRenderer.on(
          `${INITIALIZE_MYSQL_CONNECTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcCreatureDisplayInfos() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_CREATURE_DISPLAY_INFOS);
        ipcRenderer.on(LOAD_DBC_CREATURE_DISPLAY_INFOS, () => {
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(LOAD_DBC_CREATURE_MODEL_DATAS, () => {
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(LOAD_DBC_CREATURE_SPELL_DATAS, () => {
          resolve();
        });
        ipcRenderer.on(
          `${LOAD_DBC_CREATURE_SPELL_DATAS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcFactions() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_FACTIONS);
        ipcRenderer.on(LOAD_DBC_FACTIONS, () => {
          resolve();
        });
        ipcRenderer.on(`${LOAD_DBC_FACTIONS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcFactionTemplates() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_FACTION_TEMPLATES);
        ipcRenderer.on(LOAD_DBC_FACTION_TEMPLATES, () => {
          resolve();
        });
        ipcRenderer.on(
          `${LOAD_DBC_FACTION_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcItems() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ITEMS);
        ipcRenderer.on(LOAD_DBC_ITEMS, () => {
          resolve();
        });
        ipcRenderer.on(`${LOAD_DBC_ITEMS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcItemDisplayInfos() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ITEM_DISPLAY_INFOS);
        ipcRenderer.on(LOAD_DBC_ITEM_DISPLAY_INFOS, () => {
          resolve();
        });
        ipcRenderer.on(
          `${LOAD_DBC_ITEM_DISPLAY_INFOS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcItemRandomProperties() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_ITEM_RANDOM_PROPERTITIES);
        ipcRenderer.on(LOAD_DBC_ITEM_RANDOM_PROPERTITIES, () => {
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(LOAD_DBC_ITEM_RANDOM_SUFFIXES, () => {
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(LOAD_DBC_ITEM_SETS, () => {
          resolve();
        });
        ipcRenderer.on(`${LOAD_DBC_ITEM_SETS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcScalingStatDistributions() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SCALING_STAT_DISTRIBUTIONS);
        ipcRenderer.on(LOAD_DBC_SCALING_STAT_DISTRIBUTIONS, () => {
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(LOAD_DBC_SCALING_STAT_VALUES, () => {
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(LOAD_DBC_SPELLS, () => {
          resolve();
        });
        ipcRenderer.on(`${LOAD_DBC_SPELLS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcSpellCastTimes() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_CAST_TIMES);
        ipcRenderer.on(LOAD_DBC_SPELL_CAST_TIMES, () => {
          resolve();
        });
        ipcRenderer.on(
          `${LOAD_DBC_SPELL_CAST_TIMES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellDurations() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_DURATIONS);
        ipcRenderer.on(LOAD_DBC_SPELL_DURATIONS, () => {
          resolve();
        });
        ipcRenderer.on(`${LOAD_DBC_SPELL_DURATIONS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcSpellItemEnchantments() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_ITEM_ENCHANTMENTS);
        ipcRenderer.on(LOAD_DBC_SPELL_ITEM_ENCHANTMENTS, () => {
          resolve();
        });
        ipcRenderer.on(
          `${LOAD_DBC_SPELL_ITEM_ENCHANTMENTS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    loadDbcSpellMechanics() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_MECHANICS);
        ipcRenderer.on(LOAD_DBC_SPELL_MECHANICS, () => {
          resolve();
        });
        ipcRenderer.on(`${LOAD_DBC_SPELL_MECHANICS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcSpellRanges() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_SPELL_RANGES);
        ipcRenderer.on(LOAD_DBC_SPELL_RANGES, () => {
          resolve();
        });
        ipcRenderer.on(`${LOAD_DBC_SPELL_RANGES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcTalents() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_TALENTS);
        ipcRenderer.on(LOAD_DBC_TALENTS, () => {
          resolve();
        });
        ipcRenderer.on(`${LOAD_DBC_TALENTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    loadDbcTalentTabs() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(LOAD_DBC_TALENT_TABS);
        ipcRenderer.on(LOAD_DBC_TALENT_TABS, () => {
          resolve();
        });
        ipcRenderer.on(`${LOAD_DBC_TALENT_TABS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    checkVersion({ commit }) {
      return new Promise((resolve, reject) => {
        let version = "";
        let githubUrl = "";
        let netDiskUrl = "";
        let code = "";
        Promise.all([
          axios.get(GITHUB_RELEASE_URL).then((response) => {
            if (response.data.length > 0) {
              version = response.data[0].tag_name;
              githubUrl = response.data[0].assets[0].browser_download_url;
            }
          }),

          axios.get(NET_DISK_URL).then((response) => {
            netDiskUrl = response.data.url;
            code = response.data.code;
          }),
        ]).then(() => {
          commit(CHECK_VERSION, {
            version: version,
            githubUrl: githubUrl,
            netDiskUrl: netDiskUrl,
            code: code,
          });
        });
      });
    },
    initializeSuccess({ commit }) {
      commit("INITIALIZE_SUCCESS");
    },
    initializeFailure({ commit }) {
      commit("INITIALIZE_FAILURE");
    },
  },
  mutations: {
    [LOAD_DEVELOPER_CONFIG](state, developerConfig) {
      state.developerConfig = developerConfig;
    },
    [LOAD_MYSQL_CONFIG](state, mysqlConfig) {
      state.mysqlConfig = mysqlConfig;
    },
    [LOAD_DBC_CONFIG](state, dbcConfig) {
      state.dbcConfig = dbcConfig;
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
  },
};
