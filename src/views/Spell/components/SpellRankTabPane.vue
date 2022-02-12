<template>
  <div>
    <div v-show="!creating">
      <el-card style="margin-top: 1px">
        <el-button type="primary" @click="create">新增</el-button>
        <el-button @click="copy" :disabled="disabled">复制</el-button>
        <el-button type="danger" @click="destroy" :disabled="disabled">
          删除
        </el-button>
      </el-card>
      <el-card style="margin-top: 16px">
        <el-table
          :data="spellRanks"
          highlight-current-row
          :max-height="calculateMaxHeight()"
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column label="起始技能">
            <span slot-scope="scope">
              {{ scope.row.First_Spell_Name_Lang_zhCN }}
              <el-tag
                size="small"
                v-if="scope.row.First_Spell_NameSubtext_Lang_zhCN != null"
                >{{ scope.row.First_Spell_NameSubtext_Lang_zhCN }}</el-tag
              >
            </span>
          </el-table-column>
          <el-table-column label="技能">
            <span slot-scope="scope">
              {{ scope.row.Spell_Name_Lang_zhCN }}
              <el-tag
                size="small"
                v-if="scope.row.Spell_NameSubtext_Lang_zhCN != null"
                >{{ scope.row.Spell_NameSubtext_Lang_zhCN }}</el-tag
              >
            </span>
          </el-table-column>
          <el-table-column prop="rank" label="排行"></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form :model="spellRank" label-position="right" label-width="120px">
        <div
          :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }"
        >
          <el-card style="margin-top: 1px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="起始技能">
                  <spell-selector
                    v-model="spellRank.first_spell_id"
                    placeholder="first_spell_id"
                  />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能">
                  <spell-selector
                    v-model="spellRank.spell_id"
                    placeholder="spell_id"
                  />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="排行">
                  <el-input-number
                    v-model="spellRank.rank"
                    controls-position="right"
                    :min="1"
                    placeholder="rank"
                  />
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
        </div>
        <el-card style="margin-top: 16px">
          <el-button type="primary" :loading="loading" @click="store">
            保存
          </el-button>
          <el-button @click="cancel">返回</el-button>
        </el-card>
      </el-form>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
import SpellSelector from "@/components/SpellSelector";
export default {
  data() {
    return {
      initing: false,
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("spell", ["spell"]),
    ...mapState("spellRank", ["spellRanks", "spellRank"]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        first_spell_id:
          this.currentRow != undefined
            ? this.currentRow.first_spell_id
            : undefined,
        rank: this.currentRow != undefined ? this.currentRow.rank : undefined,
      };
    },
  },
  methods: {
    ...mapActions("spellRank", [
      "searchSpellRanks",
      "storeSpellRank",
      "findSpellRank",
      "updateSpellRank",
      "destroySpellRank",
      "createSpellRank",
      "copySpellRank",
    ]),
    calculateMaxHeight() {
      return this.creating ? this.clientHeight - 307 : this.clientHeight - 349;
    },
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createSpellRank({
        first_spell_id:
          this.spellRanks.length > 0 ? this.spellRanks[0].first_spell_id : 0,
        spell_id: this.spell.ID,
        rank:
          this.spellRanks.length > 0
            ? this.spellRanks[this.spellRanks.length - 1].rank + 1
            : 1,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeSpellRank(this.spellRank);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
      } else {
        await this.updateSpellRank({
          credential: this.credential,
          spellRank: this.spellRank,
        });
        this.$notify({
          title: "修改成功",
          position: "top-right",
          type: "success",
        });
      }
      await this.searchSpellRanks({
        spell_id: this.spell.ID,
      });
      this.creating = false;
      this.editing = false;
    },
    cancel() {
      this.creating = false;
    },
    copy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？", "确认复制", {
        confirmButtonText: "确认",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
        beforeClose: (action, instance, done) => {
          if (action === "confirm") {
            instance.confirmButtonLoading = true;
            this.copySpellRank(this.credential)
              .then(() => {
                this.searchSpellRanks({
                  spell_id: this.spell.ID,
                });
              })
              .then(() => {
                this.$notify({
                  title: "复制成功",
                  position: "top-right",
                  type: "success",
                });
                instance.confirmButtonLoading = false;
                done();
              });
          } else {
            done();
          }
        },
      });
    },
    destroy() {
      this.$confirm(
        "此操作将永久删除该数据，确认继续？<br><small>为避免误操作，不提供删除关联表数据功能。</small>",
        "确认删除",
        {
          confirmButtonText: "确认",
          cancelButtonText: "取消",
          type: "info",
          dangerouslyUseHTMLString: true,
          beforeClose: (action, instance, done) => {
            if (action === "confirm") {
              instance.confirmButtonLoading = true;
              this.destroySpellRank(this.credential)
                .then(() => {
                  this.searchSpellRanks({
                    spell_id: this.spell.ID,
                  });
                })
                .then(() => {
                  this.$notify({
                    title: "删除成功",
                    position: "top-right",
                    type: "success",
                  });
                  instance.confirmButtonLoading = false;
                  done();
                });
            } else {
              done();
            }
          },
        }
      );
    },
    select(row) {
      this.currentRow = row;
    },
    async show(row) {
      this.creating = true;
      this.editing = true;
      await this.findSpellRank({
        first_spell_id: row.first_spell_id,
        rank: row.rank,
      });
    },
    async init() {
      this.initing = true;
      await this.searchSpellRanks({
        spell_id: this.spell.ID,
      });
      this.initing = false;
    },
  },
  components: { SpellSelector },
  mounted() {
    this.init();
  },
};
</script>
