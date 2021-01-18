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
          :data="pickpocketingLootTemplates"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="displayid"></el-table-column>
          <el-table-column label="名称" sortable>
            <span slot-scope="scope">
              <template v-if="scope.row.Reference == 0">
                <template v-if="scope.row.localeName !== null">
                  {{ scope.row.localeName }}
                </template>
                <template v-else>{{ scope.row.name }}</template>
              </template>
              <template v-else> 关联掉落 </template>
            </span>
          </el-table-column>
          <el-table-column
            prop="Reference"
            label="关联"
            sortable
          ></el-table-column>
          <el-table-column prop="Chance" label="几率" sortable>
            <span slot-scope="scope">
              {{ `${scope.row.Chance}%` }}
            </span>
          </el-table-column>
          <el-table-column prop="QuestRequired" label="需要任务" sortable>
            <span slot-scope="scope">
              <el-tag type="success" v-if="scope.row.QuestRequired">
                需要
              </el-tag>
              <el-tag v-else>不需要</el-tag>
            </span>
          </el-table-column>
          <el-table-column
            prop="MinCount"
            label="最小数量"
            sortable
          ></el-table-column>
          <el-table-column
            prop="MaxCount"
            label="最大数量"
            sortable
          ></el-table-column>
        </el-table>
      </el-card>
      <el-card
        v-for="(pickpocketingReferenceLootTemplates,
        index) in groupedPickpocketingReferenceLootTemplates"
        :key="`pickpocketingReferenceLootTemplates-${index}`"
        :header="`关联掉落${pickpocketingReferenceLootTemplates[0].Entry}`"
        style="margin-top: 16px"
      >
        <el-table :data="pickpocketingReferenceLootTemplates">
          <el-table-column prop="displayid"></el-table-column>
          <el-table-column label="名称" sortable>
            <span slot-scope="scope">
              <template v-if="scope.row.Reference == 0">
                <template v-if="scope.row.localeName !== null">
                  {{ scope.row.localeName }}
                </template>
                <template v-else>{{ scope.row.name }}</template>
              </template>
              <template v-else> 关联掉落 </template>
            </span>
          </el-table-column>
          <el-table-column
            prop="Reference"
            label="关联"
            sortable
          ></el-table-column>
          <el-table-column prop="Chance" label="几率" sortable>
            <span slot-scope="scope">
              {{ `${scope.row.Chance}%` }}
            </span>
          </el-table-column>
          <el-table-column prop="QuestRequired" label="需要任务" sortable>
            <span slot-scope="scope">
              <el-tag type="success" v-if="scope.row.QuestRequired">
                需要
              </el-tag>
              <el-tag v-else>不需要</el-tag>
            </span>
          </el-table-column>
          <el-table-column
            prop="MinCount"
            label="最小数量"
            sortable
          ></el-table-column>
          <el-table-column
            prop="MaxCount"
            label="最大数量"
            sortable
          ></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="pickpocketingLootTemplate"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="24">
            <el-col :span="6">
              <el-form-item label="编号">
                <el-input-number
                  v-model="pickpocketingLootTemplate.Idx"
                  controls-position="right"
                  v-loading="loading"
                  disabled
                  placeholder="Idx"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
          </el-row>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-button type="primary" @click="store">保存</el-button>
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
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false
    };
  },
  computed: {
    ...mapState("creature", [
      "creatureTemplate",
      "pickpocketingLootTemplates",
      "pickpocketingLootTemplate",
      "pickpocketingReferenceLootTemplates"
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        entry: this.currentRow != undefined ? this.currentRow.Entry : undefined
      };
    },
    pickpocketingReferenceLootTemplateEntries() {
      let entries = [];
      for (let pickpocketingLootTemplate of this.pickpocketingLootTemplates) {
        if (pickpocketingLootTemplate.Reference != 0) {
          entries.push(pickpocketingLootTemplate.Reference);
        }
      }
      return entries;
    },
    groupedPickpocketingReferenceLootTemplates() {
      let groups = {};
      this.pickpocketingReferenceLootTemplates.forEach(
        creatureReferenceLootTemplate => {
          const key = creatureReferenceLootTemplate.Entry;
          groups[key] = groups[key] || [];
          groups[key].push(creatureReferenceLootTemplate);
        }
      );
      return Object.keys(groups).map(group => groups[group]);
    }
  },
  methods: {
    ...mapActions("creature", [
      "searchPickpocketingLootTemplates",
      "storePickpocketingLootTemplate",
      "findPickpocketingLootTemplate",
      "updatePickpocketingLootTemplate",
      "destroyPickpocketingLootTemplate",
      "createPickpocketingLootTemplate",
      "copyPickpocketingLootTemplate",
      "searchPickpocketingReferenceLootTemplates"
    ]),
    async create() {
      await this.createPickpocketingLootTemplate({
        entry: this.creatureTemplate.lootid
      });
      this.creating = true;
    },
    async store() {
      if (!this.editing) {
        await this.storePickpocketingLootTemplate(
          this.pickpocketingLootTemplate
        );
      } else {
        await this.updatePickpocketingLootTemplate({
          credential: this.credential,
          pickpocketingLootTemplate: this.pickpocketingLootTemplate
        });
      }
      await this.searchPickpocketingLootTemplates({
        entry: this.creatureTemplate.Entry
      });
      await this.searchPickpocketingReferenceLootTemplates({
        entries: this.pickpocketingReferenceLootTemplateEntries
      });
      this.creating = false;
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
            this.copyPickpocketingLootTemplate({
              entry: this.currentRow.Entry
            })
              .then(() => {
                this.searchPickpocketingLootTemplates({
                  entry: this.creatureTemplate.Entry
                });
                this.searchPickpocketingReferenceLootTemplates({
                  entries: this.pickpocketingReferenceLootTemplateEntries
                });
              })
              .then(() => {
                instance.confirmButtonLoading = false;
                done();
              });
          } else {
            done();
          }
        }
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
              this.destroyPickpocketingLootTemplate({
                entry: this.currentRow.Entry
              })
                .then(() => {
                  this.searchPickpocketingLootTemplates({
                    entry: this.creatureTemplate.Entry
                  });
                  this.searchPickpocketingReferenceLootTemplates({
                    entries: this.pickpocketingReferenceLootTemplateEntries
                  });
                })
                .then(() => {
                  instance.confirmButtonLoading = false;
                  done();
                });
            } else {
              done();
            }
          }
        }
      );
    },
    select(row) {
      this.currentRow = row;
    },
    async show(row) {
      await this.findPickpocketingLootTemplate({
        entry: row.Entry
      });
      this.creating = true;
      this.editing = true;
    },
    async init() {
      this.loading = true;
      await this.searchPickpocketingLootTemplates({
        entry: this.creatureTemplate.lootid
      });
      await this.searchPickpocketingReferenceLootTemplates({
        entries: this.pickpocketingReferenceLootTemplateEntries
      });
      this.loading = false;
    }
  },
  mounted() {
    this.init();
  }
};
</script>
