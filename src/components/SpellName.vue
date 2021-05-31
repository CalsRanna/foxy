<template>
  <div style="height: 36px">
    <img
      v-if="spell.TextureFilename"
      :src="`/icons/${icon}.png`"
      style="width: 36px; height: 36px; padding-right: 4px"
    />
    <span :style="styleObject">
      {{ spell.Name_Lang_zhCN }}
    </span>
  </div>
</template>

<script>
export default {
  props: {
    spell: Object,
  },
  computed: {
    icon() {
      return this.spell.TextureFilename.split("\\")
        .pop()
        .split("_")
        .map((word) => {
          return word.replace(word[0], word[0].toUpperCase());
        })
        .join("_")
        .replace("Inv", "INV");
    },
    styleObject() {
      return {
        verticalAlign: "top",
        lineHeight: "36px",
      };
    },
  },
  mounted() {
    console.log(this.spell);
  },
};
</script>
