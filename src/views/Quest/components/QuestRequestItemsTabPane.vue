<template>
  <el-form :model="questRequestItems" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card :body-style="{ padding: '22px 20px 0 20px' }" style="margin-top: 1px">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
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
            <el-form-item label="完成文本">
              <quest-request-items-localizer
                v-model="questRequestItems.CompletionText"
                placeholder="CompletionText"
              ></quest-request-items-localizer>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="VerifiedBuild">
              <el-input-number
                v-model="questRequestItems.VerifiedBuild"
                controls-position="right"
                placeholder="VerifiedBuild"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="6">
            <el-form-item label="完成表情">
              <el-input v-model="questRequestItems.EmoteOnComplete" placeholder="EmoteOnComplete"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="未完成表情">
              <el-input
                v-model="questRequestItems.EmoteOnIncomplete"
                placeholder="EmoteOnIncomplete"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>
    </div>
    <el-card style="margin-top: 16px">
      <el-button type="primary" :loading="loading" @click="store">保存</el-button>
      <el-button @click="cancel">返回</el-button>
    </el-card>
  </el-form>
</template>

<script>
import QuestRequestItemsLocalizer from "./QuestRequestItemsLocalizer.vue";
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
    ...mapState("app", ["clientHeight"]),
    ...mapState("questTemplate", ["questTemplate"]),
    ...mapState("questRequestItems", ["questRequestItems"]),
    ...mapState("questRequestItemsLocale", ["questRequestItemsLocale"]),
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
    ...mapActions("questRequestItemsLocale", ["searchQuestRequestItemsLocales"]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeQuestRequestItems(this.questRequestItems);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateQuestRequestItems({
          credential: this.credential,
          questRequestItems: this.questRequestItems,
        });
        this.$notify({
          title: "修改成功",
          position: "top-right",
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
      await Promise.all([
        this.findQuestRequestItems(this.credential),
        this.searchQuestRequestItemsLocales(this.credential),
      ]);
      if (this.questRequestItems.ID == undefined) {
        this.creating = true;
        await Promise.all([
          this.createQuestRequestItems(this.credential),
          this.searchQuestRequestItemsLocales({ ID: 0 }),
        ]);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    QuestRequestItemsLocalizer
  }
};
</script>
