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
        <el-table :data="itemEnchantmentTemplates">
          <el-table-column prop="ench" label="附魔"></el-table-column>
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
          <el-row :gutter="24">
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
                <el-input-number
                  v-model="itemEnchantmentTemplate.ench"
                  controls-position="right"
                  placeholder="ench"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="几率">
                <el-input
                  v-model="itemEnchantmentTemplate.chance"
                  placeholder="chance"
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
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

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
        entry: this.itemTemplate.entry,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeItemEnchantmentTemplate(this.itemEnchantmentTemplate);
      } else {
        await this.updateItemEnchantmentTemplate({
          credential: this.credential,
          itemEnchantmentTemplate: this.itemEnchantmentTemplate,
        });
      }
      await this.searchItemEnchantmentTemplates({
        entry: this.itemTemplate.entry,
      });
      this.creating = false;
      this.editing = false;
    },
    cancel() {
      this.creating = false;
    },
    copy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？</small>", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
        beforeClose: (action, instance, done) => {
          if (action === "confirm") {
            instance.confirmButtonLoading = true;
            this.copyItemEnchantmentTemplate(this.credential)
              .then(() => {
                this.searchItemEnchantmentTemplates({
                  entry: this.itemTemplate.entry,
                });
              })
              .then(() => {
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
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "error",
          dangerouslyUseHTMLString: true,
          beforeClose: (action, instance, done) => {
            if (action === "confirm") {
              instance.confirmButtonLoading = true;
              this.destroyItemEnchantmentTemplate(this.credential)
                .then(() => {
                  this.searchItemEnchantmentTemplates({
                    entry: this.itemTemplate.entry,
                  });
                })
                .then(() => {
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
        entry: this.itemTemplate.entry,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
