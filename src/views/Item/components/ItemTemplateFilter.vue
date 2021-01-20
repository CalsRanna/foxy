<template>
  <el-card style="margin-top: 16px">
    <div>
      <span style="font-size: 14px">类别：</span>
      <el-button
        type="text"
        size="small"
        v-for="(localeClass, index) in localeClasses"
        :key="`class-${index}`"
        @click="() => filtrate('class', index)"
      >
        {{ localeClass }}
      </el-button>
    </div>
    <div v-if="filter.class !== undefined">
      <span style="font-size: 14px">子类别：</span>
      <template v-if="filter.class !== 16">
        <el-button
          type="text"
          size="small"
          v-for="(localeSubclass, index) in localeSubclasses[filter.class]"
          :key="`subclass-${index}`"
          @click="() => filtrate('subclass', index)"
        >
          {{ localeSubclass }}
        </el-button>
      </template>
      <!-- index in [1, 2, 3, 4, 5, 6, 7, 8, 9, 11]，不取值0和10，隐藏雕文职业本地化数组中的空字符 -->
      <template v-else>
        <el-button
          type="text"
          size="small"
          v-for="index in [1, 2, 3, 4, 5, 6, 7, 8, 9, 11]"
          :key="`subclass-${index}`"
          @click="() => filtrate('subclass', index)"
        >
          {{ localeSubclasses[filter.class][index] }}
        </el-button>
      </template>
    </div>
    <div
      v-if="filter.class !== undefined || filter.subclass !== undefined"
      style="margin-top: 16px"
    >
      <el-tag
        size="small"
        closable
        @close="() => filtrate('remove-class', undefined)"
        v-if="filter.class !== undefined"
        style="margin-right: 8px"
      >
        {{ localeClasses[filter.class] }}
      </el-tag>
      <el-tag
        size="small"
        closable
        @close="() => filtrate('remove-subclass', undefined)"
        v-if="filter.subclass !== undefined"
        style="margin-right: 8px"
      >
        {{ localeSubclasses[filter.class][filter.subclass] }}
      </el-tag>
    </div>
  </el-card>
</template>

<script>
import { localeClasses, localeSubclasses } from "../locales/item.js";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      localeClasses: localeClasses,
      localeSubclasses: localeSubclasses,
    };
  },
  computed: {
    ...mapState("itemTemplate", ["filter"]),
  },
  methods: {
    ...mapActions("itemTemplate", ["updateFilter"]),
    async filtrate(field, value) {
      switch (field) {
        case "class":
          await this.updateFilter({ class: value, subclass: undefined });
          break;
        case "subclass":
          await this.updateFilter({
            class: this.filter.class,
            subclass: value,
          });
          break;
        case "remove-class":
          await this.updateFilter({
            class: undefined,
            subclass: undefined,
          });
          break;
        case "remove-subclass":
          await this.updateFilter({
            class: this.filter.class,
            subclass: undefined,
          });
          break;
        default:
          break;
      }
      this.$emit("filtrate");
    },
  },
};
</script>
