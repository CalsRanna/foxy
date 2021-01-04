<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/gossip-menu' }">对话管理</el-breadcrumb-item>
        <el-breadcrumb-item>对话详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeSubname }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="creature_template" @tab-click="switchover" style="margin-top: 16px">
      <el-tab-pane label="生物模版" name="creature_template"></el-tab-pane>
      <el-tab-pane label="模版补充" name="creature_template_addon" lazy v-loading="loading"></el-tab-pane>
      <el-tab-pane label="击杀声望" name="creature_onkill_reputation" lazy v-loading="loading"></el-tab-pane>
      <el-tab-pane label="装备模板" name="creature_equip_template" lazy v-loading="loading"></el-tab-pane>
      <el-tab-pane
        label="商人"
        name="npc_vendor"
        lazy
        v-loading="loading"
        :disabled="(creatureTemplate.npcflag & 3968) == 0"
      ></el-tab-pane>
      <el-tab-pane
        label="训练师"
        name="npc_trainer"
        lazy
        v-loading="loading"
        :disabled="(creatureTemplate.npcflag & 4194416) == 0"
      ></el-tab-pane>
      <el-tab-pane label="任务物品" name="creature_questitem" lazy v-loading="loading"></el-tab-pane>
      <el-tab-pane
        label="击杀掉落"
        name="creature_loot_template"
        lazy
        v-loading="loading"
        :disabled="creatureTemplate.lootid == 0 || creatureTemplate.lootid == null"
      ></el-tab-pane>
      <el-tab-pane
        label="偷窃掉落"
        name="pickpocketing_loot_template"
        lazy
        v-loading="loading"
        :disabled="creatureTemplate.pickpocketloot == 0 || creatureTemplate.pickpocketloot == null"
      ></el-tab-pane>
      <el-tab-pane
        label="剥皮掉落"
        name="skinning_loot_template"
        :disabled="creatureTemplate.skinloot == 0 || creatureTemplate.skinloot == null"
      ></el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import {
  npcFlags,
  typeFlags,
  unitFlags,
  unitFlags2,
  dynamicFlags,
  flagsExtra,
  mechanicImmuneMasks,
  dmgSchools,
  inhabitTypes,
  maxStandings
} from "@/locales/creature";

import { mapState, mapGetters, mapActions } from "vuex";

