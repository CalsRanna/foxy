<template>
  <div>
    <el-input
      v-model="itemRandomSuffix"
      :placeholder="placeholder"
      @input="input"
    >
      <i
        class="el-icon-s-operation clickable-icon"
        slot="suffix"
        style="margin-right: 8px"
        @click="show"
      ></i>
    </el-input>
    <el-dialog
      :visible.sync="visible"
      :show-close="false"
      :close-on-click-modal="false"
    >
      <div slot="title">
        <span style="font-size: 18px; color: #303133; margin-right: 16px">
          随机前缀选择器
        </span>
      </div>
      <el-card>
        <el-form>
          <el-row :gutter="16">
            <el-col :span="8">
              <el-input-number
                v-model="ID"
                controls-position="right"
                placeholder="ID"
              ></el-input-number>
            </el-col>
            <el-col :span="8">
              <el-input v-model="Name" placeholder="名称"></el-input>
            </el-col>
            <el-col :span="8">
              <el-button type="primary" @click="search">查询</el-button>
              <el-button @click="reset">重置</el-button>
            </el-col>
          </el-row>
        </el-form>
      </el-card>
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
        :data="itemRandomSuffixes"
        highlight-current-row
        @current-change="select"
        @row-dblclick="(row) => store(row)"
        class="item-random-suffixes-selector"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column prop="Name_Lang_zhCN" label="名称"></el-table-column>
        <el-table-column prop="Enchantment_1" label="属性1"></el-table-column>
        <el-table-column prop="Enchantment_2" label="属性2"></el-table-column>
        <el-table-column prop="Enchantment_3" label="属性3"></el-table-column>
        <el-table-column prop="Enchantment_4" label="属性4"></el-table-column>
        <el-table-column prop="Enchantment_5" label="属性5"></el-table-column>
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
      itemRandomSuffix: undefined,
      ID: undefined,
      Name: undefined,
      visible: false,
      currentRow: undefined,
    };
  },
  props: {
    value: [Number, String],
    placeholder: String,
  },
  watch: {
    value: function(newValue) {
      this.itemRandomSuffix = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("itemRandomSuffixSelector", [
      "pagination",
      "itemRandomSuffixes",
    ]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        Name: this.Name,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("itemRandomSuffixSelector", [
      "searchItemRandomSuffixesForSelector",
      "countItemRandomSuffixesForSelector",
      "paginateItemRandomSuffixesForSelector",
    ]),
    input(itemRandomSuffix) {
      if (isNaN(parseInt(itemRandomSuffix))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(itemRandomSuffix));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchItemRandomSuffixesForSelector(this.payload),
        this.countItemRandomSuffixesForSelector(this.payload),
      ]);
    },
    async search() {
      this.paginateItemRandomSuffixesForSelector({ page: 1 });
      await Promise.all([
        this.searchItemRandomSuffixesForSelector(this.payload),
        this.countItemRandomSuffixesForSelector(this.payload),
      ]);
    },
    reset() {
      this.ID = undefined;
      this.Name = undefined;
    },
    async paginate(page) {
      this.paginateItemRandomSuffixesForSelector({ page: page });
      await this.searchItemRandomSuffixesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let itemRandomSuffix =
        this.itemRandomSuffix != undefined ? this.itemRandomSuffix : this.value;
      this.$emit("input", itemRandomSuffix);
      this.visible = false;
    },
    store(row) {
      let itemRandomSuffix = row != undefined ? row.ID : this.value;
      this.$emit("input", itemRandomSuffix);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchItemRandomSuffixesForSelector(this.payload),
        this.countItemRandomSuffixesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.itemRandomSuffix = this.value;
    this.ID = this.value;
  },
};
</script>

<style scoped>
.item-random-suffixes-selector {
  max-height: 40vh;
  overflow: auto;
}
.item-random-suffixes-selector tbody tr {
  cursor: pointer;
}
</style>
