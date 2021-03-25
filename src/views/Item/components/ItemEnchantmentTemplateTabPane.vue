<template>
  <div>
    <div v-show="!creating">
      <el-card style="margin-top: 16px">
        <el-button type="primary" @click="create">新增</el-button>
        <el-button @click="copy" :disabled="disabled">复制</el-button>
        <el-button type="danger" @click="destroy" :disabled="disabled">
          删除
        </el-button>
      </el-card>
      <el-card style="margin-top: 16px">
        <el-table
          :data="itemEnchantmentTemplates"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="entry" label="编号"></el-table-column>
          <el-table-column prop="ench" label="附魔"></el-table-column>
          <el-table-column label="名称">
            <template slot-scope="scope">
              <span v-if="scope.row.Name_Lang_zhCN != null">
                {{ scope.row.Name_Lang_zhCN }}
              </span>
              <span v-else>{{ scope.row.Name }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="chance" label="几率">
            <span slot-scope="scope">
              {{ `${scope.row.chance}%` }}
            </span>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="itemEnchantmentTemplate"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="16">
            <el-col :span="6">
              <el-form-item label="物品ID">
                <el-input-number
                  v-model="itemEnchantmentTemplate.entry"
                  controls-position="right"
                  v-loading="initing"
                  placeholder="entry"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="附魔">
                <item-random-properties-selector
                  v-if="this.itemTemplate.RandomProperty != 0"
                  v-model="itemEnchantmentTemplate.ench"
                  placeholder="ench"
                ></item-random-properties-selector>
                <item-random-suffix-selector
                  v-else
                  v-model="itemEnchantmentTemplate.ench"
                  placeholder="ench"
                ></item-random-suffix-selector>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="几率">
                <el-input-number
                  v-model="itemEnchantmentTemplate.chance"
                  controls-position="right"
                  placeholder="chance"
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
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import ItemRandomPropertiesSelector from "@/components/ItemRandomPropertiesSelector";
import ItemRandomSuffixSelector from "@/components/ItemRandomSuffixSelector.vue";

export default {
  data() {
    return {
      initing: false,
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false,
    };
  },
  computed: {
    ...mapState("itemTemplate", ["itemTemplate"]),
    ...mapState("itemEnchantmentTemplate", [
      "itemEnchantmentTemplates",
      "itemEnchantmentTemplate",
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        entry: this.currentRow != undefined ? this.currentRow.entry : undefined,
        ench: this.currentRow != undefined ? this.currentRow.ench : undefined,
      };
    },
  },
  methods: {
    ...mapActions("itemEnchantmentTemplate", [
      "searchItemEnchantmentTemplates",
      "storeItemEnchantmentTemplate",
      "findItemEnchantmentTemplate",
      "updateItemEnchantmentTemplate",
      "destroyItemEnchantmentTemplate",
      "createItemEnchantmentTemplate",
      "copyItemEnchantmentTemplate",
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createItemEnchantmentTemplate({
        entry:
          this.itemTemplate.RandomProperty != 0
            ? this.itemTemplate.RandomProperty
            : this.itemTemplate.RandomSuffix,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeItemEnchantmentTemplate(this.itemEnchantmentTemplate);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
      } else {
        await this.updateItemEnchantmentTemplate({
          credential: this.credential,
          itemEnchantmentTemplate: this.itemEnchantmentTemplate,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      await this.searchItemEnchantmentTemplates({
        type: this.itemTemplate.RandomProperty != 0 ? "properties" : "suffix",
        entry:
          this.itemTemplate.RandomProperty != 0
            ? this.itemTemplate.RandomProperty
            : this.itemTemplate.RandomSuffix,
      });
      this.creating = false;
      this.editing = false;
    },
    cancel() {
      this.creating = false;
    },
    copy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？", "确认复制", {
        confirmButtonText: "确认",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
        beforeClose: (action, instance, done) => {
          if (action === "confirm") {
            instance.confirmButtonLoading = true;
            this.copyItemEnchantmentTemplate(this.credential)
              .then(() => {
                this.searchItemEnchantmentTemplates({
                  type:
                    this.itemTemplate.RandomProperty != 0
                      ? "properties"
                      : "suffix",
                  entry:
                    this.itemTemplate.RandomProperty != 0
                      ? this.itemTemplate.RandomProperty
                      : this.itemTemplate.RandomSuffix,
                });
              })
              .then(() => {
                this.$notify({
                  title: "复制成功",
                  position: "bottom-left",
                  type: "success",
                });
                instance.confirmButtonLoading = false;
                done();
              });
          } else {
            done();
          }
        },
      });
    },
    destroy() {
      this.$confirm(
        "此操作将永久删除该数据，确认继续？<br><small>为避免误操作，不提供删除关联表数据功能。</small>",
        "确认删除",
        {
          confirmButtonText: "确认",
          cancelButtonText: "取消",
          type: "info",
          dangerouslyUseHTMLString: true,
          beforeClose: (action, instance, done) => {
            if (action === "confirm") {
              instance.confirmButtonLoading = true;
              this.destroyItemEnchantmentTemplate(this.credential)
                .then(() => {
                  this.searchItemEnchantmentTemplates({
                    type:
                      this.itemTemplate.RandomProperty != 0
                        ? "properties"
                        : "suffix",
                    entry:
                      this.itemTemplate.RandomProperty != 0
                        ? this.itemTemplate.RandomProperty
                        : this.itemTemplate.RandomSuffix,
                  });
                })
                .then(() => {
                  this.$notify({
                    title: "删除成功",
                    position: "bottom-left",
                    type: "success",
                  });
                  instance.confirmButtonLoading = false;
                  done();
                });
            } else {
              done();
            }
          },
        }
      );
    },
    select(row) {
      this.currentRow = row;
    },
    async show(row) {
      this.creating = true;
      this.editing = true;
      await this.findItemEnchantmentTemplate({
        entry: row.entry,
        ench: row.ench,
      });
    },
    async init() {
      this.initing = true;
      await this.searchItemEnchantmentTemplates({
        type: this.itemTemplate.RandomProperty != 0 ? "properties" : "suffix",
        entry:
          this.itemTemplate.RandomProperty != 0
            ? this.itemTemplate.RandomProperty
            : this.itemTemplate.RandomSuffix,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { ItemRandomPropertiesSelector, ItemRandomSuffixSelector },
};
</script>
