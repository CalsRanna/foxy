import axios from "axios";

axios.defaults.baseURL = "http://localhost:8080";

const searchItemTemplates = (payload = null) => {
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
  if (payload.class !== undefined) {
    query = `${query}&class=${payload.class}`;
  }
  if (payload.subclass !== undefined) {
    query = `${query}&subclass=${payload.subclass}`;
  }
  if (payload.inventoryType !== undefined) {
    query = `${query}&inventoryType=${payload.inventoryType}`;
  }
  if (query !== "") {
    query = `?${query.substr(1)}`;
  }
  return axios.get(`/item-template${query}`);
};

const countItemTemplates = (payload, filter) => {
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
  if (filter.class !== undefined) {
    query = `${query}&class=${filter.class}`;
  }
  if (filter.subclass !== undefined) {
    query = `${query}&subclass=${filter.subclass}`;
  }
  if (filter.inventoryType !== undefined) {
    query = `${query}&inventoryType=${filter.inventoryType}`;
  }
  if (query !== "") {
    query = `?${query.substr(1)}`;
  }
  return axios.get(`/item-template/quantity${query}`);
};

const storeItemTemplate = (payload) => {
  return axios.post("/item-template", payload);
};

const showItemTemplate = (id) => {
  return axios.get(`/item-template/${id}`);
};

const updateItemTemplate = (id, payload) => {
  return axios.put(`/item-template/${id}`, payload);
};

const destroyItemTemplate = (id) => {
  return axios.delete(`/item-template/${id}`);
};

export default {
  itemTemplate: {
    search: searchItemTemplates,
    count: countItemTemplates,
    store: storeItemTemplate,
    show: showItemTemplate,
    update: updateItemTemplate,
    destroy: destroyItemTemplate,
  },
};
