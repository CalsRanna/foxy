<template>
  <el-form
    :model="questTemplateAddon"
    label-position="right"
    label-width="120px"
  >
    <el-card style="margin-top: 16px">
      <el-row :gutter="24">
        <el-col :span="6">
          <el-form-item label="ID">
            <el-input-number
              v-model="questTemplateAddon.ID"
              controls-position="right"
              :loading="initing"
              placeholder="ID"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="MaxLevel">
            <el-input
              v-model="questTemplateAddon.MaxLevel"
              placeholder="MaxLevel"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="AllowableClasses">
            <el-input
              v-model="questTemplateAddon.AllowableClasses"
              placeholder="AllowableClasses"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SourceSpellID">
            <el-input
              v-model="questTemplateAddon.SourceSpellID"
              placeholder="SourceSpellID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="PrevQuestID">
            <el-input
              v-model="questTemplateAddon.PrevQuestID"
              placeholder="PrevQuestID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="NextQuestID">
            <el-input
              v-model="questTemplateAddon.NextQuestID"
              placeholder="NextQuestID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="ExclusiveGroup">
            <el-input
              v-model="questTemplateAddon.ExclusiveGroup"
              placeholder="ExclusiveGroup"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RewardMailTemplateID">
            <el-input
              v-model="questTemplateAddon.RewardMailTemplateID"
              placeholder="RewardMailTemplateID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RewardMailDelay">
            <el-input
              v-model="questTemplateAddon.RewardMailDelay"
              placeholder="RewardMailDelay"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RequiredSkillID">
            <el-input
              v-model="questTemplateAddon.RequiredSkillID"
              placeholder="RequiredSkillID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RequiredSkillPoints">
            <el-input
              v-model="questTemplateAddon.RequiredSkillPoints"
              placeholder="RequiredSkillPoints"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RequiredMinRepFaction">
            <el-input
              v-model="questTemplateAddon.RequiredMinRepFaction"
              placeholder="RequiredMinRepFaction"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RequiredMaxRepFaction">
            <el-input
              v-model="questTemplateAddon.RequiredMaxRepFaction"
              placeholder="RequiredMaxRepFaction"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RequiredMinRepValue">
            <el-input
              v-model="questTemplateAddon.RequiredMinRepValue"
              placeholder="RequiredMinRepValue"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RequiredMaxRepValue">
            <el-input
              v-model="questTemplateAddon.RequiredMaxRepValue"
              placeholder="RequiredMaxRepValue"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="ProvidedItemCount">
            <el-input
              v-model="questTemplateAddon.ProvidedItemCount"
              placeholder="ProvidedItemCount"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SpecialFlags">
            <el-input
              v-model="questTemplateAddon.SpecialFlags"
              placeholder="SpecialFlags"
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
    ...mapState("questTemplate", ["questTemplate"]),
    ...mapState("questTemplateAddon", ["questTemplateAddon"]),
    credential() {
      return {
        ID: this.questTemplate.ID,
      };
    },
  },
  methods: {
    ...mapActions("questTemplateAddon", [
      "storeQuestTemplateAddon",
      "findQuestTemplateAddon",
      "updateQuestTemplateAddon",
      "createQuestTemplateAddon",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeQuestTemplateAddon(this.questTemplateAddon);
        this.creating = false;
      } else {
        await this.updateQuestTemplateAddon({
          credential: this.credential,
          questTemplateAddon: this.questTemplateAddon,
        });
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      await this.findQuestTemplateAddon(this.credential);
      if (this.questTemplateAddon.ID == undefined) {
        this.creating = true;
        await this.createQuestTemplateAddon(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
