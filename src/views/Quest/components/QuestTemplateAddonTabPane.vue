<template>
  <el-form
    :model="questTemplateAddon"
    label-position="right"
    label-width="120px"
  >
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
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
          <el-form-item label="最高等级">
            <el-input-number
              v-model="questTemplateAddon.MaxLevel"
              controls-position="right"
              placeholder="MaxLevel"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="允许职业">
            <flag-editor
              title="允许职业编辑器"
              v-model="questTemplate.AllowableClasses"
              :flags="allowableClasses"
              placeholder="AllowableClasses"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="施放法术">
            <el-input
              v-model="questTemplateAddon.SourceSpellID"
              placeholder="SourceSpellID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="前置任务">
            <quest-template-selector
              v-model="questTemplateAddon.PrevQuestID"
              placeholder="PrevQuestID"
            ></quest-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="后续任务">
            <quest-template-selector
              v-model="questTemplateAddon.NextQuestID"
              placeholder="NextQuestID"
            ></quest-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="特殊标识">
            <el-input
              v-model="questTemplateAddon.SpecialFlags"
              placeholder="SpecialFlags"
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
          <el-form-item label="提供物品数量">
            <el-input-number
              v-model="questTemplateAddon.ProvidedItemCount"
              controls-position="right"
              placeholder="ProvidedItemCount"
            ></el-input-number>
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
          <el-form-item label="需要最低声望">
            <el-input
              v-model="questTemplateAddon.RequiredMinRepFaction"
              placeholder="RequiredMinRepFaction"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="声望值">
            <el-input-number
              v-model="questTemplateAddon.RequiredMinRepValue"
              controls-position="right"
              placeholder="RequiredMinRepValue"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要最高声望">
            <el-input
              v-model="questTemplateAddon.RequiredMaxRepFaction"
              placeholder="RequiredMaxRepFaction"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="声望值">
            <el-input-number
              v-model="questTemplateAddon.RequiredMaxRepValue"
              controls-position="right"
              placeholder="RequiredMaxRepValue"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要技能">
            <el-input
              v-model="questTemplateAddon.RequiredSkillID"
              placeholder="RequiredSkillID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要熟练度">
            <el-input-number
              v-model="questTemplateAddon.RequiredSkillPoints"
              controls-position="right"
              placeholder="RequiredSkillPoints"
            ></el-input-number>
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
          <el-form-item label="邮件奖励">
            <el-input
              v-model="questTemplateAddon.RewardMailTemplateID"
              placeholder="RewardMailTemplateID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励延迟">
            <el-input-number
              v-model="questTemplateAddon.RewardMailDelay"
              controls-position="right"
              placeholder="RewardMailDelay"
            ></el-input-number>
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
import FlagEditor from "@/components/FlagEditor";
import QuestTemplateSelector from "@/components/QuestTemplateSelector";
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
    ...mapState("initiator", ["chrClasses"]),
    ...mapState("questTemplate", ["questTemplate"]),
    ...mapState("questTemplateAddon", ["questTemplateAddon"]),
    credential() {
      return {
        ID: this.questTemplate.ID,
      };
    },
    allowableClasses() {
      return this.chrClasses.map((chrClass) => {
        return {
          index: chrClass.ID,
          flag: Math.pow(2, chrClass.ID - 1),
          name: chrClass.Name_Lang_zhCN,
          comment: chrClass.Filename, // 不知道为什么变成了Filename，原field应该是FileName
        };
      });
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
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateQuestTemplateAddon({
          credential: this.credential,
          questTemplateAddon: this.questTemplateAddon,
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
  components: {
    FlagEditor,
    QuestTemplateSelector,
  },
};
</script>
