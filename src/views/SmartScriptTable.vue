<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>内建脚本</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">内建脚本列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form @submit.native.prevent="handleSearch">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="entryorguid" placeholder="Entry Or GUID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input v-model="comment" placeholder="备注"></el-input>
          </el-col>
          <el-col :span="6">
            <el-button type="primary" native-type="submit" :loading="loading" @click="handleSearch">查询</el-button>
            <el-button @click="reset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <el-card style="margin-top: 16px;">
      <el-button type="primary" @click="create">新增</el-button>
      <el-button :disabled="disabled" @click="handleCopy">复制</el-button>
      <el-button type="danger" :disabled="disabled" @click="handleDestroy">删除</el-button>
    </el-card>
    <el-card style="margin-top: 16px" v-loading="loading">
      <el-pagination
        layout="prev, pager, next"
        :current-page="page"
        :total="total"
        :page-size="50"
        hide-on-single-page
        @current-change="handlePaginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table :data="smartScripts" highlight-current-row @current-change="select" @row-dblclick="show">
        <el-table-column prop="entryorguid" label="Entry Or GUID" sortable></el-table-column>
        <el-table-column prop="source_type" label="类型" sortable></el-table-column>
        <el-table-column prop="id" label="编号" sortable></el-table-column>
        <el-table-column prop="link" label="链接" sortable></el-table-column>
        <el-table-column prop="event_type" label="事件类型" sortable> </el-table-column>
        <el-table-column prop="action_type" label="动作类型" sortable> </el-table-column>
        <el-table-column prop="target_type" label="目标类型" sortable> </el-table-column>
        <el-table-column prop="comment" label="备注" sortable min-width="200px"> </el-table-column>
      </el-table>
      <el-pagination
        layout="prev, pager, next"
        :current-page="page"
        :total="total"
        :page-size="50"
        hide-on-single-page
        @current-change="handlePaginate"
        style="margin-top: 16px"
      ></el-pagination>
    </el-card>
  </div>
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";
import * as TYPES from "@/store/MUTATION_TYPES";

export default {
  data() {
    return {
      loading: false,
      entryorguid: undefined,
      comment: undefined,
      currentRow: undefined
    };
  },
  computed: {
    ...mapState("smartScript", ["smartScripts", "page", "total"]),
    payload() {
      return {
        entryorguid: this.entryorguid,
        comment: this.comment,
        page: this.page
      };
    },
    disabled() {
      return this.currentRow === undefined || this.currentRow === null ? true : false;
    }
  },
  methods: {
    ...mapActions("smartScript", ["search", "count"]),
    ...mapMutations("smartScript", { paginate: TYPES.PAGINATE_SMART_SCRIPTS }),
    async handleSearch() {
      this.loading = true;
      this.paginate(1); //每次搜索时使分页器设为第一页
      await Promise.all([this.search(this.payload), this.count(this.payload)]);
      this.loading = false;
    },
    reset() {
      this.entryorguid = undefined;
      this.comment = "";
    },
    create() {
      this.$router.push("/smart-script/create");
    },
    handleCopy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？</small>", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true
      })
        .then(() => {
          // this.copy({ entry: this.currentRow.entry }).then(() => {
          //   Promise.all([this.search(this.payload), this.count(this.payload)]);
          // });
        })
        .catch(async () => {});
    },
    handleDestroy() {
      this.$confirm(
        "此操作将永久删除该数据，确认继续？<br><small>为避免误操作，不提供删除关联表数据功能。</small>",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "error",
          dangerouslyUseHTMLString: true
        }
      )
        .then(() => {
          // this.destroy({ entry: this.currentRow.entry }).then(() => {
          //   Promise.all([this.search(this.payload), this.count(this.payload)]);
          // });
        })
        .catch(() => {});
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    async handlePaginate(page) {
      this.loading = true;
      this.paginate(page);
      await this.search(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(
        `/smart-script/${row.id}?entryorguid=${row.entryorguid}&sourceType=${row.source_type}&link=${row.link}`
      );
    },
    async init() {
      this.loading = true;
      await Promise.all([this.search(this.payload), this.count(this.payload)]);
      this.loading = false;
    }
  },
  created() {
    if (this.smartScripts.length === 0) {
      this.init();
    }
  }
};
</script>
