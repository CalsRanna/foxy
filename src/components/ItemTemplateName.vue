<template>
  <el-row :gutter="24">
    <!-- 需要找个好方法解决索引图标耗时过长的问题 -->
    <!-- <el-col :span="4">
      <el-image
        :src="`/icons/${icons[itemTemplate.displayid]}.png`"
        style="width: 23px; height:23px;margin: 0; padding: 0px 0 0 0"
      >
        <el-image
          src="/icons/INV_Misc_QuestionMark.png"
          style="width: 23px; height:23px;margin: 0; padding: 0px 0 0 0"
          slot="error"
        ></el-image>
      </el-image>
    </el-col> -->
    <el-col :span="20">
      <span :style="{ color: colors[itemTemplate.Quality] }">
        <template v-if="itemTemplate.localeName !== null">{{ itemTemplate.localeName }}</template>
        <template v-else>{{ itemTemplate.name }}</template>
      </span>
    </el-col>
  </el-row>
</template>

<script>
import { colors } from "../locales/item.js";

import { mapGetters } from "vuex";

export default {
  data() {
    return {
      colors: colors
    };
  },
  props: {
    itemTemplate: Object
  },
  computed: {
    ...mapGetters("dbc", { icons: "itemIcons" })
  }
};
</script>
