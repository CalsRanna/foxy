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
        if (spellDuration.ID == this.spell.DurationIndex) {
          duration = spellDuration.Duration / 1000;
          break;
        }
      }
      return this.spell[this.field]
        .replace(
          "$s1",
          Math.abs(this.spell.EffectBasePoints_1 + this.spell.EffectDieSides_1)
        )
        .replace(
          "$s2",
          Math.abs(this.spell.EffectBasePoints_2 + this.spell.EffectDieSides_2)
        )
        .replace(
          "$s3",
          Math.abs(this.spell.EffectBasePoints_3 + this.spell.EffectDieSides_3)
        )
        .replace("$t1", this.spell.EffectAuraPeriod_1 / 1000)
        .replace("$t2", this.spell.EffectAuraPeriod_2 / 1000)
        .replace("$t3", this.spell.EffectAuraPeriod_3 / 1000)
        .replace("$n", this.spell.ProcCharges)
        .replace("$d", `${duration}秒`);
    },
  },
};
</script>
