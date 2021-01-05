<template>
  <div>
    <el-input v-model="id" :placeholder="placeholder" @input="input" @change="blur">
      <i class="el-icon-s-operation clickable-icon" slot="suffix" style="margin-right: 8px" @click="showDialog"></i>
    </el-input>
    <el-dialog :visible.sync="visible" :show-close="false" :close-on-click-modal="false" @opened="init">
      <div slot="title">
        <span style="font-size: 18px; color: #303133; margin-right: 16px">技能选择器</span>
        <el-button size="mini" @click="addSpell">新增</el-button>
      </div>
      <el-card style="margin-top: 16px">
        <el-form>
          <el-row :gutter="16">
            <el-col :span="6">
              <el-input-number
                v-model="id"
                controls-position="right"
                placeholder="ID"
                style="width: 100%"
              ></el-input-number>
            </el-col>
            <el-col :span="6">
              <el-input v-model="nameLangZhCN" placeholder="名称"></el-input>
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
        :data="spells"
        highlight-current-row
        @current-change="select"
        @row-dblclick="handleDoubleClick"
        class="spell-editor"
      >
        <el-table-column prop="id" label="ID" width="80px"> </el-table-column>
        <el-table-column prop="nameLangZhCN" label="名称"> </el-table-column>
        <el-table-column prop="descriptionLangZhCN" label="描述"> </el-table-column>
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
.spell-editor {
  max-height: 40vh;
  overflow: auto;
}
.spell-editor tbody tr {
  cursor: pointer;
}
</style>

<script>
import { mapState, mapActions, mapMutations } from "vuex";
import { PAGINATE_SPELLS } from "@/store/MUTATION_TYPES";

export default {
  data() {
    return {
      id: undefined,
      nameLangZhCN: undefined,
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
      this.id = newValue;
    }
  },
  computed: {
    ...mapState("spell", ["spells", "page", "total"]),
    payload() {
      return {
        id: this.id != 0 ? this.id : "",
        name: this.nameLangZhCN,
        page: this.page
      };
    }
  },
  methods: {
    ...mapActions("spell", ["search", "count"]),
    ...mapMutations("spell", { paginate: PAGINATE_SPELLS }),
    input(id) {
      this.$emit("input", id);
    },
    blur(id) {
      if (isNaN(parseInt(id))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(id));
      }
    },
    showDialog() {
      this.visible = true;
    },
    addSpell() {},
    async handleSearch() {
      this.paginate(1); //每次搜索时使分页器设为第一页
      await Promise.all([this.search(this.payload), this.count(this.payload)]);
    },
    reset() {
      this.id = undefined;
      this.text = undefined;
    },
    async handlePaginate(page) {
      this.paginate(page);
      await this.search(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    handleDoubleClick(row) {
      this.$emit("input", row.id);
      this.visible = false;
    },
    closeDialog() {
      this.visible = false;
    },
    store() {
      this.$emit("input", this.currentRow.id);
      this.visible = false;
    },
    async init() {
      await Promise.all([this.search(this.payload), this.count(this.payload)]);
    }
  },
  created() {
    this.id = this.value;
  }
};
</script>
