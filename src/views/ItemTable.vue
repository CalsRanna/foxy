<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
        <el-breadcrumb-item>物品管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">物品模版列表</h3>
    </el-card>
    <el-card style="margin-top: 16px;" v-loading="loading">
      <div>
        <span style="font-size: 14px">类别：</span>
        <el-button
          type="text"
          size="small"
          v-for="(localeClass, index) in localeClasses"
          :key="`class-${index}`"
          @click="
            () => {
              filtrate('class', index);
            }
          "
          >{{ localeClass }}</el-button
        >
      </div>
      <div v-if="filter.class !== undefined">
        <span style="font-size: 14px">子类别：</span>
        <el-button
          type="text"
          size="small"
          v-for="(localeSubclass, index) in localeSubclasses[filter.class]"
          :key="`subclass-${index}`"
          @click="
            () => {
              filtrate('subclass', index);
            }
          "
          >{{ localeSubclass }}</el-button
        >
      </div>
      <div v-if="[2, 4, 6, 11].indexOf(filter.class) >= 0">
        <span style="font-size: 14px">佩戴位置：</span>
        <el-button
          type="text"
          size="small"
          v-for="(localeInventoryType, index) in localeInventoryTypes"
          :key="`localeInventoryType-${index}`"
          @click="
            () => {
              filtrate('inventoryType', index);
            }
          "
          >{{ localeInventoryType }}</el-button
        >
      </div>
      <div
        v-if="
          filter.class !== undefined ||
            filter.subclass !== undefined ||
            filter.inventoryType !== undefined
        "
        style="margin-top: 16px"
      >
        <el-tag
          size="small"
          closable
          @close="() => filtrate('closeClass', undefined)"
          v-if="filter.class !== undefined"
          style="margin-right: 8px"
          >{{ localeClasses[filter.class] }}</el-tag
        >
        <el-tag
          size="small"
          closable
          @close="() => filtrate('closeSubclass', undefined)"
          v-if="filter.subclass !== undefined"
          style="margin-right: 8px"
          >{{ localeSubclasses[filter.class][filter.subclass] }}</el-tag
        >
        <el-tag
          size="small"
          closable
          @close="() => filtrate('closeInventoryType', undefined)"
          v-if="filter.inventoryType !== undefined"
          >{{ localeInventoryTypes[filter.inventoryType] }}</el-tag
        >
      </div>
    </el-card>
    <el-card style="margin-top: 16px;">
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
          <el-input v-model="name" placeholder="名称"></el-input>
        </el-col>
        <el-col :span="6">
          <el-button type="primary" @click="search">查询</el-button>
          <el-button @click="reset">重置</el-button>
        </el-col>
      </el-row>
    </el-card>
    <el-card v-loading="loading" style="margin-top: 16px;">
      <el-button type="primary">新增</el-button>
      <el-button disabled>复制</el-button>
      <el-button disabled>修改</el-button>
      <el-button type="danger" disabled>删除</el-button>
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
      <el-table :data="itemTemplates" @row-dblclick="show">
        <el-table-column prop="entry" label="ID" sortable></el-table-column>
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
        <el-table-column label="名称" sortable>
          <span
            slot-scope="scope"
            :style="{ color: colors[scope.row.Quality] }"
          >
            <template v-if="scope.row.localeName !== null">{{
              scope.row.localeName
            }}</template>
            <template v-else>{{ scope.row.name }}</template>
          </span>
        </el-table-column>
        <el-table-column prop="class" label="类别" sortable>
          <span slot-scope="scope">
            {{ localeClasses[scope.row.class] }}
          </span>
        </el-table-column>
        <el-table-column prop="subclass" label="子类别" sortable>
          <span slot-scope="scope">
            {{ localeSubclasses[scope.row.class][scope.row.subclass] }}
          </span></el-table-column
        >
        <el-table-column prop="InventoryType" label="佩戴位置" sortable>
          <span slot-scope="scope">
            {{ localeInventoryTypes[scope.row.InventoryType] }}
          </span></el-table-column
        >
        <el-table-column
          prop="ItemLevel"
          label="物品等级"
          sortable
        ></el-table-column>
        <el-table-column
          prop="RequiredLevel"
          label="需求等级"
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

