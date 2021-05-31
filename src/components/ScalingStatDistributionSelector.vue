<template>
  <div>
    <el-input
      v-model="scalingStatDistribution"
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
          缩放属性分配选择器
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
              <el-select v-model="Stat" placeholder="属性">
                <el-option
                  v-for="(localeStatType, index) in localeStatTypes"
                  :key="`Stat-${index}`"
                  :value="index"
                  :label="localeStatType"
                ></el-option>
              </el-select>
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
        :page-size="pagination.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table
        :data="scalingStatDistributions"
        highlight-current-row
        @current-change="select"
        @row-dblclick="(row) => store(row)"
        class="scaling-stat-distribution-selector"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span>
              {{ localeStatTypes[scope.row.StatID_1] }}({{ scope.row.Bonus_1 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span>
              {{ localeStatTypes[scope.row.StatID_2] }}({{ scope.row.Bonus_2 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span>
              {{ localeStatTypes[scope.row.StatID_3] }}({{ scope.row.Bonus_3 }})
            </span>
          </template>
        </el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <span>
              {{ localeStatTypes[scope.row.StatID_4] }}({{ scope.row.Bonus_4 }})
            </span>
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

import { localeStatTypes } from "@/locales/item";

export default {
  data() {
    return {
      scalingStatDistribution: undefined,
      ID: undefined,
      Stat: undefined,
      visible: false,
      loading: false,
      currentRow: undefined,
      localeStatTypes: localeStatTypes,
    };
  },
  props: {
    value: [Number, String],
    placeholder: String,
  },
  watch: {
    value: function (newValue) {
      this.scalingStatDistribution = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("scalingStatDistributionSelector", [
      "pagination",
      "scalingStatDistributions",
    ]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        Stat: this.Stat,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("scalingStatDistributionSelector", [
      "searchScalingStatDistributionsForSelector",
      "countScalingStatDistributionsForSelector",
      "paginateScalingStatDistributionsForSelector",
    ]),
    input(scalingStatDistribution) {
      if (isNaN(parseInt(scalingStatDistribution))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(scalingStatDistribution));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchScalingStatDistributionsForSelector(this.payload),
        this.countScalingStatDistributionsForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateScalingStatDistributionsForSelector({ page: 1 });
        await Promise.all([
          this.searchScalingStatDistributionsForSelector(this.payload),
          this.countScalingStatDistributionsForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.Stat = undefined;
    },
    async paginate(page) {
      this.paginateScalingStatDistributionsForSelector({ page: page });
      await this.searchScalingStatDistributionsForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let scalingStatDistribution =
        this.scalingStatDistribution != undefined
          ? this.scalingStatDistribution
          : this.value;
      this.$emit("input", scalingStatDistribution);
      this.visible = false;
    },
    store(row) {
      let scalingStatDistribution = row != undefined ? row.ID : this.value;
      this.$emit("input", scalingStatDistribution);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchScalingStatDistributionsForSelector(this.payload),
        this.countScalingStatDistributionsForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.scalingStatDistribution = this.value;
    this.ID = this.value;
  },
};
</script>

<style scoped>
.scaling-stat-distribution-selector {
  max-height: 40vh;
  overflow: auto;
}
.scaling-stat-distribution-selector tbody tr {
  cursor: pointer;
}
</style>
