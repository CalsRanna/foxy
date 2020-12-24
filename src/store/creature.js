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
  SEARCH_NPC_TRAINERS,
  SEARCH_CREATURE_QUEST_ITEMS,
  SEARCH_CREATURE_LOOT_TEMPLATES,
  SEARCH_PICKPOCKETING_LOOT_TEMPLATES,
  SEARCH_SKINNING_LOOT_TEMPLATES,
  UPDATE_CREATURE_TEMPLATE,
  GET_MAX_ENTRY_OF_CREATURE_TEMPLATE
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
    npcTrainers: [],
    creatureQuestItems: [],
    creatureLootTemplates: [],
    pickpocketingLootTemplates: [],
    skinningLootTemplates: []
  }),
  actions: {
    searchCreatureTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_CREATURE_TEMPLATES, (event, response) => {
          commit(SEARCH_CREATURE_TEMPLATES, response);
          resolve();
        });
      });
    },
    countCreatureTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COUNT_ITEM_TEMPLATES, payload);
        ipcRenderer.on(COUNT_ITEM_TEMPLATES, (event, response) => {
          commit(COUNT_CREATURE_TEMPLATES, response);
          resolve();
        });
      });
    },
    getMaxEntryOfCreatureTemplate() {
      return new Promise(resolve => {
        ipcRenderer.send(GET_MAX_ENTRY_OF_CREATURE_TEMPLATE);
        ipcRenderer.on(GET_MAX_ENTRY_OF_CREATURE_TEMPLATE, (event, response) => {
          resolve(response);
        });
      });
    },
    storeCreatureTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("STORE_CREATURE_TEMPLATE", payload);
        ipcRenderer.on("STORE_CREATURE_TEMPLATE_REPLY", () => {
          resolve();
        });
      });
    },
    findCreatureTemplate({ commit }, payload) {
      ipcRenderer.send("FIND_CREATURE_TEMPLATE", payload);
      ipcRenderer.on("FIND_CREATURE_TEMPLATE_REPLY", (event, response) => {
        commit(FIND_CREATURE_TEMPLATE, response);
      });
    },
    updateCreatureTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("UPDATE_CREATURE_TEMPLATE", payload);
        ipcRenderer.on("UPDATE_CREATURE_TEMPLATE", () => {
          commit(UPDATE_CREATURE_TEMPLATE, payload);
          resolve();
        });
      });
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
      ipcRenderer.send("SEARCH_CREATURE_TEMPLATE_LOCALES", payload);
      ipcRenderer.on("SEARCH_CREATURE_TEMPLATE_LOCALES_REPLY", (event, response) => {
        commit(SEARCH_CREATURE_TEMPLATE_LOCALES, response);
      });
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
    },
    searchCreatureQuestItems({ commit }, payload) {
      ipcRenderer.send("SEARCH_CREATURE_QUEST_ITEMS", payload);
      ipcRenderer.on("SEARCH_CREATURE_QUEST_ITEMS_REPLY", (event, response) => {
        commit(SEARCH_CREATURE_QUEST_ITEMS, response);
      });
    },
    searchCreatureLootTemplates({ commit }, payload) {
      ipcRenderer.send("SEARCH_CREATURE_LOOT_TEMPLATES", payload);
      ipcRenderer.on("SEARCH_CREATURE_LOOT_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_CREATURE_LOOT_TEMPLATES, response);
      });
    },
    searchPickpocketingLootTemplates({ commit }, payload) {
      ipcRenderer.send("SEARCH_PICKPOCKETING_LOOT_TEMPLATES", payload);
      ipcRenderer.on("SEARCH_PICKPOCKETING_LOOT_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, response);
      });
    },
    searchSkinningLootTemplates({ commit }, payload) {
      ipcRenderer.send("SEARCH_SKINNING_LOOT_TEMPLATES", payload);
      ipcRenderer.on("SEARCH_SKINNING_LOOT_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_SKINNING_LOOT_TEMPLATES, response);
      });
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
      if (creatureTemplate === undefined) {
        creatureTemplate = {};
      }
      state.creatureTemplate = creatureTemplate;
    },
    [UPDATE_CREATURE_TEMPLATE](state, creatureTemplate) {
      state.creatureTemplate = creatureTemplate;
    },
    [SEARCH_CREATURE_TEMPLATE_LOCALES](state, creatureTemplateLocales) {
      state.creatureTemplateLocales = creatureTemplateLocales;
    },
    [FIND_CREATURE_TEMPLATE_ADDON](state, creatureTemplateAddon) {
      if (creatureTemplateAddon === undefined) {
        creatureTemplateAddon = {};
      }
      state.creatureTemplateAddon = creatureTemplateAddon;
    },
    [FIND_CREATURE_ONKILL_REPUTATION](state, creatureOnKillReputation) {
      if (creatureOnKillReputation === undefined) {
        creatureOnKillReputation = {};
      }
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
    },
    [SEARCH_CREATURE_QUEST_ITEMS](state, creatureQuestItems) {
      state.creatureQuestItems = creatureQuestItems;
    },
    [SEARCH_CREATURE_LOOT_TEMPLATES](state, creatureLootTemplates) {
      state.creatureLootTemplates = creatureLootTemplates;
    },
    [SEARCH_PICKPOCKETING_LOOT_TEMPLATES](state, pickpocketingLootTemplates) {
      state.pickpocketingLootTemplates = pickpocketingLootTemplates;
    },
    [SEARCH_SKINNING_LOOT_TEMPLATES](state, skinningLootTemplates) {
      state.skinningLootTemplates = skinningLootTemplates;
    }
  }
};
