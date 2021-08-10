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
          :data="spellGroups"
          highlight-current-row
          :max-height="calculateMaxHeight()"
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="id" label="技能组"></el-table-column>
          <el-table-column prop="special_flag" label="标识"></el-table-column>
          <el-table-column
            prop="stack_rule"
            label="光环叠加规则"
          ></el-table-column>
          <el-table-column prop="description" label="描述"></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form :model="spellGroup" label-position="right" label-width="120px">
        <div
          :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }"
        >
          <el-card style="margin-top: 1px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="技能">
                  <el-input-number
                    v-model="spellGroup.spell_id"
                    controls-position="right"
                    v-loading="initing"
                    placeholder="spell_id"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能组">
                  <el-input-number
                    v-model="spellGroup.id"
                    controls-position="right"
                    placeholder="id"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="标识">
                  <el-input-number
                    v-model="spellGroup.special_flag"
                    controls-position="right"
                    placeholder="special_flag"
                  ></el-input-number>
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
    ...mapState("spellGroup", ["spellGroups", "spellGroup"]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        id: this.currentRow != undefined ? this.currentRow.id : undefined,
        spell_id:
          this.currentRow != undefined ? this.currentRow.spell_id : undefined,
      };
    },
  },
  methods: {
    ...mapActions("spellGroup", [
      "searchSpellGroups",
      "storeSpellGroup",
      "findSpellGroup",
      "updateSpellGroup",
      "destroySpellGroup",
      "createSpellGroup",
      "copySpellGroup",
    ]),
    calculateMaxHeight() {
      return this.creating ? this.clientHeight - 307 : this.clientHeight - 349;
    },
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createSpellGroup({
        spell_id: this.spell.ID,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeSpellGroup(this.spellGroup);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
      } else {
        await this.updateSpellGroup({
          credential: this.credential,
          spellGroup: this.spellGroup,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      await this.searchSpellGroups({
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
            this.copySpellGroup(this.credential)
              .then(() => {
                this.searchSpellGroups({
                  spell_id: this.spell.ID,
                });
              })
              .then(() => {
                this.$notify({
                  title: "复制成功",
                  position: "bottom-left",
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
              this.destroySpellGroup(this.credential)
                .then(() => {
                  this.searchSpellGroups({
                    spell_id: this.spell.ID,
                  });
                })
                .then(() => {
                  this.$notify({
                    title: "删除成功",
                    position: "bottom-left",
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
      await this.findSpellGroup({
        id: row.id,
        spell_id: row.spell_id,
      });
    },
    async init() {
      this.initing = true;
      await this.searchSpellGroups({
        spell_id: this.spell.ID,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
