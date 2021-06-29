<template>
  <el-form :model="questOfferReward" label-position="right" label-width="120px">
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="questOfferReward.ID"
              controls-position="right"
              :loading="initing"
              placeholder="ID"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励文本">
            <el-input
              v-model="questOfferReward.RewardText"
              placeholder="RewardText"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="VerifiedBuild">
            <el-input
              v-model="questOfferReward.VerifiedBuild"
              placeholder="VerifiedBuild"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="表情">
            <emote-selector
              v-model="questOfferReward.Emote1"
              placeholder="Emote1"
            ></emote-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="表情">
            <emote-selector
              v-model="questOfferReward.Emote2"
              placeholder="Emote2"
            ></emote-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="表情">
            <emote-selector
              v-model="questOfferReward.Emote3"
              placeholder="Emote3"
            ></emote-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="表情">
            <emote-selector
              v-model="questOfferReward.Emote4"
              placeholder="Emote4"
            ></emote-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="延迟">
            <el-input-number
              v-model="questOfferReward.EmoteDelay1"
              controls-position="right"
              placeholder="EmoteDelay1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="延迟">
            <el-input-number
              v-model="questOfferReward.EmoteDelay2"
              controls-position="right"
              placeholder="EmoteDelay2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="延迟">
            <el-input-number
              v-model="questOfferReward.EmoteDelay3"
              controls-position="right"
              placeholder="EmoteDelay3"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="延迟">
            <el-input-number
              v-model="questOfferReward.EmoteDelay4"
              controls-position="right"
              placeholder="EmoteDelay4"
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
import { mapState, mapActions } from "vuex";
import EmoteSelector from "@/components/EmoteSelector.vue";

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
    ...mapState("questOfferReward", ["questOfferReward"]),
    credential() {
      return {
        ID: this.questTemplate.ID,
      };
    },
  },
  methods: {
    ...mapActions("questOfferReward", [
      "storeQuestOfferReward",
      "findQuestOfferReward",
      "updateQuestOfferReward",
      "createQuestOfferReward",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeQuestOfferReward(this.questOfferReward);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateQuestOfferReward({
          credential: this.credential,
          questOfferReward: this.questOfferReward,
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
      await this.findQuestOfferReward(this.credential);
      if (this.questOfferReward.ID == undefined) {
        this.creating = true;
        await this.createQuestOfferReward(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { EmoteSelector },
};
</script>

Emo EmoteSelector EmoteSelectorteSelector
