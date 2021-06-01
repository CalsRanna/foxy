<template>
  <el-form :model="scalingStatValue" label-position="right" label-width="120px">
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="scalingStatValue.ID"
              controls-position="right"
              placeholder="ID"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="等级">
            <el-input-number
              v-model="scalingStatValue.Charlevel"
              controls-position="right"
              placeholder="Charlevel"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="主要预算">
            <el-input-number
              v-model="scalingStatValue.PrimaryBudget"
              controls-position="right"
              placeholder="PrimaryBudget"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="次要预算">
            <el-input-number
              v-model="scalingStatValue.TertiaryBudget"
              controls-position="right"
              placeholder="TertiaryBudget"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="肩膀预算">
            <el-input-number
              v-model="scalingStatValue.ShoulderBudget"
              controls-position="right"
              placeholder="ShoulderBudget"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="饰品预算">
            <el-input-number
              v-model="scalingStatValue.TrinketBudget"
              controls-position="right"
              placeholder="TrinketBudget"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="单手武器预算">
            <el-input-number
              v-model="scalingStatValue.WeaponBudget1H"
              controls-position="right"
              placeholder="WeaponBudget1H"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="远程预算">
            <el-input-number
              v-model="scalingStatValue.RangedBudget"
              controls-position="right"
              placeholder="RangedBudget"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="布甲肩膀护甲">
            <el-input-number
              v-model="scalingStatValue.ClothShoulderArmor"
              controls-position="right"
              placeholder="ClothShoulderArmor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="皮甲肩膀护甲">
            <el-input-number
              v-model="scalingStatValue.LeatherShoulderArmor"
              controls-position="right"
              placeholder="LeatherShoulderArmor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="锁甲肩膀护甲">
            <el-input-number
              v-model="scalingStatValue.MailShoulderArmor"
              controls-position="right"
              placeholder="MailShoulderArmor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="板甲肩膀护甲">
            <el-input-number
              v-model="scalingStatValue.PlateShoulderArmor"
              controls-position="right"
              placeholder="PlateShoulderArmor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="布甲胸部护甲">
            <el-input-number
              v-model="scalingStatValue.ClothChestArmor"
              controls-position="right"
              placeholder="ClothChestArmor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="皮甲胸部护甲">
            <el-input-number
              v-model="scalingStatValue.LeatherChestArmor"
              controls-position="right"
              placeholder="LeatherChestArmor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="锁甲胸部护甲">
            <el-input-number
              v-model="scalingStatValue.MailChestArmor"
              controls-position="right"
              placeholder="MailChestArmor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="板甲胸部护甲">
            <el-input-number
              v-model="scalingStatValue.PlateChestArmor"
              controls-position="right"
              placeholder="PlateChestArmor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="披风护甲">
            <el-input-number
              v-model="scalingStatValue.ClothCloakArmor"
              controls-position="right"
              placeholder="ClothCloakArmor"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="单手武器伤害">
            <el-input-number
              v-model="scalingStatValue.WeaponDPS1H"
              controls-position="right"
              placeholder="WeaponDPS1H"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="双手武器伤害">
            <el-input-number
              v-model="scalingStatValue.WeaponDPS2H"
              controls-position="right"
              placeholder="WeaponDPS2H"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="单手法杖伤害">
            <el-input-number
              v-model="scalingStatValue.SpellcasterDPS1H"
              controls-position="right"
              placeholder="SpellcasterDPS1H"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="双手法杖伤害">
            <el-input-number
              v-model="scalingStatValue.SpellcasterDPS2H"
              controls-position="right"
              placeholder="SpellcasterDPS2H"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="远程武器伤害">
            <el-input-number
              v-model="scalingStatValue.RangedDPS"
              controls-position="right"
              placeholder="RangedDPS"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="魔杖伤害">
            <el-input-number
              v-model="scalingStatValue.WandDPS"
              controls-position="right"
              placeholder="WandDPS"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="法术伤害">
            <el-input-number
              v-model="scalingStatValue.SpellPower"
              controls-position="right"
              placeholder="SpellPower"
            ></el-input-number>
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

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("scalingStatValue", ["scalingStatValue"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("scalingStatValue", [
      "storeScalingStatValue",
      "findScalingStatValue",
      "updateScalingStatValue",
      "createScalingStatValue",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeScalingStatValue(this.scalingStatValue);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateScalingStatValue({
          credential: this.credential,
          scalingStatValue: this.scalingStatValue,
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
      if (this.$route.path == "/scaling-stat-value/create") {
        this.creating = true;
        await Promise.all([this.createScalingStatValue()]);
      } else {
        await this.findScalingStatValue(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
