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
          :data="creatureEquipTemplates"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="ID" label="编号"></el-table-column>
          <el-table-column label="物品1">
            <template slot-scope="scope">
              <template v-if="scope.row.Name1">{{ scope.row.Name1 }}</template>
              <template v-else>{{ scope.row.name1 }}</template>
            </template>
          </el-table-column>
          <el-table-column label="物品2">
            <template slot-scope="scope">
              <template v-if="scope.row.Name2">{{ scope.row.Name2 }}</template>
              <template v-else>{{ scope.row.name2 }}</template>
            </template>
          </el-table-column>
          <el-table-column label="物品3">
            <template slot-scope="scope">
              <template v-if="scope.row.Name3">{{ scope.row.Name3 }}</template>
              <template v-else>{{ scope.row.name3 }}</template>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="creatureEquipTemplate"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="24">
            <el-col :span="6">
              <el-form-item label="生物ID">
                <el-input-number
                  v-model="creatureEquipTemplate.CreatureID"
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
                  v-model="creatureEquipTemplate.ID"
                  controls-position="right"
                  v-loading="initing"
                  placeholder="ID"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="VerifiedBuild">
                <el-input
                  v-model="creatureEquipTemplate.VerifiedBuild"
                  placeholder="VerifiedBuild"
                ></el-input>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="24">
            <el-col :span="6">
              <el-form-item label="物品1">
                <el-input-number
                  v-model="creatureEquipTemplate.ItemID1"
                  controls-position="right"
                  placeholder="ItemID1"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="物品2">
                <el-input-number
                  v-model="creatureEquipTemplate.ItemID2"
                  controls-position="right"
                  placeholder="ItemID2"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="物品3">
                <el-input-number
                  v-model="creatureEquipTemplate.ItemID3"
                  controls-position="right"
                  placeholder="ItemID3"
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

export default {
  data() {
    return {
      initing: false,
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false
    };
  },
  computed: {
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureEquipTemplate", [
      "creatureEquipTemplates",
      "creatureEquipTemplate"
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        CreatureID:
          this.currentRow != undefined ? this.currentRow.CreatureID : undefined,
        ID: this.currentRow != undefined ? this.currentRow.ID : undefined
      };
    }
  },
  methods: {
    ...mapActions("creatureEquipTemplate", [
      "searchCreatureEquipTemplates",
      "storeCreatureEquipTemplate",
      "findCreatureEquipTemplate",
      "updateCreatureEquipTemplate",
      "destroyCreatureEquipTemplate",
      "createCreatureEquipTemplate",
      "copyCreatureEquipTemplate"
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createCreatureEquipTemplate({
        CreatureID: this.creatureTemplate.entry
      });
    },
    async store() {
      if (!this.editing) {
        await this.storeCreatureEquipTemplate(this.creatureEquipTemplate);
      } else {
        await this.updateCreatureEquipTemplate({
          credential: this.credential,
          creatureEquipTemplate: this.creatureEquipTemplate
        });
      }
      await this.searchCreatureEquipTemplates({
        CreatureID: this.creatureTemplate.entry
      });
      this.creating = false;
      this.editing = false;
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
            this.copyCreatureEquipTemplate(this.credential)
              .then(() => {
                this.searchCreatureEquipTemplates({
                  CreatureID: this.creatureTemplate.entry
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
              this.destroyCreatureEquipTemplate(this.credential)
                .then(() => {
                  this.searchCreatureEquipTemplates({
                    CreatureID: this.creatureTemplate.entry
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
      this.creating = true;
      this.editing = true;
      await this.findCreatureEquipTemplate({
        CreatureID: row.CreatureID,
        ID: row.ID
      });
    },
    async init() {
      this.initing = true;
      await this.searchCreatureEquipTemplates({
        CreatureID: this.creatureTemplate.entry
      });
      this.initing = false;
    }
  },
  mounted() {
    this.init();
  }
};
</script>
