<template>
  <el-form :model="talentTab" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="talentTab.ID"
                controls-position="right"
                placeholder="ID"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="名称">
              <el-input
                v-model="talentTab.Name_Lang_zhCN"
                placeholder="Name_Lang_zhCN"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="名称掩码">
              <el-input-number
                v-model="talentTab.Name_Lang_Mask"
                controls-position="right"
                placeholder="Name_Lang_Mask"
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
            <el-form-item label="图标">
              <el-input-number
                v-model="talentTab.SpellIconID"
                controls-position="right"
                placeholder="SpellIconID"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="种族掩码">
              <el-input-number
                v-model="talentTab.RaceMask"
                controls-position="right"
                placeholder="RaceMask"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="职业掩码">
              <el-input-number
                v-model="talentTab.ClassMask"
                controls-position="right"
                placeholder="ClassMask"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="宠物天赋掩码">
              <el-input-number
                v-model="talentTab.PetTalentMask"
                controls-position="right"
                placeholder="PetTalentMask"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="权重">
              <el-input-number
                v-model="talentTab.OrderIndex"
                controls-position="right"
                placeholder="OrderIndex"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="背景图片">
              <el-input
                v-model="talentTab.BackgroundFile"
                placeholder="BackgroundFile"
              ></el-input>
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
    ...mapState("talent", ["talent"]),
    ...mapState("talentTab", ["talentTab"]),
    credential() {
      return {
        ID: this.talent.TabID,
      };
    },
  },
  methods: {
    ...mapActions("talentTab", [
      "storeTalentTab",
      "findTalentTab",
      "updateTalentTab",
      "createTalentTab",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeTalentTab(this.talentTab);
          this.$notify({
            title: "保存成功",
            position: "top-right",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateTalentTab({
            credential: this.credential,
            talentTab: this.talentTab,
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
      await this.findTalentTab({
        ID: this.talent.TabID,
      });
      if (this.talent.TabID == undefined) {
        this.creating = true;
        await this.createTalentTab({
          ID: this.talent.TabID,
        });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
