<template>
  <el-form
    :model="referenceLootTemplate"
    label-position="right"
    label-width="120px"
  >
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="referenceLootTemplate.Entry"
              controls-position="right"
              v-loading="initing"
              placeholder="Entry"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品">
            <item-template-selector
              v-model="referenceLootTemplate.Item"
              controls-position="right"
              v-loading="initing"
              placeholder="Item"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="关联">
            <el-input-number
              v-model="referenceLootTemplate.Reference"
              controls-position="right"
              placeholder="Reference"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="几率">
            <el-input-number
              v-model="referenceLootTemplate.Chance"
              controls-position="right"
              placeholder="Chance"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要任务">
            <el-switch
              v-model="referenceLootTemplate.QuestRequired"
              :active-value="1"
              :inactive-value="0"
            ></el-switch>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="掉落模式">
            <el-input-number
              v-model="referenceLootTemplate.LootMode"
              controls-position="right"
              placeholder="LootMode"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="组ID">
            <el-input-number
              v-model="referenceLootTemplate.GroudId"
              controls-position="right"
              placeholder="GroudId"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最小数量">
            <el-input-number
              v-model="referenceLootTemplate.MinCount"
              controls-position="right"
              placeholder="MinCount"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最大数量">
            <el-input-number
              v-model="referenceLootTemplate.MaxCount"
              controls-position="right"
              placeholder="MaxCount"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="注解">
            <el-input
              v-model="referenceLootTemplate.Comment"
              placeholder="Comment"
            ></el-input>
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
import ItemTemplateName from "@/components/ItemTemplateName";
import ItemTemplateSelector from "@/components/ItemTemplateSelector";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("referenceLootTemplate", ["referenceLootTemplate"]),
    credential() {
      return {
        Entry: this.$route.params.id,
        Item: this.$route.query.Item,
      };
    },
  },
  methods: {
    ...mapActions("referenceLootTemplate", [
      "storeReferenceLootTemplate",
      "findReferenceLootTemplate",
      "updateReferenceLootTemplate",
      "createReferenceLootTemplate",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeReferenceLootTemplate(this.referenceLootTemplate);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateReferenceLootTemplate({
          credential: this.credential,
          referenceLootTemplate: this.referenceLootTemplate,
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
      if (this.$route.path == "/reference-loot/create") {
        this.creating = true;
        await Promise.all([this.createReferenceLootTemplate()]);
      } else {
        await this.findReferenceLootTemplate(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    ItemTemplateName,
    ItemTemplateSelector,
  },
};
</script>
