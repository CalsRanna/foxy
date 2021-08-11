<template>
  <div>
    <el-input
      v-model="spellDifficulty"
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
          难度选择器
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
              <el-input v-model="Spell" placeholder="Spell"></el-input>
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
        :data="spellDifficulties"
        :max-height="calculateMaxHeight()"
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column label="技能">
          <template slot-scope="scope">
            <template v-if="scope.row.DifficultySpellID_1">
              [{{ scope.row.DifficultySpellID_1 }}]
            </template>
            {{ scope.row.Spell1 }}
            <template v-if="scope.row.Subtext1">
              ({{ scope.row.Subtext1 }})
            </template>
          </template>
        </el-table-column>
        <el-table-column label="技能">
          <template slot-scope="scope">
            <template v-if="scope.row.DifficultySpellID_2">
              [{{ scope.row.DifficultySpellID_2 }}]
            </template>
            {{ scope.row.Spell2 }}
            <template v-if="scope.row.Subtext2">
              ({{ scope.row.Subtext2 }})
            </template>
          </template>
        </el-table-column>
        <el-table-column label="技能">
          <template slot-scope="scope">
            <template v-if="scope.row.DifficultySpellID_3">
              [{{ scope.row.DifficultySpellID_3 }}]
            </template>
            {{ scope.row.Spell3 }}
            <template v-if="scope.row.Subtext3">
              ({{ scope.row.Subtext3 }})
            </template>
          </template>
        </el-table-column>
        <el-table-column label="技能">
          <template slot-scope="scope">
            <template v-if="scope.row.DifficultySpellID_4">
              [{{ scope.row.DifficultySpellID_4 }}]
            </template>
            {{ scope.row.Spell4 }}
            <template v-if="scope.row.Subtext4">
              ({{ scope.row.Subtext4 }})
            </template>
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
      spellDifficulty: undefined,
      ID: undefined,
      Spell: undefined,
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
      this.spellDifficulty = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("spellDifficultySelector", ["pagination", "spellDifficulties"]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        Spell: this.ID != 0 ? this.Spell : undefined,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
  },
  methods: {
    ...mapActions("spellDifficultySelector", [
      "searchSpellDifficultiesForSelector",
      "countSpellDifficultiesForSelector",
      "paginateSpellDifficultiesForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight * 0.84 - 301
        : this.clientHeight * 0.84 - 241;
    },
    input(spellDifficulty) {
      if (isNaN(parseInt(spellDifficulty))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(spellDifficulty));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchSpellDifficultiesForSelector(this.payload),
        this.countSpellDifficultiesForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateSpellDifficultiesForSelector({ page: 1 });
        await Promise.all([
          this.searchSpellDifficultiesForSelector(this.payload),
          this.countSpellDifficultiesForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.Spell = undefined;
    },
    async paginate(page) {
      this.paginateSpellDifficultiesForSelector({ page: page });
      await this.searchSpellDifficultiesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let spellDifficulty =
        this.spellDifficulty != undefined ? this.spellDifficulty : this.value;
      this.$emit("input", spellDifficulty);
      this.visible = false;
    },
    store(row) {
      let spellDifficulty = row != undefined ? row.ID : this.value;
      this.$emit("input", spellDifficulty);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchSpellDifficultiesForSelector(this.payload),
        this.countSpellDifficultiesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.spellDifficulty = this.value;
    this.ID = this.value;
  },
};
</script>
