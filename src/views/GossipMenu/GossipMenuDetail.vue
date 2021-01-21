<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/gossip-menu' }">
          对话管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>对话详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeSubname }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="gossip_menu" style="margin-top: 16px">
      <el-tab-pane label="对话" name="gossip_menu" lazy>
        <gossip-menu-tab-pane></gossip-menu-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="文本" name="npc_text" lazy>
        <npc-text-tab-pane></npc-text-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="选项" name="gossip_menu_option" lazy>
        <gossip-menu-option-tab-pane></gossip-menu-option-tab-pane>
      </el-tab-pane>
    </el-tabs>
    <el-dialog
      :visible.sync="localeDialogVisible"
      :show-close="false"
      :close-on-click-modal="false"
    >
      <div slot="title">
        <span style="font-size: 18px; color: #303133; margin-right: 16px"
          >文本本地化</span
        >
        <el-button size="mini" @click="addNpcTextLocale">新增</el-button>
      </div>
      <el-table :data="npcTextLocales">
        <el-table-column width="48">
          <el-button
            type="danger"
            size="mini"
            icon="el-icon-delete"
            circle=""
            slot-scope="scope"
            @click="() => deleteNpcTextLocale(scope.$index)"
          ></el-button>
        </el-table-column>
        <el-table-column prop="ID" label="编号">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.ID"
              controls-position="right"
              disabled
            ></el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="Locale" label="语言">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Locale"
              placeholder="Locale"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text0_0" label="文本0_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text0_0"
              placeholder="Text0_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text0_1" label="文本0_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text0_1"
              placeholder="Text0_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text1_0" label="文本1_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text1_0"
              placeholder="Text1_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text1_1" label="文本1_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text1_1"
              placeholder="Text1_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text2_0" label="文本2_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text2_0"
              placeholder="Text2_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text2_1" label="文本2_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text2_1"
              placeholder="Text2_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text3_0" label="文本3_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text3_0"
              placeholder="Text3_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text3_1" label="文本3_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text3_1"
              placeholder="Text3_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text4_0" label="文本4_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text4_0"
              placeholder="Text4_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text4_1" label="文本4_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text4_1"
              placeholder="Text4_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text5_0" label="文本5_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text5_0"
              placeholder="Text5_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text5_1" label="文本5_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text5_1"
              placeholder="Text5_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text6_0" label="文本6_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text6_0"
              placeholder="Text6_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text6_1" label="文本6_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text6_1"
              placeholder="Text6_1"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text7_0" label="文本7_0">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text7_0"
              placeholder="Text7_0"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text7_1" label="文本7_1">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.Text7_1"
              placeholder="Text7_1"
            ></el-input>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer">
        <el-button @click="closeDialog">取消</el-button>
        <el-button type="primary" @click="() => store('npc_text_locales')"
          >保存</el-button
        >
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { icons, types } from "@/locales/gossipMenuOption";
import GossipMenuOptionTabPane from "@/views/GossipMenu/components/GossipMenuOptionTabPane";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      loading: false,
      min: 0,
      isCreating: true,
      credential: {},
      isCreatingNpcText: false,
      localeDialogVisible: false,
      icons: icons,
      types: types,
    };
  },
  computed: {
    ...mapState("gossipMenu", [
      "gossipMenu",
      "npcText",
      "npcTextLocales",
      "gossipMenuOptions",
    ]),
    localeName() {
      return null;
    },
    localeSubname() {
      return null;
    },
    disabled() {
      return !this.isCreating;
    },
  },
  methods: {
    ...mapActions("gossipMenu", [
      "storeGossipMenu",
      "findGossipMenu",
      "updateGossipMenu",
      "createGossipMenu",
      "storeNpcText",
      "findNpcText",
      "updateNpcText",
      "searchNpcTextLocales",
      "storeNpcTextLocales",
      "searchGossipMenuOptions",
    ]),
    async switchover(tab) {
      this.loading = true;
      switch (tab.name) {
        case "npc_text":
          await Promise.all([
            this.findNpcText({ ID: this.gossipMenu.TextID }),
            this.searchNpcTextLocales({ ID: this.gossipMenu.TextID }),
          ]);
          if (this.npcText == undefined) {
            this.isCreatingNpcText = true;
          }
          break;
        case "gossip_menu_option":
          // await this.searchGossipMenuOptions({ MenuID: this.gossipMenu.MenuID });
          break;
        default:
          break;
      }
      this.loading = false;
    },
    showDialog() {
      this.localeDialogVisible = true;
    },
    addNpcTextLocale() {
      this.npcTextLocales.push({
        ID: this.npcText.ID,
      });
    },
    deleteNpcTextLocale(index) {
      this.npcTextLocales.splice(index, 1);
    },
    closeDialog() {
      this.localeDialogVisible = false;
    },
    store(module) {
      switch (module) {
        case "gossip_menu":
          this.loading = true;
          if (this.isCreating) {
            this.storeGossipMenu(this.gossipMenu);
          } else {
            this.updateGossipMenu({
              credential: this.credential,
              gossipMenu: this.gossipMenu,
            });
          }
          this.loading = false;
          break;
        case "npc_text":
          this.loading = true;
          if (this.isCreatingNpcText) {
            this.storeNpcText(this.npcText);
          } else {
            this.updateNpcText({
              credential: { ID: this.npcText.ID },
              npcText: this.npcText,
            });
          }
          this.loading = false;
          break;
        case "npc_text_locales":
          this.storeNpcTextLocales(this.npcTextLocales).then(() => {
            this.localeDialogVisible = false;
          });
          break;
        default:
          break;
      }
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.loading = true;
      let path = this.$route.path;
      if (path === "/gossip-menu/create") {
        await this.createGossipMenu();
      } else {
        this.isCreating = false;
        this.credential = this.$route.query;
        this.credential.MenuID = this.$route.params.id;
        await Promise.all([this.findGossipMenu(this.credential)]);
      }
      this.loading = false;
    },
  },
  created() {
    this.init();
  },
  components: {
    "gossip-menu-option-tab-pane": GossipMenuOptionTabPane,
  },
};
</script>
