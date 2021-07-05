<template>
  <div>
    <el-input
      v-model="creatureModelInfo"
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
      width="68%"
      top="8vh"
    >
      <div slot="title">
        <span style="font-size: 18px; color: #303133; margin-right: 16px">
          模型选择器
        </span>
      </div>
      <el-card>
        <el-form @submit.native.prevent="search">
          <el-row :gutter="16">
            <el-col :span="8">
              <el-input-number
                v-model="DisplayID"
                controls-position="right"
                placeholder="ID"
              ></el-input-number>
            </el-col>
            <el-col :span="8">
              <el-input v-model="ModelName" placeholder="ModelName"></el-input>
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
        :data="creatureModelInfos"
        :max-height="
          pagination.total > 50
            ? clientHeight * 0.84 - 81 - 80 - 60 - 80
            : clientHeight * 0.84 - 81 - 80 - 80
        "
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="DisplayID" label="编号" width="80px">
        </el-table-column>
        <el-table-column prop="Gender" label="性别" width="80px">
          <template slot-scope="scope">
            <span v-if="scope.row.Gender == 0">男</span>
            <span v-else-if="scope.row.Gender == 1">女</span>
            <span v-else>无</span>
          </template>
        </el-table-column>
        <el-table-column prop="ModelName_1" label="模型"> </el-table-column>
        <el-table-column prop="ModelName_2" label="其他性别模型">
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
      creatureModelInfo: undefined,
      DisplayID: undefined,
      ModelName: undefined,
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
      this.creatureModelInfo = newValue;
      this.DisplayID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("creatureModelInfoSelector", [
      "pagination",
      "creatureModelInfos",
    ]),
    payload() {
      return {
        DisplayID: this.DisplayID != 0 ? this.DisplayID : undefined,
        ModelName: this.ModelName,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("creatureModelInfoSelector", [
      "searchCreatureModelInfosForSelector",
      "countCreatureModelInfosForSelector",
      "paginateCreatureModelInfosForSelector",
    ]),
    input(creatureModelInfo) {
      if (isNaN(parseInt(creatureModelInfo))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(creatureModelInfo));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchCreatureModelInfosForSelector(this.payload),
        this.countCreatureModelInfosForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateCreatureModelInfosForSelector({ page: 1 });
        await Promise.all([
          this.searchCreatureModelInfosForSelector(this.payload),
          this.countCreatureModelInfosForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.DisplayID = undefined;
      this.ModelName = undefined;
    },
    async paginate(page) {
      this.paginateCreatureModelInfosForSelector({ page: page });
      await this.searchCreatureModelInfosForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let creatureModelInfo =
        this.creatureModelInfo != undefined
          ? this.creatureModelInfo
          : this.value;
      this.$emit("input", creatureModelInfo);
      this.visible = false;
    },
    store(row) {
      let creatureModelInfo = row != undefined ? row.ID : this.value;
      this.$emit("input", creatureModelInfo);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchCreatureModelInfosForSelector(this.payload),
        this.countCreatureModelInfosForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.creatureModelInfo = this.value;
    this.DisplayID = this.value;
  },
};
</script>
