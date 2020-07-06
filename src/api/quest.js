import axios from "axios";

axios.defaults.baseURL = "http://localhost:8080";

const searchQuestTemplates = (payload = null) => {
  let query = "";
  if (payload.ID !== undefined) {
    query = `${query}&ID=${payload.ID}`;
  }
  if (payload.LogTitle !== undefined) {
    query = `${query}&LogTitle=${payload.LogTitle}`;
  }
  if (payload.page !== undefined) {
    query = `${query}&page=${payload.page}`;
  }
  if (query !== "") {
    query = `?${query.substr(1)}`;
  }
  return axios.get(`/quest-template${query}`);
};

const countQuestTemplates = (payload = null) => {
  let query = "";
  if (payload.ID !== undefined) {
    query = `${query}&ID=${payload.ID}`;
  }
  if (payload.LogTitle !== undefined) {
    query = `${query}&LogTitle=${payload.LogTitle}`;
  }
  if (query !== undefined) {
    query = `?${query.substr(1)}`;
  }
  return axios.get(`/quest-template/quantity${query}`);
};

const storeQuestTemplate = (payload) => {
  return axios.post("/quest-template", payload);
};

const showQuestTemplate = (id) => {
  return axios.get(`/quest-template/${id}`);
};

const updateQuestTemplate = (id, payload) => {
  return axios.put(`/quest-template/${id}`, payload);
};

const destroyQuestTemplate = (id) => {
  return axios.delete(`/quest-template/${id}`);
};

export default {
  questTemplate: {
    search: searchQuestTemplates,
    count: countQuestTemplates,
    store: storeQuestTemplate,
    show: showQuestTemplate,
    update: updateQuestTemplate,
    destroy: destroyQuestTemplate,
  },
};
