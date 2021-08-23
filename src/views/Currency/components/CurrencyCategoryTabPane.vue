<template>
  <el-form
    :model="currencyCategory"
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
                v-model="currencyCategory.ID"
                controls-position="right"
                placeholder="ID"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="标识">
              <el-input-number
                v-model="currencyCategory.Flags"
                controls-position="right"
                placeholder="Flags"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="名称">
              <el-input
                v-model="currencyCategory.Name_Lang_zhCN"
                placeholder="Name_Lang_zhCN"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="名称掩码">
              <el-input-number
                v-model="currencyCategory.Name_Lang_Mask"
                controls-position="right"
                placeholder="Name_Lang_Mask"
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
    ...mapState("currencyType", ["currencyType"]),
    ...mapState("currencyCategory", ["currencyCategory"]),
    credential() {
      return {
        ID: this.currencyCategory.ID,
      };
    },
  },
  methods: {
    ...mapActions("currencyCategory", [
      "storeCurrencyCategory",
      "findCurrencyCategory",
      "updateCurrencyCategory",
      "createCurrencyCategory",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeCurrencyCategory(this.currencyCategory);
          this.$notify({
            title: "保存成功",
            position: "bottom-left",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateCurrencyCategory({
            credential: this.credential,
            currencyCategory: this.currencyCategory,
          });
          this.$notify({
            title: "修改成功",
            position: "bottom-left",
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
      await this.findCurrencyCategory({
        ID: this.currencyType.CategoryID,
      });
      if (this.currencyCategory.ID == undefined) {
        this.creating = true;
        await this.createCurrencyCategory({
          ID: this.currencyType.CategoryID,
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
