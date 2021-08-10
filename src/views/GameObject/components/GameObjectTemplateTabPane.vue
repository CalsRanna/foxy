<template>
  <el-form
    :model="gameObjectTemplate"
    label-position="right"
    label-width="120px"
  >
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="gameObjectTemplate.entry"
                controls-position="right"
                placeholder="entry"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="名称">
              <game-object-template-name-localizer
                v-model="gameObjectTemplate.name"
                placeholder="name"
              ></game-object-template-name-localizer>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="使用说明">
              <game-object-template-cast-bar-caption-localizer
                v-model="gameObjectTemplate.castBarCaption"
                placeholder="castBarCaption"
              ></game-object-template-cast-bar-caption-localizer>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="鼠标形状">
              <el-input
                v-model="gameObjectTemplate.IconName"
                placeholder="IconName"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="类型">
              <el-select
                v-model="gameObjectTemplate.type"
                filterable
                placeholder="type"
              >
                <el-option
                  v-for="(type, index) in types"
                  :value="index"
                  :label="type"
                  :key="`type-${index}`"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="外观">
              <game-object-display-info-selector
                v-model="gameObjectTemplate.displayId"
                placeholder="displayId"
              ></game-object-display-info-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="尺寸">
              <el-input-number
                v-model="gameObjectTemplate.size"
                controls-position="right"
                placeholder="size"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="unk1">
              <el-input
                v-model="gameObjectTemplate.unk1"
                placeholder="unk1"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>
      <el-card style="margin-top: 16px" v-if="matchedDatas.length > 0">
        <el-row :gutter="16">
          <el-col
            :span="6"
            v-for="(data, index) in matchedDatas"
            :key="`el-col-data-${index}`"
          >
            <el-form-item :label="data.label">
              <el-switch
                v-model="gameObjectTemplate[data.field]"
                :active-value="1"
                :inactive-value="0"
                v-if="data.type === 'el-switch'"
              ></el-switch>
              <el-input-number
                v-model="gameObjectTemplate[data.field]"
                controls-position="right"
                :placeholder="data.field"
                v-else-if="data.type === 'el-input-number'"
              ></el-input-number>
              <lock-selector
                v-model="gameObjectTemplate[data.field]"
                :placeholder="data.field"
                v-else-if="data.type === 'lock-selector'"
              ></lock-selector>
              <spell-selector
                v-model="gameObjectTemplate[data.field]"
                :placeholder="data.field"
                v-else-if="data.type === 'spell-selector'"
              ></spell-selector>
              <el-input
                v-model="gameObjectTemplate[data.field]"
                :placeholder="data.field"
                v-else
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 16px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="AI名称">
              <el-input
                v-model="gameObjectTemplate.AIName"
                placeholder="AIName"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="脚本名称">
              <el-input
                v-model="gameObjectTemplate.ScriptName"
                placeholder="ScriptName"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="VerifiedBuild">
              <el-input-number
                v-model="gameObjectTemplate.VerifiedBuild"
                controls-position="right"
                placeholder="VerifiedBuild"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>
    </div>
    <el-card style="margin-top: 16px">
      <el-button type="primary" :loading="loading" @click="store">
        保存
      </el-button>
      <el-button @click="cancel">返回</el-button>
    </el-card>
  </el-form>
</template>

<script>
import { mapState, mapActions } from "vuex";
import { types, datas } from "@/locales/gameObject";
import GameObjectDisplayInfoSelector from "@/components/GameObjectDisplayInfoSelector.vue";
import GameObjectTemplateCastBarCaptionLocalizer from "@/views/GameObject/components/GameObjectTemplateCastBarCaptionLocalizer";
import GameObjectTemplateNameLocalizer from "@/views/GameObject/components/GameObjectTemplateNameLocalizer";
import LockSelector from "@/components/LockSelector";
import SpellSelector from "@/components/SpellSelector";

export default {
  data() {
    return {
      types: types,
      datas: datas,
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("gameObjectTemplate", ["gameObjectTemplate"]),
    ...mapState("gameObjectTemplateLocale", ["gameObjectTemplateLocales"]),
    matchedDatas() {
      return this.gameObjectTemplate.type >= 0
        ? this.datas[this.gameObjectTemplate.type]
        : this.datas[0];
    },
    credential() {
      return {
        entry: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("gameObjectTemplate", [
      "storeGameObjectTemplate",
      "findGameObjectTemplate",
      "updateGameObjectTemplate",
      "createGameObjectTemplate",
    ]),
    ...mapActions("gameObjectTemplateLocale", [
      "searchGameObjectTemplateLocales",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeGameObjectTemplate(this.gameObjectTemplate);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateGameObjectTemplate({
          credential: this.credential,
          gameObjectTemplate: this.gameObjectTemplate,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      if (this.$route.path == "/game-object/create") {
        this.creating = true;
        await Promise.all([
          this.createGameObjectTemplate(),
          this.searchGameObjectTemplateLocales({ entry: 0 }),
        ]);
      } else {
        await Promise.all([
          this.findGameObjectTemplate(this.credential),
          this.searchGameObjectTemplateLocales(this.credential),
        ]);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    GameObjectDisplayInfoSelector,
    GameObjectTemplateCastBarCaptionLocalizer,
    GameObjectTemplateNameLocalizer,
    LockSelector,
    SpellSelector,
  },
};
</script>
