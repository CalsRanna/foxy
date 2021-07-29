<template></template>

<script>
import { mapState, mapActions } from "vuex";
import ClickableSpan from "@/components/ClickableSpan";

export default {
  computed: {
    ...mapState("app", { locale: "version" }),
    ...mapState("updater", {
      remote: "version",
    }),
  },
  methods: {
    ...mapActions("updater", ["checkVersion"]),
    async init() {
      try {
        await this.checkVersion();
        if (
          this.remote.version !== undefined &&
          this.remote.version > this.locale
        ) {
          this.$notify.info({
            title: "更新提示",
            message: `检测到更新的版本，请下载使用。`,
            duration: 0,
            position: "bottom-left",
          });
        }
      } catch (error) {}
    },
  },
  mounted() {
    this.init();
  },
  components: { ClickableSpan },
};
</script>
