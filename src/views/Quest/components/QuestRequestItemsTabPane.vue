<template>
  <el-form
    :model="questRequestItems"
    label-position="right"
    label-width="120px"
  >
    <el-card style="margin-top: 16px">
      <el-row :gutter="24">
        <el-col :span="6">
          <el-form-item label="ID">
            <el-input-number
              v-model="questRequestItems.ID"
              controls-position="right"
              :loading="initing"
              placeholder="ID"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="EmoteOnComplete">
            <el-input
              v-model="questRequestItems.EmoteOnComplete"
              placeholder="EmoteOnComplete"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="EmoteOnIncomplete">
            <el-input
              v-model="questRequestItems.EmoteOnIncomplete"
              placeholder="EmoteOnIncomplete"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="CompletionText">
            <el-input
              v-model="questRequestItems.CompletionText"
              placeholder="CompletionText"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="VerifiedBuild">
            <el-input
              v-model="questRequestItems.VerifiedBuild"
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
    ...mapState("questRequestItems", ["questRequestItems"]),
    credential() {
      return {
        ID: this.questTemplate.ID,
      };
    },
  },
  methods: {
    ...mapActions("questRequestItems", [
      "storeQuestRequestItems",
      "findQuestRequestItems",
      "updateQuestRequestItems",
      "createQuestRequestItems",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeQuestRequestItems(this.questRequestItems);
        this.creating = false;
      } else {
        await this.updateQuestRequestItems({
          credential: this.credential,
          questRequestItems: this.questRequestItems,
        });
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      await this.findQuestRequestItems(this.credential);
      if (this.questRequestItems.ID == undefined) {
        this.creating = true;
        await this.createQuestRequestItems(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
