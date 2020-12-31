<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/game-object' }">游戏对象管理</el-breadcrumb-item>
        <el-breadcrumb-item>游戏对象详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-tabs value="game_object_template" style="margin-top: 16px" @tab-click="switchover">
        <el-tab-pane label="游戏对象模版" name="game_object_template">
          <el-form :model="gameObjectTemplate" label-position="right" label-width="120px">
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="ID">
                    <el-input-number
                      v-model="gameObjectTemplate.entry"
                      :min="min"
                      controls-position="right"
                      placeholder="entry"
                      :disabled="disabled"
                      v-loading="loading"
                      element-loading-spinner="el-icon-loading"
                      element-loading-background="rgba(255, 255, 255, 0.5)"
                    ></el-input-number>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="名称">
                    <el-input v-model="gameObjectTemplate.name" placeholder="name">
                      <i
                        class="el-icon-s-operation clickable-icon"
                        slot="suffix"
                        style="margin-right: 8px"
                        @click="showDialog"
                      ></i>
                    </el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="使用文字">
                    <el-input v-model="gameObjectTemplate.castBarCaption" placeholder="castBarCaption">
                      <i
                        class="el-icon-s-operation clickable-icon"
                        slot="suffix"
                        style="margin-right: 8px"
                        @click="showDialog"
                      ></i>
                    </el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="鼠标形状">
                    <el-input v-model="gameObjectTemplate.IconName" placeholder="IconName"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="类型">
                    <el-input v-model="gameObjectTemplate.type" placeholder="type"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="外观">
                    <el-input v-model="gameObjectTemplate.displayId" placeholder="displayId"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="尺寸">
                    <el-input v-model="gameObjectTemplate.size" placeholder="size"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="unk1">
                    <el-input v-model="gameObjectTemplate.unk1" placeholder="unk1"></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="Data0">
                    <el-input v-model="gameObjectTemplate.Data0" placeholder="Data0"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data1">
                    <el-input v-model="gameObjectTemplate.Data1" placeholder="Data1"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data2">
                    <el-input v-model="gameObjectTemplate.Data2" placeholder="Data2"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data3">
                    <el-input v-model="gameObjectTemplate.Data3" placeholder="Data3"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data4">
                    <el-input v-model="gameObjectTemplate.Data4" placeholder="Data4"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data5">
                    <el-input v-model="gameObjectTemplate.Data5" placeholder="Data5"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data6">
                    <el-input v-model="gameObjectTemplate.Data6" placeholder="Data6"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data7">
                    <el-input v-model="gameObjectTemplate.Data7" placeholder="Data7"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data8">
                    <el-input v-model="gameObjectTemplate.Data8" placeholder="Data8"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data9">
                    <el-input v-model="gameObjectTemplate.Data9" placeholder="Data9"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data10">
                    <el-input v-model="gameObjectTemplate.Data10" placeholder="Data10"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data11">
                    <el-input v-model="gameObjectTemplate.Data11" placeholder="Data11"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data12">
                    <el-input v-model="gameObjectTemplate.Data12" placeholder="Data12"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data13">
                    <el-input v-model="gameObjectTemplate.Data13" placeholder="Data13"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data14">
                    <el-input v-model="gameObjectTemplate.Data14" placeholder="Data14"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data15">
                    <el-input v-model="gameObjectTemplate.Data15" placeholder="Data15"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data16">
                    <el-input v-model="gameObjectTemplate.Data16" placeholder="Data16"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data17">
                    <el-input v-model="gameObjectTemplate.Data17" placeholder="Data17"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data18">
                    <el-input v-model="gameObjectTemplate.Data18" placeholder="Data18"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data19">
                    <el-input v-model="gameObjectTemplate.Data19" placeholder="Data19"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data20">
                    <el-input v-model="gameObjectTemplate.Data20" placeholder="Data20"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data21">
                    <el-input v-model="gameObjectTemplate.Data21" placeholder="Data21"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data22">
                    <el-input v-model="gameObjectTemplate.Data22" placeholder="Data22"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Data23">
                    <el-input v-model="gameObjectTemplate.Data23" placeholder="Data23"></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="AI名称">
                    <el-input v-model="gameObjectTemplate.AIName" placeholder="AIName"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="脚本名称">
                    <el-input v-model="gameObjectTemplate.ScriptName" placeholder="ScriptName"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="VerifiedBuild">
                    <el-input v-model="gameObjectTemplate.VerifiedBuild" placeholder="VerifiedBuild"></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-button type="primary" @click="() => store('game_object_template')">保存</el-button>
              <el-button @click="cancle">返回</el-button>
            </el-card>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="模版补充" name="game_object_template_addon">
          <el-form :model="gameObjectTemplateAddon" label-position="right" label-width="120px">
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="ID">
                    <el-input-number
                      v-model="gameObjectTemplateAddon.entry"
                      :min="min"
                      controls-position="right"
                      placeholder="entry"
                      :disabled="disabled"
                      v-loading="loading"
                      element-loading-spinner="el-icon-loading"
                      element-loading-background="rgba(255, 255, 255, 0.5)"
                    ></el-input-number>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="势力">
                    <el-input v-model="gameObjectTemplateAddon.faction" placeholder="faction"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="标识">
                    <flag-editor
                      v-model="gameObjectTemplateAddon.flags"
                      :flags="flags"
                      title="标识编辑器"
                      placeholder="flags"
                    ></flag-editor>
                  </el-form-item>
                </el-col>
              </el-row>
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="mingold">
                    <el-input v-model="gameObjectTemplateAddon.mingold" placeholder="mingold"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="maxgold">
                    <el-input v-model="gameObjectTemplateAddon.maxgold" placeholder="maxgold"></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-button type="primary" @click="() => store('game_object_template_addon')">保存</el-button>
              <el-button @click="cancle">返回</el-button>
            </el-card>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="任务物品" name="game_object_quest_item">
          <el-card style="margin-top: 16px">
            <el-button type="primary">新增</el-button>
            <el-button disabled>复制</el-button>
            <el-button type="danger" disabled>删除</el-button>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-table :data="gameObjectQuestItems">
              <el-table-column label="名称">
                <span slot-scope="scope">
                  <template v-if="scope.row.localeName !== null">
                    {{ scope.row.localeName }}
                  </template>
                  <template v-else>{{ scope.row.name }}</template>
                </span>
              </el-table-column>
              <el-table-column prop="VerifiedBuild" label="VerifiedBuild" sortable></el-table-column>
            </el-table>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="物品掉落" name="game_object_loot_template">
          <el-card style="margin-top: 16px">
            <el-button type="primary">新增</el-button>
            <el-button disabled>复制</el-button>
            <el-button type="danger" disabled>删除</el-button>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-table :data="gameObjectLootTemplates">
              <el-table-column prop="displayid"></el-table-column>
              <el-table-column label="名称" sortable>
                <span slot-scope="scope">
                  <template v-if="scope.row.localeName !== null">
                    {{ scope.row.localeName }}
                  </template>
                  <template v-else>{{ scope.row.name }}</template>
                </span>
              </el-table-column>
              <el-table-column prop="Reference" label="关联" sortable></el-table-column>
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
              <el-table-column prop="MinCount" label="最小数量" sortable></el-table-column>
              <el-table-column prop="MaxCount" label="最大数量" sortable></el-table-column>
            </el-table>
          </el-card>
        </el-tab-pane>
      </el-tabs>
    </el-card>
    <el-dialog :visible.sync="localeDialogVisible" :show-close="false" :close-on-click-modal="false">
      <div slot="title">
        <span style="font-size: 18px;color: #303133;margin-right:16px">名称/使用文字本地化</span>
        <el-button size="mini" @click="addGameObjectTemplateLocale">新增</el-button>
      </div>
      <el-table :data="gameObjectTemplateLocales">
        <el-table-column width="48">
          <el-button
            type="danger"
            size="mini"
            icon="el-icon-delete"
            circle=""
            slot-scope="scope"
            @click="() => deleteGameObjectTemplateLocale(scope.$index)"
          ></el-button>
        </el-table-column>
        <el-table-column prop="entry" label="编号">
          <template slot-scope="scope">
            <el-input-number v-model="scope.row.entry" controls-position="right" disabled></el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="locale" label="语言">
          <template slot-scope="scope">
            <el-input v-model="scope.row.locale" placeholder="locale"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Name" label="名称">
          <template slot-scope="scope">
            <el-input v-model="scope.row.name" placeholder="name"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Title" label="使用文字">
          <template slot-scope="scope">
            <el-input v-model="scope.row.castBarCaption" placeholder="castBarCaption"></el-input>
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
        <el-button type="primary" @click="() => store('game_object_template_locales')">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { flags } from "../locales/gameObject";

