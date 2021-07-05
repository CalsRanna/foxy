<template>
  <el-form :model="spellCustomAttr" label-position="right" label-width="120px">
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="spellCustomAttr.spell_id"
              controls-position="right"
              placeholder="spell_id"
              :disabled="initing"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <flag-editor
              v-model="spellCustomAttr.attributes"
              title="属性编辑器"
              :flags="customAttributes"
              placeholder="attributes"
            ></flag-editor>
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
import { customAttributes } from "@/locales/spell";

import { mapState, mapActions } from "vuex";
import FlagEditor from "@/components/FlagEditor.vue";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      customAttributes: customAttributes,
    };
  },
  computed: {
    ...mapState("spell", ["spell"]),
    ...mapState("spellCustomAttr", ["spellCustomAttr"]),
    credential() {
      return {
        spell_id: this.spell.ID,
      };
    },
  },
  methods: {
    ...mapActions("spellCustomAttr", [
      "storeSpellCustomAttr",
      "findSpellCustomAttr",
      "updateSpellCustomAttr",
      "createSpellCustomAttr",
    ]),
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeSpellCustomAttr(this.spellCustomAttr);
          this.$notify({
            title: "保存成功",
            position: "bottom-left",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateSpellCustomAttr({
            credential: this.credential,
            spellCustomAttr: this.spellCustomAttr,
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
      await this.findSpellCustomAttr({
        spell_id: this.spell.ID,
      });
      if (this.spellCustomAttr.spell_id == undefined) {
        this.creating = true;
        await this.createSpellCustomAttr({
          spell_id: this.spell.ID,
        });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { FlagEditor },
};
</script>
