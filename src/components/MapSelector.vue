<template>
  <div>
    <el-input v-model="map" :placeholder="placeholder" @input="input">
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
          地图选择器
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
                v-model="MapName_Lang_zhCN"
                placeholder="MapName_Lang_zhCN"
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
        :data="maps"
        :max-height="calculateMaxHeight()"
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"></el-table-column>
        <el-table-column
          prop="MapName_Lang_zhCN"
          label="名称"
        ></el-table-column>
        <el-table-column
          prop="MapDescription0_Lang_zhCN"
          label="描述"
        ></el-table-column>
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
      map: undefined,
      ID: undefined,
      MapName_Lang_zhCN: undefined,
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
      this.map = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("mapSelector", ["pagination", "maps"]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        MapName_Lang_zhCN: this.MapName_Lang_zhCN,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
  },
  methods: {
    ...mapActions("mapSelector", [
      "searchMapsForSelector",
      "countMapsForSelector",
      "paginateMapsForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight * 0.84 - 301
        : this.clientHeight * 0.84 - 241;
    },
    input(map) {
      if (isNaN(parseInt(map))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(map));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchMapsForSelector(this.payload),
        this.countMapsForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateMapsForSelector({ page: 1 });
        await Promise.all([
          this.searchMapsForSelector(this.payload),
          this.countMapsForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.MapName_Lang_zhCN = undefined;
    },
    async paginate(page) {
      this.paginateMapsForSelector({ page: page });
      await this.searchMapsForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let map = this.map != undefined ? this.map : this.value;
      this.$emit("input", map);
      this.visible = false;
    },
    store(row) {
      let map = row != undefined ? row.ID : this.value;
      this.$emit("input", map);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchMapsForSelector(this.payload),
        this.countMapsForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.map = this.value;
    this.ID = this.value;
  },
};
</script>
