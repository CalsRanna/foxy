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
          :data="npcVendors"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="slot" label="插槽" sortable></el-table-column>
          <el-table-column prop="item" label="ID" sortable></el-table-column>
          <el-table-column prop="name" label="名称" sortable>
            <span slot-scope="scope">
              <template v-if="scope.row.Name !== null">
                {{ scope.row.Name }}
              </template>
              <template v-else>{{ scope.row.name }}</template>
            </span>
          </el-table-column>
          <el-table-column
            prop="maxcount"
            label="最大数量"
            sortable
          ></el-table-column>
          <el-table-column
            prop="incrtime"
            label="补货时间"
            sortable
          ></el-table-column>
          <el-table-column sortable>
            <hint-label
              label="扩展价格"
              :tooltip="extendedCostTooltip"
              slot="header"
            ></hint-label>
            <span slot-scope="scope">{{ scope.row.ExtendedCost }}</span>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form :model="npcVendor" label-position="right" label-width="120px">
        <el-card style="margin-top: 16px">
          <el-row :gutter="24">
            <el-col :span="6">
              <el-form-item label="编号">
                <el-input-number
                  v-model="npcVendor.entry"
                  controls-position="right"
                  v-loading="initing"
                  placeholder="entry"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="插槽">
                <el-input-number
                  v-model="npcVendor.slot"
                  controls-position="right"
                  v-loading="initing"
                  placeholder="slot"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="VerifiedBuild">
                <el-input
                  v-model="npcVendor.VerifiedBuild"
                  placeholder="VerifiedBuild"
                ></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="24">
            <el-col :span="6">
              <el-form-item label="物品">
                <item-template-selector
                  v-model="npcVendor.item"
                  controls-position="right"
                  placeholder="item"
                ></item-template-selector>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="最大数量">
                <el-input-number
                  v-model="npcVendor.maxcount"
                  controls-position="right"
                  placeholder="maxcount"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="补货时间">
                <el-input-number
                  v-model="npcVendor.incrtime"
                  controls-position="right"
                  placeholder="incrtime"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item>
                <hint-label
                  label="扩展价格"
                  :tooltip="extendedCostTooltip"
                  slot="label"
                ></hint-label>
                <el-input-number
                  v-model="npcVendor.ExtendedCost"
                  controls-position="right"
                  placeholder="ExtendedCost"
                ></el-input-number>
              </el-form-item>
            </el-col>
          </el-row>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-button type="primary" :loading="loading" @click="store"
            >保存</el-button
          >
          <el-button @click="cancel">返回</el-button>
        </el-card>
      </el-form>
    </div>
  </div>
</template>

<script>
import { extendedCostTooltip } from "@/locales/creature";

import HintLabel from "@/components/HintLabel.vue";

import { mapState, mapActions } from "vuex";
import ItemTemplateSelector from "../../../components/ItemTemplateSelector.vue";

export default {
  data() {
    return {
      initing: false,
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false,
      extendedCostTooltip: extendedCostTooltip,
    };
  },
  computed: {
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("npcVendor", ["npcVendors", "npcVendor"]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        entry: this.currentRow != undefined ? this.currentRow.entry : undefined,
        item: this.currentRow != undefined ? this.currentRow.item : undefined,
        ExtendedCost:
          this.currentRow != undefined
            ? this.currentRow.ExtendedCost
            : undefined,
      };
    },
  },
  methods: {
    ...mapActions("npcVendor", [
      "searchNpcVendors",
      "storeNpcVendor",
      "findNpcVendor",
      "updateNpcVendor",
      "destroyNpcVendor",
      "createNpcVendor",
      "copyNpcVendor",
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createNpcVendor({
        entry: this.creatureTemplate.entry,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeNpcVendor(this.npcVendor);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
      } else {
        await this.updateNpcVendor({
          credential: this.credential,
          npcVendor: this.npcVendor,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      await this.searchNpcVendors({
        entry: this.creatureTemplate.entry,
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
            this.copyNpcVendor(this.credential)
              .then(() => {
                this.searchNpcVendors({
                  entry: this.creatureTemplate.entry,
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
              this.destroyNpcVendor(this.credential)
                .then(() => {
                  this.searchNpcVendors({
                    entry: this.creatureTemplate.entry,
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
      await this.findNpcVendor({
        entry: row.entry,
        item: row.item,
        ExtendedCost: row.ExtendedCost,
      });
    },
    async init() {
      this.initing = true;
      await this.searchNpcVendors({
        entry: this.creatureTemplate.entry,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    HintLabel,
    ItemTemplateSelector,
  },
};
</script>
