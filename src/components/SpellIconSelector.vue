<template>
  <div>
    <el-input v-model="spellIcon" :placeholder="placeholder" @input="input">
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
          技能图标选择器
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
                v-model="TextureFilename"
                placeholder="TextureFilename"
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
        :page-size="advanceConfig.size"
        hide-on-single-page
        @current-change="paginate"
        style="margin-top: 16px"
      ></el-pagination>
      <el-table
        :data="spellIcons"
        :max-height="calculateMaxHeight()"
        highlight-current-row
        class="selectable-table hide-when-overflow tight-table"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column label="图标">
          <icon-label
            slot-scope="scope"
            :icon="scope.row.TextureFilename"
          ></icon-label>
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
import IconLabel from "./IconLabel.vue";

export default {
  data() {
    return {
      spellIcon: undefined,
      ID: undefined,
      TextureFilename: undefined,
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
      this.spellIcon = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("spellIconSelector", ["pagination", "spellIcons"]),
    payload() {
      return {
        ID: this.ID != 0 ? this.ID : undefined,
        TextureFilename: this.TextureFilename,
        page: this.pagination.page,
        size: this.advanceConfig.size,
      };
    },
  },
  methods: {
    ...mapActions("spellIconSelector", [
      "searchSpellIconsForSelector",
      "countSpellIconsForSelector",
      "paginateSpellIconsForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? clientHeight * 0.84 - 301
        : clientHeight * 0.84 - 241;
    },
    input(spellIcon) {
      if (isNaN(parseInt(spellIcon))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(spellIcon));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchSpellIconsForSelector(this.payload),
        this.countSpellIconsForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateSpellIconsForSelector({ page: 1 });
        await Promise.all([
          this.searchSpellIconsForSelector(this.payload),
          this.countSpellIconsForSelector(this.payload),
        ]);
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    reset() {
      this.ID = undefined;
      this.TextureFilename = undefined;
    },
    async paginate(page) {
      this.paginateSpellIconsForSelector({ page: page });
      await this.searchSpellIconsForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let spellIcon = this.spellIcon != undefined ? this.spellIcon : this.value;
      this.$emit("input", spellIcon);
      this.visible = false;
    },
    store(row) {
      let spellIcon = row != undefined ? row.ID : this.value;
      this.$emit("input", spellIcon);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchSpellIconsForSelector(this.payload),
        this.countSpellIconsForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.spellIcon = this.value;
    this.ID = this.value;
  },
  components: { IconLabel },
};
</script>
