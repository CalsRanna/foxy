<template>
  <el-form
    :model="questFactionReward"
    label-position="right"
    label-width="120px"
  >
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="questFactionReward.ID"
              controls-position="right"
              placeholder="ID"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="难度1">
            <el-input-number
              v-model="questFactionReward.Difficulty_1"
              controls-position="right"
              placeholder="Difficulty_1"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度2">
            <el-input-number
              v-model="questFactionReward.Difficulty_2"
              controls-position="right"
              placeholder="Difficulty_2"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度3">
            <el-input-number
              v-model="questFactionReward.Difficulty_3"
              controls-position="right"
              placeholder="Difficulty_3"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度4">
            <el-input-number
              v-model="questFactionReward.Difficulty_4"
              controls-position="right"
              placeholder="Difficulty_4"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度5">
            <el-input-number
              v-model="questFactionReward.Difficulty_5"
              controls-position="right"
              placeholder="Difficulty_5"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度6">
            <el-input-number
              v-model="questFactionReward.Difficulty_6"
              controls-position="right"
              placeholder="Difficulty_6"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度7">
            <el-input-number
              v-model="questFactionReward.Difficulty_7"
              controls-position="right"
              placeholder="Difficulty_7"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度8">
            <el-input-number
              v-model="questFactionReward.Difficulty_8"
              controls-position="right"
              placeholder="Difficulty_8"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度9">
            <el-input-number
              v-model="questFactionReward.Difficulty_9"
              controls-position="right"
              placeholder="Difficulty_9"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度10">
            <el-input-number
              v-model="questFactionReward.Difficulty_10"
              controls-position="right"
              placeholder="Difficulty_10"
            >
            </el-input-number>
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
    ...mapState("questFactionReward", ["questFactionReward"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("questFactionReward", [
      "storeQuestFactionReward",
      "findQuestFactionReward",
      "updateQuestFactionReward",
      "createQuestFactionReward",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeQuestFactionReward(this.questFactionReward);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateQuestFactionReward({
          credential: this.credential,
          questFactionReward: this.questFactionReward,
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
      if (this.$route.path == "/item-set/create") {
        this.creating = true;
        await Promise.all([this.createQuestFactionReward()]);
      } else {
        await this.findQuestFactionReward(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
