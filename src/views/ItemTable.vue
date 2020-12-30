<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>物品管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">物品模版列表</h3>
    </el-card>
    <el-card style="margin-top: 16px">
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
        <template v-if="filter.class !== 16">
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
        </template>
        <!-- index in [1, 2, 3, 4, 5, 6, 7, 8, 9, 11]，不取值0和10，隐藏雕文职业本地化数组中的空字符 -->
        <template v-else>
          <el-button
            type="text"
            size="small"
            v-for="index in [1, 2, 3, 4, 5, 6, 7, 8, 9, 11]"
            :key="`subclass-${index}`"
            @click="
              () => {
                filtrate('subclass', index);
              }
            "
            >{{ localeSubclasses[filter.class][index] }}</el-button
          >
        </template>
      </div>
      <!-- [2, 4, 6, 11]分别为武器，护甲，弹药，箭袋 -->
      <div v-if="[2, 4].indexOf(filter.class) >= 0">
        <span style="font-size: 14px">佩戴位置：</span>
        <el-button
          type="text"
          size="small"
          v-for="(localeInventoryType, index) in localeInventoryTypes"
          :key="`localeInventoryType-${index}`"
          @click="
            () => {
              filtrate('InventoryType', index);
            }
          "
          >{{ localeInventoryType }}</el-button
        >
      </div>
      <div
        v-if="filter.class !== undefined || filter.subclass !== undefined || filter.InventoryType !== undefined"
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
          v-if="filter.InventoryType !== undefined"
          >{{ localeInventoryTypes[filter.InventoryType] }}</el-tag
        >
      </div>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-form @submit.native.prevent="handleSearch">
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
            <el-button type="primary" native-type="submit" :loading="loading" @click="handleSearch">查询</el-button>
            <el-button @click="reset">重置</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-button type="primary" @click="create">新增</el-button>
      <el-button :disabled="disabled" @click="handleCopy">复制</el-button>
      <el-button type="danger" :disabled="disabled" @click="handleDestroy">删除</el-button>
    </el-card>
    <el-card v-loading="loading" style="margin-top: 16px">
      <el-pagination
        layout="prev, pager, next"
        :current-page="page"
        :total="total"
        :page-size="pageSize"
        hide-on-single-page
        @current-change="handlePaginate"
        style="margin-bottom: 16px"
      ></el-pagination>
      <el-table :data="itemTemplates" highlight-current-row @current-change="select" @row-dblclick="show">
        <el-table-column prop="entry" label="ID" sortable></el-table-column>
        <el-table-column label="名称" sortable>
          <item-template-name slot-scope="scope" :itemTemplate="scope.row"></item-template-name>
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
        <el-table-column prop="ItemLevel" label="物品等级" sortable></el-table-column>
        <el-table-column prop="RequiredLevel" label="需求等级" sortable></el-table-column>
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

<style>
.icon-height .cell {
  height: 23px !important;
}
</style>

<script>
import { colors, localeClasses, localeSubclasses, localeInventoryTypes } from "../locales/item.js";

import ItemTemplateName from "@/components/ItemTemplateName";

import { mapState, mapGetters, mapActions } from "vuex";

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
        InventoryType: undefined,
      },
      loading: false,
      entry: undefined,
      name: undefined,
      pageSize: 50,
      currentRow: undefined,
    };
  },
  computed: {
    ...mapState("item", {
      page: (state) => state.page,
      total: (state) => state.total,
      itemTemplates: (state) => state.itemTemplates,
    }),
    ...mapGetters("dbc", { icons: "itemIcons" }),
    payload() {
      return {
        class: this.filter.class,
        subclass: this.filter.subclass,
        InventoryType: this.filter.InventoryType,
        entry: this.entry,
        name: this.name,
        page: this.page,
      };
    },
    disabled() {
      return this.currentRow === undefined || this.currentRow === null ? true : false;
    },
  },
  methods: {
    ...mapActions("item", [
      "searchItemTemplates",
      "countItemTemplates",
      "paginateItemTemplates",
      "destroyItemTemplate",
      "createItemTemplate",
      "copyItemTemplate",
    ]),
    async filtrate(field, index) {
      if (field === "class") {
        this.filter.class = index;
        this.filter.subclass = undefined;
        this.filter.InventoryType = undefined;
      }
      if (field === "subclass") {
        this.filter.subclass = index;
        this.filter.InventoryType = undefined;
      }
      if (field === "InventoryType") {
        this.filter.InventoryType = index;
      }
      if (field === "closeClass") {
        this.filter.class = undefined;
        this.filter.subclass = undefined;
        this.filter.InventoryType = undefined;
      }
      if (field === "closeSubclass") {
        this.filter.subclass = undefined;
        this.filter.InventoryType = undefined;
      }
      if (field === "closeInventoryType") {
        this.filter.InventoryType = undefined;
      }
      this.entry = undefined;
      this.name = undefined;
      await this.paginateItemTemplates({ page: 1 });
      this.loading = true;
      await Promise.all([this.searchItemTemplates(this.payload), this.countItemTemplates(this.payload)]);
      this.loading = false;
    },
    async handleSearch() {
      this.loading = true;
      await this.paginateItemTemplates({ page: 1 }); //每次搜索时使分页器设为第一页
      await Promise.all([this.searchItemTemplates(this.payload), this.countItemTemplates(this.payload)]);
      this.loading = false;
    },
    reset() {
      this.entry = undefined;
      this.name = undefined;
    },
    create() {
      this.$router.push("/item/create");
    },
    handleCopy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？</small>", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
        beforeClose: (action, instance, done) => {
          if (action === "confirm") {
            instance.confirmButtonLoading = true;
            this.copyItemTemplate({ entry: this.currentRow.entry })
              .then(() => {
                Promise.all([this.searchItemTemplates(this.payload), this.countItemTemplates(this.payload)]);
              })
              .then(() => {
                instance.confirmButtonLoading = false;
                done();
              });
          } else {
            done();
          }
        },
      });
    },
    handleDestroy() {
      this.$confirm(
        "此操作将永久删除该数据，确认继续？<br><small>为避免误操作，不提供删除关联表数据功能。</small>",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "error",
          dangerouslyUseHTMLString: true,
          beforeClose: (action, instance, done) => {
            if (action === "confirm") {
              instance.confirmButtonLoading = true;
              this.destroyItemTemplate({ entry: this.currentRow.entry })
                .then(() => {
                  Promise.all([this.searchItemTemplates(this.payload), this.countItemTemplates(this.payload)]);
                })
                .then(() => {
                  instance.confirmButtonLoading = false;
                  done();
                });
            } else {
              done();
            }
          },
        }
      );
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    async handlePaginate(page) {
      this.loading = true;
      await this.paginateItemTemplates({ page: page });
      await this.searchItemTemplates(this.payload);
      this.loading = false;
    },
    show(row) {
      this.$router.push(`/item/${row.entry}`);
    },
    async init() {
      this.loading = true;
      await Promise.all([this.searchItemTemplates(this.payload), this.countItemTemplates(this.payload)]);
      this.loading = false;
    },
  },
  created() {
    if (this.itemTemplates.length === 0) {
      this.init();
    }
  },
  components: {
    "item-template-name": ItemTemplateName,
  },
};
</script>

<style></style>
