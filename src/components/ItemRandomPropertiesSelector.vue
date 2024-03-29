<template>
  <div>
    <el-input
      v-model="itemRandomProperty"
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
          随机属性选择器
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
              <el-input v-model="Name" placeholder="Name"></el-input>
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
        :data="itemRandomProperties"
        :max-height="calculateMaxHeight()"
        highlight-current-row
        class="selectable-table hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column prop="Name_Lang_zhCN" label="名称"></el-table-column>
        <el-table-column label="属性">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.Enchantment_1" style="margin-right: 8px">
              {{ scope.row.Enchantment_1 }}
            </el-tag>
            <el-tag v-if="scope.row.Enchantment_2" style="margin-right: 8px">
              {{ scope.row.Enchantment_2 }}
            </el-tag>
            <el-tag v-if="scope.row.Enchantment_3" style="margin-right: 8px">
              {{ scope.row.Enchantment_3 }}
            </el-tag>
            <el-tag v-if="scope.row.Enchantment_4" style="margin-right: 8px">
              {{ scope.row.Enchantment_4 }}
            </el-tag>
            <el-tag v-if="scope.row.Enchantment_5" style="margin-right: 8px">
              {{ scope.row.Enchantment_5 }}
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
      itemRandomProperty: undefined,
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
      this.itemRandomProperty = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("itemRandomPropertiesSelector", [
      "pagination",
      "itemRandomProperties",
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
    ...mapActions("itemRandomPropertiesSelector", [
      "searchItemRandomPropertiesForSelector",
      "countItemRandomPropertiesForSelector",
      "paginateItemRandomPropertiesForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight * 0.84 - 301
        : this.clientHeight * 0.84 - 241;
    },
    input(itemRandomProperty) {
      if (isNaN(parseInt(itemRandomProperty))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(itemRandomProperty));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchItemRandomPropertiesForSelector(this.payload),
        this.countItemRandomPropertiesForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateItemRandomPropertiesForSelector({ page: 1 });
        await Promise.all([
          this.searchItemRandomPropertiesForSelector(this.payload),
          this.countItemRandomPropertiesForSelector(this.payload),
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
      this.paginateItemRandomPropertiesForSelector({ page: page });
      await this.searchItemRandomPropertiesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let itemRandomProperty =
        this.itemRandomProperty != undefined
          ? this.itemRandomProperty
          : this.value;
      this.$emit("input", itemRandomProperty);
      this.visible = false;
    },
    store(row) {
      let itemRandomProperty = row != undefined ? row.ID : this.value;
      this.$emit("input", itemRandomProperty);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchItemRandomPropertiesForSelector(this.payload),
        this.countItemRandomPropertiesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.itemRandomProperty = this.value;
    this.ID = this.value;
  },
};
</script>
