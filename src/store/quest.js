import {
  COPY_QUEST_TEMPLATE,
  COUNT_QUEST_TEMPLATES,
  CREATE_QUEST_TEMPLATE,
  DESTROY_QUEST_TEMPLATE,
  FIND_QUEST_TEMPLATE,
  PAGINATE_QUEST_TEMPLATES,
  SEARCH_QUEST_TEMPLATES,
  STORE_QUEST_TEMPLATE,
  UPDATE_QUEST_TEMPLATE
} from "./../constants";

const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state() {
    return {
      total: 0,
      page: 1,
      questTemplates: [],
      questTemplate: {},
      questTemplateAddon: {},
      questOfferReward: {},
      questRequestItems: {},
      creatureQuestStarters: [],
      creatureQuestEnders: [],
      gameObjectQuestStarters: [],
      gameObjectQuestEnders: []
    };
  },
  actions: {
    searchQuestTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_QUEST_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_QUEST_TEMPLATES, (event, response) => {
          commit(SEARCH_QUEST_TEMPLATES, response);
          resolve();
        });
      });
    },
    countQuestTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COUNT_QUEST_TEMPLATES, payload);
        ipcRenderer.on(COUNT_QUEST_TEMPLATES, (event, response) => {
          commit(COUNT_QUEST_TEMPLATES, response);
          resolve();
        });
      });
    },
    paginateQuestTemplates({ commit }, payload) {
      return new Promise(resolve => {
        commit(PAGINATE_QUEST_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeQuestTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_QUEST_TEMPLATE, payload);
        ipcRenderer.on(STORE_QUEST_TEMPLATE, (event, response) => {
          commit(STORE_QUEST_TEMPLATE, response);
          resolve();
        });
      });
    },
    findQuestTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_QUEST_TEMPLATE, payload);
        ipcRenderer.on(FIND_QUEST_TEMPLATE, (event, response) => {
          commit(FIND_QUEST_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateQuestTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_QUEST_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_QUEST_TEMPLATE, (event, response) => {
          commit(UPDATE_QUEST_TEMPLATE, response);
          resolve();
        });
      });
    },
    destroyQuestTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_QUEST_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_QUEST_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createQuestTempalte({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(CREATE_QUEST_TEMPLATE, payload);
        ipcRenderer.on(CREATE_QUEST_TEMPLATE, (event, response) => {
          commit(CREATE_QUEST_TEMPLATE, response);
          resolve();
        });
      });
    },
    copyQuestTempalte(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_QUEST_TEMPLATE, payload);
        ipcRenderer.on(COPY_QUEST_TEMPLATE, () => {
          resolve();
        });
      });
    }
  },
  mutations: {
    [SEARCH_QUEST_TEMPLATES](state, questTemplates) {
      state.questTemplates = questTemplates;
    },
    [COUNT_QUEST_TEMPLATES](state, total) {
      state.total = total;
    },
    [PAGINATE_QUEST_TEMPLATES](state, page) {
      state.page = page;
    },
    [STORE_QUEST_TEMPLATE](state, questTemplate) {
      state.questTemplate = questTemplate;
    },
    [FIND_QUEST_TEMPLATE](state, questTemplate) {
      state.questTemplate = questTemplate;
    },
    [UPDATE_QUEST_TEMPLATE](state, questTemplate) {
      state.questTemplate = questTemplate;
    },
    [CREATE_QUEST_TEMPLATE](state, questTemplate) {
      state.questTemplate = questTemplate;
    }
  }
};
