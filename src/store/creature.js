import {
  SEARCH_CREATURE_TEMPLATES,
  COUNT_CREATURE_TEMPLATES,
  PAGINATE_CREATURE_TEMPLATES,
} from "./MUTATION_TYPES";
import api from "@/api";

const creatureTemplate = {
  namespaced: true,
  state: () => ({
    entry: undefined,
    name: undefined,
    subname: undefined,
    page: 1,
    total: 0,
    creatureTemplates: [],
  }),
  actions: {
    async search({ commit }, payload) {
      let response = await api.creature.creatureTemplate.search(payload);
      commit(SEARCH_CREATURE_TEMPLATES, response.data);
    },
    async count({ commit }, payload) {
      let response = await api.creature.creatureTemplate.count(payload);
      commit(COUNT_CREATURE_TEMPLATES, response.data);
    },
  },
  mutations: {
    [SEARCH_CREATURE_TEMPLATES](state, creatureTemplates) {
      state.creatureTemplates = creatureTemplates;
    },
    [COUNT_CREATURE_TEMPLATES](state, total) {
      state.total = total;
    },
    [PAGINATE_CREATURE_TEMPLATES](state, page) {
      state.page = page;
    },
  },
};

export default creatureTemplate;
