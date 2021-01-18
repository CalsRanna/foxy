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
          <el-table-column sortable>
            <hint-label
              label="技能ID"
              :tooltip="spellIdTooltip"
              slot="header"
            ></hint-label>
            <span slot-scope="scope">{{ scope.row.SpellID }}</span>
          </el-table-column>
          <el-table-column
            prop="MoneyCost"
            label="价格"
            sortable
          ></el-table-column>
          <el-table-column
            prop="ReqSkillLine"
            label="需要技能"
            sortable
          ></el-table-column>
          <el-table-column
            prop="ReqSkillRank"
            label="需要熟练度"
            sortable
          ></el-table-column>
          <el-table-column
            prop="ReqLevel"
            label="需要等级"
            sortable
          ></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form :model="npcTrainer" label-position="right" label-width="120px">
        <el-card style="margin-top: 16px">
          <el-row :gutter="24">
            <el-col :span="6">
              <el-form-item label="编号">
                <el-input-number
                  v-model="npcTrainer.ID"
                  controls-position="right"
                  v-loading="loading"
                  disabled
                  placeholder="ID"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
          </el-row>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-button type="primary" @click="store">保存</el-button>
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

export default {
  data() {
    return {
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false,
      spellIdTooltip: spellIdTooltip
    };
  },
  computed: {
    ...mapState("creature", ["creatureTemplate", "npcTrainers", "npcTrainer"]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        ID: this.currentRow != undefined ? this.currentRow.ID : undefined
      };
    }
  },
  methods: {
    ...mapActions("creature", [
      "searchNpcTrainers",
      "storeNpcTrainer",
      "findNpcTrainer",
      "updateNpcTrainer",
      "destroyNpcTrainer",
      "createNpcTrainer",
      "copyNpcTrainer"
    ]),
    async create() {
      await this.createNpcTrainer({
        ID: this.creatureTemplate.ID
      });
      this.creating = true;
    },
    async store() {
      if (!this.editing) {
        await this.storeNpcTrainer(this.npcTrainer);
      } else {
        await this.updateNpcTrainer({
          credential: this.credential,
          npcTrainer: this.npcTrainer
        });
      }
      await this.searchNpcTrainers({
        ID: this.creatureTemplate.ID
      });
      this.creating = false;
    },
    cancel() {
      this.creating = false;
    },
    copy() {
      this.$confirm("此操作不会复制关联表数据，确认继续？</small>", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "info",
        dangerouslyUseHTMLString: true,
        beforeClose: (action, instance, done) => {
          if (action === "confirm") {
            instance.confirmButtonLoading = true;
            this.copyNpcTrainer({
              ID: this.currentRow.ID
            })
              .then(() => {
                this.searchNpcTrainers({
                  ID: this.creatureTemplate.ID
                });
              })
              .then(() => {
                instance.confirmButtonLoading = false;
                done();
              });
          } else {
            done();
          }
        }
      });
    },
    destroy() {
      this.$confirm(
        "此操作将永久删除该数据，确认继续？<br><small>为避免误操作，不提供删除关联表数据功能。</small>",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "error",
          dangerouslyUseHTMLString: true,
          beforeClose: (action, instance, done) => {
            if (action === "confirm") {
              instance.confirmButtonLoading = true;
              this.destroyNpcTrainer({
                ID: this.currentRow.ID
              })
                .then(() => {
                  this.searchNpcTrainers({
                    ID: this.creatureTemplate.ID
                  });
                })
                .then(() => {
                  instance.confirmButtonLoading = false;
                  done();
                });
            } else {
              done();
            }
          }
        }
      );
    },
    select(row) {
      this.currentRow = row;
    },
    async show(row) {
      await this.findNpcTrainer({
        ID: row.ID
      });
      this.creating = true;
      this.editing = true;
    },
    async init() {
      this.loading = true;
      let id = this.$route.params.id;
      await this.searchNpcTrainers({ ID: id });
      this.loading = false;
    }
  },
  mounted() {
    this.init();
  },
  components: {
    HintLabel
  }
};
</script>
