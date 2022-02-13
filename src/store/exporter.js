const ipcRenderer = window.ipcRenderer;

import { capitalCase, constantCase } from "change-case";
import { UPDATE_CHECKED_DBCS } from "../constants";

export default {
  namespaced: true,
  state: () => ({
    options: [
      "Achievement",
      "AchievementCategory",
      "AchievementCriteria",
      "AreaTable",
      "CurrencyCategory",
      "CurrencyType",
      "EmotesText",
      "GlyphProperty",
      "Item",
      "ItemExtendedCost",
      "ItemSet",
      "QuestFactionReward",
      "QuestInfo",
      "QuestSort",
      "ScalingStatDistribution",
      "ScalingStatValues",
      "Spell",
      "SpellItemEnchantment",
      "Talent",
      "TalentTab",
    ],
    checkedDbcs: ["Item", "Spell"],
    tips: [],
  }),
  actions: {
    updateCheckedDbcs({ commit }, payload) {
      commit(UPDATE_CHECKED_DBCS, payload.checkedDbcs);
    },
    exportDbc({ commit }, name) {
      return new Promise((resolve, reject) => {
        let capitalCaseName = capitalCase(name);
        let constantCaseName = constantCase(name);
        commit("PUSH_TIP", `准备${capitalCaseName}数据`);
        ipcRenderer.send(`SEARCH_${constantCaseName}_DBC`);
        ipcRenderer.once(`SEARCH_${constantCaseName}_DBC`, (event, count) => {
          commit("PUSH_TIP", `找到${count}条${capitalCaseName}记录`);
          commit("PUSH_TIP", `写入${capitalCaseName}.dbc`);
          ipcRenderer.send(`WRITE_${constantCaseName}_DBC`);
          ipcRenderer.once(`WRITE_${constantCaseName}_DBC`, (event) => {
            commit("PUSH_TIP", `写入${capitalCaseName}.dbc成功`);
            resolve();
          });
          ipcRenderer.once(
            `WRITE_${constantCaseName}_DBC_REJECT`,
            (event, error) => {
              commit("PUSH_TIP", `写入${capitalCaseName}.dbc失败`);
              commit("PUSH_TIP", error);
              reject(error);
            }
          );
        });
        ipcRenderer.once(
          `SEARCH_${constantCaseName}_DBC_REJECT`,
          (event, error) => {
            commit("PUSH_TIP", `准备${capitalCaseName}数据失败`);
            commit("PUSH_TIP", error);
            reject(error);
          }
        );
      });
    },
    pushTip({ commit }, tip) {
      commit("PUSH_TIP", tip);
    },
    resetTips({ commit }) {
      commit("RESET_TIPS");
    },
  },
  mutations: {
    [UPDATE_CHECKED_DBCS](state, checkedDbcs) {
      state.checkedDbcs = checkedDbcs;
    },
    PUSH_TIP(state, tip) {
      state.tips.push(tip);
    },
    RESET_TIPS(state) {
      let length = state.tips.length;
      state.tips.splice(0, length);
    },
  },
};
