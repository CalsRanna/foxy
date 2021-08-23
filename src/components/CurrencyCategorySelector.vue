<template>
  <div>
    <el-input
      v-model="currencyCategory"
      :placeholder="placeholder"
      @input="input"
    >
      <i
        class="el-icon-search clickable-icon"
        slot="suffix"
        style="margin-right: 8px"
        @click="show"
      ></i>
    </el-input>
    <el-dialog
      :visible.sync="visible"
      :show-close="false"
      :close-on-click-modal="false"
      width="68%"
      top="8vh"
    >
      <div slot="title">
        <span style="font-size: 18px; color: #303133; margin-right: 16px">
          货币分类选择器
        </span>
      </div>
      <el-card>
        <el-form @submit.native.prevent="search">
          <el-row :gutter="16">
            <el-col :span="8">
              <el-input-number
                v-model="ID"
                controls-position="right"
                placeholder="ID"
              ></el-input-number>
            </el-col>
            <el-col :span="8">
              <el-input
                v-model="Name_Lang_zhCN"
                placeholder="Name_Lang_zhCN"
              ></el-input>
            </el-col>
            <el-col :span="8">
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
      <el-pagination
        layout="prev, pager, next"
        :current-page="pagination.page"
        :total="pagination.total"
        :page-size="advanceConfig.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table
        :data="currencyCategories"
        :max-height="calculateMaxHeight()"
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"></el-table-column>
        <el-table-column prop="Name_Lang_zhCN" label="名称">
          <template slot-scope="scope">
            <span v-if="scope.row.GrandParentName">
              {{ scope.row.GrandParentName }}
              <span style="margin: 0 8px">/</span>
            </span>
            <span v-if="scope.row.ParentName">
              {{ scope.row.ParentName }}
              <span style="margin: 0 8px">/</span>
            </span>
            <span>
              {{ scope.row.Name_Lang_zhCN }}
            </span>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="() => store(currentRow)">
          保存
        </el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      currencyCategory: undefined,
      ID: undefined,
      Name_Lang_zhCN: undefined,
      visible: false,
      loading: false,
      currentRow: undefined,
    };
  },
  props: {
    value: [Number, String],
    placeholder: String,
  },
  watch: {
    value: function (newValue) {
      this.currencyCategory = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("currencyCategorySelector", [
      "pagination",
      "currencyCategories",
    ]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        Name_Lang_zhCN: this.Name_Lang_zhCN,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
  },
  methods: {
    ...mapActions("currencyCategorySelector", [
      "searchCurrencyCategoriesForSelector",
      "countCurrencyCategoriesForSelector",
      "paginateCurrencyCategoriesForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight * 0.84 - 301
        : this.clientHeight * 0.84 - 241;
    },
    input(currencyCategory) {
      if (isNaN(parseInt(currencyCategory))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(currencyCategory));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchCurrencyCategoriesForSelector(this.payload),
        this.countCurrencyCategoriesForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateCurrencyCategoriesForSelector({ page: 1 });
        await Promise.all([
          this.searchCurrencyCategoriesForSelector(this.payload),
          this.countCurrencyCategoriesForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.Name_Lang_zhCN = undefined;
    },
    async paginate(page) {
      this.paginateCurrencyCategoriesForSelector({ page: page });
      await this.searchCurrencyCategoriesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let currencyCategory =
        this.currencyCategory != undefined
          ? this.currencyCategory
          : this.value;
      this.$emit("input", currencyCategory);
      this.visible = false;
    },
    store(row) {
      let currencyCategory = row != undefined ? row.ID : this.value;
      this.$emit("input", currencyCategory);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchCurrencyCategoriesForSelector(this.payload),
        this.countCurrencyCategoriesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.currencyCategory = this.value;
    this.ID = this.value;
  },
};
</script>
