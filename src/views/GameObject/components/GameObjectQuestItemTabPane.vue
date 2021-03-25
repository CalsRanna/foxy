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
          :data="gameObjectQuestItems"
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
        :model="gameObjectQuestItem"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="16">
            <el-col :span="6">
              <el-form-item label="生物ID">
                <el-input-number
                  v-model="gameObjectQuestItem.GameObjectEntry"
                  controls-position="right"
                  v-loading="initing"
                  placeholder="GameObjectEntry"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="编号">
                <el-input-number
                  v-model="gameObjectQuestItem.Idx"
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
                <el-input-number
                  v-model="gameObjectQuestItem.ItemId"
                  controls-position="right"
                  placeholder="ItemId"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="VerifiedBuild">
                <el-input
                  v-model="gameObjectQuestItem.VerifiedBuild"
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
    ...mapState("gameObjectTemplate", ["gameObjectTemplate"]),
    ...mapState("gameObjectQuestItem", [
      "gameObjectQuestItems",
      "gameObjectQuestItem",
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        GameObjectEntry:
          this.currentRow != undefined
            ? this.currentRow.GameObjectEntry
            : undefined,
        Idx: this.currentRow != undefined ? this.currentRow.Idx : undefined,
      };
    },
  },
  methods: {
    ...mapActions("gameObjectQuestItem", [
      "searchGameObjectQuestItems",
      "storeGameObjectQuestItem",
      "findGameObjectQuestItem",
      "updateGameObjectQuestItem",
      "destroyGameObjectQuestItem",
      "createGameObjectQuestItem",
      "copyGameObjectQuestItem",
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createGameObjectQuestItem({
        GameObjectEntry: this.gameObjectTemplate.entry,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeGameObjectQuestItem(this.gameObjectQuestItem);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
      } else {
        await this.updateGameObjectQuestItem({
          credential: this.credential,
          gameObjectQuestItem: this.gameObjectQuestItem,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      await this.searchGameObjectQuestItems({
        gameObjectEntry: this.gameObjectTemplate.entry,
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
            this.copyGameObjectQuestItem(this.credential)
              .then(() => {
                this.searchGameObjectQuestItems({
                  GameObjectEntry: this.gameObjectTemplate.entry,
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
              this.destroyGameObjectQuestItem(this.credential)
                .then(() => {
                  this.searchGameObjectQuestItems({
                    GameObjectEntry: this.gameObjectTemplate.entry,
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
      await this.findGameObjectQuestItem({
        GameObjectEntry: row.GameObjectEntry,
        Idx: row.Idx,
      });
    },
    async init() {
      this.initing = true;
      await this.searchGameObjectQuestItems({
        GameObjectEntry: this.gameObjectTemplate.entry,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
