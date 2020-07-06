<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
        <el-breadcrumb-item>游戏对象</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">游戏对象列表</h3>
    </el-card>
    <el-card style="margin-top: 16px" v-loading="loading">
      <el-form>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input-number
              controls-position="right"
              v-model="entry"
              placeholder="entry"
            ></el-input-number>
          </el-col>
          <el-col :span="6">
            <el-input v-model="name" placeholder="名称"></el-input>
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
      <el-table :data="gameObejctTemplates">
        <el-table-column prop="entry" label="entry" sortable></el-table-column>
        <el-table-column
          prop="displayId"
          label="Display ID"
          sortable
        ></el-table-column>
        <el-table-column width="43px" class-name="icon-height">
          <template slot-scope="scope">
            <el-image
              :src="`/icons/${icons[scope.row.displayid]}`"
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
            <template v-if="scope.row.localeName !== null">{{
              scope.row.localeName
            }}</template>
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
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
    </el-card>
  </div>
</template>

<script>
import api from "@/api";
import icons from '@/libs/icons';

export default {
  data() {
    return {
      loading: false,
      entry: undefined,
      name: undefined,
      gameObejctTemplates: [],
      page: 1,
      total: 0,
      icons:icons,
    };
  },
  methods: {
    search() {
      this.loading = true;
      let payload = {
        entry: this.entry,
        name: this.name,
        page: this.page,
      };
      Promise.all([
        api.gameObject.gameObjectTemplate.search(payload).then((response) => {
          this.gameObejctTemplates = response.data;
        }),
        api.gameObject.gameObjectTemplate.count(payload).then((response) => {
          this.total = response.data.total;
        }),
      ])
        .then(() => {
          this.loading = false;
        })
        .catch(() => {
          this.laoding = false;
        });
    },
    reset() {
      this.entry = undefined;
      this.name = undefined;
    },
    paginate(current) {
      this.loading = true;
      this.page = current;
      let payload = {
        entry: this.entry,
        name: this.name,
        page: this.page,
      };
      api.gameObject.gameObejctTemplate
        .search(payload)
        .then((response) => {
          this.gameObejctTemplates = response.data;
          this.loading = false;
        })
        .catch(() => {
          this.laoding = false;
        });
    },
  },
  created() {
    this.search();
  },
};
</script>
