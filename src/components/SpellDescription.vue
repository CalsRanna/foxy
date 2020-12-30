<template>
  <span>{{ description }}</span>
</template>

<script>
import { mapState } from "vuex";
export default {
  props: {
    spell: Object,
    field: String,
  },
  computed: {
    ...mapState("dbc", ["spellDurations"]),
    description() {
      let duration = 0;
      for (let spellDuration of this.spellDurations.records) {
        if (spellDuration.unk_0 == this.spell.durationIndex) {
          duration = spellDuration.unk_1 / 1000;
          break;
        }
      }
      return this.spell[this.field]
        .replace("$s1", Math.abs(this.spell.effectBasePoints_1 + this.spell.effectDieSides_1))
        .replace("$s2", Math.abs(this.spell.effectBasePoints_2 + this.spell.effectDieSides_2))
        .replace("$s3", Math.abs(this.spell.effectBasePoints_3 + this.spell.effectDieSides_3))
        .replace("$t1", this.spell.effectAuraPeriod_1 / 1000)
        .replace("$t2", this.spell.effectAuraPeriod_2 / 1000)
        .replace("$t3", this.spell.effectAuraPeriod_3 / 1000)
        .replace("$n", this.spell.procCharges)
        .replace("$d", `${duration}秒`);
    },
  },
};
</script>
