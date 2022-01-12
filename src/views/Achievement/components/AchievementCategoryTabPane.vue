<template>
  <el-form
    :model="achievementCategory"
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
            <el-form-item label="分类编号">
              <el-input-number
                v-model="achievementCategory.ID"
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
            <el-form-item label="父级编号">
              <achievement-category-selector
                v-model="achievementCategory.Parent"
                placeholder="Category"
              >
              </achievement-category-selector>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="名称">
              <el-input
                v-model="achievementCategory.Name_Lang_zhCN"
                placeholder="Name_Lang_zhCN"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="名称掩码">
              <el-input-number
                v-model="achievementCategory.Name_Lang_Mask"
                controls-position="right"
                placeholder="Name_Lang_Mask"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Ui Order">
              <el-input-number
                v-model="achievementCategory.Ui_Order"
                controls-position="right"
                placeholder="Ui_Order"
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
import AchievementCategorySelector from "@/components/AchievementCategorySelector";
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
    ...mapState("achievementCategory", ["achievementCategory"]),
    credential() {
      return {
        ID: this.achievementCategory.ID,
      };
    },
  },
  methods: {
    ...mapActions("achievementCategory", [
      "storeAchievementCategory",
      "findAchievementCategory",
      "updateAchievementCategory",
      "createAchievementCategory",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeAchievementCategory(this.achievementCategory);
          this.$notify({
            title: "保存成功",
            position: "top-right",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateAchievementCategory({
            credential: this.credential,
            achievementCategory: this.achievementCategory,
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
      await this.findAchievementCategory({
        ID: this.achievement.Category,
      });
      if (this.achievementCategory.ID == undefined) {
        this.creating = true;
        await this.createAchievementCategory({
          ID: this.achievement.Category,
        });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { AchievementCategorySelector, WaypointDataSelector },
};
</script>
