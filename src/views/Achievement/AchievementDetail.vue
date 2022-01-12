<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/advance' }">
          高级
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/achievement' }">
          成就管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>成就详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="achievement" style="margin-top: 16px">
      <el-tab-pane label="成就" name="achievement" lazy>
        <achievement-tab-pane></achievement-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="分类" name="achievement_category" lazy>
        <achievement-category-tab-pane></achievement-category-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="标准" name="achievement-criteria" lazy>
        <achievement-criteria-tab-pane></achievement-criteria-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="标准数据" name="achievement-criteria-data" lazy>
        <achievement-criteria-data-tab-pane></achievement-criteria-data-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import AchievementTabPane from "@/views/Achievement/components/AchievementTabPane";
import AchievementCategoryTabPane from "@/views/Achievement/components/AchievementCategoryTabPane";
import AchievementCriteriaDataTabPane from "@/views/Achievement/components/AchievementCriteriaDataTabPane";
import AchievementCriteriaTabPane from "@/views/Achievement/components/AchievementCriteriaTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("achievement", ["achievement"]),
    localeName() {
      return this.achievement.Title_Lang_zhCN;
    },
    localeDescription() {
      return this.achievement.Description_Lang_zhCN;
    },
  },
  components: {
    AchievementTabPane,
    AchievementCategoryTabPane,
    AchievementCriteriaDataTabPane,
    AchievementCriteriaTabPane,
  },
};
</script>
