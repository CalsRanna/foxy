<template>
  <div>
    <el-input
      v-model="itemDisplayInfo"
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
    >
      <div slot="title">
        <span style="font-size: 18px; color: #303133; margin-right: 16px">
          物品外观选择器
        </span>
      </div>
      <el-card>
        <el-form>
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
                v-model="InventoryIcon"
                controls-position="right"
                placeholder="图标"
              ></el-input-number>
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
        :data="itemDisplayInfos"
        highlight-current-row
        @current-change="select"
        @row-dblclick="(row) => store(row)"
        class="spell-duration-selector"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column width="80px">
          <template slot-scope="scope">
            <el-image
              :src="`/icons/${scope.row.InventoryIcon_1}.png`"
              style="width: 32px; height:32px;margin: 0; padding: 0px 0 0 0"
            >
              <el-image
                src="/icons/INV_Misc_QuestionMark.png"
                style="width: 32px; height:32px;margin: 0; padding: 0px 0 0 0"
                slot="error"
              ></el-image>
            </el-image>
          </template>
        </el-table-column>
        <el-table-column prop="InventoryIcon_1" label="图标"> </el-table-column>
        <el-table-column prop="ModelName_1" label="模型"></el-table-column>
        <el-table-column prop="ModelTexture_1" label="纹理"></el-table-column>
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
      itemDisplayInfo: undefined,
      ID: undefined,
      InventoryIcon: undefined,
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
      this.itemDisplayInfo = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("itemDisplayInfoSelector", ["pagination", "itemDisplayInfos"]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        InventoryIcon: this.InventoryIcon,
        page: this.pagination.page,
      };
    },
  },
  methods: {
    ...mapActions("itemDisplayInfoSelector", [
      "searchItemDisplayInfosForSelector",
      "countItemDisplayInfosForSelector",
      "paginateItemDisplayInfosForSelector",
    ]),
    input(itemDisplayInfo) {
      if (isNaN(parseInt(itemDisplayInfo))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(itemDisplayInfo));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchItemDisplayInfosForSelector(this.payload),
        this.countItemDisplayInfosForSelector(this.payload),
      ]);
    },
    async search() {
      this.paginateItemDisplayInfosForSelector({ page: 1 });
      await Promise.all([
        this.searchItemDisplayInfosForSelector(this.payload),
        this.countItemDisplayInfosForSelector(this.payload),
      ]);
    },
    reset() {
      this.ID = undefined;
      this.InventoryIcon = undefined;
    },
    async paginate(page) {
      this.paginateItemDisplayInfosForSelector({ page: page });
      await this.searchItemDisplayInfosForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let itemDisplayInfo =
        this.itemDisplayInfo != undefined ? this.itemDisplayInfo : this.value;
      this.$emit("input", itemDisplayInfo);
      this.visible = false;
    },
    store(row) {
      let itemDisplayInfo = row != undefined ? row.ID : this.value;
      this.$emit("input", itemDisplayInfo);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchItemDisplayInfosForSelector(this.payload),
        this.countItemDisplayInfosForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.itemDisplayInfo = this.value;
    this.ID = this.value;
  },
};
</script>

<style scoped>
.spell-duration-selector {
  max-height: 40vh;
  overflow: auto;
}
.spell-duration-selector tbody tr {
  cursor: pointer;
}
</style>
