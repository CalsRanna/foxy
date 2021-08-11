<template>
  <div>
    <el-input
      v-model="areaTableOrQuestSort"
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
        <el-button
          type="text"
          :disabled="module === 'areaTable'"
          style="margin-right: 8px"
          @click="() => modularize('areaTable')"
        >
          区域选择器
        </el-button>
        /
        <el-button
          type="text"
          :disabled="module === 'questSort'"
          @click="() => modularize('questSort')"
        >
          任务排序选择器
        </el-button>
      </div>
      <template v-if="module === 'areaTable'">
        <el-card>
          <el-form @submit.native.prevent="search">
            <el-row :gutter="16">
              <el-col :span="8">
                <el-input-number
                  v-model="IDOfAreaTable"
                  controls-position="right"
                  placeholder="ID"
                ></el-input-number>
              </el-col>
              <el-col :span="8">
                <el-input
                  v-model="AreaName_Lang_zhCN"
                  placeholder="AreaName_Lang_zhCN"
                ></el-input>
              </el-col>
              <el-col :span="8">
                <el-button
                  type="primary"
                  native-type="submit"
                  :loading="loadingOfAreaTable"
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
          :current-page="paginationOfAreaTable.page"
          :total="paginationOfAreaTable.total"
          :page-size="advanceConfig.size"
          hide-on-single-page
          @current-change="paginate"
          style="margin-top: 16px"
        ></el-pagination>
        <el-table
          :data="areaTables"
          :max-height="
            paginationOfAreaTable.total > this.advanceConfig.size
              ? clientHeight * 0.84 - 81 - 80 - 60 - 80
              : clientHeight * 0.84 - 81 - 80 - 80
          "
          highlight-current-row
          class="selectable-table hide-when-overflow"
          @current-change="select"
          @row-dblclick="(row) => store(row)"
        >
          <el-table-column prop="ID" label="编号" width="80px">
          </el-table-column>
          <el-table-column prop="AreaName_Lang_zhCN" label="名称">
          </el-table-column>
        </el-table>
        <div slot="footer">
          <el-button @click="close">取消</el-button>
          <el-button type="primary" @click="() => store(currentRowOfAreaTable)">
            保存
          </el-button>
        </div>
      </template>
      <template v-else>
        <el-card>
          <el-form @submit.native.prevent="search">
            <el-row :gutter="16">
              <el-col :span="8">
                <el-input-number
                  v-model="IDOfQuestSort"
                  controls-position="right"
                  placeholder="ID "
                ></el-input-number>
              </el-col>
              <el-col :span="8">
                <el-input
                  v-model="SortName_Lang_zhCN"
                  placeholder="SortName_Lang_zhCN"
                ></el-input>
              </el-col>
              <el-col :span="8">
                <el-button
                  type="primary"
                  native-type="submit"
                  :loading="loadingOfQuestSort"
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
          :current-page="paginationOfQuestSort.page"
          :total="paginationOfQuestSort.total"
          :page-size="advanceConfig.size"
          hide-on-single-page
          @current-change="paginate"
          style="margin-top: 16px"
        ></el-pagination>
        <el-table
          :data="questSorts"
          :max-height="
            paginationOfQuestSort.total > this.advanceConfig.size
              ? clientHeight * 0.84 - 81 - 80 - 60 - 80
              : clientHeight * 0.84 - 81 - 80 - 80
          "
          highlight-current-row
          class="selectable-table hide-when-overflow"
          @current-change="select"
          @row-dblclick="(row) => store(row)"
        >
          <el-table-column prop="ID" label="编号" width="80px">
          </el-table-column>
          <el-table-column prop="SortName_Lang_zhCN" label="名称">
          </el-table-column>
        </el-table>
        <div slot="footer">
          <el-button @click="close">取消</el-button>
          <el-button type="primary" @click="() => store(currentRowOfQuestSort)">
            保存
          </el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      visible: false,
      module: "areaTable",
      areaTableOrQuestSort: undefined,
      IDOfAreaTable: undefined,
      AreaName_Lang_zhCN: undefined,
      loadingOfAreaTable: false,
      currentRowOfAreaTable: undefined,
      IDOfQuestSort: undefined,
      SortName_Lang_zhCN: undefined,
      loadingOfQuestSort: false,
      currentRowOfQuestSort: undefined,
    };
  },
  props: {
    value: [Number, String],
    placeholder: String,
  },
  watch: {
    value: function (newValue) {
      this.areaTableOrQuestSort = newValue;
      this.IDOfAreaTable = Math.abs(newValue);
      this.IDOfQuestSort = Math.abs(newValue);
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("areaTableOrQuestSortSelector", [
      "paginationOfAreaTable",
      "paginationOfQuestSort",
      "areaTables",
      "questSorts",
    ]),
    payload() {
      if (this.module === "areaTable") {
        return {
          ID: this.IDOfAreaTable != 0 ? this.IDOfAreaTable : undefined,
          AreaName_Lang_zhCN: this.AreaName_Lang_zhCN,
          page: this.paginationOfAreaTable.page,
          size: this.advanceConfig.size,
        };
      } else {
        return {
          ID: this.IDOfQuestSort != 0 ? this.IDOfQuestSort : undefined,
          SortName_Lang_zhCN: this.SortName_Lang_zhCN,
          page: this.paginationOfQuestSort.page,
          size: this.advanceConfig.size,
        };
      }
    },
  },
  methods: {
    ...mapActions("areaTableOrQuestSortSelector", [
      "searchAreaTablesForSelector",
      "countAreaTablesForSelector",
      "paginateAreaTablesForSelector",
      "searchQuestSortsForSelector",
      "countQuestSortsForSelector",
      "paginateQuestSortsForSelector",
    ]),
    input(areaTableOrQuestSort) {
      if (isNaN(parseInt(areaTableOrQuestSort))) {
        this.$emit("input", undefined);
      } else {
        if (this.module === "areaTable") {
          this.$emit("input", Math.abs(parseInt(areaTableOrQuestSort)));
        } else {
          this.$emit("input", -1 * Math.abs(parseInt(areaTableOrQuestSort)));
        }
      }
    },
    async show() {
      this.visible = true;
      if (this.module === "areaTable") {
        await Promise.all([
          this.searchAreaTablesForSelector(this.payload),
          this.countAreaTablesForSelector(this.payload),
        ]);
      } else {
        await Promise.all([
          this.searchQuestSortsForSelector(this.payload),
          this.countQuestSortsForSelector(this.payload),
        ]);
      }
    },
    async modularize(module) {
      this.module = module;
      if (this.module === "areaTable") {
        await Promise.all([
          this.searchAreaTablesForSelector(this.payload),
          this.countAreaTablesForSelector(this.payload),
        ]);
      } else {
        await Promise.all([
          this.searchQuestSortsForSelector(this.payload),
          this.countQuestSortsForSelector(this.payload),
        ]);
      }
    },
    async search() {
      if (this.module === "areaTable") {
        this.loadingOfAreaTable = true;
        try {
          this.paginateAreaTablesForSelector({ page: 1 });
          await Promise.all([
            this.searchAreaTablesForSelector(this.payload),
            this.countAreaTablesForSelector(this.payload),
          ]);
          this.loadingOfAreaTable = false;
        } catch (error) {
          this.loadingOfAreaTable = false;
        }
      } else {
        this.loadingOfQuestSort = true;
        try {
          this.paginateQuestSortsForSelector({ page: 1 });
          await Promise.all([
            this.searchQuestSortsForSelector(this.payload),
            this.countQuestSortsForSelector(this.payload),
          ]);
          this.loadingOfQuestSort = false;
        } catch (error) {
          this.loadingOfQuestSort = false;
        }
      }
    },
    reset() {
      if (this.module === "areaTable") {
        this.IDOfAreaTable = undefined;
        this.AreaName_Lang_zhCN = undefined;
      } else {
        this.IDOfQuestSort = undefined;
        this.SortName_Lang_zhCN = undefined;
      }
    },
    async paginate(page) {
      if (this.module === "areaTable") {
        this.paginateAreaTablesForSelector({ page: page });
        await this.searchAreaTablesForSelector(this.payload);
      } else {
        this.paginateQuestSortsForSelector({ page: 1 });
        await this.searchQuestSortsForSelector(this.payload);
      }
    },
    select(currentRow) {
      if (this.module === "areaTable") {
        this.currentRowOfAreaTable = currentRow;
      } else {
        this.currentRowOfQuestSort = currentRow;
      }
    },
    close() {
      if (this.module === "areaTable") {
        let areaTableOrQuestSort =
          this.areaTableOrQuestSort != undefined
            ? this.areaTableOrQuestSort
            : this.value;
        this.$emit("input", Math.abs(areaTableOrQuestSort));
        this.visible = false;
      } else {
        let areaTableOrQuestSort =
          this.areaTableOrQuestSort != undefined
            ? this.areaTableOrQuestSort
            : this.value;
        this.$emit("input", -1 * Math.abs(areaTableOrQuestSort));
        this.visible = false;
      }
    },
    store(row) {
      if (this.module === "areaTable") {
        let areaTableOrQuestSort = row != undefined ? row.ID : this.value;
        this.$emit("input", Math.abs(areaTableOrQuestSort));
        this.visible = false;
      } else {
        let areaTableOrQuestSort = row != undefined ? row.ID : this.value;
        this.$emit("input", -1 * Math.abs(areaTableOrQuestSort));
        this.visible = false;
      }
    },
    async init() {
      if (this.module === "areaTable") {
        await Promise.all([
          this.searchAreaTablesForSelector(this.payload),
          this.countAreaTablesForSelector(this.payload),
        ]);
      } else {
        await Promise.all([
          this.searchQuestSortsForSelector(this.payload),
          this.countQuestSortsForSelector(this.payload),
        ]);
      }
    },
  },
  mounted() {
    if (this.value < 0) {
      this.module = "questSort";
    }
    this.areaTableOrQuestSort = this.value;
    this.IDOfAreaTable = Math.abs(this.value);
    this.IDOfQuestSort = Math.abs(this.value);
  },
};
</script>
