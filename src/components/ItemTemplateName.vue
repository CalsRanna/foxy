<template>
  <div style="height: 36px">
    <img
      v-if="itemTemplate.InventoryIcon_1"
      :src="`/icons/${itemTemplate.InventoryIcon_1}.png`"
      style="width: 36px; height: 36px; padding-right: 4px"
    />
    <span :style="styleObject" v-if="itemTemplate.localeName">
      {{ itemTemplate.localeName }}
    </span>
    <span :style="styleObject" v-else>{{ itemTemplate.name }}</span>
  </div>
</template>

<script>
import { colors } from "../locales/item.js";

export default {
  props: {
    itemTemplate: Object,
  },
  computed: {
    styleObject() {
      return {
        verticalAlign: "top",
        lineHeight: "36px",
        color: colors[this.itemTemplate.Quality],
      };
    },
  },
};
</script>
