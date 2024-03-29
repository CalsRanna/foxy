<template>
  <div>
    <el-input v-model="creature" :placeholder="placeholder" @input="input">
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
          生物模板选择器
        </span>
      </div>
      <el-card>
        <el-form @submit.native.prevent="search">
          <el-row :gutter="16">
            <el-col :span="8">
              <el-input-number
                v-model="entry"
                controls-position="right"
                placeholder="entry"
              ></el-input-number>
            </el-col>
            <el-col :span="8">
              <el-input v-model="name" placeholder="name"></el-input>
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
        :data="creatureTemplates"
        :max-height="calculateMaxHeight()"
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column
          prop="entry"
          label="编号"
          width="80px"
        ></el-table-column>
        <el-table-column label="姓名">
          <template slot-scope="scope">
            <span v-if="scope.row.localeName !== null">
              {{ scope.row.localeName }}
            </span>
            <span v-else>{{ scope.row.name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="称号">
          <template slot-scope="scope">
            <span v-if="scope.row.localeTitle != null">
              {{ scope.row.localeTitle }}
            </span>
            <span v-else>{{ scope.row.subname }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="minlevel" label="最小等级"></el-table-column>
        <el-table-column prop="maxlevel" label="最大等级"></el-table-column>
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
      creature: undefined,
      entry: undefined,
      name: undefined,
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
      this.creature = newValue;
      this.entry = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("creatureTemplateSelector", [
      "pagination",
      "creatureTemplates",
    ]),
    payload() {
      return {
        entry: this.entry != 0 ? this.entry : undefined,
        name: this.name,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
  },
  methods: {
    ...mapActions("creatureTemplateSelector", [
      "searchCreatureTemplatesForSelector",
      "countCreatureTemplatesForSelector",
      "paginateCreatureTemplatesForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight * 0.84 - 301
        : this.clientHeight * 0.84 - 241;
    },
    input(creature) {
      if (isNaN(parseInt(creature))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(creature));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchCreatureTemplatesForSelector(this.payload),
        this.countCreatureTemplatesForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateCreatureTemplatesForSelector({ page: 1 });
        await Promise.all([
          this.searchCreatureTemplatesForSelector(this.payload),
          this.countCreatureTemplatesForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.entry = undefined;
      this.name = undefined;
    },
    async paginate(page) {
      this.paginateCreatureTemplatesForSelector({ page: page });
      await this.searchCreatureTemplatesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let creature = this.creature != undefined ? this.creature : this.value;
      this.$emit("input", creature);
      this.visible = false;
    },
    store(row) {
      let creature = row != undefined ? row.entry : this.value;
      this.$emit("input", creature);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchCreatureTemplatesForSelector(this.payload),
        this.countCreatureTemplatesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.creature = this.value;
    this.entry = this.value;
  },
};
</script>
