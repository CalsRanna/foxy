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
          :data="spellAreas"
          highlight-current-row
          :max-height="calculateMaxHeight()"
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="area" label="区域"></el-table-column>
          <el-table-column
            prop="quest_start"
            label="开始任务"
          ></el-table-column>
          <el-table-column prop="quest_end" label="结束任务"></el-table-column>
          <el-table-column prop="aura_spell" label="光环"></el-table-column>
          <el-table-column prop="quest_start_status" label="开始任务掩码">
          </el-table-column>
          <el-table-column prop="quest_end_status" label="结束任务掩码">
          </el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form :model="spellArea" label-position="right" label-width="120px">
        <div
          :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }"
        >
          <el-card style="margin-top: 1px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="编号">
                  <el-input-number
                    v-model="spellArea.spell"
                    controls-position="right"
                    v-loading="initing"
                    placeholder="spell"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="区域">
                  <el-input-number
                    v-model="spellArea.area"
                    controls-position="right"
                    placeholder="area"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="开始任务">
                  <el-input-number
                    v-model="spellArea.quest_start"
                    controls-position="right"
                    placeholder="quest_start"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="结束任务">
                  <el-input-number
                    v-model="spellArea.quest_end"
                    controls-position="right"
                    placeholder="quest_end"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="开始任务掩码">
                  <el-input-number
                    v-model="spellArea.quest_start_status"
                    controls-position="right"
                    placeholder="quest_start_status"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="结束任务掩码">
                  <el-input-number
                    v-model="spellArea.quest_end_status"
                    controls-position="right"
                    placeholder="quest_end_status"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环">
                  <el-input-number
                    v-model="spellArea.aura_spell"
                    controls-position="right"
                    placeholder="aura_spell"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="种族掩码">
                  <el-input-number
                    v-model="spellArea.racemask"
                    controls-position="right"
                    placeholder="racemask"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="性别">
                  <el-input-number
                    v-model="spellArea.gender"
                    controls-position="right"
                    placeholder="gender"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="自动施放">
                  <el-switch
                    v-model="spellArea.autocast"
                    :active-value="1"
                    :inactive-value="0"
                  ></el-switch>
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
    ...mapState("spellArea", ["spellAreas", "spellArea"]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        spell: this.currentRow != undefined ? this.currentRow.spell : undefined,
        area: this.currentRow != undefined ? this.currentRow.area : undefined,
        quest_start:
          this.currentRow != undefined
            ? this.currentRow.quest_start
            : undefined,
        aura_spell:
          this.currentRow != undefined ? this.currentRow.aura_spell : undefined,
        racemask:
          this.currentRow != undefined ? this.currentRow.racemask : undefined,
        gender:
          this.currentRow != undefined ? this.currentRow.gender : undefined,
      };
    },
  },
  methods: {
    ...mapActions("spellArea", [
      "searchSpellAreas",
      "storeSpellArea",
      "findSpellArea",
      "updateSpellArea",
      "destroySpellArea",
      "createSpellArea",
      "copySpellArea",
    ]),
    calculateMaxHeight() {
      return this.creating ? this.clientHeight - 307 : this.clientHeight - 349;
    },
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createSpellArea({
        spell: this.spell.ID,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeSpellArea(this.spellArea);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
      } else {
        await this.updateSpellArea({
          credential: this.credential,
          spellArea: this.spellArea,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      await this.searchSpellAreas({
        spell: this.spell.ID,
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
            this.copySpellArea(this.credential)
              .then(() => {
                this.searchSpellAreas({
                  spell: this.spell.ID,
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
              this.destroySpellArea(this.credential)
                .then(() => {
                  this.searchSpellAreas({
                    spell: this.spell.ID,
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
      await this.findSpellArea({
        spell: row.spell,
        area: row.area,
        quest_start: row.quest_start,
        aura_spell: row.aura_spell,
        racemask: row.racemask,
        gender: row.gender,
      });
    },
    async init() {
      this.initing = true;
      await this.searchSpellAreas({
        spell: this.spell.ID,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
