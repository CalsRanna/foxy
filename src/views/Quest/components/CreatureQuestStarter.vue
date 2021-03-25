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
          :data="creatureQuestStarters"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column
            prop="id"
            label="生物编号"
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
        :model="creatureQuestStarter"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="16">
            <el-col :span="6">
              <el-form-item label="任务">
                <el-input-number
                  v-model="creatureQuestStarter.quest"
                  controls-position="right"
                  placeholder="quest"
                  v-loading="initing"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="生物编号">
                <el-input-number
                  v-model="creatureQuestStarter.id"
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
    ...mapState("creatureQuestStarter", [
      "creatureQuestStarters",
      "creatureQuestStarter",
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
    ...mapActions("creatureQuestStarter", [
      "searchCreatureQuestStarters",
      "storeCreatureQuestStarter",
      "findCreatureQuestStarter",
      "updateCreatureQuestStarter",
      "destroyCreatureQuestStarter",
      "createCreatureQuestStarter",
      "copyCreatureQuestStarter",
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createCreatureQuestStarter({
        quest: this.questTemplate.ID,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeCreatureQuestStarter(this.creatureQuestStarter);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
      } else {
        await this.updateCreatureQuestStarter({
          credential: this.credential,
          creatureQuestStarter: this.creatureQuestStarter,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      await this.searchCreatureQuestStarters({
        quest: this.questTemplate.ID,
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
            this.copyCreatureQuestStarter(this.credential)
              .then(() => {
                this.searchCreatureQuestStarters({
                  quest: this.questTemplate.ID,
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
              this.destroyCreatureQuestStarter(this.credential)
                .then(() => {
                  this.searchCreatureQuestStarters({
                    quest: this.questTemplate.ID,
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
      await this.findCreatureQuestStarter({
        id: row.id,
        quest: row.quest,
      });
    },
    async init() {
      this.initing = true;
      await this.searchCreatureQuestStarters({ quest: this.questTemplate.ID });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
