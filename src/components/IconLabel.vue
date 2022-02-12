<template>
  <div style="height: 36px">
    <img
      :src="`/icons/${formattedIcon}.png`"
      v-if="formattedIcon"
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
      if (this.icon == null) {
        return null;
      } else {
        let icon = this.icon.split("\\").pop().toLowerCase();
        // 为了避免重复的图片文件，使用代码处理不规则的图片名称
        if (icon == "ui-glyph-rune1") {
          icon = "ui-glyph-rune-1";
        }
        return icon;
      }
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
