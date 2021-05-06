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
          文本本地化
        </span>
        <el-button size="mini" @click="create">新增</el-button>
      </div>
      <el-table :data="npcTextLocales">
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
        <el-table-column prop="ID" label="编号">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.ID"
              controls-position="right"
              disabled
            ></el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="Locale" label="语言">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Locale"
              placeholder="Locale"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text0_0" label="文本0_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text0_0"
              placeholder="Text0_0"
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
        <el-table-column prop="Text1_0" label="文本1_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text1_0"
              placeholder="Text1_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text1_1" label="文本1_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text1_1"
              placeholder="Text1_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text2_0" label="文本2_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text2_0"
              placeholder="Text2_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text2_1" label="文本2_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text2_1"
              placeholder="Text2_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text3_0" label="文本3_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text3_0"
              placeholder="Text3_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text3_1" label="文本3_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text3_1"
              placeholder="Text3_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text4_0" label="文本4_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text4_0"
              placeholder="Text4_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text4_1" label="文本4_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text4_1"
              placeholder="Text4_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text5_0" label="文本5_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text5_0"
              placeholder="Text5_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text5_1" label="文本5_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text5_1"
              placeholder="Text5_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text6_0" label="文本6_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text6_0"
              placeholder="Text6_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text6_1" label="文本6_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text6_1"
              placeholder="Text6_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text7_0" label="文本7_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text7_0"
              placeholder="Text7_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text7_1" label="文本7_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text7_1"
              placeholder="Text7_1"
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
    ...mapState("npcText", ["npcText"]),
    ...mapState("npcTextLocale", ["npcTextLocales"]),
  },
  methods: {
    ...mapActions("npcTextLocale", ["storeNpcTextLocales"]),
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
