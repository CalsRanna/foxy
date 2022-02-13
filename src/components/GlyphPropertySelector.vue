<template>
  <div>
    <el-input v-model="glyphProperty" :placeholder="placeholder" @input="input">
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
          雕文属性选择器
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
        :data="glyphProperties"
        highlight-current-row
        :max-height="calculateMaxHeight()"
        class="hide-when-overflow"
        @current-change="select"
        @row-dblclick="(row) => store(row)"
      >
        <el-table-column prop="ID" label="编号" width="80px"> </el-table-column>
        <el-table-column label="技能">
          <spell-name slot-scope="scope" :spell="scope.row" />
        </el-table-column>
        <el-table-column prop="GlyphSlotFlags" label="标识"></el-table-column>
        <el-table-column label="图标">
          <icon-label
            slot-scope="scope"
            :icon="scope.row.GlyphIconTextureFilename"
          />
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

import SpellName from "@/components/SpellName";
import IconLabel from "@/components/IconLabel.vue";

export default {
  data() {
    return {
      glyphProperty: undefined,
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
      this.glyphProperty = newValue;
      this.ID = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("initiator", ["advanceConfig"]),
    ...mapState("glyphPropertySelector", ["pagination", "glyphProperties"]),
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
    ...mapActions("glyphPropertySelector", [
      "searchGlyphPropertiesForSelector",
      "countGlyphPropertiesForSelector",
      "paginateGlyphPropertiesForSelector",
    ]),
    calculateMaxHeight() {
      return this.pagination.total > this.advanceConfig.size
        ? this.clientHeight * 0.84 - 301
        : this.clientHeight * 0.84 - 241;
    },
    input(glyphProperty) {
      if (isNaN(parseInt(glyphProperty))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(glyphProperty));
      }
    },
    async show() {
      this.visible = true;
      await Promise.all([
        this.searchGlyphPropertiesForSelector(this.payload),
        this.countGlyphPropertiesForSelector(this.payload),
      ]);
    },
    async search() {
      this.loading = true;
      try {
        this.paginateGlyphPropertiesForSelector({ page: 1 });
        await Promise.all([
          this.searchGlyphPropertiesForSelector(this.payload),
          this.countGlyphPropertiesForSelector(this.payload),
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
      this.paginateGlyphPropertiesForSelector({ page: page });
      await this.searchGlyphPropertiesForSelector(this.payload);
    },
    select(currentRow) {
      this.currentRow = currentRow;
    },
    close() {
      let glyphProperty =
        this.glyphProperty != undefined ? this.glyphProperty : this.value;
      this.$emit("input", glyphProperty);
      this.visible = false;
    },
    store(row) {
      let glyphProperty = row != undefined ? row.ID : this.value;
      this.$emit("input", glyphProperty);
      this.visible = false;
    },
    async init() {
      await Promise.all([
        this.searchGlyphPropertiesForSelector(this.payload),
        this.countGlyphPropertiesForSelector(this.payload),
      ]);
    },
  },
  mounted() {
    this.glyphProperty = this.value;
    this.ID = this.value;
  },
  components: {
    SpellName,
    IconLabel,
  },
};
</script>
