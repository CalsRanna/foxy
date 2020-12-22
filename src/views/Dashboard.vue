<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>控制面板</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">控制面板</h3>
    </el-card>
    <el-alert title="欢迎使用 Foxy ，一款开发中的魔兽世界编辑器。" type="info" style="margin-top: 16px;"> </el-alert>
    <el-row :gutter="24" style="margin-top: 16px;" :loading="loading">
      <el-col :span="16">
        <el-row>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">生物模板<span>Creature Template</span></p>
              <p class="summary-content">
                {{ parseFloat(this.quantityOfCreatureTemplate).toLocaleString() }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">游戏对象模板<span>Game Object Template</span></p>
              <p class="summary-content">
                {{ parseFloat(this.quantityOfGameObjectTemplate).toLocaleString() }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">物品模板<span>Item Template</span></p>
              <p class="summary-content">
                {{ parseFloat(this.quantityOfItemTemplate).toLocaleString() }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">任务模板<span>Quest Template</span></p>
              <p class="summary-content">
                {{ parseFloat(this.quantityOfQuestTemplate).toLocaleString() }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">内建脚本<span>Smart Script</span></p>
              <p class="summary-content">
                {{ parseFloat(this.quantityOfSmartScript).toLocaleString() }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">技能<span>Spell</span></p>
              <p class="summary-content">
                {{ parseFloat(this.quantityOfSpell).toLocaleString() }}
              </p>
            </el-card>
          </el-col>
        </el-row>
      </el-col>
      <el-col :span="8">
        <el-card>
          <Chart :labels="labels" :data="data"></Chart>
        </el-card>
        <el-card style="margin-top:16px; font-size:14px;">
          <div slot="header">
            <span>Foxy</span>
          </div>
          <p style="text-indent:2em;">
            目前存在的编辑器都不是很能满足我对一个好用的编辑器的期望：简单，易用，美观，因此我提交了 Foxy
            这个开源项目。Foxy 计划中的功能很多，有且不仅有数据库的编辑，还有服务端 dbc
            文件的修改，服务端及第三方模块配置文件的修改等等，甚至自动对客户端追加补丁等功能都在尝试编码的路上了。
          </p>
          <p style="text-indent:2em;">
            闲余时间开发，进度随缘， Feature 也随缘， Bug 请到

            <span
              style="color: #409EFF; cursor: pointer"
              @click="() => openBrowser('https://github.com/CalsRanna/foxy/issues')"
            >
              Github
            </span>
            上面提交 issue 。
          </p>
          <p style="text-indent:2em;">
            如果你希望得到最新版本的 Foxy ，请访问
            <span
              style="color: #409EFF; cursor: pointer"
              @click="() => openBrowser('https://github.com/CalsRanna/foxy/release')"
            >
              下载页面
            </span>
            或者
            <span
              style="color: #409EFF; cursor: pointer"
              @click="() => openBrowser('https://github.com/CalsRanna/foxy')"
            >
              Clone
            </span>
            源码自行编译使用 。
          </p>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

import Chart from "@/components/Chart";

export default {
  data() {
    return {
      loading: false,
      labels: ["生物", "游戏对象", "物品", "任务", "内建脚本", "技能"]
    };
  },
  computed: {
    ...mapState("creature", { quantityOfCreatureTemplate: "total" }),
    ...mapState("gameObject", { quantityOfGameObjectTemplate: "total" }),
    ...mapState("item", { quantityOfItemTemplate: "total" }),
    ...mapState("quest", { quantityOfQuestTemplate: "total" }),
    ...mapState("spell", { quantityOfSpell: "total" }),
    ...mapState("smartScript", { quantityOfSmartScript: "total" }),
    data() {
      return [
        this.quantityOfCreatureTemplate,
        this.quantityOfGameObjectTemplate,
        this.quantityOfItemTemplate,
        this.quantityOfQuestTemplate,
        this.quantityOfSmartScript,
        this.quantityOfSpell
      ];
    }
  },
  methods: {
    ...mapActions("creature", ["countCreatureTemplates"]),
    ...mapActions("gameObject", { countGameObjectTemplates: "count" }),
    ...mapActions("item", { countItemTemplates: "count" }),
    ...mapActions("quest", { countQuestTemplates: "count" }),
    ...mapActions("spell", { countSpells: "count" }),
    ...mapActions("smartScript", { countSmartScript: "count" }),
    openBrowser(url) {
      const { shell } = window.require("electron");
      shell.openExternal(url);
    },
    async init() {
      this.loading = true;
      await this.countCreatureTemplates({});
      await this.countGameObjectTemplates({});
      await this.countItemTemplates({});
      await this.countQuestTemplates({});
      await this.countSpells({});
      await this.countSmartScript({});
      this.loading = false;
    }
  },
  components: {
    Chart
  },
  created() {
    this.init();
  }
};
</script>

<style>
.summary-title {
  font-size: 20px;
  font-weight: 600;
  color: #303133;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: clip;
}

.summary-title span {
  font-size: 16px;
  color: #909399;
  margin-left: 8px;
}

.summary-content {
  font-size: 24px;
  font-weight: 900;
  color: #606266;
}
</style>
