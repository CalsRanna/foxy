<template>
  <div>
    <el-input
      v-model="itemRandomProperty"
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
          随机属性选择器
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
        :data="itemRandomProperties"
        highlight-current-row
        @current-change="select"
        @row-dblclick="(row) => store(row)"
        class="item-random-properties-selector"
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
      itemRandomProperty: undefined,
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
    value: function (newValue) {
      this.itemRandomProperty = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("itemRandomPropertiesSelector", [
      "pagination",
      "itemRandomProperties",
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
    ...mapActions("itemRandomPropertiesSelector", [
      "searchItemRandomPropertiesForSelector",
      "countItemRandomPropertiesForSelector",
      "paginateItemRandomPropertiesForSelector",
    ]),
    input(itemRandomProperty) {
      if (isNaN(parseInt(itemRandomProperty))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(itemRandomProperty));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchItemRandomPropertiesForSelector(this.payload),
        this.countItemRandomPropertiesForSelector(this.payload),
      ]);
    },
    async search() {
      this.paginateItemRandomPropertiesForSelector({ page: 1 });
      await Promise.all([
        this.searchItemRandomPropertiesForSelector(this.payload),
        this.countItemRandomPropertiesForSelector(this.payload),
      ]);
    },
    reset() {
      this.ID = undefined;
      this.Name = undefined;
    },
    async paginate(page) {
      this.paginateItemRandomPropertiesForSelector({ page: page });
      await this.searchItemRandomPropertiesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let itemRandomProperty =
        this.itemRandomProperty != undefined
          ? this.itemRandomProperty
          : this.value;
      this.$emit("input", itemRandomProperty);
      this.visible = false;
    },
    store(row) {
      let itemRandomProperty = row != undefined ? row.ID : this.value;
      this.$emit("input", itemRandomProperty);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchItemRandomPropertiesForSelector(this.payload),
        this.countItemRandomPropertiesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.itemRandomProperty = this.value;
    this.ID = this.value;
  },
};
</script>

<style scoped>
.item-random-properties-selector {
  max-height: 40vh;
  overflow: auto;
}
.item-random-properties-selector tbody tr {
  cursor: pointer;
}
</style>
