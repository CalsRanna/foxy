<template>
  <el-form :model="gemProperty" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="gemProperty.ID"
                controls-position="right"
                placeholder="ID"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="附魔">
              <el-input
                v-model="gemProperty.Enchant_ID"
                placeholder="Enchant_ID"
              />
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="类型">
              <el-input-number
                v-model="gemProperty.Type"
                controls-position="right"
                placeholder="Type"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="Maxcount_Inv">
              <el-input-number
                v-model="gemProperty.Maxcount_inv"
                controls-position="right"
                placeholder="Maxcount_inv"
              />
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Maxcount_Item">
              <el-input-number
                v-model="gemProperty.Maxcount_item"
                controls-position="right"
                placeholder="Maxcount_item"
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
import { mapActions, mapState } from "vuex";

import SpellSelector from "@/components/SpellSelector";
import SpellIconSelector from "@/components/SpellIconSelector";

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
    ...mapState("gemProperty", ["gemProperty"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("gemProperty", [
      "storeGemProperty",
      "findGemProperty",
      "updateGemProperty",
      "createGemProperty",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeGemProperty(this.gemProperty);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateGemProperty({
          credential: this.credential,
          gemProperty: this.gemProperty,
        });
        this.$notify({
          title: "修改成功",
          position: "top-right",
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
      if (this.$route.path == "/gem-property/create") {
        this.creating = true;
        await Promise.all([this.createGemProperty()]);
      } else {
        await this.findGemProperty(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { SpellSelector, SpellIconSelector },
};
</script>
