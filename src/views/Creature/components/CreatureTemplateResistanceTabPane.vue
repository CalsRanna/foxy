<template>
  <div>
    <div v-show="!creating">
      <el-card style="margin-top: 16px">
        <el-button type="primary" @click="create">新增</el-button>
        <el-button @click="copy" :disabled="disabled">复制</el-button>
        <el-button type="danger" @click="destroy" :disabled="disabled">
          删除
        </el-button>
      </el-card>
      <el-card style="margin-top: 16px">
        <el-table
          :data="creatureTemplateResistances"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="School" label="类型">
            <template slot-scope="scope">
              {{ localeResistanceSchools[scope.row.School] }}
            </template>
          </el-table-column>
          <el-table-column prop="Resistance" label="抗性"></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="creatureTemplateResistance"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="16">
            <el-col :span="6">
              <el-form-item label="生物ID">
                <el-input-number
                  v-model="creatureTemplateResistance.CreatureID"
                  controls-position="right"
                  v-loading="initing"
                  placeholder="CreatureID"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="类型">
                <el-select
                  v-model="creatureTemplateResistance.School"
                  placeholder="School"
                >
                  <el-option
                    v-for="index in [1, 5, 2, 4, 3, 6]"
                    :key="`School-${index}`"
                    :label="localeResistanceSchools[index]"
                    :value="index"
                  ></el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="抗性">
                <el-input-number
                  v-model="creatureTemplateResistance.Resistance"
                  controls-position="right"
                  placeholder="School"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="VerifiedBuild">
                <el-input-number
                  v-model="creatureTemplateResistance.VerifiedBuild"
                  controls-position="right"
                  placeholder="VerifiedBuild"
                ></el-input-number>
              </el-form-item>
            </el-col>
          </el-row>
        </el-card>
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

import { localeResistanceSchools } from "@/locales/creature";

export default {
  data() {
    return {
      initing: false,
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false,
      localeResistanceSchools: localeResistanceSchools,
    };
  },
  computed: {
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureTemplateResistance", [
      "creatureTemplateResistances",
      "creatureTemplateResistance",
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        CreatureID:
          this.currentRow != undefined ? this.currentRow.CreatureID : undefined,
        School:
          this.currentRow != undefined ? this.currentRow.School : undefined,
      };
    },
  },
  methods: {
    ...mapActions("creatureTemplateResistance", [
      "searchCreatureTemplateResistances",
      "storeCreatureTemplateResistance",
      "findCreatureTemplateResistance",
      "updateCreatureTemplateResistance",
      "destroyCreatureTemplateResistance",
      "createCreatureTemplateResistance",
      "copyCreatureTemplateResistance",
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createCreatureTemplateResistance({
        CreatureID: this.creatureTemplate.entry,
      });
    },
    async store() {
      this.loading = true;
      try {
        if (!this.editing) {
          await this.storeCreatureTemplateResistance(
            this.creatureTemplateResistance
          );
          this.$notify({
            title: "保存成功",
            position: "bottom-left",
            type: "success",
          });
          await this.searchCreatureTemplateResistances({
            CreatureID: this.creatureTemplate.entry,
          });
          this.creating = false;
          this.editing = false;
        } else {
          await this.updateCreatureTemplateResistance({
            credential: this.credential,
            creatureTemplateResistance: this.creatureTemplateResistance,
          });
          this.$notify({
            title: "修改成功",
            position: "bottom-left",
            type: "success",
          });
          await this.searchCreatureTemplateResistances({
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
              await this.copyCreatureTemplateResistance(this.credential);
              await this.searchCreatureTemplateResistances({
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
                await this.destroyCreatureTemplateResistance(this.credential);
                await this.searchCreatureTemplateResistances({
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
      await this.findCreatureTemplateResistance({
        CreatureID: row.CreatureID,
        School: row.School,
      });
    },
    async init() {
      this.initing = true;
      await this.searchCreatureTemplateResistances({
        CreatureID: this.creatureTemplate.entry,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
