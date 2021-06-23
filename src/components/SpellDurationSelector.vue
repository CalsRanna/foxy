<template>
  <div>
    <el-input v-model="spellDuration" :placeholder="placeholder" @input="input">
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
          持续时间选择器
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
              <el-input-number
                v-model="Duration"
                controls-position="right"
                placeholder="持续时间"
              ></el-input-number>
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
        :data="spellDurations"
        :max-height="pagination.total > 50 ? clientHeight * 0.84 - 81 - 80 - 60 - 80 : clientHeight * 0.84 - 81 - 80 - 80"
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="ID" width="80px"> </el-table-column>
        <el-table-column prop="Duration" label="持续时间"> </el-table-column>
        <el-table-column
          prop="DurationPerLevel"
          label="每级持续时间"
        ></el-table-column>
        <el-table-column
          prop="MaxDuration"
          label="最大持续时间"
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
      spellDuration: undefined,
      ID: undefined,
      Duration: undefined,
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
      this.spellDuration = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("spellDurationSelector", ["pagination", "spellDurations"]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        Duration: this.Duration,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("spellDurationSelector", [
      "searchSpellDurationsForSelector",
      "countSpellDurationsForSelector",
      "paginateSpellDurationsForSelector",
    ]),
    input(spellDuration) {
      if (isNaN(parseInt(spellDuration))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(spellDuration));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchSpellDurationsForSelector(this.payload),
        this.countSpellDurationsForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateSpellDurationsForSelector({ page: 1 });
        await Promise.all([
          this.searchSpellDurationsForSelector(this.payload),
          this.countSpellDurationsForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.Duration = undefined;
    },
    async paginate(page) {
      this.paginateSpellDurationsForSelector({ page: page });
      await this.searchSpellDurationsForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let spellDuration =
        this.spellDuration != undefined ? this.spellDuration : this.value;
      this.$emit("input", spellDuration);
      this.visible = false;
    },
    store(row) {
      let spellDuration = row != undefined ? row.ID : this.value;
      this.$emit("input", spellDuration);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchSpellDurationsForSelector(this.payload),
        this.countSpellDurationsForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.spellDuration = this.value;
    this.ID = this.value;
  },
};
</script>
