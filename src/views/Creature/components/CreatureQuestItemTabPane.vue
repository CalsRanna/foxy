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
          :data="creatureQuestItems"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="Idx" label="编号" sortable></el-table-column>
          <el-table-column label="名称">
            <item-template-name
              slot-scope="scope"
              :itemTemplate="scope.row"
            ></item-template-name>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="creatureQuestItem"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="16">
            <el-col :span="6">
              <el-form-item label="生物ID">
                <el-input-number
                  v-model="creatureQuestItem.CreatureEntry"
                  controls-position="right"
                  v-loading="initing"
                  placeholder="CreatureEntry"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="编号">
                <el-input-number
                  v-model="creatureQuestItem.Idx"
                  controls-position="right"
                  v-loading="initing"
                  placeholder="Idx"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="物品">
                <item-template-selector
                  v-model="creatureQuestItem.ItemId"
                  controls-position="right"
                  placeholder="ItemId"
                ></item-template-selector>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="VerifiedBuild">
                <el-input
                  v-model="creatureQuestItem.VerifiedBuild"
                  placeholder="VerifiedBuild"
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
import ItemTemplateName from "@/components/ItemTemplateName";
import ItemTemplateSelector from "../../../components/ItemTemplateSelector.vue";

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
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureQuestItem", [
      "creatureQuestItems",
      "creatureQuestItem",
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        CreatureEntry:
          this.currentRow != undefined
            ? this.currentRow.CreatureEntry
            : undefined,
        Idx: this.currentRow != undefined ? this.currentRow.Idx : undefined,
      };
    },
  },
  methods: {
    ...mapActions("creatureQuestItem", [
      "searchCreatureQuestItems",
      "storeCreatureQuestItem",
      "findCreatureQuestItem",
      "updateCreatureQuestItem",
      "destroyCreatureQuestItem",
      "createCreatureQuestItem",
      "copyCreatureQuestItem",
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createCreatureQuestItem({
        CreatureEntry: this.creatureTemplate.entry,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeCreatureQuestItem(this.creatureQuestItem);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
      } else {
        await this.updateCreatureQuestItem({
          credential: this.credential,
          creatureQuestItem: this.creatureQuestItem,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      await this.searchCreatureQuestItems({
        creatureEntry: this.creatureTemplate.entry,
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
            this.copyCreatureQuestItem(this.credential)
              .then(() => {
                this.searchCreatureQuestItems({
                  CreatureEntry: this.creatureTemplate.entry,
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
              this.destroyCreatureQuestItem(this.credential)
                .then(() => {
                  this.searchCreatureQuestItems({
                    CreatureEntry: this.creatureTemplate.entry,
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
      await this.findCreatureQuestItem({
        CreatureEntry: row.CreatureEntry,
        Idx: row.Idx,
      });
    },
    async init() {
      this.initing = true;
      await this.searchCreatureQuestItems({
        CreatureEntry: this.creatureTemplate.entry,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { ItemTemplateName, ItemTemplateSelector },
};
</script>
