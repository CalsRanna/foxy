<template>
  <div>
    <el-input v-model="flag" :placeholder="placeholder" @input="input" @change="blur">
      <i class="el-icon-s-operation clickable-icon" slot="suffix" style="margin-right: 8px" @click="showDialog"></i>
    </el-input>
    <el-dialog :visible.sync="visible" :show-close="false" :close-on-click-modal="false" @opened="init">
      <div slot="title">
        <span style="font-size: 18px;color: #303133;margin-right:16px">{{ title }}</span>
      </div>
      <el-table :data="flags" @selection-change="change" @row-click="select" class="flag-editor">
        <el-table-column type="selection" width="48"></el-table-column>
        <el-table-column prop="flag" label="标识"></el-table-column>
        <el-table-column prop="name" label="名称"></el-table-column>
        <el-table-column prop="comment" label="描述" min-width="400"></el-table-column>
      </el-table>
      <div slot="footer">
        <span style="color: #606266; margin-right:8px">合计值：{{ selectedFlag }}</span>
        <el-button @click="closeDialog">取消</el-button>
        <el-button type="primary" @click="store">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<style scoped>
.flag-editor {
  max-height: 50vh;
  overflow: auto;
}
.flag-editor tbody tr {
  cursor: pointer;
}
</style>

<script>
export default {
  data() {
    return {
      flag: undefined,
      selection: [],
      visible: false
    };
  },
  props: {
    value: [Number, String],
    title: String,
    placeholder: String,
    flags: Array
  },
  watch: {
    value: function(newValue) {
      this.flag = newValue;
    }
  },
  computed: {
    selectedFlag() {
      let flag = 0;
      this.selection.forEach(row => {
        flag = flag + row.flag;
      });
      return flag;
    }
  },
  methods: {
    input(flag) {
      this.$emit("input", flag);
    },
    blur(flag) {
      if (isNaN(parseInt(flag))) {
        this.$emit("input", undefined);
      } else {
        this.$emit("input", parseInt(flag));
      }
    },
    showDialog() {
      this.visible = true;
    },
    init() {
      let selections = [];
      this.flags.forEach(flag => {
        let bit = this.flag & flag.flag;
        if (bit !== 0) {
          selections.push(true);
        } else {
          selections.push(false);
        }
      });
      selections.forEach((selection, index) => {
        this.$children[1].$children[2].toggleRowSelection(this.flags[index], selection);
      });
    },
    change(selection) {
      this.selection = selection;
    },
    select(row) {
      this.$children[1].$children[2].toggleRowSelection(row);
    },
    closeDialog() {
      this.visible = false;
    },
    store() {
      this.flag = this.selectedFlag;
      this.$emit("input", this.flag);
      this.visible = false;
    }
  },
  created() {
    this.flag = this.value;
  }
};
</script>
