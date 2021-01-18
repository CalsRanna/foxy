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
    <el-tabs
      value="creature_template"
      @tab-click="switchover"
      style="margin-top: 16px"
    >
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
      <el-tab-pane
        label="商人"
        name="npc_vendor"
        lazy
        v-loading="loading"
        :disabled="(creatureTemplate.npcflag & 3968) == 0"
      >
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="npcVendors">
            <el-table-column
              prop="slot"
              label="插槽"
              sortable
            ></el-table-column>
            <el-table-column prop="item" label="ID" sortable></el-table-column>
            <!-- <el-table-column width="43px" class-name="icon-height">
              <template slot-scope="scope">
                <el-image
                  :src="`/icons/${icons[scope.row.displayid]}.png`"
                  style="width: 23px; height:23px;margin: 0; padding: 0px 0 0 0"
                >
                  <el-image
                    src="/icons/INV_Misc_QuestionMark.png"
                    style="width: 23px; height:23px;margin: 0; padding: 0px 0 0 0"
                    slot="error"
                  ></el-image>
                </el-image>
              </template>
            </el-table-column> -->
            <el-table-column prop="name" label="名称" sortable>
              <span slot-scope="scope">
                <template v-if="scope.row.Name !== null">
                  {{ scope.row.Name }}
                </template>
                <template v-else>{{ scope.row.name }}</template>
              </span>
            </el-table-column>
            <el-table-column
              prop="maxcount"
              label="最大数量"
              sortable
            ></el-table-column>
            <el-table-column
              prop="incrtime"
              label="补货时间"
              sortable
            ></el-table-column>
            <el-table-column sortable>
              <span slot="header">
                <el-tooltip>
                  <div slot="content" style="max-width: 400px">
                    The value here corresponds to the ID in ItemExtendedCost.dbc
                    and that ID controls the item's non monetary price, be it
                    honor points, arena points, different types of badges or any
                    combination of the above.
                  </div>
                  <i class="el-icon-info"></i>
                </el-tooltip>
                扩展价格
              </span>
              <span slot-scope="scope">{{ scope.row.ExtendedCost }}</span>
            </el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane
        label="训练师"
        name="npc_trainer"
        lazy
        v-loading="loading"
        :disabled="(creatureTemplate.npcflag & 4194416) == 0"
      >
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="npcTrainers">
            <el-table-column prop="SpellID" label="技能ID" sortable>
              <span slot="header">
                <el-tooltip>
                  <i class="el-icon-info"></i>
                  <div slot="content" style="max-width: 400px">
                    The spell ID from Spell.dbc. If the ID is negative, it's
                    pointing to a reference template.
                  </div>
                </el-tooltip>
                技能ID
              </span>
            </el-table-column>
            <el-table-column
              prop="MoneyCost"
              label="价格"
              sortable
            ></el-table-column>
            <el-table-column
              prop="ReqSkillLine"
              label="需要技能"
              sortable
            ></el-table-column>
            <el-table-column
              prop="ReqSkillRank"
              label="需要熟练度"
              sortable
            ></el-table-column>
            <el-table-column
              prop="ReqLevel"
              label="需要等级"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane
        label="任务物品"
        name="creature_questitem"
        lazy
        v-loading="loading"
      >
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="creatureQuestItems">
            <el-table-column label="名称">
              <span slot-scope="scope">
                <template v-if="scope.row.localeName !== null">
                  {{ scope.row.localeName }}
                </template>
                <template v-else>{{ scope.row.name }}</template>
              </span>
            </el-table-column>
            <el-table-column
              prop="VerifiedBuild"
              label="VerifiedBuild"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane
        label="击杀掉落"
        name="creature_loot_template"
        lazy
        v-loading="loading"
        :disabled="
          creatureTemplate.lootid == 0 || creatureTemplate.lootid == null
        "
      >
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="creatureLootTemplates">
            <el-table-column prop="displayid"></el-table-column>
            <el-table-column label="名称" sortable>
              <span slot-scope="scope">
                <template v-if="scope.row.Reference == 0">
                  <template v-if="scope.row.localeName !== null">
                    {{ scope.row.localeName }}
                  </template>
                  <template v-else>{{ scope.row.name }}</template>
                </template>
                <template v-else> 关联掉落 </template>
              </span>
            </el-table-column>
            <el-table-column
              prop="Reference"
              label="关联"
              sortable
            ></el-table-column>
            <el-table-column prop="Chance" label="几率" sortable>
              <span slot-scope="scope">
                {{ `${scope.row.Chance}%` }}
              </span>
            </el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务" sortable>
              <span slot-scope="scope">
                <el-tag type="success" v-if="scope.row.QuestRequired">
                  需要
                </el-tag>
                <el-tag v-else>不需要</el-tag>
              </span>
            </el-table-column>
            <el-table-column
              prop="MinCount"
              label="最小数量"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MaxCount"
              label="最大数量"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
        <el-card
          v-for="(
            creatureReferenceLootTemplates, index
          ) in groupedCreatureReferenceLootTemplates"
          :key="`creatureReferenceLootTemplates-${index}`"
          :header="`关联掉落${creatureReferenceLootTemplates[0].Entry}`"
          style="margin-top: 16px"
        >
          <el-table :data="creatureReferenceLootTemplates">
            <el-table-column prop="displayid"></el-table-column>
            <el-table-column label="名称" sortable>
              <span slot-scope="scope">
                <template v-if="scope.row.Reference == 0">
                  <template v-if="scope.row.localeName !== null">
                    {{ scope.row.localeName }}
                  </template>
                  <template v-else>{{ scope.row.name }}</template>
                </template>
                <template v-else> 关联掉落 </template>
              </span>
            </el-table-column>
            <el-table-column
              prop="Reference"
              label="关联"
              sortable
            ></el-table-column>
            <el-table-column prop="Chance" label="几率" sortable>
              <span slot-scope="scope">
                {{ `${scope.row.Chance}%` }}
              </span>
            </el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务" sortable>
              <span slot-scope="scope">
                <el-tag type="success" v-if="scope.row.QuestRequired">
                  需要
                </el-tag>
                <el-tag v-else>不需要</el-tag>
              </span>
            </el-table-column>
            <el-table-column
              prop="MinCount"
              label="最小数量"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MaxCount"
              label="最大数量"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane
        label="偷窃掉落"
        name="pickpocketing_loot_template"
        lazy
        v-loading="loading"
        :disabled="
          creatureTemplate.pickpocketloot == 0 ||
          creatureTemplate.pickpocketloot == null
        "
      >
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="pickpocketingLootTemplates">
            <el-table-column prop="displayid"></el-table-column>
            <el-table-column prop="Item" label="ID" sortable></el-table-column>
            <el-table-column label="名称">
              <span slot-scope="scope">
                <template v-if="scope.row.localeName !== null">
                  {{ scope.row.localeName }}
                </template>
                <template v-else>{{ scope.row.name }}</template>
              </span>
            </el-table-column>
            <el-table-column
              prop="Reference"
              label="关联"
              sortable
            ></el-table-column>
            <el-table-column prop="Chance" label="几率" sortable>
              <template slot-scope="scope">
                {{ `${scope.row.Chance}%` }}
              </template>
            </el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务" sortable>
              <span slot-scope="scope">
                <el-tag type="success" v-if="scope.row.QuestRequired">
                  需要
                </el-tag>
                <el-tag v-else>不需要</el-tag>
              </span>
            </el-table-column>
            <el-table-column
              prop="LootMode"
              label="掉落模式"
              sortable
            ></el-table-column>
            <el-table-column
              prop="GroupId"
              label="组ID"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MinCount"
              label="最小数量"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MaxCount"
              label="最大数量"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane
        label="剥皮掉落"
        name="skinning_loot_template"
        :disabled="
          creatureTemplate.skinloot == 0 || creatureTemplate.skinloot == null
        "
      >
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="skinningLootTemplates">
            <el-table-column prop="displayid"></el-table-column>
            <el-table-column prop="Item" label="ID" sortable></el-table-column>
            <el-table-column label="名称">
              <span slot-scope="scope">
                <template v-if="scope.row.localeName !== null">
                  {{ scope.row.localeName }}
                </template>
                <template v-else>{{ scope.row.name }}</template>
              </span>
            </el-table-column>
            <el-table-column
              prop="Reference"
              label="关联"
              sortable
            ></el-table-column>
            <el-table-column prop="Chance" label="几率" sortable>
              <template slot-scope="scope">
                {{ `${scope.row.Chance}%` }}
              </template>
            </el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务" sortable>
              <span slot-scope="scope">
                <el-tag type="success" v-if="scope.row.QuestRequired">
                  需要
                </el-tag>
                <el-tag v-else>不需要</el-tag>
              </span>
            </el-table-column>
            <el-table-column
              prop="LootMode"
              label="掉落模式"
              sortable
            ></el-table-column>
            <el-table-column
              prop="GroupId"
              label="组ID"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MinCount"
              label="最小数量"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MaxCount"
              label="最大数量"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
    </el-tabs>
    <el-dialog
      :visible.sync="localeDialogVisible"
      :show-close="false"
      :close-on-click-modal="false"
    >
      <div slot="title">
        <span style="font-size: 18px; color: #303133; margin-right: 16px"
          >名称/称号本地化</span
        >
        <el-button size="mini" @click="addCreatureTemplateLocale"
          >新增</el-button
        >
      </div>
      <el-table :data="creatureTemplateLocales">
        <el-table-column width="48">
          <el-button
            type="danger"
            size="mini"
            icon="el-icon-delete"
            circle=""
            slot-scope="scope"
            @click="() => deleteCreatureTemplateLocale(scope.$index)"
          ></el-button>
        </el-table-column>
        <el-table-column prop="entry" label="编号">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.entry"
              controls-position="right"
              disabled
            ></el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="locale" label="语言">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.locale"
              placeholder="locale"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Name" label="名称">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Name" placeholder="Name"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Title" label="称号">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Title" placeholder="Title"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="VerifiedBuild" label="VerifiedBuild">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.VerifiedBuild"
              :min="0"
              controls-position="right"
              placeholder="VerifiedBuild"
            ></el-input-number>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer">
        <el-button @click="closeDialog">取消</el-button>
        <el-button
          type="primary"
          @click="() => store('creature_template_locales')"
          >保存</el-button
        >
      </div>
    </el-dialog>
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
  maxStandings,
} from "@/locales/creature";

