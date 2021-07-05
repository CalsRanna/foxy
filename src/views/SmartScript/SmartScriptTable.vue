<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item>内建脚本管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">内建脚本列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input
              v-model="credential.entryorguid"
              placeholder="Entry Or GUID"
            ></el-input>
          </el-col>
          <el-col :span="6">
            <el-input
              v-model="credential.comment"
              placeholder="comment"
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
        :data="smartScripts"
        highlight-current-row
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column
          prop="entryorguid"
          label="编号"
          width="80px"
          sortable
        ></el-table-column>
        <el-table-column prop="source_type" label="类型" sortable>
          <template slot-scope="scope">
            {{ sourceTypes[scope.row.source_type] }}
          </template>
        </el-table-column>
        <el-table-column prop="id" label="编号" sortable></el-table-column>
        <el-table-column prop="link" label="链接" sortable></el-table-column>
        <el-table-column prop="event_type" label="事件类型" sortable>
          <template slot-scope="scope">
            {{ eventTypes[scope.row.event_type] }}
          </template>
        </el-table-column>
        <el-table-column prop="action_type" label="动作类型" sortable>
          <template slot-scope="scope">
            {{ actionTypes[scope.row.action_type] }}
          </template>
        </el-table-column>
        <el-table-column prop="target_type" label="目标类型" sortable>
          <template slot-scope="scope">
            {{ targetTypes[scope.row.target_type] }}
          </template>
        </el-table-column>
        <el-table-column prop="comment" label="备注" sortable min-width="200px">
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
import {
  sourceTypes,
  eventTypes,
  actionTypes,
  targetTypes,
} from "@/locales/smartScript";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      loading: false,
      currentRow: undefined,
      sourceTypes: sourceTypes,
      eventTypes: eventTypes,
      actionTypes: actionTypes,
      targetTypes: targetTypes,
    };
  },
  computed: {
    ...mapState("smartScript", [
      "refresh",
      "credential",
      "pagination",
      "smartScripts",
    ]),
    payload() {
      return {
        entryorguid: this.credential.entryorguid,
        comment: this.credential.comment,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow === undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("smartScript", [
      "searchSmartScripts",
      "countSmartScripts",
      "paginateSmartScripts",
      "destroySmartScript",
      "copySmartScript",
      "resetCredential",
    ]),
    async search() {
      this.loading = true;
      this.paginateSmartScripts({ page: 1 });
      await Promise.all([
        this.searchSmartScripts(this.payload),
        this.countSmartScripts(this.payload),
      ]);
      this.loading = false;
    },
    reset() {
      this.resetCredential();
    },
    create() {
      this.$router.push("/smart-script/create");
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
            this.copySmartScript({
              entryorguid: this.currentRow.entryorguid,
              source_type: this.currentRow.source_type,
              id: this.currentRow.id,
              link: this.currentRow.link,
            })
              .then(() => {
                Promise.all([
                  this.searchSmartScripts(this.payload),
                  this.countSmartScripts(this.payload),
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
              this.destroySmartScript({
                entryorguid: this.currentRow.entryorguid,
                source_type: this.currentRow.source_type,
                id: this.currentRow.id,
                link: this.currentRow.link,
              })
                .then(() => {
                  Promise.all([
                    this.searchSmartScripts(this.payload),
                    this.countSmartScripts(this.payload),
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
      this.paginateSmartScripts({ page: page });
      await this.searchSmartScripts(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(
        `/smart-script/${row.id}?entryorguid=${row.entryorguid}&source_type=${row.source_type}&link=${row.link}`
      );
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchSmartScripts(this.payload),
        this.countSmartScripts(this.payload),
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
