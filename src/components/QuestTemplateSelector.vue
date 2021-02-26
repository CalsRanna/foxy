<template>
  <div>
    <el-input v-model="quest" :placeholder="placeholder" @input="input">
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
          任务选择器
        </span>
      </div>
      <el-card>
        <el-form>
          <el-row :gutter="16">
            <el-col :span="8">
              <el-input-number
                v-model="id"
                controls-position="right"
                placeholder="id"
              ></el-input-number>
            </el-col>
            <el-col :span="8">
              <el-input v-model="title" placeholder="名称"></el-input>
            </el-col>
            <el-col :span="8">
              <el-button type="primary" @click="search">查询</el-button>
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
        :data="questTemplates"
        highlight-current-row
        @current-change="select"
        @row-dblclick="(row) => store(row)"
        class="quest-template-selector"
      >
        <el-table-column prop="ID" label="ID" sortable></el-table-column>
        <el-table-column
          prop="LogTitle"
          label="标题"
          min-width="100px"
          sortable
        >
          <template slot-scope="scope">
            <template v-if="scope.row.Title !== null">{{
              scope.row.Title
            }}</template>
            <template v-else>{{ scope.row.LogTitle }}</template>
          </template>
        </el-table-column>
        <el-table-column
          prop="QuestDescription"
          label="描述"
          sortable
          min-width="500px"
        >
          <template slot-scope="scope">
            <template v-if="scope.row.Details !== null">{{
              scope.row.Details
            }}</template>
            <template v-else>{{ scope.row.LogDescription }}</template>
          </template>
        </el-table-column>
        <el-table-column
          prop="QuestLevel"
          label="等级"
          sortable
        ></el-table-column>
        <el-table-column
          prop="MinLevel"
          label="最低等级"
          sortable
        ></el-table-column>
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

export default {
  data() {
    return {
      quest: undefined,
      id: undefined,
      title: undefined,
      visible: false,
      currentRow: undefined,
    };
  },
  props: {
    value: [Number, String],
    placeholder: String,
  },
  watch: {
    value: function(newValue) {
      this.quest = newValue;
      this.id = newValue;
    },
  },
  computed: {
    ...mapState("questTemplateSelector", ["pagination", "questTemplates"]),
    payload() {
      return {
        id: this.id != 0 ? this.id : undefined,
        title: this.title,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("questTemplateSelector", [
      "searchQuestTemplatesForSelector",
      "countQuestTemplatesForSelector",
      "paginateQuestTemplatesForSelector",
    ]),
    input(quest) {
      if (isNaN(parseInt(quest))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(quest));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchQuestTemplatesForSelector(this.payload),
        this.countQuestTemplatesForSelector(this.payload),
      ]);
    },
    async search() {
      this.paginateQuestTemplatesForSelector({ page: 1 });
      await Promise.all([
        this.searchQuestTemplatesForSelector(this.payload),
        this.countQuestTemplatesForSelector(this.payload),
      ]);
    },
    reset() {
      this.id = undefined;
      this.title = undefined;
    },
    async paginate(page) {
      this.paginateQuestTemplatesForSelector({ page: page });
      await this.searchQuestTemplatesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let quest = this.quest != undefined ? this.quest : this.value;
      this.$emit("input", quest);
      this.visible = false;
    },
    store(row) {
      let quest = row != undefined ? row.ID : this.value;
      this.$emit("input", quest);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchQuestTemplatesForSelector(this.payload),
        this.countQuestTemplatesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.quest = this.value;
    this.id = this.value;
  },
};
</script>

<style scoped>
.quest-template-selector {
  max-height: 40vh;
  overflow: auto;
}
.quest-template-selector tbody tr {
  cursor: pointer;
}
</style>