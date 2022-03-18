<template>
  <el-form
    :model="achievementCriteria"
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
                v-model="achievementCriteria.ID"
                controls-position="right"
                placeholder="ID"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="成就">
              <el-input-number
                v-model="achievementCriteria.Achievement_Id"
                controls-position="right"
                placeholder="Achievement_Id"
                :disabled="initing"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="描述">
              <el-input
                v-model="achievementCriteria.Description_Lang_zhCN"
                placeholder="Description_Lang_zhCN"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="描述掩码">
              <el-input-number
                v-model="achievementCriteria.Description_Lang_Mask"
                controls-position="right"
                placeholder="Description_Lang_Mask"
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
            <el-form-item label="类别">
              <el-input
                v-model="achievementCriteria.Type"
                placeholder="Type"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="标识">
              <el-input-number
                v-model="achievementCriteria.Flags"
                controls-position="right"
                placeholder="Flags"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="顺序">
              <el-input-number
                v-model="achievementCriteria.Ui_Order"
                controls-position="right"
                placeholder="Ui_Order"
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
            <el-form-item label="物品">
              <item-template-selector
                v-model="achievementCriteria.Asset_Id"
                placeholder="Asset_Id"
              ></item-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="数量">
              <el-input-number
                v-model="achievementCriteria.Quantity"
                controls-position="right"
                placeholder="Quantity"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="开始事件">
              <el-input
                v-model="achievementCriteria.Start_Event"
                placeholder="Start_Event"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Start_Asset">
              <el-input
                v-model="achievementCriteria.Start_Asset"
                placeholder="Start_Asset"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="失败事件">
              <el-input
                v-model="achievementCriteria.Fail_Event"
                placeholder="Fail_Event"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Fail_Asset">
              <el-input
                v-model="achievementCriteria.Fail_Asset"
                placeholder="Fail_Asset"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Timer_Start_Event">
              <el-input-number
                v-model="achievementCriteria.Timer_Start_Event"
                controls-position="right"
                placeholder="Timer_Start_Event"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Timer_Asset_Id">
              <el-input-number
                v-model="achievementCriteria.Timer_Asset_Id"
                controls-position="right"
                placeholder="Timer_Asset_Id"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Timer_Time">
              <el-input-number
                v-model="achievementCriteria.Timer_Time"
                controls-position="right"
                placeholder="Timer_Time"
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
import ItemTemplateSelector from "@/components/ItemTemplateSelector";
import WaypointDataSelector from "@/components/WaypointDataSelector.vue";

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
    ...mapState("achievementCriteria", ["achievementCriteria"]),
    credential() {
      return {
        ID: this.achievementCriteria.ID,
      };
    },
  },
  methods: {
    ...mapActions("achievementCriteria", [
      "storeAchievementCriteria",
      "findAchievementCriteria",
      "updateAchievementCriteria",
      "createAchievementCriteria",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeAchievementCriteria(this.achievementCriteria);
          this.$notify({
            title: "保存成功",
            position: "top-right",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateAchievementCriteria({
            credential: this.credential,
            achievementCriteria: this.achievementCriteria,
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
      await this.findAchievementCriteria({
        Achievement_Id: this.achievement.ID,
      });
      if (this.achievementCriteria.ID == undefined) {
        this.creating = true;
        await this.createAchievementCriteria({
          Achievement_Id: this.achievement.ID,
        });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { ItemTemplateSelector, WaypointDataSelector },
};
</script>
