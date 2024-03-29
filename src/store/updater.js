const ipcRenderer = window.ipcRenderer;

import axios from "axios";
import { CHECK_VERSION } from "@/constants";

const GITHUB_RELEASE_URL =
  "https://service-8hb18act-1257886063.cd.apigw.tencentcs.com/release/APIService-GetGithubUrl";
const NET_DISK_URL =
  "https://service-10eupx2f-1257886063.cd.apigw.tencentcs.com/release/APIService-GetNetDiskUrl";

export default {
  namespaced: true,
  state: () => ({
    version: {},
  }),
  actions: {
    checkVersion({ commit }) {
      return new Promise((resolve, reject) => {
        let version = "";
        let githubUrl = "";
        let netDiskUrl = "";
        let code = "";
        Promise.all([
          axios.get(GITHUB_RELEASE_URL).then((response) => {
            version = response.data.version;
            githubUrl = response.data.githubUrl;
          }),

          axios.get(NET_DISK_URL).then((response) => {
            netDiskUrl = response.data.url;
            code = response.data.code;
          }),
        ])
          .then(() => {
            commit(CHECK_VERSION, {
              version: version,
              githubUrl: githubUrl,
              netDiskUrl: netDiskUrl,
              code: code,
            });
            resolve();
          })
          .catch(() => {
            reject();
          });
      });
    },
  },
  mutations: {
    [CHECK_VERSION](state, version) {
      state.version = version;
    },
  },
};
