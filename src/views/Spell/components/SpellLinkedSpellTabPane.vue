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
          :data="spellLinkedSpells"
          highlight-current-row
          :max-height="calculateMaxHeight()"
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column
            prop="spell_effect"
            label="链接技能"
          ></el-table-column>
          <el-table-column prop="type" label="类型"></el-table-column>
          <el-table-column prop="comment" label="注解"></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="spellLinkedSpell"
        label-position="right"
        label-width="120px"
      >
        <div
          :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }"
        >
          <el-card style="margin-top: 1px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="触发技能">
                  <el-input-number
                    v-model="spellLinkedSpell.spell_trigger"
                    controls-position="right"
                    v-loading="initing"
                    placeholder="spell_trigger"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="链接技能">
                  <el-input-number
                    v-model="spellLinkedSpell.spell_effect"
                    controls-position="right"
                    placeholder="spell_effect"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="类型">
                  <el-input-number
                    v-model="spellLinkedSpell.type"
                    controls-position="right"
                    placeholder="type"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="注解">
                  <el-input
                    v-model="spellLinkedSpell.comment"
                    placeholder="comment"
                  ></el-input>
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
    ...mapState("spellLinkedSpell", ["spellLinkedSpells", "spellLinkedSpell"]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        spell_trigger:
          this.currentRow != undefined
            ? this.currentRow.spell_trigger
            : undefined,
        spell_effect:
          this.currentRow != undefined
            ? this.currentRow.spell_effect
            : undefined,
      };
    },
  },
  methods: {
    ...mapActions("spellLinkedSpell", [
      "searchSpellLinkedSpells",
      "storeSpellLinkedSpell",
      "findSpellLinkedSpell",
      "updateSpellLinkedSpell",
      "destroySpellLinkedSpell",
      "createSpellLinkedSpell",
      "copySpellLinkedSpell",
    ]),
    calculateMaxHeight() {
      return this.creating ? this.clientHeight - 307 : this.clientHeight - 349;
    },
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createSpellLinkedSpell({
        spell_trigger: this.spell.ID,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeSpellLinkedSpell(this.spellLinkedSpell);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
      } else {
        await this.updateSpellLinkedSpell({
          credential: this.credential,
          spellLinkedSpell: this.spellLinkedSpell,
        });
        this.$notify({
          title: "修改成功",
          position: "top-right",
          type: "success",
        });
      }
      await this.searchSpellLinkedSpells({
        spell_trigger: this.spell.ID,
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
            this.copySpellLinkedSpell(this.credential)
              .then(() => {
                this.searchSpellLinkedSpells({
                  spell_trigger: this.spell.ID,
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
              this.destroySpellLinkedSpell(this.credential)
                .then(() => {
                  this.searchSpellLinkedSpells({
                    spell_trigger: this.spell.ID,
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
      await this.findSpellLinkedSpell({
        spell_trigger: row.spell_trigger,
        spell_effect: row.spell_effect,
      });
    },
    async init() {
      this.initing = true;
      await this.searchSpellLinkedSpells({
        spell_trigger: this.spell.ID,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
