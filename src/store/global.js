import {
  UPDATE_MYSQL_CONFIG,
  UPDATE_DBC_CONFIG,
  UPDATE_DEVELOPER_CONFIG,
  UPDATE_MESSAGE,
  SET_ACTIVE
} from "./MUTATION_TYPES";

const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state: () => ({
    debug: true,
    active: "dashboard",
    isAuth: false,
    mysqlConfig: {
      host: "127.0.0.1",
      port: 3306,
      username: "acore",
      password: "acore",
      database: "acore_world",
      limit: 10
    },
    dbcConfig: {
      path: ""
    },
    developerConfig: {
      debug: false
    },
    message: {
      count: 0,
      type: undefined,
      title: undefined,
      content: undefined
    }
  }),
  mutations: {
    [UPDATE_MYSQL_CONFIG](state, config) {
      this.mysqlConfig = config;

      localStorage.setItem("host", config.host);
      localStorage.setItem("port", config.port);
      localStorage.setItem("username", config.username);
      localStorage.setItem("password", config.password);
      localStorage.setItem("database", config.database);
      localStorage.setItem("limit", config.limit);

      ipcRenderer.send("INIT_DATABASE_POOL", config);
    },
    [UPDATE_DBC_CONFIG](state, config) {
      this.dbcConfig = config;

      localStorage.setItem("dbcPath", config.path);
    },
    [UPDATE_DEVELOPER_CONFIG](state, config) {
      this.developerConfig = config;

      localStorage.setItem("debug", config.debug);
    },
    [UPDATE_MESSAGE](state, message) {
      state.message = {
        count: this.message.count + 1,
        type: message.type,
        title: message.title,
        content: message.contet
      };
    },
    [SET_ACTIVE](state, active) {
      state.active = active;
    }
  }
};
