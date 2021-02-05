<template>
  <div>
    <el-input
      v-model="text"
      :placeholder="placeholder"
      @input="input"
      @change="blur"
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
          名称/描述本地化
        </span>
        <el-button size="mini" @click="create">新增</el-button>
      </div>
      <el-table :data="questTemplateLocales">
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
        <el-table-column prop="entry" label="编号">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.ID"
              controls-position="right"
              disabled
            ></el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="locale" label="语言">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.locale"
              placeholder="locale"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Title" label="名称">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Title" placeholder="Title"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Details" label="任务详情">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Details"
              placeholder="Details"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Objectives" label="Objectives">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Objectives"
              placeholder="Objectives"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="EndText" label="EndText">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.EndText"
              placeholder="EndText"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="CompletedText" label="CompletedText">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.CompletedText"
              placeholder="CompletedText"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="ObjectiveText1" label="ObjectiveText1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.ObjectiveText1"
              placeholder="ObjectiveText1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="ObjectiveText2" label="ObjectiveText2">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.ObjectiveText2"
              placeholder="ObjectiveText2"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="ObjectiveText3" label="ObjectiveText3">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.ObjectiveText3"
              placeholder="ObjectiveText3"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="ObjectiveText4" label="ObjectiveText4">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.ObjectiveText4"
              placeholder="ObjectiveText4"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="VerifiedBuild" label="VerifiedBuild">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.VerifiedBuild"
              :min="0"
              controls-position="right"
              placeholder="VerifiedBuild"
            ></el-input-number>
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
    value: function(newValue) {
      this.text = newValue;
    },
  },
  computed: {
    ...mapState("questTemplate", ["questTemplate"]),
    ...mapState("questTemplateLocale", ["questTemplateLocales"]),
  },
  methods: {
    ...mapActions("questTemplateLocale", ["storeQuestTemplateLocales"]),
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
      this.questTemplateLocales.push({
        ID: this.questTemplate.entry,
        VerifiedBuild: 0,
      });
    },
    destroy(index) {
      this.questTemplateLocales.splice(index, 1);
    },
    async store() {
      this.loading = true;
      await this.storeQuestTemplateLocales(this.questTemplateLocales);
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
