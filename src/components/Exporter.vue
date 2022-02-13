<template>
  <div>
    <el-dialog
      title="请选择需要导出的dbc文件"
      :visible.sync="visible"
      top="30vh"
    >
      <el-checkbox
        :indeterminate="isIndeterminate"
        v-model="checkAll"
        @change="handleCheckAllChange"
      >
        全选
      </el-checkbox>
      <!-- <el-checkbox v-model="checkedMpq">
        同时生成{{ mpqDefaultName }}
      </el-checkbox> -->
      <div style="margin: 15px 0"></div>
      <el-checkbox-group :value="checkedDbcs" @input="handleInput">
        <el-checkbox
          v-for="option in options"
          :label="option"
          :key="option"
          style="width: 20%"
        >
          {{ option }}
        </el-checkbox>
      </el-checkbox-group>
      <span slot="footer">
        <el-button @click="visible = false">取消</el-button>
        <el-button
          type="primary"
          :disabled="checkedDbcs.length === 0"
          @click="confirm"
        >
          确定
        </el-button>
      </span>
    </el-dialog>
    <el-dialog
      width="30%"
      :visible.sync="visible2"
      top="30vh"
      :show-close="closable"
      :close-on-click-modal="closable"
      :close-on-press-escape="closable"
      @closed="handleClosed"
    >
      <span slot="title">
        导出信息<i class="el-icon-loading" v-if="exporting" />
      </span>
      <ul
        style="
          list-style: none;
          color: #909399;
          max-height: 300px;
          overflow: auto;
        "
      >
        <li v-for="(tip, index) in tips" :key="`tip-${index}`">
          <span v-if="tip.indexOf('找到') > -1 || tip.indexOf('成功') > -1">
            <i class="el-icon-check" style="color: #67c23a" />{{ tip }}
          </span>
          <span v-else-if="tip.indexOf('失败') > -1">
            <i class="el-icon-close" style="color: #f56c6c" />{{ tip }}
          </span>
          <span v-else> <i class="el-icon-arrow-right" />{{ tip }} </span>
        </li>
      </ul>
    </el-dialog>
  </div>
</template>

<script>
const ipcRenderer = window.ipcRenderer;

import { START_EXPORT } from "@/constants";
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      visible: false,
      isIndeterminate: true,
      checkedMpq: false,
      mpqDefaultName: "patch-zhCN-5.MPQ",
      checkAll: false,
      visible2: false,
      closable: false,
      exporting: false,
    };
  },
  computed: {
    ...mapState("exporter", ["options", "checkedDbcs", "tips"]),
  },
  methods: {
    ...mapActions("exporter", [
      "updateCheckedDbcs",
      "exportDbc",
      "pushTip",
      "resetTips",
    ]),
    handleCheckAllChange(val) {
      this.isIndeterminate = false;
      this.updateCheckedDbcs({ checkedDbcs: val ? this.options : [] });
    },
    handleInput(value) {
      let checkedCount = value.length;
      this.checkAll = checkedCount === this.options.length;
      this.isIndeterminate =
        checkedCount > 0 && checkedCount < this.options.length;
      this.updateCheckedDbcs({ checkedDbcs: value });
    },
    confirm() {
      this.visible = false;
      this.visible2 = true;
      this.closable = false;
      this.exporting = true;
      this.exportData();
    },
    exportData() {
      let start = Date.now();
      this.pushTip("导出开始");
      let promises = [];
      for (let dbc of this.checkedDbcs) {
        promises.push(this.exportDbc(dbc));
      }
      Promise.all(promises)
        .then(() => {
          this.closable = true;
          this.exporting = false;
          let end = Date.now();
          this.pushTip(
            `导出成功，本次共导出${this.checkedDbcs.length}个文件，耗时${
              (end - start) / 1000
            }秒`
          );
        })
        .catch((e) => {
          this.closable = true;
          this.exporting = false;
          this.pushTip(`导出失败, ${e}`);
        });
    },
    handleClosed() {
      this.resetTips();
    },
  },
  mounted() {
    ipcRenderer.once(START_EXPORT, () => {
      if (this.visible == false && this.visible2 == false) {
        this.visible = true;
      }
    });
  },
};
</script>

<style scoped>
li {
  margin-bottom: 8px;
}
</style>
