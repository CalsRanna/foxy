<template>
  <div>
    <el-input
      v-model="text"
      :placeholder="placeholder"
      @input="input"
      @change="blur"
    >
      <i
        class="el-icon-orange clickable-icon"
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
          文本本地化
        </span>
        <el-button type="primary" size="mini" @click="create">新增</el-button>
      </div>
      <el-table :data="npcTextLocales" :max-height="calculateMaxHeight()">
        <el-table-column width="48">
          <el-button
            type="danger"
            size="mini"
            icon="el-icon-delete"
            circle=""
            slot-scope="scope"
            @click="() => destroy(scope.$index)"
          ></el-button>
        </el-table-column>
        <el-table-column prop="Locale" label="语言" width="96">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Locale"
              placeholder="Locale"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text0_1" label="文本0_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text0_1"
              placeholder="Text0_1"
            ></el-input>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer">
        <el-button @click="cancel">取消</el-button>
        <el-button type="primary" :loading="loading" @click="store">
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
      text: undefined,
      visible: false,
      loading: false,
    };
  },
  props: {
    value: String,
    placeholder: String,
  },
  watch: {
    value: function (newValue) {
      this.text = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("npcText", ["npcText"]),
    ...mapState("npcTextLocale", ["npcTextLocales"]),
  },
  methods: {
    ...mapActions("npcTextLocale", ["storeNpcTextLocales"]),
    calculateMaxHeight() {
      return this.clientHeight * 0.84 - 161;
    },
    input(text) {
      this.$emit("input", text);
    },
    blur(text) {
      this.$emit("input", text);
    },
    show() {
      this.visible = true;
    },
    create() {
      this.npcTextLocales.push({
        ID: this.npcText.ID,
        VerifiedBuild: 0,
      });
    },
    destroy(index) {
      this.npcTextLocales.splice(index, 1);
    },
    async store() {
      this.loading = true;
      await this.storeNpcTextLocales(this.npcTextLocales);
      this.$notify({
        title: "保存成功",
        position: "bottom-left",
        type: "success",
      });
      this.loading = false;
      this.visible = false;
    },
    cancel() {
      this.visible = false;
    },
  },
  created() {
    this.text = this.value;
  },
};
</script>
