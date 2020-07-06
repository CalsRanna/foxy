<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
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
            <el-button type="primary" @click="search">查询</el-button>
            <el-button @click="reset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
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
      <el-table :data="questTemplates">
        <el-table-column
          prop="ID"
          label="ID"
          sortable
          min-width="100px"
        ></el-table-column>
        <el-table-column
          prop="LogTitle"
          label="标题"
          min-width="100px"
          sortable
        >
          <template slot-scope="scope">
            <template v-if="scope.row.Title !== null">{{
              scope.row.Title
            }}</template>
            <template v-else>{{ scope.row.LogTitle }}</template>
          </template>
        </el-table-column>
        <el-table-column
          prop="QuestDescription"
          label="描述"
          sortable
          min-width="500px"
        >
          <template slot-scope="scope">
            <template v-if="scope.row.Details !== null">{{
              scope.row.Details
            }}</template>
            <template v-else>{{ scope.row.LogDescription }}</template>
          </template>
        </el-table-column>
        <el-table-column
          prop="QuestType"
          label="类型"
          sortable
        ></el-table-column>
        <el-table-column
          prop="QuestLevel"
          label="等级"
          sortable
        ></el-table-column>
        <el-table-column
          prop="MinLevel"
          label="所需最小等级"
          sortable
        ></el-table-column>
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
import api from "@/api";

export default {
  data() {
    return {
      loading: false,
      ID: undefined,
      LogTitle: undefined,
      questTemplates: [],
      page: 1,
      total: 0,
    };
  },
  methods: {
    search() {
      this.loading = true;
      this.page = 1;
      let payload = {
        ID: this.ID,
        LogTitle: this.LogTitle,
        page: this.page,
      };
      Promise.all([
        api.quest.questTemplate.search(payload).then((response) => {
          this.questTemplates = response.data;
        }),
        api.quest.questTemplate.count(payload).then((response) => {
          this.total = response.data.total;
        }),
      ])
        .then(() => {
          this.loading = false;
        })
        .catch(() => {
          this.loading = false;
        });
    },
    reset() {
      this.ID = undefined;
      this.LogTitle = "";
    },
    paginate(current) {
      this.loading = true;
      this.page = current;
      let payload = {
        ID: this.ID,
        LogTitle: this.LogTitle,
        page: this.page,
      };
      api.quest.questTemplate
        .search(payload)
        .then((response) => {
          this.questTemplates = response.data;
        })
        .then(() => {
          this.loading = false;
        })
        .catch(() => {
          this.loading = false;
        });
    },
  },
  created() {
    this.loading = true;
    Promise.all([
      api.quest.questTemplate.search({}).then((response) => {
        this.questTemplates = response.data;
      }),
      api.quest.questTemplate.count({}).then((response) => {
        this.total = response.data.total;
      }),
    ])
      .then(() => {
        this.loading = false;
      })
      .catch(() => {
        this.loading = false;
      });
  },
};
</script>
