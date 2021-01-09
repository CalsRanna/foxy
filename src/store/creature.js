const ipcRenderer = window.require("electron").ipcRenderer;

import {
  COPY_CREATURE_TEMPLATE,
  COUNT_CREATURE_TEMPLATES,
  CREATE_CREATURE_TEMPLATE,
  DESTROY_CREATURE_TEMPLATE,
  FIND_CREATURE_ONKILL_REPUTATION,
  FIND_CREATURE_TEMPLATE,
  FIND_CREATURE_TEMPLATE_ADDON,
  PAGINATE_CREATURE_TEMPLATES,
  SEARCH_CREATURE_EQUIP_TEMPLATES,
  SEARCH_CREATURE_LOOT_TEMPLATES,
  SEARCH_CREATURE_QUEST_ITEMS,
  SEARCH_CREATURE_REFERENCE_LOOT_TEMPLATES,
  SEARCH_CREATURE_TEMPLATES,
  SEARCH_CREATURE_TEMPLATE_LOCALES,
  SEARCH_NPC_TRAINERS,
  SEARCH_NPC_VENDORS,
  SEARCH_PICKPOCKETING_LOOT_TEMPLATES,
  SEARCH_SKINNING_LOOT_TEMPLATES,
  STORE_CREATURE_ONKILL_REPUTATION,
  STORE_CREATURE_TEMPLATE,
  STORE_CREATURE_TEMPLATE_ADDON,
  STORE_CREATURE_TEMPLATE_LOCALES,
  UPDATE_CREATURE_ONKILL_REPUTATION,
  UPDATE_CREATURE_TEMPLATE,
  UPDATE_CREATURE_TEMPLATE_ADDON,
  UPDATE_CREATURE_TEMPLATE_CREDENTIAL_ENTRY,
  UPDATE_CREATURE_TEMPLATE_CREDENTIAL_NAME,
  UPDATE_CREATURE_TEMPLATE_CREDENTIAL_SUBNAME
} from "../constants";

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
    creatureEquipTemplate: {},
    npcVendors: [],
    npcTrainers: [],
    creatureQuestItems: [],
    creatureLootTemplates: [],
    creatureReferenceLootTemplates: [],
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
        ipcRenderer.send(COUNT_CREATURE_TEMPLATES, payload);
        ipcRenderer.on(COUNT_CREATURE_TEMPLATES, (event, response) => {
          commit(COUNT_CREATURE_TEMPLATES, response);
          resolve();
        });
      });
    },
    paginateCreatureTemplates({ commit }, payload) {
      return new Promise(resolve => {
        commit(PAGINATE_CREATURE_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeCreatureTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(STORE_CREATURE_TEMPLATE, () => {
          resolve();
        });
      });
    },
    findCreatureTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(FIND_CREATURE_TEMPLATE, (event, response) => {
          commit(FIND_CREATURE_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateCreatureTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_CREATURE_TEMPLATE, () => {
          commit(UPDATE_CREATURE_TEMPLATE, payload);
          resolve();
        });
      });
    },
    destroyCreatureTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_CREATURE_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createCreatureTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(CREATE_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(CREATE_CREATURE_TEMPLATE, (event, response) => {
          commit(CREATE_CREATURE_TEMPLATE, response);
          resolve();
        });
      });
    },
    copyCreatureTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_CREATURE_TEMPLATE, payload);
        ipcRenderer.on(COPY_CREATURE_TEMPLATE, () => {
          resolve();
        });
      });
    },
    searchCreatureTemplateLocales({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(SEARCH_CREATURE_TEMPLATE_LOCALES, (event, response) => {
          commit(SEARCH_CREATURE_TEMPLATE_LOCALES, response);
          resolve();
        });
      });
    },
    storeCreatureTemplateLocales(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(STORE_CREATURE_TEMPLATE_LOCALES, () => {
          resolve();
        });
      });
    },
    storeCreatureTemplateAddon(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE_ADDON, payload);
        ipcRenderer.on(STORE_CREATURE_TEMPLATE_ADDON, () => {
          resolve();
        });
      });
    },
    findCreatureTemplateAddon({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_CREATURE_TEMPLATE_ADDON, payload);
        ipcRenderer.on(FIND_CREATURE_TEMPLATE_ADDON, (event, response) => {
          commit(FIND_CREATURE_TEMPLATE_ADDON, response);
          resolve();
        });
      });
    },
    updateCreatureTemplateAddon(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_CREATURE_TEMPLATE_ADDON, payload);
        ipcRenderer.on(UPDATE_CREATURE_TEMPLATE_ADDON, () => {
          resolve();
        });
      });
    },
    storeCreatureOnKillReputation(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_ONKILL_REPUTATION, payload);
        ipcRenderer.on(STORE_CREATURE_ONKILL_REPUTATION, () => {
          resolve();
        });
      });
    },
    findCreatureOnKillReputation({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_CREATURE_ONKILL_REPUTATION, payload);
        ipcRenderer.on(FIND_CREATURE_ONKILL_REPUTATION, (event, response) => {
          commit(FIND_CREATURE_ONKILL_REPUTATION, response);
          resolve();
        });
      });
    },
    updateCreatureOnKillReputation(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_CREATURE_ONKILL_REPUTATION, payload);
        ipcRenderer.on(UPDATE_CREATURE_ONKILL_REPUTATION, () => {
          resolve();
        });
      });
    },
    searchCreatureEquipTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_EQUIP_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_CREATURE_EQUIP_TEMPLATES, (event, response) => {
          commit(SEARCH_CREATURE_EQUIP_TEMPLATES, response);
          resolve();
        });
      });
    },
    searchNpcVendors({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_NPC_VENDORS, payload);
        ipcRenderer.on(SEARCH_NPC_VENDORS, (event, response) => {
          commit(SEARCH_NPC_VENDORS, response);
          resolve();
        });
      });
    },
    searchNpcTrainers({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_NPC_TRAINERS, payload);
        ipcRenderer.on(SEARCH_NPC_TRAINERS, (event, response) => {
          commit(SEARCH_NPC_TRAINERS, response);
          resolve();
        });
      });
    },
    searchCreatureQuestItems({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_QUEST_ITEMS, payload);
        ipcRenderer.on(SEARCH_CREATURE_QUEST_ITEMS, (event, response) => {
          commit(SEARCH_CREATURE_QUEST_ITEMS, response);
          resolve();
        });
      });
    },
    searchCreatureLootTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_CREATURE_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_CREATURE_LOOT_TEMPLATES, response);
          resolve();
        });
      });
    },
    searchCreatureReferenceLootTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_REFERENCE_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_CREATURE_REFERENCE_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_CREATURE_REFERENCE_LOOT_TEMPLATES, response);
          resolve();
        });
      });
    },
    searchPickpocketingLootTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, response);
          resolve();
        });
      });
    },
    searchSkinningLootTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_SKINNING_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_SKINNING_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_SKINNING_LOOT_TEMPLATES, response);
          resolve();
        });
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
      state.creatureTemplate = creatureTemplate;
    },
    [UPDATE_CREATURE_TEMPLATE](state, creatureTemplate) {
      state.creatureTemplate = creatureTemplate;
    },
    [CREATE_CREATURE_TEMPLATE](state, creatureTemplate) {
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
    },
    [SEARCH_CREATURE_QUEST_ITEMS](state, creatureQuestItems) {
      state.creatureQuestItems = creatureQuestItems;
    },
    [SEARCH_CREATURE_LOOT_TEMPLATES](state, creatureLootTemplates) {
      state.creatureLootTemplates = creatureLootTemplates;
    },
    [SEARCH_CREATURE_REFERENCE_LOOT_TEMPLATES](state, creatureReferenceLootTemplates) {
      state.creatureReferenceLootTemplates = creatureReferenceLootTemplates;
    },
    [SEARCH_PICKPOCKETING_LOOT_TEMPLATES](state, pickpocketingLootTemplates) {
      state.pickpocketingLootTemplates = pickpocketingLootTemplates;
    },
    [SEARCH_SKINNING_LOOT_TEMPLATES](state, skinningLootTemplates) {
      state.skinningLootTemplates = skinningLootTemplates;
    }
  }
};
