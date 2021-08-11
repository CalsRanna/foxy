<template>
  <el-form :model="pageText" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="pageText.ID"
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
              <page-text-text-localizer
                v-model="pageText.Text"
                placeholder="Text"
              ></page-text-text-localizer>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="下一页">
              <page-text-selector
                v-model="pageText.NextPageID"
                placeholder="NextPageID"
              ></page-text-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="VerifiedBuild">
              <el-input-number
                v-model="pageText.VerifiedBuild"
                controls-position="right"
                placeholder="VerifiedBuild"
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
import { mapActions, mapState } from "vuex";

import PageTextSelector from "@/components/PageTextSelector";
import PageTextTextLocalizer from "./PageTextTextLocalizer";

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
    ...mapState("pageText", ["pageText"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("pageText", [
      "storePageText",
      "findPageText",
      "updatePageText",
      "createPageText",
    ]),
    ...mapActions("pageTextLocale", ["searchPageTextLocales"]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storePageText(this.pageText);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updatePageText({
          credential: this.credential,
          pageText: this.pageText,
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
        await Promise.all([
          this.createPageText(),
          this.searchPageTextLocales({ ID: 0 }),
        ]);
      } else {
        await this.findPageText(this.credential);
        await this.searchPageTextLocales({ ID: this.pageText.ID });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { PageTextSelector, PageTextTextLocalizer },
};
</script>
