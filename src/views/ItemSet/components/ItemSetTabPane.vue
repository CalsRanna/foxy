<template>
  <el-form :model="itemSet" label-position="right" label-width="120px">
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="itemSet.ID"
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
              v-model="itemSet.Name_Lang_zhCN"
              placeholder="Name_Lang_zhCN"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="名称掩码">
            <el-input-number
              v-model="itemSet.Name_Lang_Mask"
              controls-position="right"
              placeholder="Name_Lang_Mask"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_1"
              placeholder="ItemID_1"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_2"
              placeholder="ItemID_2"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_3"
              placeholder="ItemID_3"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_4"
              placeholder="ItemID_4"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_5"
              placeholder="ItemID_5"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_6"
              placeholder="ItemID_6"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_7"
              placeholder="ItemID_7"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_8"
              placeholder="ItemID_8"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_9"
              placeholder="ItemID_9"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_10"
              placeholder="ItemID_10"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_11"
              placeholder="ItemID_11"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_12"
              placeholder="ItemID_12"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_13"
              placeholder="ItemID_13"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_14"
              placeholder="ItemID_14"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_15"
              placeholder="ItemID_15"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_16"
              placeholder="ItemID_16"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="itemSet.ItemID_17"
              placeholder="ItemID_17"
            >
            </item-template-selector>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="SetThreshold_1">
            <el-input-number
              v-model="itemSet.SetThreshold_1"
              controls-position="right"
              placeholder="SetThreshold_1"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="itemSet.SetSpellID_1"
              placeholder="SetSpellID_1"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SetThreshold_2">
            <el-input-number
              v-model="itemSet.SetThreshold_2"
              controls-position="right"
              placeholder="SetThreshold_2"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="itemSet.SetSpellID_2"
              placeholder="SetSpellID_2"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SetThreshold_3">
            <el-input-number
              v-model="itemSet.SetThreshold_3"
              controls-position="right"
              placeholder="SetThreshold_3"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="itemSet.SetSpellID_3"
              placeholder="SetSpellID_3"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SetThreshold_4">
            <el-input-number
              v-model="itemSet.SetThreshold_4"
              controls-position="right"
              placeholder="SetThreshold_4"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="itemSet.SetSpellID_4"
              placeholder="SetSpellID_4"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SetThreshold_5">
            <el-input-number
              v-model="itemSet.SetThreshold_5"
              controls-position="right"
              placeholder="SetThreshold_5"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="itemSet.SetSpellID_5"
              placeholder="SetSpellID_5"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SetThreshold_6">
            <el-input-number
              v-model="itemSet.SetThreshold_6"
              controls-position="right"
              placeholder="SetThreshold_6"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="itemSet.SetSpellID_6"
              placeholder="SetSpellID_6"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SetThreshold_7">
            <el-input-number
              v-model="itemSet.SetThreshold_7"
              controls-position="right"
              placeholder="SetThreshold_7"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="itemSet.SetSpellID_7"
              placeholder="SetSpellID_7"
            >
            </spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="SetThreshold_8">
            <el-input-number
              v-model="itemSet.SetThreshold_8"
              controls-position="right"
              placeholder="SetThreshold_8"
            >
            </el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能">
            <spell-selector
              v-model="itemSet.SetSpellID_8"
              placeholder="SetSpellID_8"
            >
            </spell-selector>
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
    ...mapState("itemSet", ["itemSet"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("itemSet", [
      "storeItemSet",
      "findItemSet",
      "updateItemSet",
      "createItemSet",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeItemSet(this.itemSet);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateItemSet({
          credential: this.credential,
          itemSet: this.itemSet,
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
        await Promise.all([this.createItemSet()]);
      } else {
        await this.findItemSet(this.credential);
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
