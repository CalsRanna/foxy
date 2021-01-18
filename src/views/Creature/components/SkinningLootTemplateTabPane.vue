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
          :data="skinningLootTemplates"
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
        v-for="(skinningReferenceLootTemplates,
        index) in groupedSkinningReferenceLootTemplates"
        :key="`skinningReferenceLootTemplates-${index}`"
        :header="`关联掉落${skinningReferenceLootTemplates[0].Entry}`"
        style="margin-top: 16px"
      >
        <el-table :data="skinningReferenceLootTemplates">
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
        :model="skinningLootTemplate"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="24">
            <el-col :span="6">
              <el-form-item label="编号">
                <el-input-number
                  v-model="skinningLootTemplate.Idx"
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
      "skinningLootTemplates",
      "skinningLootTemplate",
      "skinningReferenceLootTemplates"
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        entry: this.currentRow != undefined ? this.currentRow.Entry : undefined
      };
    },
    skinningReferenceLootTemplateEntries() {
      let entries = [];
      for (let skinningLootTemplate of this.skinningLootTemplates) {
        if (skinningLootTemplate.Reference != 0) {
          entries.push(skinningLootTemplate.Reference);
        }
      }
      return entries;
    },
    groupedSkinningReferenceLootTemplates() {
      let groups = {};
      this.skinningReferenceLootTemplates.forEach(
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
      "searchSkinningLootTemplates",
      "storeSkinningLootTemplate",
      "findSkinningLootTemplate",
      "updateSkinningLootTemplate",
      "destroySkinningLootTemplate",
      "createSkinningLootTemplate",
      "copySkinningLootTemplate",
      "searchSkinningReferenceLootTemplates"
    ]),
    async create() {
      await this.createSkinningLootTemplate({
        entry: this.creatureTemplate.lootid
      });
      this.creating = true;
    },
    async store() {
      if (!this.editing) {
        await this.storeSkinningLootTemplate(this.skinningLootTemplate);
      } else {
        await this.updateSkinningLootTemplate({
          credential: this.credential,
          skinningLootTemplate: this.skinningLootTemplate
        });
      }
      await this.searchSkinningLootTemplates({
        entry: this.creatureTemplate.Entry
      });
      await this.searchSkinningReferenceLootTemplates({
        entries: this.skinningReferenceLootTemplateEntries
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
            this.copySkinningLootTemplate({
              entry: this.currentRow.Entry
            })
              .then(() => {
                this.searchSkinningLootTemplates({
                  entry: this.creatureTemplate.Entry
                });
                this.searchSkinningReferenceLootTemplates({
                  entries: this.skinningReferenceLootTemplateEntries
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
              this.destroySkinningLootTemplate({
                entry: this.currentRow.Entry
              })
                .then(() => {
                  this.searchSkinningLootTemplates({
                    entry: this.creatureTemplate.Entry
                  });
                  this.searchSkinningReferenceLootTemplates({
                    entries: this.skinningReferenceLootTemplateEntries
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
      await this.findSkinningLootTemplate({
        entry: row.Entry
      });
      this.creating = true;
      this.editing = true;
    },
    async init() {
      this.loading = true;
      await this.searchSkinningLootTemplates({
        entry: this.creatureTemplate.lootid
      });
      await this.searchSkinningReferenceLootTemplates({
        entries: this.skinningReferenceLootTemplateEntries
      });
      this.loading = false;
    }
  },
  mounted() {
    this.init();
  }
};
</script>
