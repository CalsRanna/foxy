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
          :data="creatureTemplateSpells"
          highlight-current-row
          :max-height="calculateMaxHeight()"
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column
            prop="Index"
            label="编号"
            width="80px"
          ></el-table-column>
          <el-table-column prop="Spell" label="技能"></el-table-column>
          <el-table-column prop="Name_Lang_zhCN" label="名称"></el-table-column>
          <el-table-column
            prop="NameSubtext_Lane_zhCN"
            label="子名称"
          ></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="creatureTemplateSpell"
        label-position="right"
        label-width="120px"
      >
        <div
          :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }"
        >
          <el-card style="margin-top: 1px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="生物ID">
                  <el-input-number
                    v-model="creatureTemplateSpell.CreatureID"
                    controls-position="right"
                    v-loading="initing"
                    placeholder="CreatureID"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="编号">
                  <el-input-number
                    v-model="creatureTemplateSpell.Index"
                    controls-position="right"
                    placeholder="Index"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能">
                  <spell-selector
                    v-model="creatureTemplateSpell.Spell"
                    placeholder="Spell"
                  ></spell-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="VerifiedBuild">
                  <el-input-number
                    v-model="creatureTemplateSpell.VerifiedBuild"
                    controls-position="right"
                    placeholder="VerifiedBuild"
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
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureTemplateSpell", [
      "creatureTemplateSpells",
      "creatureTemplateSpell",
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        CreatureID:
          this.currentRow != undefined ? this.currentRow.CreatureID : undefined,
        Index: this.currentRow != undefined ? this.currentRow.Index : undefined,
      };
    },
  },
  methods: {
    ...mapActions("creatureTemplateSpell", [
      "searchCreatureTemplateSpells",
      "storeCreatureTemplateSpell",
      "findCreatureTemplateSpell",
      "updateCreatureTemplateSpell",
      "destroyCreatureTemplateSpell",
      "createCreatureTemplateSpell",
      "copyCreatureTemplateSpell",
    ]),
    calculateMaxHeight() {
      return this.creating ? this.clientHeight - 307 : this.clientHeight - 349;
    },
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createCreatureTemplateSpell({
        CreatureID: this.creatureTemplate.entry,
      });
    },
    async store() {
      this.loading = true;
      try {
        if (!this.editing) {
          await this.storeCreatureTemplateSpell(this.creatureTemplateSpell);
          this.$notify({
            title: "保存成功",
            position: "bottom-left",
            type: "success",
          });
          await this.searchCreatureTemplateSpells({
            CreatureID: this.creatureTemplate.entry,
          });
          this.creating = false;
          this.editing = false;
        } else {
          await this.updateCreatureTemplateSpell({
            credential: this.credential,
            creatureTemplateSpell: this.creatureTemplateSpell,
          });
          this.$notify({
            title: "修改成功",
            position: "bottom-left",
            type: "success",
          });
          await this.searchCreatureTemplateSpells({
            CreatureID: this.creatureTemplate.entry,
          });
          this.creating = false;
          this.editing = false;
        }
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
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
        beforeClose: async (action, instance, done) => {
          if (action === "confirm") {
            instance.confirmButtonLoading = true;
            try {
              await this.copyCreatureTemplateSpell(this.credential);
              await this.searchCreatureTemplateSpells({
                CreatureID: this.creatureTemplate.entry,
              });
              this.$notify({
                title: "复制成功",
                position: "bottom-left",
                type: "success",
              });
              instance.confirmButtonLoading = false;
              done();
            } catch (error) {
              instance.confirmButtonLoading = false;
              done();
            }
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
          beforeClose: async (action, instance, done) => {
            if (action === "confirm") {
              try {
                await this.destroyCreatureTemplateSpell(this.credential);
                await this.searchCreatureTemplateSpells({
                  CreatureID: this.creatureTemplate.entry,
                });
                this.$notify({
                  title: "删除成功",
                  position: "bottom-left",
                  type: "success",
                });
                instance.confirmButtonLoading = false;
                done();
              } catch (error) {
                instance.confirmButtonLoading = false;
                done();
              }
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
      await this.findCreatureTemplateSpell({
        CreatureID: row.CreatureID,
        Index: row.Index,
      });
    },
    async init() {
      this.initing = true;
      await this.searchCreatureTemplateSpells({
        CreatureID: this.creatureTemplate.entry,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    SpellSelector,
  },
};
</script>
