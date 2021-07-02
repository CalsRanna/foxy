<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/advance' }">
          高级
        </el-breadcrumb-item>
        <el-breadcrumb-item>任务信息管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">任务信息列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.ID" placeholder="ID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input
              v-model="credential.InfoName_Lang_zhCN"
              placeholder="名称"
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
        :page-size="pagination.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table
        :data="questInfos"
        highlight-current-row
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column prop="ID" label="编号" sortable width="80px">
        </el-table-column>
        <el-table-column
          prop="InfoName_Lang_zhCN"
          label="名称"
          sortable
        ></el-table-column>
        <el-table-column
          prop="InfoName_Lang_Mask"
          label="名称掩码"
        ></el-table-column>
      </el-table>
      <el-pagination
        layout="prev, pager, next"
        :current-page="pagination.page"
        :total="pagination.total"
        :page-size="pagination.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
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
    ...mapState("questInfo", [
      "refresh",
      "credential",
      "pagination",
      "questInfos",
    ]),
    payload() {
      return {
        ID: this.credential.ID,
        InfoName_Lang_zhCN: this.credential.InfoName_Lang_zhCN,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("questInfo", [
      "searchQuestInfos",
      "countQuestInfos",
      "paginateQuestInfos",
      "copyQuestInfo",
      "destroyQuestInfo",
      "resetCredential",
    ]),
    async search() {
      this.loading = true;
      this.paginateQuestInfos({ page: 1 });
      await Promise.all([
        this.searchQuestInfos(this.payload),
        this.countQuestInfos(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/quest-info/create");
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
            this.copyQuestInfo({ ID: this.currentRow.ID })
              .then(() => {
                Promise.all([
                  this.searchQuestInfos(this.payload),
                  this.countQuestInfos(this.payload),
                ]);
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
              this.destroyQuestInfo({ ID: this.currentRow.ID })
                .then(() => {
                  Promise.all([
                    this.searchQuestInfos(this.payload),
                    this.countQuestInfos(this.payload),
                  ]);
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
    select(currentRow) {
      this.currentRow = currentRow;
    },
    async paginate(page) {
      this.loading = true;
      this.paginateQuestInfos({ page: page });
      await this.searchQuestInfos(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/quest-info/${row.ID}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchQuestInfos(this.payload),
        this.countQuestInfos(this.payload),
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