export default {
  data() {
    return {
      loading: false,
      min: 0,
      isCreating: true,
      localeDialogVisible: false,
      npcFlags: npcFlags,
      typeFlags: typeFlags,
      unitFlags: unitFlags,
      unitFlags2: unitFlags2,
      dynamicFlags: dynamicFlags,
      flagsExtra: flagsExtra,
      mechanicImmuneMasks: mechanicImmuneMasks,
      dmgSchools: dmgSchools,
      inhabitTypes: inhabitTypes,
      maxStandings: maxStandings
    };
  },
  computed: {
    ...mapState("creature", [
      "creatureTemplate",
      "creatureTemplateLocales",
      "creatureTemplateAddon",
      "creatureOnKillReputation",
      "creatureEquipTemplate",
      "creatureEquipTemplates",
      "npcVendors",
      "npcTrainers",
      "creatureQuestItems",
      "creatureLootTemplates",
      "pickpocketingLootTemplates",
      "skinningLootTemplates"
    ]),
    ...mapGetters("dbc", { icons: "itemIcons" }),
    localeName() {
      if (this.creatureTemplateLocales.length > 0) {
        let name = undefined;
        for (let creatureTemplateLocale of this.creatureTemplateLocales) {
          if (creatureTemplateLocale.locale === "zhCN") {
            name = creatureTemplateLocale.Name;
          }
        }
        return name !== undefined ? name : this.creatureTemplate.name;
      } else {
        return this.creatureTemplate.name;
      }
    },
    localeSubname() {
      if (this.creatureTemplateLocales.length > 0) {
        let subname = undefined;
        for (let creatureTemplateLocale of this.creatureTemplateLocales) {
          if (creatureTemplateLocale.locale === "zhCN") {
            subname = creatureTemplateLocale.Title;
          }
        }
        return subname !== undefined ? subname : this.creatureTemplate.subname;
      } else {
        return this.creatureTemplate.subname;
      }
    },
    disabled() {
      return !this.isCreating;
    }
  },
  methods: {
    ...mapActions("creature", [
      "storeCreatureTemplate",
      "findCreatureTemplate",
      "updateCreatureTemplate",
      "createCreatureTemplate",
      "searchCreatureTemplateLocales",
      "storeCreatureTemplateLocales",
      "storeCreatureTemplateAddon",
      "findCreatureTemplateAddon",
      "updateCreatureTemplateAddon",
      "storeCreatureOnKillReputation",
      "findCreatureOnKillReputation",
      "updateCreatureOnKillReputation",
      "searchCreatureEquipTemplates",
      "searchNpcVendors",
      "searchNpcTrainers",
      "searchCreatureQuestItems",
      "searchCreatureLootTemplates",
      "searchPickpocketingLootTemplates",
      "searchSkinningLootTemplates"
    ]),
    async switchover(tab) {
      let id = this.creatureTemplate.entry;
      if (tab.name === "creature_template_addon") {
        this.loading = true;
        await this.findCreatureTemplateAddon({ entry: id });
        this.loading = false;
      }
      if (tab.name === "creature_onkill_reputation") {
        this.loading = true;
        await this.findCreatureOnKillReputation({ creature_id: id });
        this.loading = false;
      }
      if (tab.name === "creature_equip_template") {
        this.loading = true;
        await this.searchCreatureEquipTemplates({ creatureId: id });
        this.loading = false;
      }
      if (tab.name === "npc_vendor") {
        this.loading = true;
        await this.searchNpcVendors({ entry: id });
        this.loading = false;
      }
      if (tab.name === "npc_trainer") {
        this.loading = true;
        await this.searchNpcTrainers({ id: id });
        this.loading = false;
      }
      if (tab.name === "creature_questitem") {
        await this.searchCreatureQuestItems({ creatureEntry: id });
        this.loading = true;
      }
      if (tab.name === "creature_loot_template") {
        await this.searchCreatureLootTemplates({ entry: id });
        this.loading = true;
      }
      if (tab.name === "pickpocketing_loot_template") {
        await this.searchPickpocketingLootTemplates({ entry: id });
        this.loading = true;
      }
      if (tab.name === "skinning_loot_template") {
        await this.searchSkinningLootTemplates({ entry: id });
        this.loading = true;
      }
      this.loading = false;
    },
    showDialog() {
      this.localeDialogVisible = true;
    },
    addCreatureTemplateLocale() {
      this.creatureTemplateLocales.push({
        entry: this.creatureTemplate.entry,
        VerifiedBuild: 0
      });
    },
    deleteCreatureTemplateLocale(index) {
      this.creatureTemplateLocales.splice(index, 1);
    },
    closeDialog() {
      this.localeDialogVisible = false;
    },
    store(module) {
      switch (module) {
        case "creature_template":
          if (this.isCreating) {
            this.storeCreatureTemplate(this.creatureTemplate).then(() => {});
          } else {
            this.updateCreatureTemplate(this.creatureTemplate).then(() => {});
          }
          break;
        case "creature_template_locales":
          this.storeCreatureTemplateLocales(this.creatureTemplateLocales).then(() => {
            this.localeDialogVisible = false;
          });
          break;
        case "creature_template_addon":
          if (this.creatureTemplateAddon.entry == undefined) {
            this.creatureTemplateAddon.entry = this.creatureTemplate.entry;
            this.storeCreatureTemplateAddon(this.creatureTemplateAddon).then(() => {});
          } else {
            this.updateCreatureTemplateAddon(this.creatureTemplateAddon).then(() => {});
          }
          break;
        case "creature_onkill_reputation":
          if (this.creatureOnKillReputation.creature_id == undefined) {
            this.creatureOnKillReputation.creature_id = this.creatureTemplate.entry;
            this.storeCreatureOnKillReputation(this.creatureOnKillReputation).then(() => {});
          } else {
            this.updateCreatureOnKillReputation(this.creatureOnKillReputation).then(() => {});
          }
          break;
        default:
          break;
      }
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.loading = true;
      let id = this.$route.params.id;
      let path = this.$route.path;
      if (path === "/creature/create") {
        await this.createCreatureTemplate();
      } else {
        this.isCreating = false;
        await Promise.all([
          this.findCreatureTemplate({ entry: id }),
          this.searchCreatureTemplateLocales({ entry: id })
        ]);
      }
      this.loading = false;
    }
  },
  created() {
    this.init();
  }
};
</script>
