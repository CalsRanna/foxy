<template>
  <div>
    <div v-show="!creating">
      <el-card style="margin-top: 1px">
        <el-button type="primary" @click="create">新增</el-button>
        <el-button @click="copy" :disabled="disabled">复制</el-button>
        <el-button type="danger" @click="destroy" :disabled="disabled">
          删除
        </el-button>
      </el-card>
      <el-card style="margin-top: 16px">
        <el-table
          :data="achievementCriteriaDatas"
          highlight-current-row
          :max-height="calculateMaxHeight()"
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="criteria_id" label="编号" width="80px" />
          <el-table-column prop="type" label="类型" />
          <el-table-column prop="value1" label="值" />
          <el-table-column prop="value2" label="值" />
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="achievementCriteriaData"
        label-position="right"
        label-width="120px"
      >
        <div
          :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }"
        >
          <el-card style="margin-top: 1px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="标准ID">
                  <el-input-number
                    v-model="achievementCriteriaData.criteria_id"
                    controls-position="right"
                    v-loading="initing"
                    placeholder="criteria_id"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="类型">
                  <el-input-number
                    v-model="achievementCriteriaData.type"
                    controls-position="right"
                    v-loading="initing"
                    placeholder="type"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="值">
                  <el-input-number
                    v-model="achievementCriteriaData.value1"
                    controls-position="right"
                    placeholder="value1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="值">
                  <el-input-number
                    v-model="achievementCriteriaData.value2"
                    controls-position="right"
                    placeholder="value2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="脚本名称">
                  <el-input
                    v-model="achievementCriteriaData.ScriptName"
                    placeholder="ScriptName"
                  />
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
        </div>
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
    ...mapState("app", ["clientHeight"]),
    ...mapState("achievementCriteria", ["achievementCriteria"]),
    ...mapState("achievementCriteriaData", [
      "achievementCriteriaDatas",
      "achievementCriteriaData",
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        criteria_id:
          this.currentRow != undefined
            ? this.currentRow.criteria_id
            : undefined,
        type: this.currentRow != undefined ? this.currentRow.type : undefined,
      };
    },
  },
  methods: {
    ...mapActions("achievementCriteriaData", [
      "searchAchievementCriteriaDatas",
      "storeAchievementCriteriaData",
      "findAchievementCriteriaData",
      "updateAchievementCriteriaData",
      "destroyAchievementCriteriaData",
      "createAchievementCriteriaData",
      "copyAchievementCriteriaData",
    ]),
    calculateMaxHeight() {
      return this.creating ? this.clientHeight - 307 : this.clientHeight - 349;
    },
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createAchievementCriteriaData({
        criteria_id: this.achievementCriteria.ID,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeAchievementCriteriaData(this.achievementCriteriaData);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
      } else {
        await this.updateAchievementCriteriaData({
          credential: this.credential,
          achievementCriteriaData: this.achievementCriteriaData,
        });
        this.$notify({
          title: "修改成功",
          position: "top-right",
          type: "success",
        });
      }
      await this.searchAchievementCriteriaDatas({
        criteria_id: this.achievementCriteria.ID,
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
            this.copyAchievementCriteriaData(this.credential)
              .then(() => {
                this.searchAchievementCriteriaDatas({
                  criteria_id: this.achievementCriteria.ID,
                });
              })
              .then(() => {
                this.$notify({
                  title: "复制成功",
                  position: "top-right",
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
              this.destroyAchievementCriteriaData(this.credential)
                .then(() => {
                  this.searchAchievementCriteriaDatas({
                    criteria_id: this.achievementCriteria.ID,
                  });
                })
                .then(() => {
                  this.$notify({
                    title: "删除成功",
                    position: "top-right",
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
      await this.findAchievementCriteriaData({
        criteria_id: row.criteria_id,
        type: row.type,
      });
    },
    async init() {
      this.initing = true;
      await this.searchAchievementCriteriaDatas({
        criteria_id: this.achievementCriteria.ID,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
