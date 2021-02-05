<template>
  <el-form
    :model="gameObjectTemplate"
    label-position="right"
    label-width="120px"
  >
    <el-card style="margin-top: 16px">
      <el-row :gutter="24">
        <el-col :span="6">
          <el-form-item label="ID">
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
            <game-object-template-localizer
              v-model="gameObjectTemplate.name"
              placeholder="name"
            ></game-object-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="使用文字">
            <game-object-template-localizer
              v-model="gameObjectTemplate.castBarCaption"
              placeholder="castBarCaption"
            ></game-object-template-localizer>
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
            <el-input
              v-model="gameObjectTemplate.type"
              placeholder="type"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="外观">
            <el-input-number
              v-model="gameObjectTemplate.displayId"
              controls-position="right"
              placeholder="displayId"
            ></el-input-number>
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
    <el-card style="margin-top: 16px">
      <el-row :gutter="24">
        <el-col :span="6">
          <el-form-item label="Data0">
            <el-input
              v-model="gameObjectTemplate.Data0"
              placeholder="Data0"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data1">
            <el-input
              v-model="gameObjectTemplate.Data1"
              placeholder="Data1"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data2">
            <el-input
              v-model="gameObjectTemplate.Data2"
              placeholder="Data2"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data3">
            <el-input
              v-model="gameObjectTemplate.Data3"
              placeholder="Data3"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data4">
            <el-input
              v-model="gameObjectTemplate.Data4"
              placeholder="Data4"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data5">
            <el-input
              v-model="gameObjectTemplate.Data5"
              placeholder="Data5"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data6">
            <el-input
              v-model="gameObjectTemplate.Data6"
              placeholder="Data6"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data7">
            <el-input
              v-model="gameObjectTemplate.Data7"
              placeholder="Data7"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data8">
            <el-input
              v-model="gameObjectTemplate.Data8"
              placeholder="Data8"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data9">
            <el-input
              v-model="gameObjectTemplate.Data9"
              placeholder="Data9"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data10">
            <el-input
              v-model="gameObjectTemplate.Data10"
              placeholder="Data10"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data11">
            <el-input
              v-model="gameObjectTemplate.Data11"
              placeholder="Data11"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data12">
            <el-input
              v-model="gameObjectTemplate.Data12"
              placeholder="Data12"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data13">
            <el-input
              v-model="gameObjectTemplate.Data13"
              placeholder="Data13"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data14">
            <el-input
              v-model="gameObjectTemplate.Data14"
              placeholder="Data14"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data15">
            <el-input
              v-model="gameObjectTemplate.Data15"
              placeholder="Data15"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data16">
            <el-input
              v-model="gameObjectTemplate.Data16"
              placeholder="Data16"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data17">
            <el-input
              v-model="gameObjectTemplate.Data17"
              placeholder="Data17"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data18">
            <el-input
              v-model="gameObjectTemplate.Data18"
              placeholder="Data18"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data19">
            <el-input
              v-model="gameObjectTemplate.Data19"
              placeholder="Data19"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data20">
            <el-input
              v-model="gameObjectTemplate.Data20"
              placeholder="Data20"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data21">
            <el-input
              v-model="gameObjectTemplate.Data21"
              placeholder="Data21"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data22">
            <el-input
              v-model="gameObjectTemplate.Data22"
              placeholder="Data22"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Data23">
            <el-input
              v-model="gameObjectTemplate.Data23"
              placeholder="Data23"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="24">
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
            <el-input
              v-model="gameObjectTemplate.VerifiedBuild"
              placeholder="VerifiedBuild"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-button type="primary" :loading="loading" @click="store">
        保存
      </el-button>
      <el-button @click="cancel">返回</el-button>
    </el-card>
  </el-form>
</template>

<script>
import GameObjectTemplateLocalizer from "@/views/GameObject/components/GameObjectTemplateLocalizer";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("gameObjectTemplate", ["gameObjectTemplate"]),
    ...mapState("gameObjectTemplateLocale", ["gameObjectTemplateLocales"]),
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
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeGameObjectTemplate(this.gameObjectTemplate);
        this.creating = false;
      } else {
        await this.updateGameObjectTemplate({
          credential: this.credential,
          gameObjectTemplate: this.gameObjectTemplate,
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
  components: { GameObjectTemplateLocalizer },
};
</script>
