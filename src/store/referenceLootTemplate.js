const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_REFERENCE_LOOT_TEMPLATES,
  COUNT_REFERENCE_LOOT_TEMPLATES,
  PAGINATE_REFERENCE_LOOT_TEMPLATES,
  STORE_REFERENCE_LOOT_TEMPLATE,
  FIND_REFERENCE_LOOT_TEMPLATE,
  UPDATE_REFERENCE_LOOT_TEMPLATE,
  DESTROY_REFERENCE_LOOT_TEMPLATE,
  CREATE_REFERENCE_LOOT_TEMPLATE,
  COPY_REFERENCE_LOOT_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    refresh: true,
    credential: {
      Entry: undefined,
      name: undefined,
    },
    pagination: {
      page: 1,
      size: 50,
      total: 0,
    },
    referenceLootTemplates: [],
    referenceLootTemplate: {},
  }),
  actions: {
    searchReferenceLootTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_REFERENCE_LOOT_TEMPLATES, payload);
        ipcRenderer.once(SEARCH_REFERENCE_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_REFERENCE_LOOT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_REFERENCE_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countReferenceLootTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_REFERENCE_LOOT_TEMPLATES, payload);
        ipcRenderer.once(COUNT_REFERENCE_LOOT_TEMPLATES, (event, response) => {
          commit(COUNT_REFERENCE_LOOT_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_REFERENCE_LOOT_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateReferenceLootTemplates({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_REFERENCE_LOOT_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeReferenceLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.once(STORE_REFERENCE_LOOT_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_REFERENCE_LOOT_TEMPLATE", true);
          resolve();
        });
        ipcRenderer.once(
          `${STORE_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findReferenceLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.once(FIND_REFERENCE_LOOT_TEMPLATE, (event, response) => {
          commit(FIND_REFERENCE_LOOT_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateReferenceLootTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_REFERENCE_LOOT_TEMPLATE, () => {
          commit("UPDATE_REFRESH_OF_REFERENCE_LOOT_TEMPLATE", true);
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyReferenceLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_REFERENCE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createReferenceLootTemplate({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_REFERENCE_LOOT_TEMPLATE, payload);
        resolve();
      });
    },
    copyReferenceLootTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_REFERENCE_LOOT_TEMPLATE, payload);
        ipcRenderer.once(COPY_REFERENCE_LOOT_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_REFERENCE_LOOT_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_REFERENCE_LOOT_TEMPLATE");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_REFERENCE_LOOT_TEMPLATES](state, referenceLootTemplates) {
      state.referenceLootTemplates = referenceLootTemplates;
      state.refresh = false;
    },
    [COUNT_REFERENCE_LOOT_TEMPLATES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_REFERENCE_LOOT_TEMPLATES](state, page) {
      state.pagination.page = page;
    },
    [FIND_REFERENCE_LOOT_TEMPLATE](state, referenceLootTemplate) {
      state.referenceLootTemplate = referenceLootTemplate;
    },
    [CREATE_REFERENCE_LOOT_TEMPLATE](state, referenceLootTemplate) {
      state.referenceLootTemplate = referenceLootTemplate;
    },
    UPDATE_REFRESH_OF_REFERENCE_LOOT_TEMPLATE(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_REFERENCE_LOOT_TEMPLATE(state) {
      state.credential = {
        Entry: undefined,
        name: undefined,
      };
    },
  },
};
