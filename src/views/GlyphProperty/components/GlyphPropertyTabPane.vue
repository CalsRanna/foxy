<template>
  <el-form :model="glyphProperty" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="glyphProperty.ID"
                controls-position="right"
                placeholder="ID"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="技能">
              <spell-selector
                v-model="glyphProperty.SpellID"
                placeholder="SpellID"
              />
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="标识">
              <el-input-number
                v-model="glyphProperty.GlyphSlotFlags"
                controls-position="right"
                placeholder="GlyphSlotFlags"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="图标">
              <spell-icon-selector
                v-model="glyphProperty.SpellIconID"
                controls-position="right"
                placeholder="SpellIconID"
              ></spell-icon-selector>
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
    ...mapState("glyphProperty", ["glyphProperty"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("glyphProperty", [
      "storeGlyphProperty",
      "findGlyphProperty",
      "updateGlyphProperty",
      "createGlyphProperty",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeGlyphProperty(this.glyphProperty);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateGlyphProperty({
          credential: this.credential,
          glyphProperty: this.glyphProperty,
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
      if (this.$route.path == "/glyph-property/create") {
        this.creating = true;
        await Promise.all([this.createGlyphProperty()]);
      } else {
        await this.findGlyphProperty(this.credential);
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
