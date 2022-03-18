<template>
  <el-form
    :model="achievementReward"
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
                v-model="achievementReward.ID"
                controls-position="right"
                placeholder="ID"
                :disabled="initing"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="联盟称号">
              <char-title-selector
                v-model="achievementReward.TitleA"
                placeholder="TitleA"
              />
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="部落称号">
              <char-title-selector
                v-model="achievementReward.TitleH"
                placeholder="TitleA"
              />
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
            <el-form-item label="邮件模板">
              <el-input-number
                v-model="achievementReward.MailTemplateID"
                controls-position="right"
                placeholder="MailTemplateID"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="发件人">
              <creature-template-selector
                v-model="achievementReward.Sender"
                placeholder="Sender"
              ></creature-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="主题">
              <achievement-reward-subject-localizer
                v-model="achievementReward.Subject"
                placeholder="Subject"
              />
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="内容">
              <achievement-reward-body-localizer
                v-model="achievementReward.Body"
                placeholder="Body"
              />
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="物品">
              <item-template-selector
                v-model="achievementReward.ItemID"
                placeholder="ItemID"
              />
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
import CharTitleSelector from "@/components/CharTitleSelector";
import CreatureTemplateSelector from "@/components/CreatureTemplateSelector";
import ItemTemplateSelector from "@/components/ItemTemplateSelector";
import AchievementRewardSubjectLocalizer from "./AchievementRewardSubjectLocalizer.vue";
import AchievementRewardBodyLocalizer from "./AchievementRewardBodyLocalizer.vue";

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
    ...mapState("achievement", ["achievement"]),
    ...mapState("achievementReward", ["achievementReward"]),
    credential() {
      return {
        ID: this.achievementReward.ID,
      };
    },
  },
  methods: {
    ...mapActions("achievementReward", [
      "storeAchievementReward",
      "findAchievementReward",
      "updateAchievementReward",
      "createAchievementReward",
    ]),
    ...mapActions("achievementRewardLocale", [
      "searchAchievementRewardLocales",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeAchievementReward(this.achievementReward);
          this.$notify({
            title: "保存成功",
            position: "top-right",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateAchievementReward({
            credential: this.credential,
            achievementReward: this.achievementReward,
          });
          this.$notify({
            title: "修改成功",
            position: "top-right",
            type: "success",
          });
        }
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      let payload = {
        ID: this.achievement.ID,
      };
      await Promise.all([
        this.findAchievementReward(payload),
        this.searchAchievementRewardLocales(payload),
      ]);
      await this.findAchievementReward({
        ID: this.achievement.ID,
      });
      await this.searchAchievementRewardLocales({
        ID: this.achievement.ID,
      });
      if (this.achievementReward.ID == undefined) {
        this.creating = true;
        await this.createAchievementReward({
          ID: this.achievement.ID,
        });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    AchievementRewardSubjectLocalizer,
    AchievementRewardBodyLocalizer,
    CharTitleSelector,
    CreatureTemplateSelector,
    ItemTemplateSelector,
  },
};
</script>
