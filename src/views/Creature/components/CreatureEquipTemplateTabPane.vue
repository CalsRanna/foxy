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
            <item-template-name
              slot-scope="scope"
              :itemTemplate="{
                name: scope.row.name_1,
                localeName: scope.row.localeName_1,
                Quality: scope.row.Quality_1,
                InventoryIcon_1: scope.row.Icon_1,
              }"
            ></item-template-name>
          </el-table-column>
          <el-table-column label="物品2">
            <item-template-name
              slot-scope="scope"
              :itemTemplate="{
                name: scope.row.name_2,
                localeName: scope.row.localeName_2,
                Quality: scope.row.Quality_2,
                InventoryIcon_1: scope.row.Icon_2,
              }"
            ></item-template-name>
          </el-table-column>
          <el-table-column label="物品3">
            <item-template-name
              slot-scope="scope"
              :itemTemplate="{
                name: scope.row.name_3,
                localeName: scope.row.localeName_3,
                Quality: scope.row.Quality_3,
                InventoryIcon_1: scope.row.Icon_3,
              }"
            ></item-template-name>
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
          <el-row :gutter="16">
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
                <el-input-number
                  v-model="creatureEquipTemplate.VerifiedBuild"
                  controls-position="right"
                  placeholder="VerifiedBuild"
                ></el-input-number>
              </el-form-item>
            </el-col>
          </el-row>
          <el-row :gutter="16">
            <el-col :span="6">
              <el-form-item label="物品1">
                <item-template-selector
                  v-model="creatureEquipTemplate.ItemID1"
                  controls-position="right"
                  placeholder="ItemID1"
                ></item-template-selector>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="物品2">
                <item-template-selector
                  v-model="creatureEquipTemplate.ItemID2"
                  controls-position="right"
                  placeholder="ItemID2"
                ></item-template-selector>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="物品3">
                <item-template-selector
                  v-model="creatureEquipTemplate.ItemID3"
                  controls-position="right"
                  placeholder="ItemID3"
                ></item-template-selector>
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
import ItemTemplateName from "@/components/ItemTemplateName";
import ItemTemplateSelector from "../../../components/ItemTemplateSelector.vue";

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
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureEquipTemplate", [
      "creatureEquipTemplates",
      "creatureEquipTemplate",
    ]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        CreatureID:
          this.currentRow != undefined ? this.currentRow.CreatureID : undefined,
        ID: this.currentRow != undefined ? this.currentRow.ID : undefined,
      };
    },
  },
  methods: {
    ...mapActions("creatureEquipTemplate", [
      "searchCreatureEquipTemplates",
      "storeCreatureEquipTemplate",
      "findCreatureEquipTemplate",
      "updateCreatureEquipTemplate",
      "destroyCreatureEquipTemplate",
      "createCreatureEquipTemplate",
      "copyCreatureEquipTemplate",
    ]),
    async create() {
      this.creating = true;
      this.editing = false;
      await this.createCreatureEquipTemplate({
        CreatureID: this.creatureTemplate.entry,
      });
    },
    async store() {
      this.loading = true;
      try {
        if (!this.editing) {
          await this.storeCreatureEquipTemplate(this.creatureEquipTemplate);
          this.$notify({
            title: "保存成功",
            position: "bottom-left",
            type: "success",
          });
          await this.searchCreatureEquipTemplates({
            CreatureID: this.creatureTemplate.entry,
          });
          this.creating = false;
          this.editing = false;
        } else {
          await this.updateCreatureEquipTemplate({
            credential: this.credential,
            creatureEquipTemplate: this.creatureEquipTemplate,
          });
          this.$notify({
            title: "修改成功",
            position: "bottom-left",
            type: "success",
          });
          await this.searchCreatureEquipTemplates({
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
              await this.copyCreatureEquipTemplate(this.credential);
              await this.searchCreatureEquipTemplates({
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
                await this.destroyCreatureEquipTemplate(this.credential);
                await this.searchCreatureEquipTemplates({
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
      await this.findCreatureEquipTemplate({
        CreatureID: row.CreatureID,
        ID: row.ID,
      });
    },
    async init() {
      this.initing = true;
      await this.searchCreatureEquipTemplates({
        CreatureID: this.creatureTemplate.entry,
      });
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { ItemTemplateName, ItemTemplateSelector },
};
</script>
