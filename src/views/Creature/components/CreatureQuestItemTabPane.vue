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
            <span slot-scope="scope">
              <template v-if="scope.row.localeName !== null">
                {{ scope.row.localeName }}
              </template>
              <template v-else>{{ scope.row.name }}</template>
            </span>
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
          <el-row :gutter="24">
            <el-col :span="6">
              <el-form-item label="编号">
                <el-input-number
                  v-model="creatureQuestItem.Idx"
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
      "creatureQuestItems",
      "creatureQuestItem"
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        creatureEntry:
          this.currentRow != undefined
            ? this.currentRow.CreatureEntry
            : undefined
      };
    }
  },
  methods: {
    ...mapActions("creature", [
      "searchCreatureQuestItems",
      "storeCreatureQuestItem",
      "findCreatureQuestItem",
      "updateCreatureQuestItem",
      "destroyCreatureQuestItem",
      "createCreatureQuestItem",
      "copyCreatureQuestItem"
    ]),
    async create() {
      await this.createCreatureQuestItem({
        creatureEntry: this.creatureTemplate.CreatureEntry
      });
      this.creating = true;
    },
    async store() {
      if (!this.editing) {
        await this.storeCreatureQuestItem(this.creatureQuestItem);
      } else {
        await this.updateCreatureQuestItem({
          credential: this.credential,
          creatureQuestItem: this.creatureQuestItem
        });
      }
      await this.searchCreatureQuestItems({
        creatureEntry: this.creatureTemplate.CreatureEntry
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
            this.copyCreatureQuestItem({
              creatureEntry: this.currentRow.CreatureEntry
            })
              .then(() => {
                this.searchCreatureQuestItems({
                  creatureEntry: this.creatureTemplate.CreatureEntry
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
              this.destroyCreatureQuestItem({
                creatureEntry: this.currentRow.CreatureEntry
              })
                .then(() => {
                  this.searchCreatureQuestItems({
                    creatureEntry: this.creatureTemplate.CreatureEntry
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
      await this.findCreatureQuestItem({
        creatureEntry: row.CreatureEntry
      });
      this.creating = true;
      this.editing = true;
    },
    async init() {
      this.loading = true;
      let id = this.$route.params.id;
      await this.searchCreatureQuestItems({ creatureEntry: id });
      this.loading = false;
    }
  },
  mounted() {
    this.init();
  }
};
</script>
