<template>
  <el-form :model="gossipMenu" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="对话ID">
              <el-input-number
                v-model="gossipMenu.MenuID"
                controls-position="right"
                placeholder="MenuID"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="文本ID">
              <el-input
                v-model="gossipMenu.TextID"
                placeholder="TextID"
              ></el-input>
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
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("gossipMenu", ["gossipMenu"]),
    ...mapState("npcText", ["npcText"]),
    ...mapState("npcTextLocale", ["npcTextLocales"]),
    credential() {
      return {
        MenuID: this.$route.params.id,
        TextID: this.$route.query.TextID,
      };
    },
  },
  methods: {
    ...mapActions("gossipMenu", [
      "storeGossipMenu",
      "findGossipMenu",
      "updateGossipMenu",
      "createGossipMenu",
    ]),
    ...mapActions("npcText", ["findNpcText"]),
    ...mapActions("npcTextLocale", ["searchNpcTextLocales"]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeGossipMenu(this.gossipMenu);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateGossipMenu({
          credential: this.credential,
          gossipMenu: this.gossipMenu,
        });
        this.$notify({
          title: "修改成功",
          position: "top-right",
          type: "success",
        });
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      if (this.$route.path == "/gossip-menu/create") {
        this.creating = true;
        await this.createGossipMenu();
      } else {
        await this.findGossipMenu(this.credential);
        await Promise.all([
          this.findNpcText({ ID: this.gossipMenu.TextID }),
          this.searchNpcTextLocales({ ID: this.gossipMenu.TextID }),
        ]);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
