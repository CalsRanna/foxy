<template>
  <el-form
    :model="spellItemEnchantment"
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
                v-model="spellItemEnchantment.ID"
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
                v-model="spellItemEnchantment.Name_Lang_zhCN"
                placeholder="Name_Lang_zhCN"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="名称掩码">
              <el-input-number
                v-model="spellItemEnchantment.Name_Lang_Mask"
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
            <el-form-item label="视觉效果">
              <el-input
                v-model="spellItemEnchantment.ItemVisual"
                placeholder="SoundProviderPref"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="标识">
              <el-input
                v-model="spellItemEnchantment.Flags"
                placeholder="SoundProviderPrefUnderwater"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="最小等级">
              <el-input-number
                v-model="spellItemEnchantment.MinLevel"
                controls-position="right"
                placeholder="MinLevel"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="Src_ItemID">
              <el-input
                v-model="spellItemEnchantment.Src_ItemID"
                placeholder="Src_ItemID"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="条件">
              <el-input
                v-model="spellItemEnchantment.Condition_Id"
                placeholder="Condition_Id"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="需要技能">
              <el-input
                v-model="spellItemEnchantment.RequiredSkillID"
                placeholder="RequiredSkillID"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="需要技能等级">
              <el-input
                v-model="spellItemEnchantment.RequiredSkillRank"
                placeholder="RequiredSkillRank"
              >
              </el-input>
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
            <el-form-item label="充能">
              <el-input-number
                v-model="spellItemEnchantment.Charges"
                controls-position="right"
                placeholder="Charges"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="效果">
              <el-input
                v-model="spellItemEnchantment.Effect_1"
                placeholder="Effect_1"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数">
              <el-input-number
                v-if="spellItemEnchantment.Effect_1 === 5"
                v-model="spellItemEnchantment.EffectArg_1"
                controls-position="right"
                placeholder="EffectArg_1"
              >
              </el-input-number>
              <spell-selector
                v-else
                v-model="spellItemEnchantment.EffectArg_1"
                placeholder="EffectArg_1"
              ></spell-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="最小值">
              <el-input-number
                v-model="spellItemEnchantment.EffectPointsMin_1"
                controls-position="right"
                placeholder="EffectPointsMin_1"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="最大值">
              <el-input-number
                v-model="spellItemEnchantment.EffectPointsMax_1"
                controls-position="right"
                placeholder="EffectPointsMax_1"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="效果">
              <el-input
                v-model="spellItemEnchantment.Effect_2"
                placeholder="Effect_2"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数">
              <el-input-number
                v-if="spellItemEnchantment.Effect_2 === 5"
                v-model="spellItemEnchantment.EffectArg_2"
                controls-position="right"
                placeholder="EffectArg_2"
              >
              </el-input-number>
              <spell-selector
                v-else
                v-model="spellItemEnchantment.EffectArg_2"
                placeholder="EffectArg_2"
              ></spell-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="最小值">
              <el-input-number
                v-model="spellItemEnchantment.EffectPointsMin_2"
                controls-position="right"
                placeholder="EffectPointsMin_2"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="最大值">
              <el-input-number
                v-model="spellItemEnchantment.EffectPointsMax_2"
                controls-position="right"
                placeholder="EffectPointsMax_2"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="效果">
              <el-input
                v-model="spellItemEnchantment.Effect_3"
                placeholder="Effect_3"
              >
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数">
              <el-input-number
                v-if="spellItemEnchantment.Effect_3 === 5"
                v-model="spellItemEnchantment.EffectArg_3"
                controls-position="right"
                placeholder="EffectArg_3"
              >
              </el-input-number>
              <spell-selector
                v-else
                v-model="spellItemEnchantment.EffectArg_3"
                placeholder="EffectArg_3"
              ></spell-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="最小值">
              <el-input-number
                v-model="spellItemEnchantment.EffectPointsMin_3"
                controls-position="right"
                placeholder="EffectPointsMin_3"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="最大值">
              <el-input-number
                v-model="spellItemEnchantment.EffectPointsMax_3"
                controls-position="right"
                placeholder="EffectPointsMax_3"
              >
              </el-input-number>
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
    ...mapState("spellItemEnchantment", ["spellItemEnchantment"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("spellItemEnchantment", [
      "storeSpellItemEnchantment",
      "findSpellItemEnchantment",
      "updateSpellItemEnchantment",
      "createSpellItemEnchantment",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeSpellItemEnchantment(this.spellItemEnchantment);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateSpellItemEnchantment({
          credential: this.credential,
          spellItemEnchantment: this.spellItemEnchantment,
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
      if (this.$route.path == "/spell-item-enchantment/create") {
        this.creating = true;
        await Promise.all([this.createSpellItemEnchantment()]);
      } else {
        await this.findSpellItemEnchantment(this.credential);
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
