import {
  UPDATE_CREATURE_TEMPLATE_CREDENTIAL_ENTRY,
  UPDATE_CREATURE_TEMPLATE_CREDENTIAL_NAME,
  UPDATE_CREATURE_TEMPLATE_CREDENTIAL_SUBNAME,
  SEARCH_CREATURE_TEMPLATES,
  COUNT_CREATURE_TEMPLATES,
  PAGINATE_CREATURE_TEMPLATES,
  FIND_CREATURE_TEMPLATE,
  SEARCH_CREATURE_TEMPLATE_LOCALES,
  FIND_CREATURE_TEMPLATE_ADDON,
  FIND_CREATURE_ONKILL_REPUTATION,
  SEARCH_CREATURE_EQUIP_TEMPLATES,
  SEARCH_NPC_VENDORS,
  SEARCH_NPC_TRAINERS
} from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state: () => ({
    entry: undefined,
    name: undefined,
    subname: undefined,
    page: 1,
    total: 0,
    size: 50,
    creatureTemplates: [],
    creatureTemplate: {},
    creatureTemplateLocales: [],
    creatureTemplateAddon: {},
    creatureOnKillReputation: {},
    creatureEquipTemplates: [],
    npcVendors: [],
    npcTrainers: []
  }),
  actions: {
    searchCreatureTemplates({ commit }, payload) {
      ipcRenderer.on("SEARCH_CREATURE_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_CREATURE_TEMPLATES, response);
      });
      ipcRenderer.send("SEARCH_CREATURE_TEMPLATES", payload);
    },
    countCreatureTemplates({ commit }, payload) {
      ipcRenderer.on("COUNT_CREATURE_TEMPLATES_REPLY", (event, response) => {
        commit(COUNT_CREATURE_TEMPLATES, response);
      });
      ipcRenderer.send("COUNT_CREATURE_TEMPLATES", payload);
    },
    findCreatureTemplate({ commit }, payload) {
      ipcRenderer.on("FIND_CREATURE_TEMPLATE_REPLY", (event, response) => {
        commit(FIND_CREATURE_TEMPLATE, response);
      });
      ipcRenderer.send("FIND_CREATURE_TEMPLATE", payload);
    },
    destroyCreatureTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.on("DESTROY_CREATURE_TEMPLATE_REPLY", (event, response) => {
          resolve(response);
        });
        ipcRenderer.send("DESTROY_CREATURE_TEMPLATE", payload);
      });
    },
    copyCreatureTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.on("COPY_CREATURE_TEMPLATE_REPLY", (event, response) => {
          resolve(response);
        });
        ipcRenderer.send("COPY_CREATURE_TEMPLATE", payload);
      });
    },
    searchCreatureTemplateLocales({ commit }, payload) {
      ipcRenderer.on("SEARCH_CREATURE_TEMPLATE_LOCALES_REPLY", (event, response) => {
        commit(SEARCH_CREATURE_TEMPLATE_LOCALES, response);
      });
      ipcRenderer.send("SEARCH_CREATURE_TEMPLATE_LOCALES", payload);
    },
    findCreatureTemplateAddon({ commit }, payload) {
      ipcRenderer.on("FIND_CREATURE_TEMPLATE_ADDON_REPLY", (event, response) => {
        commit(FIND_CREATURE_TEMPLATE_ADDON, response);
      });
      ipcRenderer.send("FIND_CREATURE_TEMPLATE_ADDON", payload);
    },
    findCreatureOnKillReputation({ commit }, payload) {
      ipcRenderer.on("FIND_CREATURE_ONKILL_REPUTATION_REPLY", (event, response) => {
        commit(FIND_CREATURE_ONKILL_REPUTATION, response);
      });
      ipcRenderer.send("FIND_CREATURE_ONKILL_REPUTATION", payload);
    },
    searchCreatureEquipTemplates({ commit }, payload) {
      ipcRenderer.on("SEARCH_CREATURE_EQUIP_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_CREATURE_EQUIP_TEMPLATES, response);
      });
      ipcRenderer.send("SEARCH_CREATURE_EQUIP_TEMPLATES", payload);
    },
    searchNpcVendors({ commit }, payload) {
      ipcRenderer.on("SEARCH_NPC_VENDORS_REPLY", (event, response) => {
        commit(SEARCH_NPC_VENDORS, response);
      });
      ipcRenderer.send("SEARCH_NPC_VENDORS", payload);
    },
    searchNpcTrainers({ commit }, payload) {
      ipcRenderer.on("SEARCH_NPC_TRAINERS_REPLY", (event, response) => {
        commit(SEARCH_NPC_TRAINERS, response);
      });
      ipcRenderer.send("SEARCH_NPC_TRAINERS", payload);
    }
  },
  mutations: {
    [UPDATE_CREATURE_TEMPLATE_CREDENTIAL_ENTRY](state, entry) {
      state.entry = entry;
    },
    [UPDATE_CREATURE_TEMPLATE_CREDENTIAL_NAME](state, name) {
      state.name = name;
    },
    [UPDATE_CREATURE_TEMPLATE_CREDENTIAL_SUBNAME](state, subname) {
      state.subname = subname;
    },
    [SEARCH_CREATURE_TEMPLATES](state, creatureTemplates) {
      state.creatureTemplates = creatureTemplates;
    },
    [COUNT_CREATURE_TEMPLATES](state, total) {
      state.total = total;
    },
    [PAGINATE_CREATURE_TEMPLATES](state, page) {
      state.page = page;
    },
    [FIND_CREATURE_TEMPLATE](state, creatureTemplate) {
      state.creatureTemplate = creatureTemplate;
    },
    [SEARCH_CREATURE_TEMPLATE_LOCALES](state, creatureTemplateLocales) {
      state.creatureTemplateLocales = creatureTemplateLocales;
    },
    [FIND_CREATURE_TEMPLATE_ADDON](state, creatureTemplateAddon) {
      state.creatureTemplateAddon = creatureTemplateAddon;
    },
    [FIND_CREATURE_ONKILL_REPUTATION](state, creatureOnKillReputation) {
      state.creatureOnKillReputation = creatureOnKillReputation;
    },
    [SEARCH_CREATURE_EQUIP_TEMPLATES](state, creatureEquipTemplates) {
      state.creatureEquipTemplates = creatureEquipTemplates;
    },
    [SEARCH_NPC_VENDORS](state, npcVendors) {
      state.npcVendors = npcVendors;
    },
    [SEARCH_NPC_TRAINERS](state, npcTrainers) {
      state.npcTrainers = npcTrainers;
    }
  }
};
