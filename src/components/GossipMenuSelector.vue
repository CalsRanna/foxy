<template>
  <div>
    <el-input v-model="gossipMenu" :placeholder="placeholder" @input="input">
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
          对话菜单选择器
        </span>
      </div>
      <el-card style="margin-top: 16px">
        <el-form>
          <el-row :gutter="16">
            <el-col :span="6">
              <el-input-number
                v-model="MenuID"
                controls-position="right"
                placeholder="MenuID"
              ></el-input-number>
            </el-col>
            <el-col :span="6">
              <el-input v-model="Text" placeholder="文本"></el-input>
            </el-col>
            <el-col :span="6">
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
        :data="gossipMenus"
        highlight-current-row
        @current-change="select"
        @row-dblclick="(row) => store(row)"
        class="gossipMenu-selector"
      >
        <el-table-column
          prop="MenuID"
          label="对话ID"
          width="80px"
        ></el-table-column>
        <el-table-column
          prop="TextID"
          label="文本ID"
          width="80px"
        ></el-table-column>
        <el-table-column label="文本">
          <template slot-scope="scope">
            <span v-if="scope.row.Text0_0 != '' && scope.row.Text0_0 != null">{{
              scope.row.Text0_0
            }}</span>
            <span
              v-else-if="scope.row.Text0_1 != '' && scope.row.Text0_1 != null"
              >{{ scope.row.Text0_1 }}</span
            >
            <span
              v-else-if="scope.row.text0_0 != '' && scope.row.text0_0 != null"
              >{{ scope.row.text0_0 }}</span
            >
            <span v-else>{{ scope.row.text0_1 }}</span>
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
      gossipMenu: undefined,
      MenuID: undefined,
      Text: undefined,
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
      this.gossipMenu = newValue;
      this.MenuID = newValue;
    },
  },
  computed: {
    ...mapState("gossipMenuSelector", ["pagination", "gossipMenus"]),
    payload() {
      return {
        MenuID: this.MenuID != 0 ? this.MenuID : undefined,
        Text: this.Text,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("gossipMenuSelector", [
      "searchGossipMenusForSelector",
      "countGossipMenusForSelector",
      "paginateGossipMenusForSelector",
    ]),
    input(gossipMenu) {
      if (isNaN(parseInt(gossipMenu))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(gossipMenu));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchGossipMenusForSelector(this.payload),
        this.countGossipMenusForSelector(this.payload),
      ]);
    },
    async search() {
      this.paginateGossipMenusForSelector({ page: 1 }); //每次搜索时使分页器设为第一页
      await Promise.all([
        this.searchGossipMenusForSelector(this.payload),
        this.countGossipMenusForSelector(this.payload),
      ]);
    },
    reset() {
      this.MenuID = undefined;
      this.Text = undefined;
    },
    async paginate(page) {
      this.paginateGossipMenusForSelector({ page: page });
      await this.searchGossipMenusForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let gossipMenu =
        this.gossipMenu != undefined ? this.gossipMenu : this.value;
      this.$emit("input", gossipMenu);
      this.visible = false;
    },
    store(row) {
      let gossipMenu = row != undefined ? row.MenuID : this.value;
      this.$emit("input", gossipMenu);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchGossipMenusForSelector(this.payload),
        this.countGossipMenusForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.gossipMenu = this.value;
    this.MenuID = this.value;
  },
};
</script>

<style scoped>
.gossipMenu-selector {
  max-height: 40vh;
  overflow: auto;
}
.gossipMenu-selector tbody tr {
  cursor: pointer;
}
</style>
