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
          内容本地化
        </span>
        <el-button type="primary" size="mini" @click="create">新增</el-button>
      </div>
      <el-table
        :data="achievementRewardLocales"
        :max-height="calculateMaxHeight()"
      >
        <el-table-column width="48px">
          <el-button
            slot-scope="scope"
            type="danger"
            size="mini"
            icon="el-icon-delete"
            circle
            @click="() => destroy(scope.$index)"
          ></el-button>
        </el-table-column>
        <el-table-column prop="Locale" label="语言" width="96px">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Locale" placeholder="Locale" />
          </template>
        </el-table-column>
        <el-table-column prop="Text" label="内容">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text" placeholder="Text" />
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
    ...mapState("achievementReward", ["achievementReward"]),
    ...mapState("achievementRewardLocale", ["achievementRewardLocales"]),
  },
  methods: {
    ...mapActions("achievementRewardLocale", ["storeAchievementRewardLocales"]),
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
      this.achievementRewardLocales.push({
        ID: this.achievementReward.ID,
      });
    },
    destroy(index) {
      this.achievementRewardLocales.splice(index, 1);
    },
    async store() {
      this.loading = true;
      await this.storeAchievementRewardLocales(this.achievementRewardLocales);
      this.$notify({
        title: "保存成功",
        position: "top-right",
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