<style>
.icon-height .cell {
  height: 23px !important;
}
</style>

<script>
import axios from "axios";
import icons from "@/libs/icons";

import {
  colors,
  localeClasses,
  localeSubclasses,
  localeInventoryTypes,
} from "../locales/item.js";
export default {
  data() {
    return {
      colors: colors,
      localeClasses: localeClasses,
      localeSubclasses: localeSubclasses,
      localeInventoryTypes: localeInventoryTypes,
      filter: {
        class: undefined,
        subclass: undefined,
        inventoryType: undefined,
      },
      loading: false,
      entry: undefined,
      name: "",
      page: 1,
      total: 0,
      itemTemplates: [],
      icons: icons,
    };
  },
  methods: {
    filtrate(field, index) {
      if (field === "class") {
        this.filter.class = index;
        this.filter.subclass = undefined;
        this.filter.inventoryType = undefined;
      }
      if (field === "subclass") {
        this.filter.subclass = index;
        this.filter.inventoryType = undefined;
      }
      if (field === "inventoryType") {
        this.filter.inventoryType = index;
      }
      if (field === "closeClass") {
        this.filter.class = undefined;
        this.filter.subclass = undefined;
        this.filter.inventoryType = undefined;
      }
      if (field === "closeSubclass") {
        this.filter.subclass = undefined;
        this.filter.inventoryType = undefined;
      }
      if (field === "closeInventoryType") {
        this.filter.inventoryType = undefined;
      }
      this.loading = true;
      this.entry = undefined;
      this.name = "";
      this.page = 1;
      let query = "";
      if (this.filter.class !== undefined) {
        query = `${query}&class=${this.filter.class}`;
      }
      if (this.filter.subclass !== undefined) {
        query = `${query}&subclass=${this.filter.subclass}`;
      }
      if (this.filter.inventoryType !== undefined) {
        query = `${query}&inventoryType=${this.filter.inventoryType}`;
      }
      if (query !== "") {
        query = `?${query.substr(1)}`;
      }
      Promise.all([
        axios.get(`/item-template${query}`).then((response) => {
          this.itemTemplates = response.data;
        }),
        axios.get(`/item-template/quantity${query}`).then((response) => {
          this.total = response.data.total;
        }),
      ]).then(() => {
        this.loading = false;
      });
    },
    search() {
      this.loading = true;
      this.page = 1;
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
        axios.get(`/item-template${query}`).then((response) => {
          this.itemTemplates = response.data;
        }),
        axios.get(`/item-template/quantity${query}`).then((response) => {
          this.total = response.data.total;
        }),
      ]).then(() => {
        this.loading = false;
      });
    },
    reset() {
      this.entry = undefined;
      this.name = "";
    },
    show(row) {
      this.$router.push(`/item/${row.entry}`);
    },
    paginate(currentPage) {
      this.page = currentPage;
      this.loading = true;
      let query = "";
      if (this.filter.class !== undefined) {
        query = `${query}&class=${this.filter.class}`;
      }
      if (this.filter.subclass !== undefined) {
        query = `${query}&subclass=${this.filter.subclass}`;
      }
      if (this.filter.inventoryType !== undefined) {
        query = `${query}&inventoryType=${this.filter.inventoryType}`;
      }
      if (query !== "") {
        query = `?${query.substr(1)}`;
      }
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
      axios.get(`/item-template${query}`).then((response) => {
        this.loading = false;
        this.itemTemplates = response.data;
      });
    },
  },
  created() {
    this.loading = true;
    Promise.all([
      axios.get(`/item-template`).then((response) => {
        this.itemTemplates = response.data;
      }),
      axios.get(`/item-template/quantity`).then((response) => {
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
