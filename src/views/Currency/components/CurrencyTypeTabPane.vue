<template>
  <el-form :model="currencyType" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="currencyType.ID"
                controls-position="right"
                placeholder="ID"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="物品">
              <item-template-selector
                v-model="currencyType.ItemID"
                placeholder="ItemID"
              ></item-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="分类">
              <currency-category-selector
                v-model="currencyType.CategoryID"
                placeholder="CategoryID"
              ></currency-category-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="BitIndex">
              <el-input-number
                v-model="currencyType.BitIndex"
                controls-position="right"
                placeholder="BitIndex"
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
import CurrencyCategorySelector from "@/components/CurrencyCategorySelector";
import ItemTemplateSelector from "@/components/ItemTemplateSelector";
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
    ...mapState("currencyType", ["currencyType"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("currencyType", [
      "storeCurrencyType",
      "findCurrencyType",
      "updateCurrencyType",
      "createCurrencyType",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeCurrencyType(this.currencyType);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateCurrencyType({
          credential: this.credential,
          currencyType: this.currencyType,
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
      if (this.$route.path == "/currency/create") {
        this.creating = true;
        await Promise.all([this.createCurrencyType()]);
      } else {
        await this.findCurrencyType(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    CurrencyCategorySelector,
    ItemTemplateSelector,
  }
};
</script>
