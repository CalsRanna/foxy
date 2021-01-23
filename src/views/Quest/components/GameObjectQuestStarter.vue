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
          :data="gameObjectQuestStarters"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column
            prop="id"
            label="物体编号"
            sortable
          ></el-table-column>
          <el-table-column label="名称" sortable>
            <template slot-scope="scope">
              <span v-if="scope.row.localeName !== null">
                {{ scope.row.localeName }}
              </span>
              <span v-else>{{ scope.row.name }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="quest" label="任务" sortable></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="gameObjectQuestStarter"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="24">
            <el-col :span="6">
              <el-form-item label="任务">
                <el-input-number
                  v-model="gameObjectQuestStarter.quest"
                  controls-position="right"
                  placeholder="quest"
                  v-loading="initing"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="物体编号">
                <el-input-number
                  v-model="gameObjectQuestStarter.id"
                  controls-position="right"
                  placeholder="id"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
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
    ...mapState("questTemplate", ["questTemplate"]),
    ...mapState("gameObjectQuestStarter", [
      "gameObjectQuestStarters",
      "gameObjectQuestStarter",
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        id: this.currentRow != undefined ? this.currentRow.id : undefined,
        quest: this.currentRow != undefined ? this.currentRow.quest : undefined,
      };
    },
  },
  methods: {
    ...mapActions("gameObjectQuestStarter", [
      "searchGameObjectQuestStarters",
      "storeGameObjectQuestStarter",
      "findGameObjectQuestStarter",
      "updateGameObjectQuestStarter",
      "destroyGameObjectQuestStarter",
      "createGameObjectQuestStarter",
      "copyGameObjectQuestStarter",
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createGameObjectQuestStarter({
        quest: this.questTemplate.ID,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeGameObjectQuestStarter(this.gameObjectQuestStarter);
      } else {
        await this.updateGameObjectQuestStarter({
          credential: this.credential,
          gameObjectQuestStarter: this.gameObjectQuestStarter,
        });
      }
      await this.searchGameObjectQuestStarters({
        quest: this.questTemplate.ID,
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
            this.copyGameObjectQuestStarter(this.credential)
              .then(() => {
                this.searchGameObjectQuestStarters({
                  quest: this.questTemplate.ID,
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
              this.destroyGameObjectQuestStarter(this.credential)
                .then(() => {
                  this.searchGameObjectQuestStarters({
                    quest: this.questTemplate.ID,
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
      await this.findGameObjectQuestStarter({
        id: row.id,
        quest: row.quest,
      });
    },
    async init() {
      this.initing = true;
      await this.searchGameObjectQuestStarters({
        quest: this.questTemplate.ID,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
