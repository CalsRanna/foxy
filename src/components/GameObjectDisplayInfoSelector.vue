<template>
  <div>
    <el-input
      v-model="gameObjectDisplayInfo"
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
          物体模型选择器
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
              <el-input v-model="ModelName" placeholder="模型名称"></el-input>
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
        :data="gameObjectDisplayInfos"
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
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column prop="ModelName" label="模型名称"> </el-table-column>
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
      gameObjectDisplayInfo: undefined,
      ID: undefined,
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
      this.gameObjectDisplayInfo = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("gameObjectDisplayInfoSelector", [
      "pagination",
      "gameObjectDisplayInfos",
    ]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        ModelName: this.ModelName,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("gameObjectDisplayInfoSelector", [
      "searchGameObjectDisplayInfosForSelector",
      "countGameObjectDisplayInfosForSelector",
      "paginateGameObjectDisplayInfosForSelector",
    ]),
    input(gameObjectDisplayInfo) {
      if (isNaN(parseInt(gameObjectDisplayInfo))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(gameObjectDisplayInfo));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchGameObjectDisplayInfosForSelector(this.payload),
        this.countGameObjectDisplayInfosForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateGameObjectDisplayInfosForSelector({ page: 1 });
        await Promise.all([
          this.searchGameObjectDisplayInfosForSelector(this.payload),
          this.countGameObjectDisplayInfosForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.ModelName = undefined;
    },
    async paginate(page) {
      this.paginateGameObjectDisplayInfosForSelector({ page: page });
      await this.searchGameObjectDisplayInfosForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let gameObjectDisplayInfo =
        this.gameObjectDisplayInfo != undefined
          ? this.gameObjectDisplayInfo
          : this.value;
      this.$emit("input", gameObjectDisplayInfo);
      this.visible = false;
    },
    store(row) {
      let gameObjectDisplayInfo = row != undefined ? row.ID : this.value;
      this.$emit("input", gameObjectDisplayInfo);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchGameObjectDisplayInfosForSelector(this.payload),
        this.countGameObjectDisplayInfosForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.gameObjectDisplayInfo = this.value;
    this.ID = this.value;
  },
};
</script>
