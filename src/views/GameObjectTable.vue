<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>游戏对象</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">游戏对象列表</h3>
    </el-card>
    <el-card style="margin-top: 16px" v-loading="loading">
      <el-form>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input-number controls-position="right" v-model="entry" placeholder="entry"></el-input-number>
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
        @current-change="handlePaginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table :data="gameObjectTemplates">
        <el-table-column prop="entry" label="编号" sortable></el-table-column>
        <el-table-column prop="displayId" label="Display ID" sortable></el-table-column>
        <el-table-column width="43px" class-name="icon-height">
          <template slot-scope="scope">
            <el-image
              :src="`/icons/${icons[scope.row.displayId]}`"
              style="width: 23px; height:23px;margin: 0; padding: 0px 0 0 0"
            >
              <el-image
                src="/icons/INV_Misc_QuestionMark.png"
                style="width: 23px; height:23px;margin: 0; padding: 0px 0 0 0"
                slot="error"
              ></el-image>
            </el-image>
          </template>
        </el-table-column>
        <el-table-column prop="name" label="名称" sortable>
          <template slot-scope="scope">
            <template v-if="scope.row.localeName !== null">{{ scope.row.localeName }}</template>
            <template v-else>{{ scope.row.name }}</template>
          </template>
        </el-table-column>
        <el-table-column prop="type" label="类型" sortable></el-table-column>
        <el-table-column prop="size" label="尺寸" sortable></el-table-column>
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
import { mapState, mapGetters, mapActions, mapMutations } from "vuex";
import * as TYPES from "@/store/MUTATION_TYPES";

export default {
  data() {
    return {
      loading: false,
      entry: undefined,
      name: undefined
    };
  },
  computed: {
    ...mapState("gameObject", ["gameObjectTemplates", "page", "total"]),
    ...mapGetters("dbc", { icons: "itemIcons" }),
    payload() {
      return { entry: this.entry, name: this.name, page: this.page };
    }
  },
  methods: {
    ...mapActions("gameObject", ["search", "count"]),
    ...mapMutations("gameObject", { paginate: TYPES.PAGINATE_GAME_OBJECT_TEMPLATES }),
    async handleSearch() {
      this.loading = true;
      this.paginate(1); //每次搜索时使分页器设为第一页
      await Promise.all([this.search(this.payload), this.count(this.payload)]);
      this.loading = false;
    },
    reset() {
      this.entry = undefined;
      this.name = undefined;
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
    if (this.gameObjectTemplates.length === 0) {
      this.init();
    }
  }
};
</script>
