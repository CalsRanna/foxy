<template>
  <div>
    <el-input v-model="spell" :placeholder="placeholder" @input="input">
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
          技能选择器
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
              <el-input v-model="Name_Lang_zhCN" placeholder="名称"></el-input>
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
        :data="spells"
        highlight-current-row
        @current-change="select"
        @row-dblclick="(row) => store(row)"
        class="spell-selector"
      >
        <el-table-column prop="ID" label="ID" width="80px"> </el-table-column>
        <el-table-column prop="Name_Lang_zhCN" label="名称"> </el-table-column>
        <el-table-column prop="Description_Lang_zhCN" label="描述">
          <template slot-scope="scope">
            <spell-description
              :spell="scope.row"
              field="Description_Lang_zhCN"
            ></spell-description>
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
import SpellDescription from "@/components/SpellDescription";

export default {
  data() {
    return {
      spell: undefined,
      ID: undefined,
      Name_Lang_zhCN: undefined,
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
      this.spell = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("spellSelector", ["pagination", "spells"]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        Name_Lang_zhCN: this.Name_Lang_zhCN,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("spellSelector", [
      "searchSpellsForSelector",
      "countSpellsForSelector",
      "paginateSpellsForSelector",
    ]),
    input(spell) {
      if (isNaN(parseInt(spell))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(spell));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchSpellsForSelector(this.payload),
        this.countSpellsForSelector(this.payload),
      ]);
    },
    async search() {
      this.paginateSpellsForSelector({ page: 1 });
      await Promise.all([
        this.searchSpellsForSelector(this.payload),
        this.countSpellsForSelector(this.payload),
      ]);
    },
    reset() {
      this.ID = undefined;
      this.Name_Lang_zhCN = undefined;
    },
    async paginate(page) {
      this.paginateSpellsForSelector({ page: page });
      await this.searchSpellsForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let spell = this.spell != undefined ? this.spell : this.value;
      this.$emit("input", spell);
      this.visible = false;
    },
    store(row) {
      let spell = row != undefined ? row.ID : this.value;
      this.$emit("input", spell);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchSpellsForSelector(this.payload),
        this.countSpellsForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.spell = this.value;
    this.ID = this.value;
  },
  components: {
    SpellDescription,
  },
};
</script>

<style scoped>
.spell-selector {
  max-height: 40vh;
  overflow: auto;
}
.spell-selector tbody tr {
  cursor: pointer;
}
</style>
