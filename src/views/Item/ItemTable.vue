<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
        <el-breadcrumb-item>物品管理</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">物品列表</h3>
    </el-card>
    <item-template-filter
      @filtrate="filtrate"
      style="margin-top: 16px"
    ></item-template-filter>
    <el-card style="margin-top: 16px">
      <el-form :model="credential" @submit.native.prevent="search">
        <el-row :gutter="16">
          <el-col :span="6">
            <el-input-number
              v-model="credential.entry"
              controls-position="right"
              placeholder="Entry"
            ></el-input-number>
          </el-col>
          <el-col :span="6">
            <el-input v-model="credential.name" placeholder="name"></el-input>
          </el-col>
          <el-col :span="6">
            <el-input
              v-model="credential.description"
              placeholder="description"
            ></el-input>
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
    <el-card style="margin-top: 16px">
      <el-pagination
        layout="prev, pager, next"
        :current-page="pagination.page"
        :total="pagination.total"
        :page-size="pagination.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-bottom: 16px"
      ></el-pagination>
      <el-table
        :data="itemTemplates"
        highlight-current-row
        class="hide-when-overflow tight-table"
        @current-change="select"
        @row-dblclick="show"
      >
        <el-table-column
          prop="entry"
          label="编号"
          width="80px"
        ></el-table-column>
        <el-table-column label="名称" min-width="160">
          <item-template-name
            slot-scope="scope"
            :itemTemplate="scope.row"
          ></item-template-name>
        </el-table-column>
        <el-table-column prop="class" label="类别">
          <span slot-scope="scope">
            {{ localeClasses[scope.row.class] }}
          </span>
        </el-table-column>
        <el-table-column prop="subclass" label="子类别">
          <span slot-scope="scope">
            {{ localeSubclasses[scope.row.class][scope.row.subclass] }}
          </span></el-table-column
        >
        <el-table-column prop="InventoryType" label="佩戴位置">
          <span slot-scope="scope">
            {{ localeInventoryTypes[scope.row.InventoryType] }}
          </span></el-table-column
        >
        <el-table-column prop="ItemLevel" label="物品等级"></el-table-column>
        <el-table-column
          prop="RequiredLevel"
          label="需求等级"
        ></el-table-column>
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

<style>
.icon-height .cell {
  height: 23px !important;
}
</style>

<script>
import {
  colors,
  localeClasses,
  localeSubclasses,
  localeInventoryTypes,
} from "@/locales/item.js";

import ItemTemplateFilter from "@/views/Item/components/ItemTemplateFilter";
import ItemTemplateName from "@/components/ItemTemplateName";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      loading: false,
      currentRow: undefined,
      colors: colors,
      localeClasses: localeClasses,
      localeSubclasses: localeSubclasses,
      localeInventoryTypes: localeInventoryTypes,
    };
  },
  computed: {
    ...mapState("itemTemplate", [
      "refresh",
      "filter",
      "credential",
      "pagination",
      "itemTemplates",
    ]),
    payload() {
      return {
        class: this.filter.class,
        subclass: this.filter.subclass,
        entry: this.credential.entry,
        name: this.credential.name,
        description: this.credential.description,
        page: this.pagination.page,
      };
    },
    disabled() {
      return this.currentRow === undefined ? true : false;
    },
  },
  methods: {
    ...mapActions("itemTemplate", [
      "searchItemTemplates",
      "countItemTemplates",
      "paginateItemTemplates",
      "destroyItemTemplate",
      "createItemTemplate",
      "copyItemTemplate",
      "resetCredential",
    ]),
    async filtrate() {
      this.loading = true;
      await this.paginateItemTemplates({ page: 1 });
      await Promise.all([
        this.searchItemTemplates(this.payload),
        this.countItemTemplates(this.payload),
      ]);
      this.loading = false;
    },
    async search() {
      this.loading = true;
      await this.paginateItemTemplates({ page: 1 });
      await Promise.all([
        this.searchItemTemplates(this.payload),
        this.countItemTemplates(this.payload),
      ]);
      this.loading = false;
    },
    reset() {
      this.resetCredential();
    },
    create() {
      this.$router.push("/item/create");
    },
    copy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？", "确认复制", {
        confirmButtonText: "确认",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
        beforeClose: (action, instance, done) => {
          if (action === "confirm") {
            instance.confirmButtonLoading = true;
            this.copyItemTemplate({ entry: this.currentRow.entry })
              .then(() => {
                Promise.all([
                  this.searchItemTemplates(this.payload),
                  this.countItemTemplates(this.payload),
                ]);
              })
              .then(() => {
                this.$notify({
                  title: "复制成功",
                  position: "bottom-left",
                  type: "success",
                });
                instance.confirmButtonLoading = false;
                done();
              });
          } else {
            done();
          }
        },
      });
    },
    destroy() {
      this.$confirm(
        "此操作将永久删除该数据，确认继续？<br><small>为避免误操作，不提供删除关联表数据功能。</small>",
        "确认删除",
        {
          confirmButtonText: "确认",
          cancelButtonText: "取消",
          type: "info",
          dangerouslyUseHTMLString: true,
          beforeClose: (action, instance, done) => {
            if (action === "confirm") {
              instance.confirmButtonLoading = true;
              this.destroyItemTemplate({ entry: this.currentRow.entry })
                .then(() => {
                  Promise.all([
                    this.searchItemTemplates(this.payload),
                    this.countItemTemplates(this.payload),
                  ]);
                })
                .then(() => {
                  this.$notify({
                    title: "删除成功",
                    position: "bottom-left",
                    type: "success",
                  });
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
    async paginate(page) {
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
      await Promise.all([
        this.searchItemTemplates(this.payload),
        this.countItemTemplates(this.payload),
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
    ItemTemplateFilter,
    ItemTemplateName,
  },
};
</script>
