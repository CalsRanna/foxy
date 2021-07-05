<template>
  <div>
    <el-input
      v-model="itemEnchantmentTemplate"
      :placeholder="placeholder"
      :disabled="disabled"
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
          随机附魔选择器
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
        :data="itemEnchantmentTemplates"
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
        <el-table-column prop="entry" label="编号" width="80px">
        </el-table-column>
        <el-table-column prop="enchs" label="附魔数量"></el-table-column>
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
      itemEnchantmentTemplate: undefined,
      entry: undefined,
      visible: false,
      loading: false,
      currentRow: undefined,
    };
  },
  props: {
    value: [Number, String],
    type: {
      type: String,
      default: "properties",
    },
    placeholder: String,
    disabled: Boolean,
  },
  watch: {
    value: function (newValue) {
      this.itemEnchantmentTemplate = newValue;
      this.entry = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("itemEnchantmentTemplateSelector", [
      "pagination",
      "itemEnchantmentTemplates",
    ]),
    payload() {
      return {
        type: this.type,
        entry: this.entry != 0 ? this.entry : undefined,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("itemEnchantmentTemplateSelector", [
      "searchItemEnchantmentTemplatesForSelector",
      "countItemEnchantmentTemplatesForSelector",
      "paginateItemEnchantmentTemplatesForSelector",
    ]),
    input(itemEnchantmentTemplate) {
      if (isNaN(parseInt(itemEnchantmentTemplate))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(itemEnchantmentTemplate));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchItemEnchantmentTemplatesForSelector(this.payload),
        this.countItemEnchantmentTemplatesForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateItemEnchantmentTemplatesForSelector({ page: 1 });
        await Promise.all([
          this.searchItemEnchantmentTemplatesForSelector(this.payload),
          this.countItemEnchantmentTemplatesForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.entry = undefined;
    },
    async paginate(page) {
      this.paginateItemEnchantmentTemplatesForSelector({ page: page });
      await this.searchItemEnchantmentTemplatesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let itemEnchantmentTemplate =
        this.itemEnchantmentTemplate != undefined
          ? this.itemEnchantmentTemplate
          : this.value;
      this.$emit("input", itemEnchantmentTemplate);
      this.visible = false;
    },
    store(row) {
      let itemEnchantmentTemplate = row != undefined ? row.entry : this.value;
      this.$emit("input", itemEnchantmentTemplate);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchItemEnchantmentTemplatesForSelector(this.payload),
        this.countItemEnchantmentTemplatesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.itemEnchantmentTemplate = this.value;
    this.entry = this.value;
  },
};
</script>
