<template>
  <el-form :model="spellBonusData" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="spellBonusData.entry"
                controls-position="right"
                placeholder="entry"
                :disabled="initing"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="备注">
              <el-input
                v-model="spellBonusData.comments"
                placeholder="comments"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="法术强度">
              <el-input-number
                v-model="spellBonusData.direct_bonus"
                controls-position="right"
                placeholder="direct_bonus"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="法术强度(dot)">
              <el-input-number
                v-model="spellBonusData.dot_bonus"
                controls-position="right"
                placeholder="dot_bonus"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="攻击强度">
              <el-input-number
                v-model="spellBonusData.ap_bonus"
                controls-position="right"
                placeholder="ap_bonus"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="攻击强度(dot)">
              <el-input-number
                v-model="spellBonusData.ap_dot_bonus"
                controls-position="right"
                placeholder="ap_dot_bonus"
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
    ...mapState("spell", ["spell"]),
    ...mapState("spellBonusData", ["spellBonusData"]),
    credential() {
      return {
        entry: this.spell.ID,
      };
    },
  },
  methods: {
    ...mapActions("spellBonusData", [
      "storeSpellBonusData",
      "findSpellBonusData",
      "updateSpellBonusData",
      "createSpellBonusData",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeSpellBonusData(this.spellBonusData);
          this.$notify({
            title: "保存成功",
            position: "bottom-left",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateSpellBonusData({
            credential: this.credential,
            spellBonusData: this.spellBonusData,
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
      await this.findSpellBonusData({
        entry: this.spell.ID,
      });
      if (this.spellBonusData.entry == undefined) {
        this.creating = true;
        await this.createSpellBonusData({
          entry: this.spell.ID,
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
