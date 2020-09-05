<template>
  <div>
    <flag-editor
      v-model="flag"
      :flags="flags"
      title="Npc标识编辑器"
      placeholder="npcflag"
    ></flag-editor>
    绑定值：{{ flag }}
    <br />
    <el-button @click="random">Random value</el-button>
  </div>
</template>

<script>
import FlagEditor from "@/components/FlagEditor";
import { npcFlags } from "@/locales/creature";

export default {
  data() {
    return {
      flag: 1,
      flags: npcFlags,
    };
  },
  methods: {
    random() {
      this.flag = Math.round(Math.random() * 10000);
    },
  },
  components: {
    "flag-editor": FlagEditor,
  },
};
</script>
