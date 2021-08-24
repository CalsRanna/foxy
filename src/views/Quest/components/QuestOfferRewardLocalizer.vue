<template>
  <div>
    <el-input v-model="text" :placeholder="placeholder" @input="input" @change="blur">
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
        <span style="font-size: 18px; color: #303133; margin-right: 16px">奖励文本本地化</span>
        <el-button type="primary" size="mini" @click="create">新增</el-button>
      </div>
      <el-table :data="questOfferRewardLocales" :max-height="calculateMaxHeight()">
        <el-table-column width="48">
          <el-button
            type="danger"
            size="mini"
            icon="el-icon-delete"
            circle
            slot-scope="scope"
            @click="() => destroy(scope.$index)"
          ></el-button>
        </el-table-column>
        <el-table-column prop="locale" label="语言" width="96">
          <template slot-scope="scope">
            <el-input v-model="scope.row.locale" placeholder="locale"></el-input>
          </template>
        </el-table-column>
        <el-table-column label="奖励文本">
          <template slot-scope="scope">
            <el-input v-model="scope.row.RewardText" placeholder="RewardText"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="VerifiedBuild" label="VerifiedBuild" width="128">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.VerifiedBuild"
              controls-position="right"
              placeholder="VerifiedBuild"
            ></el-input-number>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer">
        <el-button @click="cancel">取消</el-button>
        <el-button type="primary" :loading="loading" @click="store">保存</el-button>
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
    ...mapState("questTemplate", ["questTemplate"]),
    ...mapState("questOfferRewardLocale", ["questOfferRewardLocales"]),
  },
  methods: {
    ...mapActions("questOfferRewardLocale", ["storeQuestOfferRewardLocales"]),
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
      this.questOfferRewardLocales.push({
        ID: this.questTemplate.entry,
        VerifiedBuild: 0,
      });
    },
    destroy(index) {
      this.questOfferRewardLocales.splice(index, 1);
    },
    async store() {
      this.loading = true;
      await this.storeQuestOfferRewardLocales(this.questOfferRewardLocales);
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
