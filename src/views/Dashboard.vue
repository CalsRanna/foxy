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
    <el-row
      :gutter="16"
      :style="{
        maxHeight: `${calculateMaxHeight()}px`,
        overflow: 'auto',
      }"
      :loading="loading"
    >
      <el-col :span="24" style="margin-top: 16px">
        <el-alert type="info" :closable="false">
          <div slot="title">
            狐狸魔兽世界论坛<clickable-span
              text="http://foxwow.xyz"
              url="http://foxwow.xyz"
            ></clickable-span
            >已正式上线运行，请前往论坛反馈BUG及建议。
          </div>
        </el-alert>
      </el-col>
      <el-col :span="16">
        <el-row :gutter="16">
          <el-col :span="8">
            <el-card
              shadow="hover"
              class="clickable-card"
              @click.native="() => navigate('/creature')"
            >
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
            <el-card
              shadow="hover"
              class="clickable-card"
              @click.native="() => navigate('/item')"
            >
              <p class="summary-title">物品模板<span>Item Template</span></p>
              <p class="summary-content">
                {{
                  parseFloat(this.quantityOfItemTemplate.total).toLocaleString()
                }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card
              shadow="hover"
              class="clickable-card"
              @click.native="() => navigate('/game-object')"
            >
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
          <el-col :span="8">
            <el-card
              shadow="hover"
              class="clickable-card"
              @click.native="() => navigate('/quest')"
            >
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
            <el-card
              shadow="hover"
              class="clickable-card"
              @click.native="() => navigate('/gossip-menu')"
            >
              <p class="summary-title">对话<span>Gossip Menu</span></p>
              <p class="summary-content">
                {{
                  parseFloat(this.quantityOfGossipMenu.total).toLocaleString()
                }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card
              shadow="hover"
              class="clickable-card"
              @click.native="() => navigate('/smart-script')"
            >
              <p class="summary-title">内建脚本<span>Smart Script</span></p>
              <p class="summary-content">
                {{
                  parseFloat(this.quantityOfSmartScript.total).toLocaleString()
                }}
              </p>
            </el-card>
          </el-col>
          <el-col :span="8">
            <el-card
              shadow="hover"
              class="clickable-card"
              @click.native="() => navigate('/spell')"
            >
              <p class="summary-title">技能<span>Spell</span></p>
              <p class="summary-content">
                {{ parseFloat(this.quantityOfSpell.total).toLocaleString() }}
              </p>
            </el-card>
          </el-col>
        </el-row>
      </el-col>
      <el-col :span="8">
        <el-card style="margin-top: 16px; font-size: 14px">
          <div slot="header">
            <span>介绍</span>
          </div>
          <p style="text-indent: 2em">
            目前存在的工具都不能满足我对一个好用的编辑器的期望：简单，易用，美观，因此我发起了Foxy这个项目。
          </p>
          <p style="text-indent: 2em">
            Foxy目前只支持AzerothCore或基于其二次开发的数据库，不支持对数据库表自定义。
          </p>
          <p style="text-indent: 2em">
            闲余时间开发，进度随缘， Feature也随缘， Bug请到<clickable-span
              text="Github"
              url="https://github.com/CalsRanna/foxy/issues"
            ></clickable-span
            >上面提交issue，也可以前往<clickable-span
              text="Foxwow"
              url="http://foxwow.xyz/d/2-foxy"
            ></clickable-span
            >讨论。
          </p>
          <p style="text-indent: 2em">
            如果你希望得到最新版本的Foxy，请访问<clickable-span
              text="下载页面"
              url="https://github.com/CalsRanna/foxy/releases"
            ></clickable-span
            >或前往<el-tooltip
              ><clickable-span
                text="百度网盘"
                :url="remote.netDiskUrl"
              ></clickable-span>
              <span slot="content">提取码：{{ remote.code }}</span> </el-tooltip
            >下载，你也可以<clickable-span
              text="Clone"
              url="https://github.com/CalsRanna/foxy"
            ></clickable-span
            >源码自行编译使用。
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
import ClickableSpan from "@/components/ClickableSpan";

export default {
  data() {
    return {
      loading: false,
      labels: ["生物", "物品", "物体", "任务", "对话", "内建脚本", "技能"],
    };
  },
  computed: {
    ...mapState("app", ["version", "clientHeight"]),
    ...mapState("updater", {
      remote: "version",
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
    ...mapActions("app", ["setActive"]),
    ...mapActions("version", ["findVersion"]),
    ...mapActions("creatureTemplate", ["countCreatureTemplates"]),
    ...mapActions("itemTemplate", ["countItemTemplates"]),
    ...mapActions("gameObjectTemplate", ["countGameObjectTemplates"]),
    ...mapActions("questTemplate", ["countQuestTemplates"]),
    ...mapActions("gossipMenu", ["countGossipMenus"]),
    ...mapActions("smartScript", ["countSmartScripts"]),
    ...mapActions("spell", ["countSpells"]),
    calculateMaxHeight() {
      return this.clientHeight - 154;
    },
    openBrowser(url) {
      const shell = window.shell;
      shell.openExternal(url);
    },
    navigate(route) {
      this.setActive(route.substr(1));
      this.$router.push(route);
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
          this.findVersion(),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
  },
  mounted() {
    this.init();
  },
  components: { ClickableSpan },
};
</script>
