<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item>物体管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">物体列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input-number
              controls-position="right"
              v-model="credential.entry"
              placeholder="entry"
            ></el-input-number>
          </el-col>
          <el-col :span="6">
            <el-input v-model="credential.name" placeholder="名称"></el-input>
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
        ref="gameObjectTable"
        :data="gameObjectTemplates"
        highlight-current-row
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column prop="entry" label="编号" sortable></el-table-column>
        <el-table-column prop="name" label="名称" sortable>
          <template slot-scope="scope">
            <template v-if="scope.row.localeName">{{
              scope.row.localeName
            }}</template>
            <template v-else>{{ scope.row.name }}</template>
          </template>
        </el-table-column>
        <el-table-column prop="type" label="类型" sortable></el-table-column>
        <el-table-column prop="size" label="尺寸" sortable></el-table-column>
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
    ...mapState("gameObjectTemplate", [
      "refresh",
      "credential",
      "pagination",
      "gameObjectTemplates",
    ]),
    payload() {
      return {
        entry: this.credential.entry,
        name: this.credential.name,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow === undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("gameObjectTemplate", [
      "searchGameObjectTemplates",
      "countGameObjectTemplates",
      "paginateGameObjectTemplates",
      "destroyGameObjectTemplate",
      "createGameObjectTemplate",
      "copyGameObjectTemplate",
      "resetCredential",
    ]),
    async search() {
      this.loading = true;
      await this.paginateGameObjectTemplates({ page: 1 });
      await Promise.all([
        this.searchGameObjectTemplates(this.payload),
        this.countGameObjectTemplates(this.payload),
      ]);
      this.loading = false;
    },
    reset() {
      this.resetCredential();
    },
    create() {
      this.$router.push("/game-object/create");
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
            this.copyGameObjectTemplate({ entry: this.currentRow.entry })
              .then(() => {
                Promise.all([
                  this.searchGameObjectTemplates(this.payload),
                  this.countGameObjectTemplates(this.payload),
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
              this.destroyGameObjectTemplate({ entry: this.currentRow.entry })
                .then(() => {
                  Promise.all([
                    this.searchGameObjectTemplates(this.payload),
                    this.countGameObjectTemplates(this.payload),
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
      await this.paginateGameObjectTemplates({ page: page });
      await this.searchGameObjectTemplates(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/game-object/${row.entry}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchGameObjectTemplates(this.payload),
        this.countGameObjectTemplates(this.payload),
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
