<template>
  <div>
    <el-input v-model="emote" :placeholder="placeholder" @input="input">
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
          表情选择器
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
                v-model="EmoteSlashCommand"
                placeholder="EmoteSlashCommand"
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
        :page-size="pagination.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table
        :data="emotes"
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
        <el-table-column prop="EmoteSlashCommand" label="名称">
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
      emote: undefined,
      ID: undefined,
      EmoteSlashCommand: undefined,
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
      this.emote = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("emoteSelector", ["pagination", "emotes"]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        EmoteSlashCommand: this.EmoteSlashCommand,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("emoteSelector", [
      "searchEmotesForSelector",
      "countEmotesForSelector",
      "paginateEmotesForSelector",
    ]),
    input(emote) {
      if (isNaN(parseInt(emote))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(emote));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchEmotesForSelector(this.payload),
        this.countEmotesForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateEmotesForSelector({ page: 1 });
        await Promise.all([
          this.searchEmotesForSelector(this.payload),
          this.countEmotesForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.EmoteSlashCommand = undefined;
    },
    async paginate(page) {
      this.paginateEmotesForSelector({ page: page });
      await this.searchEmotesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let emote = this.emote != undefined ? this.emote : this.value;
      this.$emit("input", emote);
      this.visible = false;
    },
    store(row) {
      let emote = row != undefined ? row.ID : this.value;
      this.$emit("input", emote);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchEmotesForSelector(this.payload),
        this.countEmotesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.emote = this.value;
    this.ID = this.value;
  },
};
</script>
