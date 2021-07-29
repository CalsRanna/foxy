<template>
  <div style="height: 36px">
    <img
      :src="`/icons/${formattedIcon}.png`"
      style="width: 36px; height: 36px; padding-right: 4px"
    />
    <span :style="styleObject">
      {{ icon }}
    </span>
  </div>
</template>

<script>
export default {
  props: {
    icon: String,
  },
  computed: {
    formattedIcon() {
      return this.icon.split("\\").pop().toLowerCase();
    },
    styleObject() {
      return {
        verticalAlign: "top",
        lineHeight: "36px",
      };
    },
  },
};
</script>
