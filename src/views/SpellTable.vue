<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>技能</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">技能列表</h3>
    </el-card>
    <el-card style="margin-top: 16px" v-loading="loading">
      <el-form>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="id" placeholder="ID"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input v-model="name" placeholder="名称"></el-input>
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
      <el-table :data="spells" @row-dblclick="show">
        <el-table-column prop="id" label="ID" sortable width="64px"></el-table-column>
        <el-table-column prop="nameLangZhCN" label="名称" width="256px" sortable> </el-table-column>
        <el-table-column prop="rankLangZhCN" label="等级" sortable width="128px"></el-table-column>
        <el-table-column prop="descriptionLangZhCN" label="描述" sortable>
          <template slot-scope="scope">
            <spell-description :spell="scope.row" field="descriptionLangZhCN"></spell-description>
          </template>
        </el-table-column>
        <el-table-column prop="auraDescriptionLangZhCN" label="Buff 描述" sortable>
          <template slot-scope="scope">
            <spell-description :spell="scope.row" field="auraDescriptionLangZhCN"></spell-description>
          </template>
        </el-table-column>
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
import { PAGINATE_SPELLS } from "@/store/MUTATION_TYPES";
import SpellDescription from "@/components/SpellDescription";

export default {
  data() {
    return {
      loading: false,
      id: undefined,
      name: undefined
    };
  },
  computed: {
    ...mapState("spell", ["spells", "total", "page"]),
    ...mapState("dbc", ["spellDurations"]),
    payload() {
      return {
        id: this.id,
        name: this.name,
        page: this.page
      };
    }
  },
  methods: {
    ...mapActions("spell", ["search", "count"]),
    ...mapMutations("spell", {
      paginate: PAGINATE_SPELLS
    }),
    async handleSearch() {
      this.loading = true;
      this.paginate(1); //每次搜索时使分页器设为第一页
      await Promise.all([this.search(this.payload), this.count(this.payload)]);
      this.loading = false;
    },
    reset() {
      this.id = undefined;
      this.name = undefined;
    },
    show(row) {
      this.$router.push(`/spell/${row.id}`);
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
    this.init();
  },
  components: {
    "spell-description": SpellDescription
  }
};
</script>
