<template>
  <span slot="label">
    <el-tooltip>
      <i class="el-icon-info"></i>
      <div slot="content" style="max-width: 400px">
        {{ tooltip }}
      </div>
    </el-tooltip>
    {{ label }}
  </span>
</template>

<script>
export default {
  props: {
    label: String,
    tooltip: String,
    maxWidth: Number,
  },
};
</script>
