<template>
  <el-form :model="npcText" label-position="right" label-width="120px">
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="ID">
            <el-input-number
              v-model="npcText.ID"
              controls-position="right"
              placeholder="ID"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="VerifiedBuild">
            <el-input
              v-model="npcText.VerifiedBuild"
              placeholder="VerifiedBuild"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="lang0">
            <el-input v-model="npcText.lang0" placeholder="lang0"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Probability0">
            <el-input
              v-model="npcText.Probability0"
              placeholder="Probability0"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="text0_0">
            <npc-text-localizer
              v-model="npcText.text0_0"
              placeholder="text0_0"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="text0_1">
            <npc-text-localizer
              v-model="npcText.text0_1"
              placeholder="text0_1"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="BroadcastTextID0">
            <el-input
              v-model="npcText.BroadcastTextID0"
              placeholder="BroadcastTextID0"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="em0_0">
            <el-input v-model="npcText.em0_0" placeholder="em0_0"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em0_1">
            <el-input v-model="npcText.em0_1" placeholder="em0_1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em0_2">
            <el-input v-model="npcText.em0_2" placeholder="em0_2"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em0_3">
            <el-input v-model="npcText.em0_3" placeholder="em0_3"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em0_4">
            <el-input v-model="npcText.em0_4" placeholder="em0_4"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em0_5">
            <el-input v-model="npcText.em0_5" placeholder="em0_5"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="lang1">
            <el-input v-model="npcText.lang1" placeholder="lang1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Probability1">
            <el-input
              v-model="npcText.Probability1"
              placeholder="Probability1"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="text1_0">
            <npc-text-localizer
              v-model="npcText.text1_0"
              placeholder="text1_0"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="text1_1">
            <npc-text-localizer
              v-model="npcText.text1_1"
              placeholder="text1_1"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="BroadcastTextID1">
            <el-input
              v-model="npcText.BroadcastTextID1"
              placeholder="BroadcastTextID1"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="em1_0">
            <el-input v-model="npcText.em1_0" placeholder="em1_0"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em1_1">
            <el-input v-model="npcText.em1_1" placeholder="em1_1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em1_2">
            <el-input v-model="npcText.em1_2" placeholder="em1_2"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em1_3">
            <el-input v-model="npcText.em1_3" placeholder="em1_3"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em1_4">
            <el-input v-model="npcText.em1_4" placeholder="em1_4"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em1_5">
            <el-input v-model="npcText.em1_5" placeholder="em1_5"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="lang2">
            <el-input v-model="npcText.lang2" placeholder="lang2"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Probability2">
            <el-input
              v-model="npcText.Probability2"
              placeholder="Probability2"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="text2_0">
            <npc-text-localizer
              v-model="npcText.text2_0"
              placeholder="text2_0"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="text2_1">
            <npc-text-localizer
              v-model="npcText.text2_1"
              placeholder="text2_1"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="BroadcastTextID2">
            <el-input
              v-model="npcText.BroadcastTextID2"
              placeholder="BroadcastTextID2"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="em2_0">
            <el-input v-model="npcText.em2_0" placeholder="em2_0"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em2_1">
            <el-input v-model="npcText.em2_1" placeholder="em2_1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em2_2">
            <el-input v-model="npcText.em2_2" placeholder="em2_2"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em2_3">
            <el-input v-model="npcText.em2_3" placeholder="em2_3"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em2_4">
            <el-input v-model="npcText.em2_4" placeholder="em2_4"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em2_5">
            <el-input v-model="npcText.em2_5" placeholder="em2_5"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="lang3">
            <el-input v-model="npcText.lang3" placeholder="lang3"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Probability3">
            <el-input
              v-model="npcText.Probability3"
              placeholder="Probability3"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="text3_0">
            <el-input
              v-model="npcText.text3_0"
              placeholder="text3_0"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="text3_1">
            <npc-text-localizer
              v-model="npcText.text3_1"
              placeholder="text3_1"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="BroadcastTextID3">
            <el-input
              v-model="npcText.BroadcastTextID3"
              placeholder="BroadcastTextID3"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="em3_0">
            <el-input v-model="npcText.em3_0" placeholder="em3_0"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em3_1">
            <el-input v-model="npcText.em3_1" placeholder="em3_1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em3_2">
            <el-input v-model="npcText.em3_2" placeholder="em3_2"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em3_3">
            <el-input v-model="npcText.em3_3" placeholder="em3_3"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em3_4">
            <el-input v-model="npcText.em3_4" placeholder="em3_4"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em3_5">
            <el-input v-model="npcText.em3_5" placeholder="em3_5"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="lang4">
            <el-input v-model="npcText.lang4" placeholder="lang4"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Probability4">
            <el-input
              v-model="npcText.Probability4"
              placeholder="Probability4"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="text4_0">
            <el-input
              v-model="npcText.text4_0"
              placeholder="text4_0"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="text4_1">
            <npc-text-localizer
              v-model="npcText.text4_1"
              placeholder="text4_1"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="BroadcastTextID4">
            <el-input
              v-model="npcText.BroadcastTextID4"
              placeholder="BroadcastTextID4"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="em4_0">
            <el-input v-model="npcText.em4_0" placeholder="em4_0"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em4_1">
            <el-input v-model="npcText.em4_1" placeholder="em4_1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em4_2">
            <el-input v-model="npcText.em4_2" placeholder="em4_2"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em4_3">
            <el-input v-model="npcText.em4_3" placeholder="em4_3"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em4_4">
            <el-input v-model="npcText.em4_4" placeholder="em4_4"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em4_5">
            <el-input v-model="npcText.em4_5" placeholder="em4_5"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="lang5">
            <el-input v-model="npcText.lang5" placeholder="lang5"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Probability5">
            <el-input
              v-model="npcText.Probability5"
              placeholder="Probability5"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="text5_0">
            <el-input
              v-model="npcText.text5_0"
              placeholder="text5_0"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="text5_1">
            <npc-text-localizer
              v-model="npcText.text5_1"
              placeholder="text5_1"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="BroadcastTextID5">
            <el-input
              v-model="npcText.BroadcastTextID5"
              placeholder="BroadcastTextID5"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="em5_0">
            <el-input v-model="npcText.em5_0" placeholder="em5_0"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em5_1">
            <el-input v-model="npcText.em5_1" placeholder="em5_1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em5_2">
            <el-input v-model="npcText.em5_2" placeholder="em5_2"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em5_3">
            <el-input v-model="npcText.em5_3" placeholder="em5_3"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em5_4">
            <el-input v-model="npcText.em5_4" placeholder="em5_4"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em5_5">
            <el-input v-model="npcText.em5_5" placeholder="em5_5"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="lang6">
            <el-input v-model="npcText.lang6" placeholder="lang6"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Probability6">
            <el-input
              v-model="npcText.Probability6"
              placeholder="Probability6"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="text6_0">
            <el-input
              v-model="npcText.text6_0"
              placeholder="text6_0"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="text6_1">
            <npc-text-localizer
              v-model="npcText.text6_1"
              placeholder="text6_1"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="BroadcastTextID6">
            <el-input
              v-model="npcText.BroadcastTextID6"
              placeholder="BroadcastTextID6"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="em6_0">
            <el-input v-model="npcText.em6_0" placeholder="em6_0"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em6_1">
            <el-input v-model="npcText.em6_1" placeholder="em6_1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em6_2">
            <el-input v-model="npcText.em6_2" placeholder="em6_2"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em6_3">
            <el-input v-model="npcText.em6_3" placeholder="em6_3"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em6_4">
            <el-input v-model="npcText.em6_4" placeholder="em6_4"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em6_5">
            <el-input v-model="npcText.em6_5" placeholder="em6_5"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="lang7">
            <el-input v-model="npcText.lang7" placeholder="lang7"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Probability7">
            <el-input
              v-model="npcText.Probability7"
              placeholder="Probability7"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="text7_0">
            <el-input
              v-model="npcText.text7_0"
              placeholder="text7_0"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="text7_1">
            <npc-text-localizer
              v-model="npcText.text7_1"
              placeholder="text6_1"
            ></npc-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="BroadcastTextID7">
            <el-input
              v-model="npcText.BroadcastTextID7"
              placeholder="BroadcastTextID7"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="em7_0">
            <el-input v-model="npcText.em7_0" placeholder="em7_0"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em7_1">
            <el-input v-model="npcText.em7_1" placeholder="em7_1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em7_2">
            <el-input v-model="npcText.em7_2" placeholder="em7_2"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em7_3">
            <el-input v-model="npcText.em7_3" placeholder="em7_3"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em7_4">
            <el-input v-model="npcText.em7_4" placeholder="em7_4"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="em7_5">
            <el-input v-model="npcText.em7_5" placeholder="em7_5"></el-input>
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
    ...mapState("gossipMenu", ["gossipMenu"]),
    ...mapState("npcText", ["npcText"]),
    credential() {
      return {
        ID: this.gossipMenu.TextID,
      };
    },
  },
  methods: {
    ...mapActions("npcText", [
      "storeNpcText",
      "findNpcText",
      "updateNpcText",
      "createNpcText",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeNpcText(this.npcText);
        this.creating = false;
      } else {
        await this.updateNpcText({
          credential: this.credential,
          npcText: this.npcText,
        });
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      await this.findNpcText({ ID: this.npcText.TextID });
      if (this.npcText.ID == undefined) {
        this.creating = true;
        await this.createNpcText({ ID: this.npcText.TextID });
      }
      this.initing = false;
    },
  },
  created() {
    this.init();
  },
};
</script>
