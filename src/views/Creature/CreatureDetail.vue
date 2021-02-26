<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/creature' }">
          生物管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>生物详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeSubname }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="creature_template" style="margin-top: 16px">
      <el-tab-pane label="生物模版" name="creature_template">
        <creature-template-tab-pane></creature-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="模版补充" name="creature_template_addon" lazy>
        <creature-template-addon-tab-pane></creature-template-addon-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="击杀声望" name="creature_onkill_reputation" lazy>
        <creature-on-kill-reputation-tab-pane></creature-on-kill-reputation-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="装备模板" name="creature_equip_template" lazy>
        <creature-equip-template-tab-pane></creature-equip-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="任务物品" name="creature_questitem" lazy>
        <creature-quest-item-tab-pane></creature-quest-item-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="商人"
        name="npc_vendor"
        lazy
        :disabled="(creatureTemplate.npcflag & 3968) == 0"
      >
        <npc-vendor-tab-pane></npc-vendor-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="训练师"
        name="npc_trainer"
        lazy
        :disabled="(creatureTemplate.npcflag & 4194416) == 0"
      >
        <npc-trainer-tab-pane></npc-trainer-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="击杀掉落"
        name="creature_loot_template"
        lazy
        :disabled="
          creatureTemplate.lootid == 0 || creatureTemplate.lootid == undefined
        "
      >
        <creature-loot-template-tab-pane></creature-loot-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="偷窃掉落"
        name="pickpocketing_loot_template"
        lazy
        :disabled="
          creatureTemplate.pickpocketloot == 0 ||
            creatureTemplate.pickpocketloot == undefined
        "
      >
        <pickpocketing-loot-template-tab-pane></pickpocketing-loot-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="剥皮掉落"
        name="skinning_loot_template"
        lazy
        :disabled="
          creatureTemplate.skinloot == 0 ||
            creatureTemplate.skinloot == undefined
        "
      >
        <skinning-loot-template-tab-pane></skinning-loot-template-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { mapState } from "vuex";

import CreatureTemplateTabPane from "@/views/Creature/components/CreatureTemplateTabPane";
import CreatureTemplateAddonTabPane from "@/views/Creature/components/CreatureTemplateAddonTabPane";
import CreatureOnKillReputationTabPane from "@/views/Creature/components/CreatureOnKillReputationTabPane";
import CreatureEquipTemplateTabPane from "@/views/Creature/components/CreatureEquipTemplateTabPane";
import CreatureQuestItemTabPane from "@/views/Creature/components/CreatureQuestItemTabPane";
import NpcVendorTabPane from "@/views/Creature/components/NpcVendorTabPane";
import NpcTrainerTabPane from "@/views/Creature/components/NpcTrainerTabPane";
import CreatureLootTemplateTabPane from "@/views/Creature/components/CreatureLootTemplateTabPane";
import PickpocketingLootTemplateTabPane from "@/views/Creature/components/PickpocketingLootTemplateTabPane";
import SkinningLootTemplateTabPane from "@/views/Creature/components/SkinningLootTemplateTabPane";

export default {
  computed: {
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureTemplateLocale", ["creatureTemplateLocales"]),
    localeName() {
      if (this.creatureTemplateLocales.length > 0) {
        let name = undefined;
        for (let creatureTemplateLocale of this.creatureTemplateLocales) {
          if (creatureTemplateLocale.locale === "zhCN") {
            name = creatureTemplateLocale.Name;
          }
        }
        return name ? name : this.creatureTemplate.name;
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
        return subname ? subname : this.creatureTemplate.subname;
      } else {
        return this.creatureTemplate.subname;
      }
    }
  },
  components: {
    CreatureTemplateTabPane,
    CreatureTemplateAddonTabPane,
    CreatureOnKillReputationTabPane,
    CreatureEquipTemplateTabPane,
    CreatureQuestItemTabPane,
    NpcVendorTabPane,
    NpcTrainerTabPane,
    CreatureLootTemplateTabPane,
    PickpocketingLootTemplateTabPane,
    SkinningLootTemplateTabPane
  }
};
</script>
