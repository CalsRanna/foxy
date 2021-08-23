<template>
  <div>
    <el-input
      v-model="ItemExtendedCost"
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
          扩展价格选择器
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
                v-model="Name"
                placeholder="Name"
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
        :data="itemExtendedCosts"
        :max-height="calculateMaxHeight()"
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column prop="HonorPoints" label="荣誉点数" width="80px"></el-table-column>
        <el-table-column prop="ArenaPoints" label="竞技场点数" width="120px"></el-table-column>
        <el-table-column label="物品">
          <template slot-scope="scope">
            <el-tag style="margin-right: 8px" v-if="scope.row.name_1">
              {{scope.row.localeName_1 ? scope.row.localeName_1 : scope.row.name_1}}({{scope.row.ItemCount_1}})
            </el-tag>
            <el-tag style="margin-right: 8px" v-if="scope.row.name_2">
              {{scope.row.localeName_2 ? scope.row.localeName_2 : scope.row.name_2}}({{scope.row.ItemCount_2}})
            </el-tag>
            <el-tag style="margin-right: 8px" v-if="scope.row.name_3">
              {{scope.row.localeName_3 ? scope.row.localeName_3 : scope.row.name_3}}({{scope.row.ItemCount_3}})
            </el-tag>
            <el-tag style="margin-right: 8px" v-if="scope.row.name_4">
              {{scope.row.localeName_4 ? scope.row.localeName_4 : scope.row.name_4}}({{scope.row.ItemCount_4}})
            </el-tag>
            <el-tag style="margin-right: 8px" v-if="scope.row.name_5">
              {{scope.row.localeName_5 ? scope.row.localeName_5 : scope.row.name_5}}({{scope.row.ItemCount_5}})
            </el-tag>
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
      ItemExtendedCost: undefined,
      ID: undefined,
      Name: undefined,
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
      this.ItemExtendedCost = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("itemExtendedCostSelector", [
      "pagination",
      "itemExtendedCosts",
    ]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        Name: this.Name,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
  },
  methods: {
    ...mapActions("itemExtendedCostSelector", [
      "searchItemExtendedCostsForSelector",
      "countItemExtendedCostsForSelector",
      "paginateItemExtendedCostsForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight * 0.84 - 301
        : this.clientHeight * 0.84 - 241;
    },
    input(ItemExtendedCost) {
      if (isNaN(parseInt(ItemExtendedCost))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(ItemExtendedCost));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchItemExtendedCostsForSelector(this.payload),
        this.countItemExtendedCostsForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateItemExtendedCostsForSelector({ page: 1 });
        await Promise.all([
          this.searchItemExtendedCostsForSelector(this.payload),
          this.countItemExtendedCostsForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.Name = undefined;
    },
    async paginate(page) {
      this.paginateItemExtendedCostsForSelector({ page: page });
      await this.searchItemExtendedCostsForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let ItemExtendedCost =
        this.ItemExtendedCost != undefined
          ? this.ItemExtendedCost
          : this.value;
      this.$emit("input", ItemExtendedCost);
      this.visible = false;
    },
    store(row) {
      let ItemExtendedCost = row != undefined ? row.ID : this.value;
      this.$emit("input", ItemExtendedCost);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchItemExtendedCostsForSelector(this.payload),
        this.countItemExtendedCostsForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.ItemExtendedCost = this.value;
    this.ID = this.value;
  },
};
</script>
