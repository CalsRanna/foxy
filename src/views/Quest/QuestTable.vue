<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item>任务管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">任务列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.ID" placeholder="ID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input
              v-model="credential.LogTitle"
              placeholder="LogTitle"
            ></el-input>
          </el-col>
          <el-col :span="6">
            <el-button
              type="primary"
              native-type="submit"
              :loading="loading"
              @click="search"
            >
              查询
            </el-button>
            <el-button @click="reset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-button type="primary" @click="create">新增</el-button>
      <el-button :disabled="disabled" @click="copy">复制</el-button>
      <el-button type="danger" :disabled="disabled" @click="destroy">
        删除
      </el-button>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-pagination
        layout="prev, pager, next"
        :current-page="pagination.page"
        :total="pagination.total"
        :page-size="advanceConfig.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-bottom: 16px"
      ></el-pagination>
      <el-table
        ref="questTable"
        :data="questTemplates"
        highlight-current-row
        :max-height="calculateMaxHeight()"
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column prop="ID" label="编号" width="80px"></el-table-column>
        <el-table-column prop="LogTitle" label="标题" min-width="100px">
          <template slot-scope="scope">
            <template v-if="scope.row.Title">
              {{ scope.row.Title }}
            </template>
            <template v-else>{{ scope.row.LogTitle }}</template>
          </template>
        </el-table-column>
        <el-table-column prop="QuestDescription" label="描述" min-width="500px">
          <template slot-scope="scope">
            <template v-if="scope.row.Details">
              {{ scope.row.Details }}
            </template>
            <template v-else>{{ scope.row.LogDescription }}</template>
          </template>
        </el-table-column>
        <el-table-column prop="QuestType" label="类型"></el-table-column>
        <el-table-column prop="QuestLevel" label="等级"></el-table-column>
        <el-table-column prop="MinLevel" label="最低等级"></el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      loading: false,
      currentRow: undefined,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("questTemplate", [
      "refresh",
      "credential",
      "pagination",
      "questTemplates",
    ]),
    payload() {
      return {
        id: this.credential.ID,
        title: this.credential.LogTitle,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("questTemplate", [
      "searchQuestTemplates",
      "countQuestTemplates",
      "paginateQuestTemplates",
      "destroyQuestTemplate",
      "copyQuestTemplate",
      "resetCredential",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight - 440
        : this.clientHeight - 392;
    },
    async search() {
      this.loading = true;
      await this.paginateQuestTemplates({ page: 1 });
      await Promise.all([
        this.searchQuestTemplates(this.payload),
        this.countQuestTemplates(this.payload),
      ]);
      this.loading = false;
    },
    reset() {
      this.resetCredential();
    },
    create() {
      this.$router.push("/quest/create");
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
            this.copyQuestTemplate({ ID: this.currentRow.ID })
              .then(() => {
                Promise.all([
                  this.searchQuestTemplates(this.payload),
                  this.countQuestTemplates(this.payload),
                ]);
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
              this.destroyQuestTemplate({ ID: this.currentRow.ID })
                .then(() => {
                  Promise.all([
                    this.searchQuestTemplates(this.payload),
                    this.countQuestTemplates(this.payload),
                  ]);
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
    select(currentRow) {
      this.currentRow = currentRow;
    },
    async paginate(page) {
      this.loading = true;
      await this.paginateQuestTemplates({ page: page });
      await this.searchQuestTemplates(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/quest/${row.ID}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchQuestTemplates(this.payload),
        this.countQuestTemplates(this.payload),
      ]);
      this.loading = false;
    },
  },
  mounted() {
    if (this.refresh) {
      this.init();
    }
  },
};
</script>
