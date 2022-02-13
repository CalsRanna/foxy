const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR,
  COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR,
  PAGINATE_AREA_TABLES_FOR_ATOQS_SELECTOR,
  SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR,
  COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR,
  PAGINATE_QUEST_SORTS_FOR_ATOQS_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    paginationOfAreaTable: {
      total: 0,
      page: 1,
      size: 50,
    },
    paginationOfQuestSort: {
      total: 0,
      page: 1,
      size: 50,
    },
    areaTables: [],
    questSorts: [],
  }),
  actions: {
    searchAreaTablesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR, payload);
        ipcRenderer.once(
          SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR,
          (event, response) => {
            commit(SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countAreaTablesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR, payload);
        ipcRenderer.once(
          COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR,
          (event, response) => {
            commit(COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateAreaTablesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_AREA_TABLES_FOR_ATOQS_SELECTOR, payload.page);
        resolve();
      });
    },
    searchQuestSortsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR, payload);
        ipcRenderer.once(
          SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR,
          (event, response) => {
            commit(SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countQuestSortsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR, payload);
        ipcRenderer.once(
          COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR,
          (event, response) => {
            commit(COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateQuestSortsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_QUEST_SORTS_FOR_ATOQS_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR](state, areaTables) {
      state.areaTables = areaTables;
    },
    [COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR](state, total) {
      state.paginationOfAreaTable.total = total;
    },
    [PAGINATE_AREA_TABLES_FOR_ATOQS_SELECTOR](state, page) {
      state.paginationOfAreaTable.page = page;
    },
    [SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR](state, questSorts) {
      state.questSorts = questSorts;
    },
    [COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR](state, total) {
      state.paginationOfQuestSort.total = total;
    },
    [PAGINATE_QUEST_SORTS_FOR_ATOQS_SELECTOR](state, page) {
      state.paginationOfQuestSort.page = page;
    },
  },
};
