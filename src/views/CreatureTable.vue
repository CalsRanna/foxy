<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>生物管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">生物模版列表</h3>
    </el-card>
    <el-card style="margin-top: 16px;">
      <el-form>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input-number
              v-model="entry"
              controls-position="right"
              placeholder="Entry"
              style="width: 100%"
            ></el-input-number>
          </el-col>
          <el-col :span="6">
            <el-input v-model="name" placeholder="姓名"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input v-model="subname" placeholder="称号"></el-input>
          </el-col>
          <el-col :span="6" style="text-align: right;">
            <el-button type="primary" @click="search">查询</el-button>
            <el-button @click="reset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <el-card v-loading="loading" style="margin-top: 16px;">
      <el-pagination
        layout="prev, pager, next"
        :current-page="page"
        :total="total"
        :page-size="50"
        hide-on-single-page
        @current-change="paginate"
        style="margin-bottom: 16px"
      ></el-pagination>
      <el-table :data="creatureTemplates" @row-dblclick="show">
        <el-table-column prop="entry" label="ID" sortable></el-table-column>
        <el-table-column label="姓名" sortable>
          <template slot-scope="scope">
            <span v-if="scope.row.localeName !== null">{{
              scope.row.localeName
            }}</span>
            <span v-else>{{ scope.row.name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="称号" sortable>
          <template slot-scope="scope">
            <span v-if="scope.row.localeTitle !== null">{{
              scope.row.localeTitle
            }}</span>
            <span v-else>{{ scope.row.subname }}</span>
          </template>
        </el-table-column>
        <el-table-column
          prop="minlevel"
          label="最小等级"
          sortable
        ></el-table-column>
        <el-table-column
          prop="maxlevel"
          label="最大等级"
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
import axios from "axios";

export default {
  data() {
    return {
      loading: false,
      entry: undefined,
      name: "",
      subname: "",
      page: 1,
      total: 0,
      creatureTemplates: [],
    };
  },
  methods: {
    search() {
      this.loading = true;
      this.currentPage = 1;
      let query = "";
      if (this.entry !== undefined) {
        query = `${query}&entry=${this.entry}`;
      }
      if (this.name !== "") {
        query = `${query}&name=${this.name}`;
      }
      if (this.subname !== "") {
        query = `${query}&subname=${this.subname}`;
      }
      if (query !== "") {
        query = `?${query.substr(1)}`;
      }
      Promise.all([
        axios.get(`/creature-template${query}`).then((response) => {
          this.creatureTemplates = response.data;
        }),
        axios.get(`/creature-template/quantity${query}`).then((response) => {
          this.total = response.data.total;
        }),
      ]).then(() => {
        this.loading = false;
      });
    },
    reset() {
      this.entry = undefined;
      this.name = "";
      this.subname = "";
    },
    show(row) {
      this.$router.push(`/creature/${row.entry}`);
    },
    paginate(currentPage) {
      this.loading = true;
      this.page = currentPage;
      let query = "";
      if (this.entry !== undefined) {
        query = `${query}&entry=${this.entry}`;
      }
      if (this.name !== "") {
        query = `${query}&name=${this.name}`;
      }
      if (this.subname !== "") {
        query = `${query}&subname=${this.subname}`;
      }
      query = `${query}&page=${this.page}`;
      if (query !== "") {
        query = `?${query.substr(1)}`;
      }
      axios.get(`/creature-template${query}`).then((response) => {
        this.loading = false;
        this.creatureTemplates = response.data;
      });
    },
  },
  created() {
    this.loading = true;
    Promise.all([
      axios.get(`/creature-template`).then((response) => {
        this.creatureTemplates = response.data;
      }),
      axios.get(`/creature-template/quantity`).then((response) => {
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

<style></style>
