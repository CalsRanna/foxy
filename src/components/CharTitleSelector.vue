<template>
  <div>
    <el-input v-model="charTitle" :placeholder="placeholder" @input="input">
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
          头衔选择器
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
        :data="charTitles"
        :max-height="
          pagination.total > this.advanceConfig.size
            ? clientHeight * 0.84 - 81 - 80 - 60 - 80
            : clientHeight * 0.84 - 81 - 80 - 80
        "
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column prop="Name_Lang_zhCN" label="名称"> </el-table-column>
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
      charTitle: undefined,
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
      this.charTitle = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("charTitleSelector", ["pagination", "charTitles"]),
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
    ...mapActions("charTitleSelector", [
      "searchCharTitlesForSelector",
      "countCharTitlesForSelector",
      "paginateCharTitlesForSelector",
    ]),
    input(charTitle) {
      if (isNaN(parseInt(charTitle))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(charTitle));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchCharTitlesForSelector(this.payload),
        this.countCharTitlesForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateCharTitlesForSelector({ page: 1 });
        await Promise.all([
          this.searchCharTitlesForSelector(this.payload),
          this.countCharTitlesForSelector(this.payload),
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
      this.paginateCharTitlesForSelector({ page: page });
      await this.searchCharTitlesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let charTitle = this.charTitle != undefined ? this.charTitle : this.value;
      this.$emit("input", charTitle);
      this.visible = false;
    },
    store(row) {
      let charTitle = row != undefined ? row.ID : this.value;
      this.$emit("input", charTitle);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchCharTitlesForSelector(this.payload),
        this.countCharTitlesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.charTitle = this.value;
    this.ID = this.value;
  },
};
</script>
