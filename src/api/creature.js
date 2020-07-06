import axios from "axios";

axios.defaults.baseURL = "http://localhost:8080";

const searchCreatureTemplates = (payload = null) => {
  let query = "";
  if (payload.entry !== undefined) {
    query = `${query}&entry=${payload.entry}`;
  }
  if (payload.name !== "") {
    query = `${query}&name=${payload.name}`;
  }
  if (payload.subname !== "") {
    query = `${query}&subname=${payload.subname}`;
  }
  if (payload.page !== "") {
    query = `${query}&page=${payload.page}`;
  }
  if (query !== "") {
    query = `?${query.substr(1)}`;
  }
  return axios.get(`/creature-template${query}`);
};

const countCreatureTemplates = (payload = null) => {
  let query = "";
  if (payload.entry !== undefined) {
    query = `${query}&entry=${payload.entry}`;
  }
  if (payload.name !== "") {
    query = `${query}&name=${payload.name}`;
  }
  if (payload.subname !== "") {
    query = `${query}&subname=${payload.subname}`;
  }
  if (query !== "") {
    query = `?${query.substr(1)}`;
  }
  return axios.get(`/creature-template/quantity${query}`);
};

const storeCreatureTemplate = (payload) => {
  return axios.post("/creature-template", payload);
};

const showCreatureTemplate = (id) => {
  return axios.get(`/creature-template/${id}`);
};

const updateCreatureTemplate = (id, payload) => {
  return axios.put(`/creature-template/${id}`, payload);
};

const destroyCreatureTemplate = (id) => {
  return axios.delete(`/creature-template/${id}`);
};

export default {
  creatureTemplate: {
    search: searchCreatureTemplates,
    count: countCreatureTemplates,
    store: storeCreatureTemplate,
    show: showCreatureTemplate,
    update: updateCreatureTemplate,
    destroy: destroyCreatureTemplate,
  },
};
