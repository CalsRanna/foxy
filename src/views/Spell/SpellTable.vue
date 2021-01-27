<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item>技能管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">技能列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input v-model="credential.id" placeholder="ID"></el-input>
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
    <el-card style="margin-top: 16px" v-loading="loading">
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
        :data="spells"
        highlight-current-row
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column
          prop="id"
          label="ID"
          sortable
          width="64px"
        ></el-table-column>
        <el-table-column
          prop="nameLangZhCN"
          label="名称"
          width="256px"
          sortable
        >
        </el-table-column>
        <el-table-column
          prop="rankLangZhCN"
          label="子名称"
          sortable
          width="128px"
        ></el-table-column>
        <el-table-column prop="descriptionLangZhCN" label="描述" sortable>
          <template slot-scope="scope">
            <spell-description
              :spell="scope.row"
              field="descriptionLangZhCN"
            ></spell-description>
          </template>
        </el-table-column>
        <el-table-column
          prop="auraDescriptionLangZhCN"
          label="Buff 描述"
          sortable
        >
          <template slot-scope="scope">
            <spell-description
              :spell="scope.row"
              field="auraDescriptionLangZhCN"
            ></spell-description>
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

import SpellDescription from "@/components/SpellDescription";

export default {
  data() {
    return {
      loading: false,
      currentRow: undefined,
    };
  },
  computed: {
    ...mapState("spell", ["refresh", "credential", "pagination", "spells"]),
    ...mapState("dbc", ["spellDurations"]),
    payload() {
      return {
        id: this.credential.id,
        name: this.credential.name,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow == undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("spell", [
      "searchSpells",
      "countSpells",
      "paginateSpells",
      "resetCredential",
    ]),
    async search() {
      this.loading = true;
      this.paginateSpells({ page: 1 }); //每次搜索时使分页器设为第一页
      await Promise.all([
        this.searchSpells(this.payload),
        this.countSpells(this.payload),
      ]);
      this.loading = false;
    },
    async reset() {
      await this.resetCredential();
    },
    create() {
      this.$router.push("/spell/create");
    },
    copy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？</small>", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
      })
        .then(() => {
          // this.copy({ entry: this.currentRow.entry }).then(() => {
          //   Promise.all([this.search(this.payload), this.count(this.payload)]);
          // });
        })
        .catch(async () => {});
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
    async paginate(page) {
      this.loading = true;
      this.paginateSpells({ page: page });
      await this.searchSpells(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/spell/${row.id}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([
        this.searchSpells(this.payload),
        this.countSpells(this.payload),
      ]);
      this.loading = false;
    },
  },
  mounted() {
    if (this.refresh) {
      this.init();
    }
  },
  components: {
    SpellDescription,
  },
};
</script>
