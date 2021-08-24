<template>
  <el-form :model="itemExtendedCost" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="itemExtendedCost.ID"
                controls-position="right"
                placeholder="ID"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="荣誉点数">
              <el-input-number
                v-model="itemExtendedCost.HonorPoints"
                controls-position="right"
                placeholder="HonorPoints"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="竞技场点数">
              <el-input-number
                v-model="itemExtendedCost.ArenaPoints"
                controls-position="right"
                placeholder="ArenaPoints"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="ArenaBracket">
              <el-input-number
                v-model="itemExtendedCost.ArenaBracket"
                controls-position="right"
                placeholder="ArenaBracket"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="RequiredArenaRating">
              <el-input-number
                v-model="itemExtendedCost.RequiredArenaRating"
                controls-position="right"
                placeholder="RequiredArenaRating"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="ItemPurchaseGroup">
              <el-input-number
                v-model="itemExtendedCost.ItemPurchaseGroup"
                controls-position="right"
                placeholder="ItemPurchaseGroup"
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
            <el-form-item label="物品">
              <item-template-selector
                v-model="itemExtendedCost.ItemID_1"
                placeholder="ItemID_1"
              >
              </item-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="数量">
              <el-input-number
                v-model="itemExtendedCost.ItemCount_1"
                controls-position="right"
                placeholder="ItemCount_1"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="物品">
              <item-template-selector
                v-model="itemExtendedCost.ItemID_2"
                placeholder="ItemID_2"
              >
              </item-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="数量">
              <el-input-number
                v-model="itemExtendedCost.ItemCount_2"
                controls-position="right"
                placeholder="ItemCount_2"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="物品">
              <item-template-selector
                v-model="itemExtendedCost.ItemID_3"
                placeholder="ItemID_3"
              >
              </item-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="数量">
              <el-input-number
                v-model="itemExtendedCost.ItemCount_3"
                controls-position="right"
                placeholder="ItemCount_3"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="物品">
              <item-template-selector
                v-model="itemExtendedCost.ItemID_4"
                placeholder="ItemID_4"
              >
              </item-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="数量">
              <el-input-number
                v-model="itemExtendedCost.ItemCount_4"
                controls-position="right"
                placeholder="ItemCount_4"
              >
              </el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="物品">
              <item-template-selector
                v-model="itemExtendedCost.ItemID_5"
                placeholder="ItemID_5"
              >
              </item-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="数量">
              <el-input-number
                v-model="itemExtendedCost.ItemCount_5"
                controls-position="right"
                placeholder="ItemCount_5"
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

import { localeStatTypes } from "@/locales/item";
import ItemTemplateSelector from "../../../components/ItemTemplateSelector.vue";
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
    ...mapState("app", ["clientHeight"]),
    ...mapState("itemExtendedCost", ["itemExtendedCost"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("itemExtendedCost", [
      "storeItemExtendedCost",
      "findItemExtendedCost",
      "updateItemExtendedCost",
      "createItemExtendedCost",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeItemExtendedCost(this.itemExtendedCost);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateItemExtendedCost({
          credential: this.credential,
          itemExtendedCost: this.itemExtendedCost,
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
      if (this.$route.path == "/item-extended-cost/create") {
        this.creating = true;
        await Promise.all([this.createItemExtendedCost()]);
      } else {
        await this.findItemExtendedCost(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { ItemTemplateSelector, SpellSelector },
};
</script>
