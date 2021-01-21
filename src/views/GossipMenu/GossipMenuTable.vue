<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item>对话管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">对话列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input-number
              v-model="credential.MenuID"
              controls-position="right"
              placeholder="MenuID"
            ></el-input-number>
          </el-col>
          <el-col :span="6">
            <el-input v-model="credential.Text" placeholder="Text"></el-input>
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
    <el-card v-loading="loading" style="margin-top: 16px">
      <el-pagination
        layout="prev, pager, next"
        :current-page="pagination.page"
        :total="pagination.total"
        :page-size="pagination.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-bottom: 16px"
      ></el-pagination>
      <el-table
        ref="creatureTable"
        :data="gossipMenus"
        highlight-current-row
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column
          prop="MenuID"
          label="对话ID"
          width="160"
          sortable
        ></el-table-column>
        <el-table-column
          prop="TextID"
          label="文本ID"
          width="160"
          sortable
        ></el-table-column>
        <el-table-column label="文本" sortable>
          <template slot-scope="scope">
            <span v-if="scope.row.Text0_0 != '' && scope.row.Text0_0 != null">{{
              scope.row.Text0_0
            }}</span>
            <span
              v-else-if="scope.row.Text0_1 != '' && scope.row.Text0_1 != null"
              >{{ scope.row.Text0_1 }}</span
            >
            <span
              v-else-if="scope.row.text0_0 != '' && scope.row.text0_0 != null"
              >{{ scope.row.text0_0 }}</span
            >
            <span v-else>{{ scope.row.text0_1 }}</span>
          </template>
        </el-table-column>
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
    ...mapState("gossipMenu", [
      "refresh",
      "credential",
      "pagination",
      "gossipMenus",
    ]),
    payload() {
      return {
        MenuID: this.credential.MenuID,
        Text: this.credential.Text,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("gossipMenu", [
      "searchGossipMenus",
      "countGossipMenus",
      "paginateGossipMenus",
      "createGossipMenu",
      "destroyGossipMenu",
      "copyGossipMenu",
      "resetCredential",
    ]),
    async search() {
      this.loading = true;
      await this.paginateGossipMenus({ page: 1 }); //每次搜索时使分页器设为第一页
      await Promise.all([
        this.searchGossipMenus(this.payload),
        this.countGossipMenus(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/gossip-menu/create");
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
            this.copyGossipMenu({
              MenuID: this.currentRow.MenuID,
              TextID: this.currentRow.TextID,
            })
              .then(() => {
                Promise.all([
                  this.searchGossipMenus(this.payload),
                  this.countGossipMenus(this.payload),
                ]);
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

              this.destroyGossipMenu({
                MenuID: this.currentRow.MenuID,
                TextID: this.currentRow.TextID,
              })
                .then(() => {
                  Promise.all([
                    this.searchGossipMenus(this.payload),
                    this.countGossipMenus(this.payload),
                  ]);
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
    select(currentRow) {
      this.currentRow = currentRow;
    },
    async paginate(page) {
      this.loading = true;
      await this.paginateGossipMenus({ page: page });
      await this.searchGossipMenus(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/gossip-menu/${row.MenuID}?TextID=${row.TextID}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchGossipMenus(this.payload),
        this.countGossipMenus(this.payload),
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

<style></style>
