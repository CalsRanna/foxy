<template>
  <div class="loading-background">
    <div class="loading-text" v-if="this.class !== ''">{{ text }}</div>
    <el-input></el-input>
  </div>
</template>

<style>
.loading-background {
  -webkit-app-region: drag;
  width: 400px;
  height: 300px;
  background: url(/images/wlk.jpg) no-repeat 0 0;
  background-size: 100% 100%;
}

.loading-text {
  color: #ffffff;
  padding: 252px 16px 16px 16px;
  text-align: center;
  font-size: 16px;
  height: 32px;
  line-height: 32px;
}
</style>

<script>
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  data() {
    return {
      class: "loading-background",
      text: "环境检测中……",
    };
  },
  methods: {
    async initSetting() {
      await ipcRenderer.send("OPEN_SETTING_VIEW");
    },
    async loadIcons() {
      this.text = "加载图标……";
      ipcRenderer.on("LOAD_ICONS_REPLY", (event, args) => {
        this.text = `${args}个图标加载完成`;
      });
      await ipcRenderer.send("LOAD_ICONS");
    },
  },
  created() {
    let dbcPath = localStorage.getItem("dbcPath");
    let mpqPath = localStorage.getItem("mpqPath");
    if (dbcPath === null || mpqPath === null) {
      this.initSetting();
    } else {
      setTimeout(() => {
        this.loadIcons();
      }, 1000);
    }
  },
};
</script>
