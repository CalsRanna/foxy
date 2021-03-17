<template>
  <div>
    <el-divider>关联掉落</el-divider>
    <el-card
      style="margin-top: 16px"
      v-for="referenceLootTemplates in groupedReferenceLootTemplates"
      :key="`reference-loot-template-${referenceLootTemplates[0].Entry}`"
    >
      <div slot="header">
        <el-tag>{{ referenceLootTemplates[0].Entry }}</el-tag>
      </div>
      <el-table :data="referenceLootTemplates">
        <el-table-column prop="displayid"></el-table-column>
        <el-table-column label="名称" sortable>
          <span slot-scope="scope">
            <template v-if="scope.row.Reference == 0">
              <template v-if="scope.row.localeName !== null">
                {{ scope.row.localeName }}
              </template>
              <template v-else>{{ scope.row.name }}</template>
            </template>
            <template v-else>
              <el-tag>关联掉落</el-tag>
            </template>
          </span>
        </el-table-column>
        <el-table-column
          prop="Reference"
          label="关联"
          sortable
        ></el-table-column>
        <el-table-column prop="Chance" label="几率" sortable>
          <span slot-scope="scope">
            {{ `${scope.row.Chance}%` }}
          </span>
        </el-table-column>
        <el-table-column prop="QuestRequired" label="需要任务" sortable>
          <span slot-scope="scope">
            <el-tag type="success" v-if="scope.row.QuestRequired">
              需要
            </el-tag>
            <el-tag v-else>不需要</el-tag>
          </span>
        </el-table-column>
        <el-table-column
          prop="MinCount"
          label="最小数量"
          sortable
        ></el-table-column>
        <el-table-column
          prop="MaxCount"
          label="最大数量"
          sortable
        ></el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      uncheckedEntries: [],
      checkedEntries: [],
      groupedReferenceLootTemplates: [],
    };
  },
  props: {
    entries: Array,
  },
  computed: {
    ...mapState("referenceLootTemplate", ["referenceLootTemplates"]),
  },
  watch: {
    entries: function() {
      (this.timer = setTimeout(this.init(), 1000)), clearTimeout(this.timer);
    },
  },
  methods: {
    ...mapActions("referenceLootTemplate", [
      "searchReferenceLootTemplates",
      "checkReferenceEntries",
    ]),
    groupBy() {
      let entries = [];
      let groups = [];
      this.referenceLootTemplates.forEach((referenceLootTemplate) => {
        let index = entries.indexOf(referenceLootTemplate.Entry);
        if (index > -1) {
          groups[index].push(referenceLootTemplate);
        } else {
          entries.push(referenceLootTemplate.Entry);
          groups.push([referenceLootTemplate]);
        }
      });
      this.groupedReferenceLootTemplates = groups;
    },
    async init() {
      let uncheckedEntries = this.entries;
      let checkedEntries = [];
      while (uncheckedEntries.length > 0) {
        let entries = await this.checkReferenceEntries({
          entries: uncheckedEntries,
        });
        for (let entry of uncheckedEntries) {
          checkedEntries.push(entry);
        }
        uncheckedEntries = entries;
      }
      let payload = {
        entries: [0],
      };
      if (checkedEntries.length > 0) {
        payload.entries = checkedEntries;
      }
      await this.searchReferenceLootTemplates(payload);
      this.groupBy();
    },
  },
  beforeMount() {
    if (this.referenceLootTemplates.length == 0) {
      this.init();
    }
  },
};
</script>
