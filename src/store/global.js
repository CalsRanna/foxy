import {
  UPDATE_MYSQL_CONFIG,
  UPDATE_DBC_CONFIG,
  UPDATE_CONFIG_CONFIG,
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
      host: "",
      port: "",
      username: "",
      password: "",
      database: "",
      limit: 10
    },
    dbcConfig: {
      path: ""
    },
    configConfig: {
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
  actions: {
    testMysqlConfig(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send("INIT_DATABASE_POOL", payload);
        ipcRenderer.on("INIT_DATABASE_POOL", (event, response) => {
          resolve(response);
        });
      });
    }
  },
  mutations: {
    [UPDATE_MYSQL_CONFIG](state, config) {
      state.mysqlConfig = config;

      localStorage.setItem("host", config.host);
      localStorage.setItem("port", config.port);
      localStorage.setItem("username", config.username);
      localStorage.setItem("password", config.password);
      localStorage.setItem("database", config.database);
      localStorage.setItem("limit", config.limit);

      ipcRenderer.send("INIT_DATABASE_POOL", config);
    },
    [UPDATE_DBC_CONFIG](state, config) {
      state.dbcConfig = config;

      localStorage.setItem("dbcPath", config.path);

      ipcRenderer.send("INIT_DBC_CONFIG", config);
    },
    [UPDATE_CONFIG_CONFIG](state, config) {
      state.configConfig = config;

      localStorage.setItem("configPath", config.path);
    },
    [UPDATE_DEVELOPER_CONFIG](state, config) {
      state.developerConfig = config;

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
