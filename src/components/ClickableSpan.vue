<template>
  <span
    style="color: #409eff; cursor: pointer"
    @click="() => openBrowser(url)"
    >{{ text }}</span
  >
</template>

<script>
export default {
  props: {
    text: String,
    url: String,
  },
  methods: {
    openBrowser(url) {
      const shell = window.shell;
      shell.openExternal(url);
    },
  },
};
</script>
