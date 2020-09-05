<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
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
          <el-col :span="6">
            <el-button type="primary" @click="handleSearch">查询</el-button>
            <el-button @click="reset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <el-card style="margin-top: 16px;">
      <el-button type="primary" @click="create">新增</el-button>
      <el-button disabled>复制</el-button>
      <el-button disabled>修改</el-button>
      <el-button type="danger" disabled>删除</el-button>
    </el-card>
    <el-card v-loading="loading" style="margin-top: 16px;">
      <el-pagination
        layout="prev, pager, next"
        :current-page="page"
        :total="total"
        :page-size="pageSize"
        hide-on-single-page
        @current-change="handlePaginate"
        style="margin-bottom: 16px"
      ></el-pagination>
      <el-table :data="creatureTemplates" @row-dblclick="show">
        <el-table-column prop="entry" label="ID" sortable></el-table-column>
        <el-table-column label="姓名" sortable>
          <template slot-scope="scope">
            <span v-if="scope.row.localeName !== null">{{ scope.row.localeName }}</span>
            <span v-else>{{ scope.row.name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="称号" sortable>
          <template slot-scope="scope">
            <span v-if="scope.row.localeTitle !== null">{{ scope.row.localeTitle }}</span>
            <span v-else>{{ scope.row.subname }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="minlevel" label="最小等级" sortable></el-table-column>
        <el-table-column prop="maxlevel" label="最大等级" sortable></el-table-column>
      </el-table>
      <el-pagination
        layout="prev, pager, next"
        :current-page="page"
        :total="total"
        :page-size="pageSize"
        hide-on-single-page
        @current-change="handlePaginate"
        style="margin-top: 16px"
      ></el-pagination>
    </el-card>
  </div>
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";
import * as types from "@/store/MUTATION_TYPES";

export default {
  data() {
    return {
      loading: false,
      entry: undefined,
      name: "",
      subname: "",
      pageSize: 50
    };
  },
  computed: {
    ...mapState("creature", {
      page: "page",
      total: "total",
      creatureTemplates: "creatureTemplates"
    }),
    payload() {
      return {
        entry: this.entry,
        name: this.name,
        subname: this.subname,
        page: this.page
      };
    }
  },
  methods: {
    ...mapActions("creature", ["search", "count"]),
    ...mapMutations("creature", { paginate: types.PAGINATE_CREATURE_TEMPLATES }),
    async handleSearch() {
      this.loading = true;
      this.paginate(1); //每次搜索时使分页器设为第一页
      await Promise.all([this.search(this.payload), this.count(this.payload)]);
      this.loading = false;
    },
    reset() {
      this.entry = undefined;
      this.name = "";
      this.subname = "";
    },
    create() {
      this.$router.push("/creature/create");
    },
    show(row) {
      this.$router.push(`/creature/${row.entry}`);
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
    if (this.creatureTemplates.length === 0) {
      this.init();
    }
  }
};
</script>

<style></style>
