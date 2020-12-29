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
    <el-card style="margin-top: 16px;">
      <el-tabs value="game_object_template" style="margin-top: 16px">
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
                    <el-input v-model="gameObjectTemplate.name" placeholder="name"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="type">
                    <el-input v-model="gameObjectTemplate.type" placeholder="type"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="displayId">
                    <el-input v-model="gameObjectTemplate.displayId" placeholder="displayId"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="IconName">
                    <el-input v-model="gameObjectTemplate.IconName" placeholder="IconName"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="castBarCaption">
                    <el-input v-model="gameObjectTemplate.castBarCaption" placeholder="castBarCaption"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="unk1">
                    <el-input v-model="gameObjectTemplate.unk1" placeholder="unk1"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="size">
                    <el-input v-model="gameObjectTemplate.size" placeholder="size"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="AIName">
                    <el-input v-model="gameObjectTemplate.AIName" placeholder="AIName"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ScriptName">
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
                    <el-input v-model="gameObjectTemplateAddon.entry" placeholder="entry"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="faction">
                    <el-input v-model="gameObjectTemplateAddon.faction" placeholder="faction"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="flags">
                    <el-input v-model="gameObjectTemplateAddon.flags" placeholder="flags"></el-input>
                  </el-form-item>
                </el-col>
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
              <el-table-column prop="GameObjectEntry" label="ID"></el-table-column>
              <el-table-column prop="Idx" label="序号"></el-table-column>
              <el-table-column prop="ItemId" label="物品"></el-table-column>
              <el-table-column prop="VerifiedBuild" label="VerifiedBuild"></el-table-column>
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
              <el-table-column prop="Entry" label="ID"></el-table-column>
              <el-table-column prop="Item" label="物品"></el-table-column>
              <el-table-column prop="Reference" label="关联"></el-table-column>
              <el-table-column prop="Chance" label="几率"></el-table-column>
              <el-table-column prop="QuestRequired" label="需要任务"></el-table-column>
              <el-table-column prop="LootMode" label="掉落模式"></el-table-column>
              <el-table-column prop="GroupId" label="组"></el-table-column>
              <el-table-column prop="MinCount" label="最小数量"></el-table-column>
              <el-table-column prop="MaxCount" label="最大数量"></el-table-column>
              <el-table-column prop="Comment" label="Comment"></el-table-column>
            </el-table>
          </el-card>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      loading: false,
      min: 0,
      isCreating: true
    };
  },
  computed: {
    ...mapState("gameObject", [
      "gameObjectTemplate",
      "gameObjectTemplateAddon",
      "gameObjectQuestItems",
      "gameObjectLootTemplates"
    ]),
    localeName() {
      return this.gameObjectTemplate.name;
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
      "createGameObjectTemplate"
    ]),
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
        await Promise.all([this.findGameObjectTemplate({ entry: id })]);
      }
      this.loading = false;
    }
  },
  created() {
    this.init();
  }
};
</script>
