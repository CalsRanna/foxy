<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>内建脚本</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">内建脚本列表</h3>
    </el-card>
    <el-card style="margin-top: 16px" v-loading="loading">
      <el-form>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="entryorguid" placeholder="Entry Or GUID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input v-model="comment" placeholder="备注"></el-input>
          </el-col>
          <el-col :span="6">
            <el-button type="primary" @click="search">查询</el-button>
            <el-button @click="reset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <el-card v-loading="loading" style="margin-top: 16px;">
      <el-button type="primary">新增</el-button>
      <el-button disabled>复制</el-button>
      <el-button disabled>修改</el-button>
      <el-button type="danger" disabled>删除</el-button>
    </el-card>
    <el-card style="margin-top: 16px" v-loading="loading">
      <el-pagination
        layout="prev, pager, next"
        :current-page="page"
        :total="total"
        :page-size="50"
        hide-on-single-page
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table :data="smartScripts">
        <el-table-column prop="entryorguid" label="Entry Or GUID" sortable></el-table-column>
        <el-table-column prop="source_type" label="类型" sortable></el-table-column>
        <el-table-column prop="id" label="编号" sortable></el-table-column>
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
      entryorguid: undefined,
      comment: undefined
      // questTemplates: [],
      // page: 1,
      // total: 0
    };
  },
  computed: {
    ...mapState("smartScript", ["smartScripts", "page", "total"]),
    payload() {
      return {
        entryorguid: this.entryorguid,
        comment: this.comment
      };
    }
  },
  methods: {
    ...mapActions("smartScript", ["search"]),
    // search() {
    //   this.loading = true;
    //   this.page = 1;
    // },
    reset() {
      this.ID = undefined;
      this.LogTitle = "";
    },
    paginate(current) {
      this.loading = true;
      this.page = current;
    }
  },
  created() {
    // this.loading = true;
    this.search(this.payload);
  }
};
</script>