import { mapState, mapActions } from "vuex";

import FlagEditor from "@/components/FlagEditor";

export default {
  data() {
    return {
      loading: false,
      min: 0,
      isCreating: true,
      localeDialogVisible: false,
      flags: flags
    };
  },
  computed: {
    ...mapState("gameObject", [
      "gameObjectTemplate",
      "gameObjectTemplateLocales",
      "gameObjectTemplateAddon",
      "gameObjectQuestItems",
      "gameObjectLootTemplates"
    ]),
    localeName() {
      if (this.gameObjectTemplateLocales.length > 0) {
        let name = undefined;
        for (let gameObjectTemplateLocale of this.gameObjectTemplateLocales) {
          if (gameObjectTemplateLocale.locale === "zhCN") {
            name = gameObjectTemplateLocale.name;
          }
        }
        return name !== undefined ? name : this.gameObjectTemplate.name;
      } else {
        return this.gameObjectTemplate.name;
      }
    },
    localeDescription() {
      return null;
    },
    disabled() {
      return !this.isCreating;
    }
  },
  methods: {
    ...mapActions("gameObject", [
      "storeGameObjectTemplate",
      "findGameObjectTemplate",
      "updateGameObjectTemplate",
      "createGameObjectTemplate",
      "searchGameObjectTemplateLocales",
      "storeGameObjectTemplateLocales",
      "storeGameObjectTemplateAddon",
      "findGameObjectTemplateAddon",
      "updateGameObjectTemplateAddon",
      "searchGameObjectQuestItems",
      "searchGameObjectLootTemplates"
    ]),
    async switchover(tab) {
      this.loading = true;
      switch (tab.name) {
        case "game_object_template_addon":
          await this.findGameObjectTemplateAddon({ entry: this.gameObjectTemplate.entry });
          break;
        case "game_object_quest_item":
          await this.searchGameObjectQuestItems({ GameObjectEntry: this.gameObjectTemplate.entry });
          break;
        case "game_object_loot_template":
          await this.searchGameObjectLootTemplates({ Entry: this.gameObjectTemplate.entry });
          break;
        default:
          break;
      }
      this.loading = false;
    },
    showDialog() {
      this.localeDialogVisible = true;
    },
    addGameObjectTemplateLocale() {
      this.gameObjectTemplateLocales.push({
        entry: this.gameObjectTemplate.entry,
        VerifiedBuild: 0
      });
    },
    deleteGameObjectTemplateLocale(index) {
      this.gameObjectTemplateLocales.splice(index, 1);
    },
    closeDialog() {
      this.localeDialogVisible = false;
    },
    store(module) {
      switch (module) {
        case "game_object_template":
          this.loading = true;
          if (this.isCreating) {
            this.storeGameObjectTemplate(this.gameObjectTemplate);
          } else {
            this.updateGameObjectTemplate(this.gameObjectTemplate);
          }
          this.loading = false;
          break;
        case "game_object_template_locales":
          this.storeGameObjectTemplateLocales(this.gameObjectTemplateLocales).then(() => {
            this.localeDialogVisible = false;
          });
          break;
        case "game_object_template_addon":
          if (this.gameObjectTemplateAddon.entry == undefined) {
            this.gameObjectTemplateAddon.entry = this.gameObjectTemplate.entry;
            this.storeGameObjectTemplateAddon(this.gameObjectTemplateAddon).then(() => {});
          } else {
            this.updateGameObjectTemplateAddon(this.gameObjectTemplateAddon).then(() => {});
          }
          break;
        default:
          break;
      }
    },
    cancle() {
      this.$router.go(-1);
    },
    async init() {
      this.loading = true;
      let id = this.$route.params.id;
      let path = this.$route.path;
      if (path === "/game-object/create") {
        await this.createGameObjectTemplate();
      } else {
        this.isCreating = false;
        await Promise.all([
          this.findGameObjectTemplate({ entry: id }),
          this.searchGameObjectTemplateLocales({ entry: id })
        ]);
      }
      this.loading = false;
    }
  },
  created() {
    this.init();
  },
  components: {
    "flag-editor": FlagEditor
  }
};
</script>
