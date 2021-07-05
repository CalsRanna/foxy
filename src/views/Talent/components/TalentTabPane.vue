<template>
  <el-form :model="talent" label-position="right" label-width="120px">
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="talent.ID"
              controls-position="right"
              placeholder="ID"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="天赋页">
            <el-input-number
              v-model="talent.TabID"
              controls-position="right"
              placeholder="TabID"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="行">
            <el-input-number
              v-model="talent.TierID"
              controls-position="right"
              placeholder="TierID"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="列">
            <el-input-number
              v-model="talent.ColumnIndex"
              controls-position="right"
              placeholder="ColumnIndex"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要技能">
            <spell-selector
              v-model="talent.RequiredSpellID"
              placeholder="RequiredSpellID"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="标识">
            <el-input-number
              v-model="talent.Flags"
              controls-position="right"
              placeholder="Flags"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="类别掩码">
            <el-input-number
              v-model="talent.CategoryMask_1"
              controls-position="right"
              placeholder="CategoryMask_1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="类别掩码">
            <el-input-number
              v-model="talent.CategoryMask_2"
              controls-position="right"
              placeholder="CategoryMask_2"
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
          <el-form-item label="技能">
            <spell-selector
              v-model="talent.SpellRank_1"
              placeholder="SpellRank_1"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="talent.SpellRank_2"
              placeholder="SpellRank_2"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="talent.SpellRank_3"
              placeholder="SpellRank_3"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="talent.SpellRank_4"
              placeholder="SpellRank_4"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="talent.SpellRank_5"
              placeholder="SpellRank_5"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="talent.SpellRank_6"
              placeholder="SpellRank_6"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="talent.SpellRank_7"
              placeholder="SpellRank_7"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="talent.SpellRank_8"
              placeholder="SpellRank_8"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="talent.SpellRank_9"
              placeholder="SpellRank_9"
            >
            </spell-selector>
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
          <el-form-item label="前置天赋">
            <el-input-number
              v-model="talent.PrereqTalent_1"
              controls-position="right"
              placeholder="PrereqTalent_1"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="等级">
            <el-input-number
              v-model="talent.PrereqRank_1"
              controls-position="right"
              placeholder="PrereqRank_1"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="前置天赋">
            <el-input-number
              v-model="talent.PrereqTalent_2"
              controls-position="right"
              placeholder="PrereqTalent_2"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="等级">
            <el-input-number
              v-model="talent.PrereqRank_2"
              controls-position="right"
              placeholder="PrereqRank_2"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="前置天赋">
            <el-input-number
              v-model="talent.PrereqTalent_3"
              controls-position="right"
              placeholder="PrereqTalent_3"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="等级">
            <el-input-number
              v-model="talent.PrereqRank_3"
              controls-position="right"
              placeholder="PrereqRank_3"
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

import { localeStatTypes } from "@/locales/item";
import SpellSelector from "../../../components/SpellSelector.vue";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      localeStatTypes: localeStatTypes,
    };
  },
  computed: {
    ...mapState("talent", ["talent"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("talent", [
      "storeTalent",
      "findTalent",
      "updateTalent",
      "createTalent",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeTalent(this.talent);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateTalent({
          credential: this.credential,
          talent: this.talent,
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
      if (this.$route.path == "/talent/create") {
        this.creating = true;
        await Promise.all([this.createTalent()]);
      } else {
        await this.findTalent(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { SpellSelector },
};
</script>
