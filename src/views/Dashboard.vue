<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item>控制面板</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">控制面板</h3>
    </el-card>
    <el-alert type="info" style="margin-top: 16px">
      <span slot="title">
        欢迎使用 Foxy ，一款开发中的魔兽世界编辑器。
        <span v-show="latestVersion !== null && latestVersion !== version">
          当前版本 {{ version }}，新版本
          <span
            style="color: #409eff; cursor: pointer"
            @click="() => openBrowser(downloadUrl)"
          >
            {{ latestVersion }}
          </span>
          可用，请下载使用。
        </span>
      </span>
    </el-alert>
    <el-row :gutter="16" style="margin-top: 16px" :loading="loading">
      <el-col :span="16">
        <el-row :gutter="16">
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">
                生物模板<span>Creature Template</span>
              </p>
              <p class="summary-content">
                {{
                  parseFloat(
                    this.quantityOfCreatureTemplate.total
                  ).toLocaleString()
                }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">物品模板<span>Item Template</span></p>
              <p class="summary-content">
                {{
                  parseFloat(this.quantityOfItemTemplate.total).toLocaleString()
                }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">
                物体模板<span>Game Object Template</span>
              </p>
              <p class="summary-content">
                {{
                  parseFloat(
                    this.quantityOfGameObjectTemplate.total
                  ).toLocaleString()
                }}
              </p>
            </el-card>
          </el-col>
        </el-row>
        <el-row :gutter="16" style="margin-top: 16px">
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">任务模板<span>Quest Template</span></p>
              <p class="summary-content">
                {{
                  parseFloat(
                    this.quantityOfQuestTemplate.total
                  ).toLocaleString()
                }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">对话<span>Gossip Menu</span></p>
              <p class="summary-content">
                {{
                  parseFloat(this.quantityOfGossipMenu.total).toLocaleString()
                }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">内建脚本<span>Smart Script</span></p>
              <p class="summary-content">
                {{
                  parseFloat(this.quantityOfSmartScript.total).toLocaleString()
                }}
              </p>
            </el-card>
          </el-col>
        </el-row>
        <el-row :gutter="16" style="margin-top: 16px">
          <el-col :span="8">
            <el-card shadow="hover">
              <p class="summary-title">技能<span>Spell</span></p>
              <p class="summary-content">
                {{ parseFloat(this.quantityOfSpell.total).toLocaleString() }}
              </p>
            </el-card>
          </el-col>
        </el-row>
      </el-col>
      <el-col :span="8">
        <el-card style="font-size: 14px">
          <div slot="header">
            <span>介绍</span>
          </div>
          <p style="text-indent: 2em">
            目前存在的编辑器都不是很能满足我对一个好用的编辑器的期望：简单，易用，美观，因此我提交了Foxy这个开源项目。
          </p>
          <p style="text-indent: 2em">
            一旦涉及自定义配置项，软件很难做到简单易用，因此目前暂不支持对数据库表的定义，
            所有编辑项全部写死在代码里（基于AzerothCore），后期考虑改为可配置，以便适配其他服务端，
            提高软件复用效率。
          </p>
          <p style="text-indent: 2em">
            闲余时间开发，进度随缘， Feature也随缘， Bug请到

            <span
              style="color: #409eff; cursor: pointer"
              @click="
                () => openBrowser('https://github.com/CalsRanna/foxy/issues')
              "
            >
              Github
            </span>
            上面提交 issue 。
          </p>
          <p style="text-indent: 2em">
            如果你希望得到最新版本的Foxy，请访问
            <span
              style="color: #409eff; cursor: pointer"
              @click="
                () => openBrowser('https://github.com/CalsRanna/foxy/releases')
              "
            >
              下载页面
            </span>
            或前往
            <el-tooltip>
              <span
                style="color: #409eff; cursor: pointer"
                @click="() => openBrowser(netDiskUrl.url)"
              >
                百度网盘
              </span>
              <span slot="content">提取码：{{ netDiskUrl.code }}</span>
            </el-tooltip>
            下载。你也可以
            <span
              style="color: #409eff; cursor: pointer"
              @click="() => openBrowser('https://github.com/CalsRanna/foxy')"
            >
              Clone
            </span>
            源码自行编译使用 。
          </p>
        </el-card>
        <el-card style="margin-top: 16px; font-size: 14px">
          <div slot="header">
            <span>版本信息</span>
          </div>
          <ul style="list-style: none; padding: 0">
            <li>核心版本：{{ coreVersion.core_version }}</li>
            <li style="margin-top: 8px">
              核心修正版本：{{ coreVersion.core_revision }}
            </li>
            <li style="margin-top: 8px">
              数据库版本：{{ coreVersion.db_version }}
            </li>
            <li style="margin-top: 8px">软件版本：{{ version }}</li>
          </ul>
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
      version: "0.1.4",
      labels: ["生物", "物品", "物体", "任务", "对话", "内建脚本", "技能"],
    };
  },
  computed: {
    ...mapState("global", {
      latestVersion: "latestVersion",
      downloadUrl: "downloadUrl",
      netDiskUrl: "netDiskUrl",
    }),
    ...mapState("version", {
      coreVersion: "version",
    }),
    ...mapState("creatureTemplate", {
      quantityOfCreatureTemplate: "pagination",
    }),
    ...mapState("itemTemplate", { quantityOfItemTemplate: "pagination" }),
    ...mapState("gameObjectTemplate", {
      quantityOfGameObjectTemplate: "pagination",
    }),
    ...mapState("questTemplate", { quantityOfQuestTemplate: "pagination" }),
    ...mapState("gossipMenu", { quantityOfGossipMenu: "pagination" }),
    ...mapState("smartScript", { quantityOfSmartScript: "pagination" }),
    ...mapState("spell", { quantityOfSpell: "pagination" }),
    data() {
      return [
        this.quantityOfCreatureTemplate.total,
        this.quantityOfItemTemplate.total,
        this.quantityOfGameObjectTemplate.total,
        this.quantityOfQuestTemplate.total,
        this.quantityOfGossipMenu.total,
        this.quantityOfSmartScript.total,
        this.quantityOfSpell.total,
      ];
    },
  },
  methods: {
    ...mapActions("version", ["findVersion"]),
    ...mapActions("creatureTemplate", ["countCreatureTemplates"]),
    ...mapActions("itemTemplate", ["countItemTemplates"]),
    ...mapActions("gameObjectTemplate", ["countGameObjectTemplates"]),
    ...mapActions("questTemplate", ["countQuestTemplates"]),
    ...mapActions("gossipMenu", ["countGossipMenus"]),
    ...mapActions("smartScript", ["countSmartScripts"]),
    ...mapActions("spell", ["countSpells"]),
    openBrowser(url) {
      const shell = window.shell;
      shell.openExternal(url);
    },
    async init() {
      this.loading = true;
      try {
        await Promise.all([
          this.countCreatureTemplates({}),
          this.countGameObjectTemplates({}),
          this.countItemTemplates({}),
          this.countQuestTemplates({}),
          this.countGossipMenus({}),
          this.countSmartScripts({}),
          this.countSpells({}),
        ]);
        await this.findVersion();
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
  },
  components: {
    Chart,
  },
  mounted() {
    this.init();
  },
};
</script>
