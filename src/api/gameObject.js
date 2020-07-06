import axios from "axios";

axios.defaults.baseURL = "http://localhost:8080";

const searchGameObjectTemplates = (payload = null) => {
  let query = "";
  if (payload.entry !== undefined) {
    query = `${query}&entry=${payload.entry}`;
  }
  if (payload.name !== undefined) {
    query = `${query}&name=${payload.name}`;
  }
  if (payload.page !== undefined) {
    query = `${query}&page=${payload.page}`;
  }
  if (query !== "") {
    query = `?${query.substr(1)}`;
  }
  return axios.get(`/game-object-template${query}`);
};

const countGameObjectTemplates = (payload = null) => {
  let query = "";
  if (payload.entry !== undefined) {
    query = `${query}&entry=${payload.entry}`;
  }
  if (payload.name !== undefined) {
    query = `${query}&name=${payload.name}`;
  }
  if (query !== undefined) {
    query = `?${query.substr(1)}`;
  }
  return axios.get(`/game-object-template/quantity${query}`);
};

const storeGameObjectTemplate = (payload) => {
  return axios.post("/game-object-template", payload);
};

const showGameObjectTemplate = (id) => {
  return axios.get(`/game-object-template/${id}`);
};

const updateGameObjectTemplate = (id, payload) => {
  return axios.put(`/game-object-template/${id}`, payload);
};

const destroyGameObjectTemplate = (id) => {
  return axios.delete(`/game-object-template/${id}`);
};

export default {
  gameObjectTemplate: {
    search: searchGameObjectTemplates,
    count: countGameObjectTemplates,
    store: storeGameObjectTemplate,
    show: showGameObjectTemplate,
    update: updateGameObjectTemplate,
    destroy: destroyGameObjectTemplate,
  },
};
