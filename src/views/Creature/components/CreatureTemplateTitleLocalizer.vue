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
      width="68%"
      top="8vh"
    >
      <div slot="title">
        <span style="font-size: 18px; color: #303133; margin-right: 16px">
          称号本地化
        </span>
        <el-button type="primary" size="mini" @click="create">新增</el-button>
      </div>
      <el-table
        :data="creatureTemplateLocales"
        :max-height="clientHeight * 0.84 - 81 - 80"
      >
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
        <el-table-column prop="locale" label="语言" width="96">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.locale"
              placeholder="locale"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Title" label="称号">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Title" placeholder="Title"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="VerifiedBuild" label="VerifiedBuild" width="128">
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
    value: function (newValue) {
      this.text = newValue;
    },
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureTemplateLocale", ["creatureTemplateLocales"]),
  },
  methods: {
    ...mapActions("creatureTemplateLocale", ["storeCreatureTemplateLocales"]),
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
      this.creatureTemplateLocales.push({
        entry: this.creatureTemplate.entry,
        VerifiedBuild: 0,
      });
    },
    destroy(index) {
      this.creatureTemplateLocales.splice(index, 1);
    },
    async store() {
      this.loading = true;
      await this.storeCreatureTemplateLocales(this.creatureTemplateLocales);
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
