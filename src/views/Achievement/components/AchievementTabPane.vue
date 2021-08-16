<template>
  <el-form :model="achievement" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="achievement.ID"
                controls-position="right"
                placeholder="ID"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="名称">
              <el-input
                v-model="achievement.Title_Lang_zhCN"
                placeholder="Title_Lang_zhCN"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="描述">
              <el-input
                v-model="achievement.Description_Lang_zhCN"
                placeholder="Description_Lang_zhCN"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="奖励">
              <el-input
                v-model="achievement.Reward_Lang_zhCN"
                placeholder="Reward_Lang_zhCN"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="名称掩码">
              <el-input
                v-model="achievement.Title_Lang_Mask"
                placeholder="Title_Lang_Mask"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="描述掩码">
              <el-input
                v-model="achievement.Description_Lang_Mask"
                placeholder="Description_Lang_Mask"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="奖励掩码">
              <el-input
                v-model="achievement.Reward_Lang_Mask"
                placeholder="Reward_Lang_Mask"
              ></el-input>
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
            <el-form-item label="Faction">
              <el-input v-model="achievement.Faction" placeholder="Faction">
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Instance_Id">
              <el-input
                v-model="achievement.Instance_Id"
                placeholder="Instance_Id"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Supercedes">
              <el-input
                v-model="achievement.Supercedes"
                placeholder="Supercedes"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="分类">
              <achievement-category-selector
                v-model="achievement.Category"
                placeholder="Category"
              >
              </achievement-category-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="成就点数">
              <el-input-number
                v-model="achievement.Points"
                controls-position="right"
                placeholder="Points"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Ui_Order">
              <el-input v-model="achievement.Ui_Order" placeholder="Ui_Order">
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="标识">
              <el-input v-model="achievement.Flags" placeholder="Flags">
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="图标">
              <spell-icon-selector
                v-model="achievement.IconID"
                placeholder="IconID"
              >
              </spell-icon-selector>
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
            <el-form-item label="Minimum_Criteria">
              <el-input
                v-model="achievement.Minimum_Criteria"
                placeholder="Minimum_Criteria"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Shares_Criteria">
              <el-input
                v-model="achievement.Shares_Criteria"
                placeholder="Shares_Criteria"
              >
              </el-input>
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
import AchievementCategorySelector from "@/components/AchievementCategorySelector";
import SpellIconSelector from "@/components/SpellIconSelector";
import { mapActions, mapState } from "vuex";

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
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("achievement", [
      "storeAchievement",
      "findAchievement",
      "updateAchievement",
      "createAchievement",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeAchievement(this.achievement);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateAchievement({
          credential: this.credential,
          achievement: this.achievement,
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
      if (this.$route.path == "/achievement/create") {
        this.creating = true;
        await Promise.all([this.createAchievement()]);
      } else {
        await this.findAchievement(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    AchievementCategorySelector,
    SpellIconSelector,
  },
};
</script>
