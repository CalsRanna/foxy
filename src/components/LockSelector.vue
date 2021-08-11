<template>
  <div>
    <el-input v-model="lock" :placeholder="placeholder" @input="input">
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
          锁选择器
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
        :data="locks"
        :max-height="calculateMaxHeight()"
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column label="类型">
          <div slot-scope="scope">
            <el-tag v-if="scope.row.Name_1" style="margin-right: 8px">
              {{ scope.row.Name_1 }}
            </el-tag>
            <el-tag v-if="scope.row.Name_2" style="margin-right: 8px">
              {{ scope.row.Name_2 }}
            </el-tag>
            <el-tag v-if="scope.row.Name_3" style="margin-right: 8px">
              {{ scope.row.Name_3 }}
            </el-tag>
            <el-tag v-if="scope.row.Name_4" style="margin-right: 8px">
              {{ scope.row.Name_4 }}
            </el-tag>
            <el-tag v-if="scope.row.Name_5" style="margin-right: 8px">
              {{ scope.row.Name_5 }}
            </el-tag>
            <el-tag v-if="scope.row.Name_6" style="margin-right: 8px">
              {{ scope.row.Name_6 }}
            </el-tag>
            <el-tag v-if="scope.row.Name_7" style="margin-right: 8px">
              {{ scope.row.Name_7 }}
            </el-tag>
            <el-tag v-if="scope.row.Name_8" style="margin-right: 8px">
              {{ scope.row.Name_8 }}
            </el-tag>
          </div>
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
      lock: undefined,
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
      this.lock = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("lockSelector", ["pagination", "locks"]),
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
    ...mapActions("lockSelector", [
      "searchLocksForSelector",
      "countLocksForSelector",
      "paginateLocksForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? clientHeight * 0.84 - 301
        : clientHeight * 0.84 - 241;
    },
    input(lock) {
      if (isNaN(parseInt(lock))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(lock));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchLocksForSelector(this.payload),
        this.countLocksForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateLocksForSelector({ page: 1 });
        await Promise.all([
          this.searchLocksForSelector(this.payload),
          this.countLocksForSelector(this.payload),
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
      this.paginateLocksForSelector({ page: page });
      await this.searchLocksForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let lock = this.lock != undefined ? this.lock : this.value;
      this.$emit("input", lock);
      this.visible = false;
    },
    store(row) {
      let lock = row != undefined ? row.ID : this.value;
      this.$emit("input", lock);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchLocksForSelector(this.payload),
        this.countLocksForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.lock = this.value;
    this.ID = this.value;
  },
};
</script>
