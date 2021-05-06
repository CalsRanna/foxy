<template>
  <div>
    <el-input
      v-model="creatureSpellData"
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
          宠物技能选择器
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
              <el-input v-model="Spell" placeholder="名称"></el-input>
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
        :data="creatureSpellDatas"
        highlight-current-row
        @current-change="select"
        @row-dblclick="(row) => store(row)"
        class="creature-spell-data-selector"
      >
        <el-table-column prop="ID" label="ID" width="80px"> </el-table-column>
        <el-table-column prop="Spells_1" label="技能1"> </el-table-column>
        <el-table-column prop="Spells_2" label="技能2"> </el-table-column>
        <el-table-column prop="Spells_3" label="技能3"> </el-table-column>
        <el-table-column prop="Spells_4" label="技能4"> </el-table-column>
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
      creatureSpellData: undefined,
      ID: undefined,
      Spell: undefined,
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
      this.creatureSpellData = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("creatureSpellDataSelector", [
      "pagination",
      "creatureSpellDatas",
    ]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        Spell: this.Spell,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("creatureSpellDataSelector", [
      "searchCreatureSpellDatasForSelector",
      "countCreatureSpellDatasForSelector",
      "paginateCreatureSpellDatasForSelector",
    ]),
    input(creatureSpellData) {
      if (isNaN(parseInt(creatureSpellData))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(creatureSpellData));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchCreatureSpellDatasForSelector(this.payload),
        this.countCreatureSpellDatasForSelector(this.payload),
      ]);
    },
    async search() {
      this.paginateCreatureSpellDatasForSelector({ page: 1 });
      await Promise.all([
        this.searchCreatureSpellDatasForSelector(this.payload),
        this.countCreatureSpellDatasForSelector(this.payload),
      ]);
    },
    reset() {
      this.ID = undefined;
      this.Spell = undefined;
    },
    async paginate(page) {
      this.paginateCreatureSpellDatasForSelector({ page: page });
      await this.searchCreatureSpellDatasForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let creatureSpellData =
        this.creatureSpellData != undefined
          ? this.creatureSpellData
          : this.value;
      this.$emit("input", creatureSpellData);
      this.visible = false;
    },
    store(row) {
      let creatureSpellData = row != undefined ? row.ID : this.value;
      this.$emit("input", creatureSpellData);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchCreatureSpellDatasForSelector(this.payload),
        this.countCreatureSpellDatasForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.creatureSpellData = this.value;
    this.ID = this.value;
  },
};
</script>

<style scoped>
.creature-spell-data-selector {
  max-height: 40vh;
  overflow: auto;
}
.creature-spell-data-selector tbody tr {
  cursor: pointer;
}
</style>
