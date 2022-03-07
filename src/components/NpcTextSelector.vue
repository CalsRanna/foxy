<template>
  <div>
    <el-input v-model="npcText" :placeholder="placeholder" @input="input">
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
          文本选择器
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
              <el-input v-model="Text" placeholder="Text"></el-input>
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
        :data="npcTexts"
        :max-height="calculateMaxHeight()"
        highlight-current-row
        class="selectable-table hide-when-overflow tight-table"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"></el-table-column>
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
      npcText: undefined,
      ID: undefined,
      Text: undefined,
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
      this.npcText = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("npcTextSelector", ["pagination", "npcTexts"]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        Text: this.Text,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
  },
  methods: {
    ...mapActions("npcTextSelector", [
      "searchNpcTextsForSelector",
      "countNpcTextsForSelector",
      "paginateNpcTextsForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight * 0.84 - 301
        : this.clientHeight * 0.84 - 241;
    },
    input(npcText) {
      if (isNaN(parseInt(npcText))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(npcText));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchNpcTextsForSelector(this.payload),
        this.countNpcTextsForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateNpcTextsForSelector({ page: 1 });
        await Promise.all([
          this.searchNpcTextsForSelector(this.payload),
          this.countNpcTextsForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.Text = undefined;
    },
    async paginate(page) {
      this.paginateNpcTextsForSelector({ page: page });
      await this.searchNpcTextsForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let npcText = this.npcText != undefined ? this.npcText : this.value;
      this.$emit("input", npcText);
      this.visible = false;
    },
    store(row) {
      let npcText = row != undefined ? row.ID : this.value;
      this.$emit("input", npcText);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchNpcTextsForSelector(this.payload),
        this.countNpcTextsForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.npcText = this.value;
    this.ID = this.value;
  },
};
</script>
