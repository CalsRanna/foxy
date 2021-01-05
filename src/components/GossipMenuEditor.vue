<template>
  <div>
    <el-input v-model="gossipMenuId" :placeholder="placeholder" @input="input" @change="blur">
      <i class="el-icon-s-operation clickable-icon" slot="suffix" style="margin-right: 8px" @click="showDialog"></i>
    </el-input>
    <el-dialog :visible.sync="visible" :show-close="false" :close-on-click-modal="false" @opened="init">
      <div slot="title">
        <span style="font-size: 18px; color: #303133; margin-right: 16px">对话选项编辑器</span>
        <el-button size="mini" @click="addGossipMenu">新增</el-button>
      </div>
      <el-card style="margin-top: 16px">
        <el-form>
          <el-row :gutter="16">
            <el-col :span="6">
              <el-input-number
                v-model="gossipMenuId"
                controls-position="right"
                placeholder="ID"
                style="width: 100%"
              ></el-input-number>
            </el-col>
            <el-col :span="6">
              <el-input v-model="text" placeholder="文本"></el-input>
            </el-col>
            <el-col :span="6">
              <el-button type="primary" @click="handleSearch">查询</el-button>
              <el-button @click="reset">重置</el-button>
            </el-col>
          </el-row>
        </el-form>
      </el-card>
      <el-pagination
        layout="prev, pager, next"
        :current-page="page"
        :total="total"
        :page-size="size"
        hide-on-single-page
        @current-change="handlePaginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table
        :data="gossipMenus"
        highlight-current-row
        @current-change="select"
        @row-dblclick="handleDoubleClick"
        class="gossip-menu-editor"
      >
        <el-table-column prop="MenuID" label="编号" width="80px"> </el-table-column>
        <el-table-column label="文本">
          <template slot-scope="scope">
            <span v-if="scope.row.Text0_0 !== null">{{ scope.row.Text0_0 }}</span>
            <span v-else>{{ scope.row.text0_0 }}</span>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        layout="prev, pager, next"
        :current-page="page"
        :total="total"
        :page-size="size"
        hide-on-single-page
        @current-change="handlePaginate"
        style="margin-top: 16px"
      ></el-pagination>
      <div slot="footer">
        <el-button @click="closeDialog">取消</el-button>
        <el-button type="primary" @click="store">保存</el-button>
      </div>
      <el-dialog width="30%" title="内层 Dialog" :visible.sync="innerVisible" append-to-body> </el-dialog>
    </el-dialog>
  </div>
</template>

<style scoped>
.gossip-menu-editor {
  max-height: 40vh;
  overflow: auto;
}
.gossip-menu-editor tbody tr {
  cursor: pointer;
}
</style>

<script>
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      gossipMenuId: undefined,
      text: undefined,
      visible: false,
      size: 50,
      currentRow: undefined,
      innerVisible: false
    };
  },
  props: {
    value: [Number, String],
    placeholder: String
  },
  watch: {
    value: function(newValue) {
      this.gossipMenuId = newValue;
    }
  },
  computed: {
    ...mapState("gossipMenu", ["page", "total", "gossipMenus"]),
    payload() {
      return {
        menuId: this.gossipMenuId,
        text: this.text,
        page: this.page
      };
    }
  },
  methods: {
    ...mapActions("gossipMenu", ["searchGossipMenus", "countGossipMenus", "paginateGossipMenus"]),
    input(gossipMenuId) {
      this.$emit("input", gossipMenuId);
    },
    blur(gossipMenuId) {
      if (isNaN(parseInt(gossipMenuId))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(gossipMenuId));
      }
    },
    showDialog() {
      this.visible = true;
    },
    addGossipMenu() {},
    async handleSearch() {
      this.paginateGossipMenus({ page: 1 }); //每次搜索时使分页器设为第一页
      await Promise.all([this.searchGossipMenus(this.payload), this.countGossipMenus(this.payload)]);
    },
    reset() {
      this.gossipMenuId = undefined;
      this.text = undefined;
    },
    async handlePaginate(page) {
      await this.paginateGossipMenus({ page: page });
      await this.searchGossipMenus(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    handleDoubleClick(row) {
      this.$emit("input", row.MenuID);
      this.visible = false;
    },
    closeDialog() {
      this.visible = false;
    },
    store() {
      this.$emit("input", this.currentRow.MenuID);
      this.visible = false;
    },
    async init() {
      await Promise.all([this.searchGossipMenus(this.payload), this.countGossipMenus(this.payload)]);
    }
  },
  created() {
    this.gossipMenuId = this.value;
  }
};
</script>
