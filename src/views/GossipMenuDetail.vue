<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/gossip-menu' }">对话管理</el-breadcrumb-item>
        <el-breadcrumb-item>对话详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeSubname }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="gossip_menu" @tab-click="switchover" style="margin-top: 16px">
      <el-tab-pane label="对话" name="gossip_menu">
        <el-form :model="gossipMenu" label-position="right" label-width="120px">
          <el-card style="margin-top: 16px">
            <el-row :gutter="24">
              <el-col :span="6">
                <el-form-item label="对话ID">
                  <el-input-number
                    v-model="gossipMenu.MenuID"
                    :min="min"
                    controls-position="right"
                    placeholder="MenuID"
                    :disabled="disabled"
                    v-loading="loading"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="文本ID">
                  <el-input v-model="gossipMenu.TextID" placeholder="TextID"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-button type="primary" @click="() => store('gossip_menu')">保存</el-button>
            <el-button @click="cancel">返回</el-button>
          </el-card>
        </el-form>
      </el-tab-pane>
      <el-tab-pane label="文本" name="npc_text" lazy v-loading="loading">
        <el-form :model="npcText" label-position="right" label-width="120px">
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="ID">
                  <el-input-number
                    v-model="npcText.ID"
                    :min="0"
                    controls-position="right"
                    placeholder="ID"
                    :disabled="disabled"
                    v-loading="loading"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="VerifiedBuild">
                  <el-input v-model="npcText.VerifiedBuild" placeholder="VerifiedBuild"></el-input>
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
                  <el-input v-model="npcText.Probability0" placeholder="Probability0"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="text0_0">
                  <el-input v-model="npcText.text0_0" placeholder="text0_0">
                    <i
                      class="el-icon-s-operation clickable-icon"
                      slot="suffix"
                      style="margin-right: 8px"
                      @click="showDialog"
                    ></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="text0_1">
                  <el-input v-model="npcText.text0_1" placeholder="text0_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="BroadcastTextID0">
                  <el-input v-model="npcText.BroadcastTextID0" placeholder="BroadcastTextID0"></el-input>
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
                  <el-input v-model="npcText.Probability1" placeholder="Probability1"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="text1_0">
                  <el-input v-model="npcText.text1_0" placeholder="text1_0"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="text1_1">
                  <el-input v-model="npcText.text1_1" placeholder="text1_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="BroadcastTextID1">
                  <el-input v-model="npcText.BroadcastTextID1" placeholder="BroadcastTextID1"></el-input>
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
                  <el-input v-model="npcText.Probability2" placeholder="Probability2"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="text2_0">
                  <el-input v-model="npcText.text2_0" placeholder="text2_0"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="text2_1">
                  <el-input v-model="npcText.text2_1" placeholder="text2_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="BroadcastTextID2">
                  <el-input v-model="npcText.BroadcastTextID2" placeholder="BroadcastTextID2"></el-input>
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
                  <el-input v-model="npcText.Probability3" placeholder="Probability3"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="text3_0">
                  <el-input v-model="npcText.text3_0" placeholder="text3_0"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="text3_1">
                  <el-input v-model="npcText.text3_1" placeholder="text3_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="BroadcastTextID3">
                  <el-input v-model="npcText.BroadcastTextID3" placeholder="BroadcastTextID3"></el-input>
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
                  <el-input v-model="npcText.Probability4" placeholder="Probability4"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="text4_0">
                  <el-input v-model="npcText.text4_0" placeholder="text4_0"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="text4_1">
                  <el-input v-model="npcText.text4_1" placeholder="text4_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="BroadcastTextID4">
                  <el-input v-model="npcText.BroadcastTextID4" placeholder="BroadcastTextID4"></el-input>
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
                  <el-input v-model="npcText.Probability5" placeholder="Probability5"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="text5_0">
                  <el-input v-model="npcText.text5_0" placeholder="text5_0"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="text5_1">
                  <el-input v-model="npcText.text5_1" placeholder="text5_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="BroadcastTextID5">
                  <el-input v-model="npcText.BroadcastTextID5" placeholder="BroadcastTextID5"></el-input>
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
                  <el-input v-model="npcText.Probability6" placeholder="Probability6"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="text6_0">
                  <el-input v-model="npcText.text6_0" placeholder="text6_0"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="text6_1">
                  <el-input v-model="npcText.text6_1" placeholder="text6_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="BroadcastTextID6">
                  <el-input v-model="npcText.BroadcastTextID6" placeholder="BroadcastTextID6"></el-input>
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
                  <el-input v-model="npcText.Probability7" placeholder="Probability7"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="text7_0">
                  <el-input v-model="npcText.text7_0" placeholder="text7_0"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="text7_1">
                  <el-input v-model="npcText.text7_1" placeholder="text7_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="BroadcastTextID7">
                  <el-input v-model="npcText.BroadcastTextID7" placeholder="BroadcastTextID7"></el-input>
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
            <el-button type="primary" :loading="loading" @click="() => store('npc_text')"
              >保存</el-button
            >
            <el-button @click="cancel">返回</el-button>
          </el-card>
        </el-form>
      </el-tab-pane>
      <el-tab-pane label="选项" name="gossip_menu_option" lazy v-loading="loading"></el-tab-pane>
    </el-tabs>
    <el-dialog :visible.sync="localeDialogVisible" :show-close="false" :close-on-click-modal="false">
      <div slot="title">
        <span style="font-size: 18px;color: #303133;margin-right:16px">文本本地化</span>
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
            <el-input-number v-model="scope.row.ID" controls-position="right" disabled></el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="Locale" label="语言">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Locale" placeholder="Locale"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text0_0" label="文本0_0">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text0_0" placeholder="Text0_0"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text0_1" label="文本0_1">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text0_1" placeholder="Text0_1"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text1_0" label="文本1_0">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text1_0" placeholder="Text1_0"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text1_1" label="文本1_1">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text1_1" placeholder="Text1_1"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text2_0" label="文本2_0">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text2_0" placeholder="Text2_0"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text2_1" label="文本2_1">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text2_1" placeholder="Text2_1"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text3_0" label="文本3_0">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text3_0" placeholder="Text3_0"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text3_1" label="文本3_1">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text3_1" placeholder="Text3_1"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text4_0" label="文本4_0">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text4_0" placeholder="Text4_0"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text4_1" label="文本4_1">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text4_1" placeholder="Text4_1"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text5_0" label="文本5_0">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text5_0" placeholder="Text5_0"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text5_1" label="文本5_1">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text5_1" placeholder="Text5_1"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text6_0" label="文本6_0">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text6_0" placeholder="Text6_0"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text6_1" label="文本6_1">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text6_1" placeholder="Text6_1"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text7_0" label="文本7_0">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text7_0" placeholder="Text7_0"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Text7_1" label="文本7_1">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Text7_1" placeholder="Text7_1"></el-input>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer">
        <el-button @click="closeDialog">取消</el-button>
        <el-button type="primary" @click="() => store('npc_text_locales')">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
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
    };
  },
  computed: {
    ...mapState("gossipMenu", ["gossipMenu", "npcText", "npcTextLocales"]),
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
          // await this.searchGameObjectQuestItems({ GameObjectEntry: this.gameObjectTemplate.entry });
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
        ID: this.npcText.ID
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
              credential: {ID: this.npcText.ID},
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
};
</script>
