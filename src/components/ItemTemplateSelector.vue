<template>
  <div>
    <el-input v-model="item" :placeholder="placeholder" @input="input">
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
          物品选择器
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
        :data="itemTemplates"
        :max-height="
          pagination.total > this.advanceConfig.size
            ? clientHeight * 0.84 - 81 - 80 - 60 - 80
            : clientHeight * 0.84 - 81 - 80 - 80
        "
        highlight-current-row
        class="selectable-table hide-when-overflow tight-table"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="entry" label="编号" width="80px">
        </el-table-column>
        <el-table-column prop="name" label="名称">
          <item-template-name
            slot-scope="scope"
            :itemTemplate="scope.row"
          ></item-template-name>
        </el-table-column>
        <el-table-column prop="description" label="描述">
          <template slot-scope="scope">
            <span v-if="scope.row.localeDescription != undefined">
              {{ scope.row.localeDescription }}
            </span>
            <span v-else>{{ scope.row.description }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="ItemLevel" label="物品等级"></el-table-column>
        <el-table-column
          prop="RequiredLevel"
          label="需求等级"
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

import ItemTemplateName from "@/components/ItemTemplateName";

export default {
  data() {
    return {
      item: undefined,
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
      this.item = newValue;
      this.entry = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("itemTemplateSelector", ["pagination", "itemTemplates"]),
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
    ...mapActions("itemTemplateSelector", [
      "searchItemTemplatesForSelector",
      "countItemTemplatesForSelector",
      "paginateItemTemplatesForSelector",
    ]),
    input(item) {
      if (isNaN(parseInt(item))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(item));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchItemTemplatesForSelector(this.payload),
        this.countItemTemplatesForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateItemTemplatesForSelector({ page: 1 });
        await Promise.all([
          this.searchItemTemplatesForSelector(this.payload),
          this.countItemTemplatesForSelector(this.payload),
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
      this.paginateItemTemplatesForSelector({ page: page });
      await this.searchItemTemplatesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let item = this.item != undefined ? this.item : this.value;
      this.$emit("input", item);
      this.visible = false;
    },
    store(row) {
      let item = row != undefined ? row.entry : this.value;
      this.$emit("input", item);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchItemTemplatesForSelector(this.payload),
        this.countItemTemplatesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.item = this.value;
    this.entry = this.value;
  },
  components: { ItemTemplateName },
};
</script>
