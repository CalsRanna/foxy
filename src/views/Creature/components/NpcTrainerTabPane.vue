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
          :data="npcTrainers"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column>
            <hint-label
              label="技能ID"
              :tooltip="spellIdTooltip"
              slot="header"
            ></hint-label>
            <span slot-scope="scope">{{ scope.row.SpellID }}</span>
          </el-table-column>
          <el-table-column prop="MoneyCost" label="价格"></el-table-column>
          <el-table-column
            prop="ReqSkillLine"
            label="需要技能"
          ></el-table-column>
          <el-table-column
            prop="ReqSkillRank"
            label="需要熟练度"
          ></el-table-column>
          <el-table-column prop="ReqLevel" label="需要等级"></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form :model="npcTrainer" label-position="right" label-width="120px">
        <el-card style="margin-top: 16px">
          <el-row :gutter="16">
            <el-col :span="6">
              <el-form-item label="编号">
                <el-input-number
                  v-model="npcTrainer.ID"
                  controls-position="right"
                  v-loading="initing"
                  placeholder="ID"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="技能">
                <spell-selector
                  v-model="npcTrainer.SpellID"
                  controls-position="right"
                  placeholder="SpellID"
                ></spell-selector>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="16">
            <el-col :span="6">
              <el-form-item label="价格">
                <el-input-number
                  v-model="npcTrainer.MoneyCost"
                  controls-position="right"
                  placeholder="MoneyCost"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="需要技能">
                <el-input-number
                  v-model="npcTrainer.ReqSkillLine"
                  controls-position="right"
                  placeholder="ReqSkillLine"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="需要熟练度">
                <el-input-number
                  v-model="npcTrainer.ReqSkillRank"
                  controls-position="right"
                  placeholder="ReqSkillRank"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="需要等级">
                <el-input-number
                  v-model="npcTrainer.ReqLevel"
                  controls-position="right"
                  placeholder="ReqLevel"
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
import { spellIdTooltip } from "@/locales/creature";

import HintLabel from "@/components/HintLabel.vue";

import { mapState, mapActions } from "vuex";
import SpellSelector from "../../../components/SpellSelector.vue";

export default {
  data() {
    return {
      initing: false,
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false,
      spellIdTooltip: spellIdTooltip,
    };
  },
  computed: {
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("npcTrainer", ["npcTrainers", "npcTrainer"]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        ID: this.currentRow != undefined ? this.currentRow.ID : undefined,
        SpellID:
          this.currentRow != undefined ? this.currentRow.SpellID : undefined,
      };
    },
  },
  methods: {
    ...mapActions("npcTrainer", [
      "searchNpcTrainers",
      "storeNpcTrainer",
      "findNpcTrainer",
      "updateNpcTrainer",
      "destroyNpcTrainer",
      "createNpcTrainer",
      "copyNpcTrainer",
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createNpcTrainer({
        ID: this.creatureTemplate.entry,
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeNpcTrainer(this.npcTrainer);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
      } else {
        await this.updateNpcTrainer({
          credential: this.credential,
          npcTrainer: this.npcTrainer,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      await this.searchNpcTrainers({
        ID: this.creatureTemplate.entry,
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
            this.copyNpcTrainer(this.credential)
              .then(() => {
                this.searchNpcTrainers({
                  ID: this.creatureTemplate.entry,
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
              this.destroyNpcTrainer(this.credential)
                .then(() => {
                  this.searchNpcTrainers({
                    ID: this.creatureTemplate.entry,
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
      await this.findNpcTrainer({
        ID: row.ID,
        SpellID: row.SpellID,
      });
    },
    async init() {
      this.initing = true;
      await this.searchNpcTrainers({ ID: this.creatureTemplate.entry });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    HintLabel,
    SpellSelector,
  },
};
</script>
