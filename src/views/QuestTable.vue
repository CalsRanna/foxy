<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>任务</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">任务列表</h3>
    </el-card>
    <el-card style="margin-top: 16px" v-loading="loading">
      <el-form>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="ID" placeholder="ID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input v-model="LogTitle" placeholder="标题"></el-input>
          </el-col>
          <el-col :span="6">
            <el-button type="primary" @click="handleSearch">查询</el-button>
            <el-button @click="reset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <el-card v-loading="loading" style="margin-top: 16px;">
      <el-button type="primary">新增</el-button>
      <el-button disabled>复制</el-button>
      <el-button type="danger" disabled>删除</el-button>
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
      <el-table :data="questTemplates">
        <el-table-column prop="ID" label="ID" sortable></el-table-column>
        <el-table-column prop="LogTitle" label="标题" min-width="100px" sortable>
          <template slot-scope="scope">
            <template v-if="scope.row.Title !== null">{{ scope.row.Title }}</template>
            <template v-else>{{ scope.row.LogTitle }}</template>
          </template>
        </el-table-column>
        <el-table-column prop="QuestDescription" label="描述" sortable min-width="500px">
          <template slot-scope="scope">
            <template v-if="scope.row.Details !== null">{{ scope.row.Details }}</template>
            <template v-else>{{ scope.row.LogDescription }}</template>
          </template>
        </el-table-column>
        <el-table-column prop="QuestType" label="类型" sortable></el-table-column>
        <el-table-column prop="QuestLevel" label="等级" sortable></el-table-column>
        <el-table-column prop="MinLevel" label="所需最小等级" sortable></el-table-column>
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
      ID: undefined,
      LogTitle: undefined
    };
  },
  computed: {
    ...mapState("quest", ["questTemplates", "page", "total"]),
    payload() {
      return {
        id: this.ID,
        title: this.LogTitle,
        page: this.page
      };
    }
  },
  methods: {
    ...mapActions("quest", ["search", "count"]),
    ...mapMutations("quest", { paginate: TYPES.PAGINATE_QUEST_TEMPLATES }),
    async handleSearch() {
      this.loading = true;
      this.paginate(1); //每次搜索时使分页器设为第一页
      await Promise.all([this.search(this.payload), this.count(this.payload)]);
      this.loading = false;
    },
    reset() {
      this.ID = undefined;
      this.LogTitle = "";
    },
    async handlePaginate(page) {
      this.loading = true;
      this.paginate(page);
      await this.search(this.payload);
      this.loading = false;
    },
    async init() {
      this.loading = true;
      await Promise.all([this.search(this.payload), this.count(this.payload)]);
      this.loading = false;
    }
  },
  created() {
    if (this.questTemplates.length === 0) {
      this.init();
    }
  }
};
</script>
