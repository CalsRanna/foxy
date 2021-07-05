<template>
  <div>
    <div v-show="!creating">
      <el-card style="margin-top: 16px">
        <el-button type="primary" @click="create">新增</el-button>
        <el-button @click="copy" :disabled="disabled">复制</el-button>
        <el-button type="danger" @click="destroy" :disabled="disabled"
          >删除</el-button
        >
      </el-card>
      <el-card style="margin-top: 16px">
        <el-table
          :data="gossipMenuOptions"
          highlight-current-row
          @current-change="select"
          @row-dblclick="show"
        >
          <el-table-column prop="OptionID" label="编号"></el-table-column>
          <el-table-column prop="OptionIcon" label="图标">
            <span slot-scope="scope">{{ icons[scope.row.OptionIcon] }}</span>
          </el-table-column>
          <el-table-column label="文本" min-width="400">
            <span slot-scope="scope">
              <template v-if="scope.row.localeOptionText !== null">
                {{ scope.row.localeOptionText }}
              </template>
              <template v-else>{{ scope.row.OptionText }}</template>
            </span>
          </el-table-column>
          <el-table-column prop="OptionType" label="类型">
            <span slot-scope="scope">{{ types[scope.row.OptionType] }}</span>
          </el-table-column>
          <el-table-column
            prop="OptionNpcFlag"
            label="Npc标识"
          ></el-table-column>
          <el-table-column
            prop="OptionBroadcastTextID"
            label="广播文本ID"
          ></el-table-column>
          <el-table-column
            prop="ActionMenuID"
            label="子选项编号"
          ></el-table-column>
        </el-table>
      </el-card>
    </div>
    <div v-show="creating">
      <el-form
        :model="gossipMenuOption"
        label-position="right"
        label-width="120px"
      >
        <el-card style="margin-top: 16px">
          <el-row :gutter="16">
            <el-col :span="6">
              <el-form-item label="对话ID">
                <el-input-number
                  v-model="gossipMenuOption.MenuID"
                  controls-position="right"
                  v-loading="loading"
                  placeholder="MenuID"
                  element-loading-spinner="el-icon-loading"
                  element-loading-background="rgba(255, 255, 255, 0.5)"
                ></el-input-number>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="编号">
                <el-input
                  v-model="gossipMenuOption.OptionID"
                  placeholder="OptionID"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="图标">
                <el-select
                  v-model="gossipMenuOption.OptionIcon"
                  placeholder="rank"
                >
                  <el-option
                    v-for="(icon, index) in icons"
                    :key="`icon-${index}`"
                    :label="icon"
                    :value="index"
                  ></el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="文本">
                <el-input
                  v-model="gossipMenuOption.OptionText"
                  placeholder="OptionText"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="类型">
                <el-select
                  v-model="gossipMenuOption.OptionType"
                  placeholder="rank"
                >
                  <el-option
                    v-for="(type, index) in types"
                    :key="`type-${index}`"
                    :label="type"
                    :value="index"
                  ></el-option>
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="NPC标识">
                <flag-editor
                  v-model="gossipMenuOption.OptionNpcFlag"
                  :flags="npcFlags"
                  title="Npc标识编辑器"
                  placeholder="OptionNpcFlag"
                ></flag-editor>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="子选项编号">
                <el-input
                  v-model="gossipMenuOption.ActionMenuID"
                  placeholder="ActionMenuID"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="广播文本编号">
                <el-input
                  v-model="gossipMenuOption.OptionBroadcastTextID"
                  placeholder="OptionBroadcastTextID"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="ActionPoiID">
                <el-input
                  v-model="gossipMenuOption.ActionPoiID"
                  placeholder="ActionPoiID"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="BoxCoded">
                <el-input
                  v-model="gossipMenuOption.BoxCoded"
                  placeholder="BoxCoded"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="BoxMoney">
                <el-input
                  v-model="gossipMenuOption.BoxMoney"
                  placeholder="BoxMoney"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="BoxText">
                <el-input
                  v-model="gossipMenuOption.BoxText"
                  placeholder="BoxText"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="BoxBroadcastTextID">
                <el-input
                  v-model="gossipMenuOption.BoxBroadcastTextID"
                  placeholder="BoxBroadcastTextID"
                ></el-input>
              </el-form-item>
            </el-col>
            <el-col :span="6">
              <el-form-item label="VerifiedBuild">
                <el-input-number
                  v-model="gossipMenuOption.VerifiedBuild"
                  controls-position="right"
                  placeholder="VerifiedBuild"
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
import { icons, types } from "@/locales/gossipMenuOption";
import { npcFlags } from "@/locales/creature";
import FlagEditor from "@/components/FlagEditor";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      creating: false,
      editing: false,
      currentRow: undefined,
      loading: false,
      icons: icons,
      types: types,
      npcFlags: npcFlags,
    };
  },
  computed: {
    ...mapState("gossipMenu", ["gossipMenu"]),
    ...mapState("gossipMenuOption", ["gossipMenuOptions", "gossipMenuOption"]),
    disabled() {
      return this.currentRow == undefined;
    },
    credential() {
      return {
        MenuID:
          this.currentRow != undefined ? this.currentRow.MenuID : undefined,
        OptionID:
          this.currentRow != undefined ? this.currentRow.OptionID : undefined,
      };
    },
  },
  methods: {
    ...mapActions("gossipMenuOption", [
      "searchGossipMenuOptions",
      "storeGossipMenuOption",
      "findGossipMenuOption",
      "updateGossipMenuOption",
      "destroyGossipMenuOption",
      "createGossipMenuOption",
      "copyGossipMenuOption",
    ]),
    async create() {
      await this.createGossipMenuOption({ MenuID: this.gossipMenu.MenuID });
      this.creating = true;
    },
    async store() {
      if (!this.editing) {
        await this.storeGossipMenuOption(this.gossipMenuOption);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
      } else {
        await this.updateGossipMenuOption({
          credential: this.credential,
          gossipMenuOption: this.gossipMenuOption,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      await this.searchGossipMenuOptions({ MenuID: this.gossipMenu.MenuID });
      this.creating = false;
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
            this.copyGossipMenuOption({
              MenuID: this.currentRow.MenuID,
              OptionID: this.currentRow.OptionID,
            })
              .then(() => {
                this.searchGossipMenuOptions({
                  MenuID: this.gossipMenu.MenuID,
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
              this.destroyGossipMenuOption({
                MenuID: this.currentRow.MenuID,
                OptionID: this.currentRow.OptionID,
              })
                .then(() => {
                  this.searchGossipMenuOptions({
                    MenuID: this.gossipMenu.MenuID,
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
      await this.findGossipMenuOption({
        MenuID: row.MenuID,
        OptionID: row.OptionID,
      });
      this.creating = true;
      this.editing = true;
    },
    async init() {
      this.loading = true;
      await this.searchGossipMenuOptions({ MenuID: this.gossipMenu.MenuID });
      this.loading = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    FlagEditor,
  },
};
</script>