import { mapState, mapGetters, mapActions } from "vuex";

import FlagEditor from "@/components/FlagEditor";
import GossipMenuSelector from "@/components/GossipMenuSelector";
import SpellSelector from "@/components/SpellSelector";
import CreatureTemplateTabPane from "@/views/Creature/components/CreatureTemplateTabPane";
import CreatureTemplateAddonTabPane from "@/views/Creature/components/CreatureTemplateAddonTabPane";
import CreatureOnKillReputationTabPane from "@/views/Creature/components/CreatureOnKillReputationTabPane.vue";
import CreatureEquipTemplateTabPane from "@/views/Creature/components/CreatureEquipTemplateTabPane.vue";

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
      maxStandings: maxStandings,
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
      "creatureReferenceLootTemplates",
      "pickpocketingLootTemplates",
      "skinningLootTemplates",
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
    },
    creatureReferenceLootTemplateEntries() {
      let entries = [];
      for (let creatureLootTemplate of this.creatureLootTemplates) {
        if (creatureLootTemplate.Reference != 0) {
          entries.push(creatureLootTemplate.Reference);
        }
      }
      return entries;
    },
    groupedCreatureReferenceLootTemplates() {
      let groups = {};
      this.creatureReferenceLootTemplates.forEach(
        (creatureReferenceLootTemplate) => {
          const key = creatureReferenceLootTemplate.Entry;
          groups[key] = groups[key] || [];
          groups[key].push(creatureReferenceLootTemplate);
        }
      );
      return Object.keys(groups).map((group) => groups[group]);
    },
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
      "searchCreatureReferenceLootTemplates",
      "searchPickpocketingLootTemplates",
      "searchSkinningLootTemplates",
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
        this.loading = true;
        await this.searchCreatureQuestItems({ creatureEntry: id });
        this.loading = false;
      }
      if (tab.name === "creature_loot_template") {
        this.loading = true;
        await this.searchCreatureLootTemplates({ entry: id });
        this.searchCreatureReferenceLootTemplates({
          entries: this.creatureReferenceLootTemplateEntries,
        });
        this.loading = false;
      }
      if (tab.name === "pickpocketing_loot_template") {
        this.loading = true;
        await this.searchPickpocketingLootTemplates({ entry: id });
        this.loading = false;
      }
      if (tab.name === "skinning_loot_template") {
        await this.searchSkinningLootTemplates({ entry: id });
        this.loading = false;
      }
      this.loading = false;
    },
    showDialog() {
      this.localeDialogVisible = true;
    },
    addCreatureTemplateLocale() {
      this.creatureTemplateLocales.push({
        entry: this.creatureTemplate.entry,
        VerifiedBuild: 0,
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
          this.storeCreatureTemplateLocales(this.creatureTemplateLocales).then(
            () => {
              this.localeDialogVisible = false;
            }
          );
          break;
        case "creature_template_addon":
          if (this.creatureTemplateAddon.entry == undefined) {
            this.creatureTemplateAddon.entry = this.creatureTemplate.entry;
            this.storeCreatureTemplateAddon(
              this.creatureTemplateAddon
            ).then(() => {});
          } else {
            this.updateCreatureTemplateAddon(
              this.creatureTemplateAddon
            ).then(() => {});
          }
          break;
        case "creature_onkill_reputation":
          if (this.creatureOnKillReputation.creature_id == undefined) {
            this.creatureOnKillReputation.creature_id = this.creatureTemplate.entry;
            this.storeCreatureOnKillReputation(
              this.creatureOnKillReputation
            ).then(() => {});
          } else {
            this.updateCreatureOnKillReputation(
              this.creatureOnKillReputation
            ).then(() => {});
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
          this.searchCreatureTemplateLocales({ entry: id }),
        ]);
      }
      this.loading = false;
    },
  },
  created() {
    this.init();
  },
  components: {
    "flag-editor": FlagEditor,
    "gossip-menu-selector": GossipMenuSelector,
    "spell-selector": SpellSelector,
    "creature-template-tab-pane": CreatureTemplateTabPane,
    "creature-template-addon-tab-pane": CreatureTemplateTabAddonPane,
    "creature-on-kill-reputation-tab-pane": CreatureOnKillReputationTabPane,
    CreatureEquipTemplateTabPane,
  },
};
</script>
