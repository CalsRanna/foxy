<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
        <el-breadcrumb-item :to="{ path: '/quest' }"
          >任务管理</el-breadcrumb-item
        >
        <el-breadcrumb-item>任务详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-tabs value="quest_template" style="margin-top: 16px">
        <el-tab-pane label="任务模版" name="quest_template">
          <el-form
            :model="questTemplate"
            label-position="right"
            label-width="120px"
          >
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="ID">
                    <el-input-number
                      v-model="questTemplate.ID"
                      :min="min"
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
                  <el-form-item label="LogTitle">
                    <el-input
                      v-model="questTemplate.LogTitle"
                      placeholder="LogTitle"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="QuestType">
                    <el-input
                      v-model="questTemplate.QuestType"
                      placeholder="QuestType"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="QuestLevel">
                    <el-input
                      v-model="questTemplate.QuestLevel"
                      placeholder="QuestLevel"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="MinLevel">
                    <el-input
                      v-model="questTemplate.MinLevel"
                      placeholder="MinLevel"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="QuestSortID">
                    <el-input
                      v-model="questTemplate.QuestSortID"
                      placeholder="QuestSortID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="QuestInfoID">
                    <el-input
                      v-model="questTemplate.QuestInfoID"
                      placeholder="QuestInfoID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="SuggestedGroupNum">
                    <el-input
                      v-model="questTemplate.SuggestedGroupNum"
                      placeholder="SuggestedGroupNum"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredFactionId1">
                    <el-input
                      v-model="questTemplate.RequiredFactionId1"
                      placeholder="RequiredFactionId1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="StartItem">
                    <el-input
                      v-model="questTemplate.StartItem"
                      placeholder="StartItem"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Flags">
                    <el-input
                      v-model="questTemplate.Flags"
                      placeholder="Flags"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="TimeAllowed">
                    <el-input
                      v-model="questTemplate.TimeAllowed"
                      placeholder="TimeAllowed"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="AllowableRaces">
                    <el-input
                      v-model="questTemplate.AllowableRaces"
                      placeholder="AllowableRaces"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Unknown0">
                    <el-input
                      v-model="questTemplate.Unknown0"
                      placeholder="Unknown0"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredPlayerKills">
                    <el-input
                      v-model="questTemplate.RequiredPlayerKills"
                      placeholder="RequiredPlayerKills"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="VerifiedBuild">
                    <el-input
                      v-model="questTemplate.VerifiedBuild"
                      placeholder="VerifiedBuild"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="POIContinent">
                    <el-input
                      v-model="questTemplate.POIContinent"
                      placeholder="POIContinent"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="POIx">
                    <el-input
                      v-model="questTemplate.POIx"
                      placeholder="POIx"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="POIy">
                    <el-input
                      v-model="questTemplate.POIy"
                      placeholder="POIy"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="POIPriority">
                    <el-input
                      v-model="questTemplate.POIPriority"
                      placeholder="POIPriority"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="LogDescription">
                    <el-input
                      v-model="questTemplate.LogDescription"
                      placeholder="LogDescription"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="QuestDescription">
                    <el-input
                      v-model="questTemplate.QuestDescription"
                      placeholder="QuestDescription"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="AreaDescription">
                    <el-input
                      v-model="questTemplate.AreaDescription"
                      placeholder="AreaDescription"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="QuestCompletionLog">
                    <el-input
                      v-model="questTemplate.QuestCompletionLog"
                      placeholder="QuestCompletionLog"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ObjectiveText1">
                    <el-input
                      v-model="questTemplate.ObjectiveText1"
                      placeholder="ObjectiveText1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ObjectiveText2">
                    <el-input
                      v-model="questTemplate.ObjectiveText2"
                      placeholder="ObjectiveText2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ObjectiveText3">
                    <el-input
                      v-model="questTemplate.ObjectiveText3"
                      placeholder="ObjectiveText3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ObjectiveText4">
                    <el-input
                      v-model="questTemplate.ObjectiveText4"
                      placeholder="ObjectiveText4"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RequiredItemId1">
                    <el-input
                      v-model="questTemplate.RequiredItemId1"
                      placeholder="RequiredItemId1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemCount1">
                    <el-input
                      v-model="questTemplate.RequiredItemCount1"
                      placeholder="RequiredItemCount1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemId2">
                    <el-input
                      v-model="questTemplate.RequiredItemId2"
                      placeholder="RequiredItemId2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemCount2">
                    <el-input
                      v-model="questTemplate.RequiredItemCount2"
                      placeholder="RequiredItemCount2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemId3">
                    <el-input
                      v-model="questTemplate.RequiredItemId3"
                      placeholder="RequiredItemId3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemCount3">
                    <el-input
                      v-model="questTemplate.RequiredItemCount3"
                      placeholder="RequiredItemCount3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemId4">
                    <el-input
                      v-model="questTemplate.RequiredItemId4"
                      placeholder="RequiredItemId4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemCount4">
                    <el-input
                      v-model="questTemplate.RequiredItemCount4"
                      placeholder="RequiredItemCount4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemId5">
                    <el-input
                      v-model="questTemplate.RequiredItemId5"
                      placeholder="RequiredItemId5"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemCount5">
                    <el-input
                      v-model="questTemplate.RequiredItemCount5"
                      placeholder="RequiredItemCount5"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemId6">
                    <el-input
                      v-model="questTemplate.RequiredItemId6"
                      placeholder="RequiredItemId6"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredItemCount6">
                    <el-input
                      v-model="questTemplate.RequiredItemCount6"
                      placeholder="RequiredItemCount6"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RequiredFactionId1">
                    <el-input
                      v-model="questTemplate.RequiredFactionId1"
                      placeholder="RequiredFactionId1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredFactionValue1">
                    <el-input
                      v-model="questTemplate.RequiredFactionValue1"
                      placeholder="RequiredFactionValue1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredFactionId2">
                    <el-input
                      v-model="questTemplate.RequiredFactionId2"
                      placeholder="RequiredFactionId2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredFactionValue2">
                    <el-input
                      v-model="questTemplate.RequiredFactionValue2"
                      placeholder="RequiredFactionValue2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredNpcOrGo1">
                    <el-input
                      v-model="questTemplate.RequiredNpcOrGo1"
                      placeholder="RequiredNpcOrGo1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredNpcOrGoCount1">
                    <el-input
                      v-model="questTemplate.RequiredNpcOrGoCount1"
                      placeholder="RequiredNpcOrGoCount1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredNpcOrGo2">
                    <el-input
                      v-model="questTemplate.RequiredNpcOrGo2"
                      placeholder="RequiredNpcOrGo2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredNpcOrGoCount2">
                    <el-input
                      v-model="questTemplate.RequiredNpcOrGoCount2"
                      placeholder="RequiredNpcOrGoCount2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredNpcOrGo3">
                    <el-input
                      v-model="questTemplate.RequiredNpcOrGo3"
                      placeholder="RequiredNpcOrGo3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredNpcOrGoCount3">
                    <el-input
                      v-model="questTemplate.RequiredNpcOrGoCount3"
                      placeholder="RequiredNpcOrGoCount3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredNpcOrGo4">
                    <el-input
                      v-model="questTemplate.RequiredNpcOrGo4"
                      placeholder="RequiredNpcOrGo4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredNpcOrGoCount4">
                    <el-input
                      v-model="questTemplate.RequiredNpcOrGoCount4"
                      placeholder="RequiredNpcOrGoCount4"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="ItemDrop1">
                    <el-input
                      v-model="questTemplate.ItemDrop1"
                      placeholder="ItemDrop1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ItemDropQuantity1">
                    <el-input
                      v-model="questTemplate.ItemDropQuantity1"
                      placeholder="ItemDropQuantity1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ItemDrop2">
                    <el-input
                      v-model="questTemplate.ItemDrop2"
                      placeholder="ItemDrop2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ItemDropQuantity2">
                    <el-input
                      v-model="questTemplate.ItemDropQuantity2"
                      placeholder="ItemDropQuantity2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ItemDrop3">
                    <el-input
                      v-model="questTemplate.ItemDrop3"
                      placeholder="ItemDrop3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ItemDropQuantity3">
                    <el-input
                      v-model="questTemplate.ItemDropQuantity3"
                      placeholder="ItemDropQuantity3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ItemDrop4">
                    <el-input
                      v-model="questTemplate.ItemDrop4"
                      placeholder="ItemDrop4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ItemDropQuantity4">
                    <el-input
                      v-model="questTemplate.ItemDropQuantity4"
                      placeholder="ItemDropQuantity4"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RewardTitle">
                    <el-input
                      v-model="questTemplate.RewardTitle"
                      placeholder="RewardTitle"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardTalents">
                    <el-input
                      v-model="questTemplate.RewardTalents"
                      placeholder="RewardTalents"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardArenaPoints">
                    <el-input
                      v-model="questTemplate.RewardArenaPoints"
                      placeholder="RewardArenaPoints"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardNextQuest">
                    <el-input
                      v-model="questTemplate.RewardNextQuest"
                      placeholder="RewardNextQuest"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardXPDifficulty">
                    <el-input
                      v-model="questTemplate.RewardXPDifficulty"
                      placeholder="RewardXPDifficulty"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardMoney">
                    <el-input
                      v-model="questTemplate.RewardMoney"
                      placeholder="RewardMoney"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardBonusMoney">
                    <el-input
                      v-model="questTemplate.RewardBonusMoney"
                      placeholder="RewardBonusMoney"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardDisplaySpell">
                    <el-input
                      v-model="questTemplate.RewardDisplaySpell"
                      placeholder="RewardDisplaySpell"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardSpell">
                    <el-input
                      v-model="questTemplate.RewardSpell"
                      placeholder="RewardSpell"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardHonor">
                    <el-input
                      v-model="questTemplate.RewardHonor"
                      placeholder="RewardHonor"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardKillHonor">
                    <el-input
                      v-model="questTemplate.RewardKillHonor"
                      placeholder="RewardKillHonor"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RewardItem1">
                    <el-input
                      v-model="questTemplate.RewardItem1"
                      placeholder="RewardItem1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardAmount1">
                    <el-input
                      v-model="questTemplate.RewardAmount1"
                      placeholder="RewardAmount1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardItem2">
                    <el-input
                      v-model="questTemplate.RewardItem2"
                      placeholder="RewardItem2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardAmount2">
                    <el-input
                      v-model="questTemplate.RewardAmount2"
                      placeholder="RewardAmount2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardItem3">
                    <el-input
                      v-model="questTemplate.RewardItem3"
                      placeholder="RewardItem3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardAmount3">
                    <el-input
                      v-model="questTemplate.RewardAmount3"
                      placeholder="RewardAmount3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardItem4">
                    <el-input
                      v-model="questTemplate.RewardItem4"
                      placeholder="RewardItem4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardAmount4">
                    <el-input
                      v-model="questTemplate.RewardAmount4"
                      placeholder="RewardAmount4"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemID1">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemID1"
                      placeholder="RewardChoiceItemID1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemQuantity1">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemQuantity1"
                      placeholder="RewardChoiceItemQuantity1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemID2">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemID2"
                      placeholder="RewardChoiceItemID2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemQuantity2">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemQuantity2"
                      placeholder="RewardChoiceItemQuantity2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemID3">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemID3"
                      placeholder="RewardChoiceItemID3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemQuantity3">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemQuantity3"
                      placeholder="RewardChoiceItemQuantity3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemID4">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemID4"
                      placeholder="RewardChoiceItemID4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemQuantity4">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemQuantity4"
                      placeholder="RewardChoiceItemQuantity4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemID5">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemID5"
                      placeholder="RewardChoiceItemID5"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemQuantity5">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemQuantity5"
                      placeholder="RewardChoiceItemQuantity5"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemID6">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemID6"
                      placeholder="RewardChoiceItemID6"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardChoiceItemQuantity6">
                    <el-input
                      v-model="questTemplate.RewardChoiceItemQuantity6"
                      placeholder="RewardChoiceItemQuantity6"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RewardFactionID1">
                    <el-input
                      v-model="questTemplate.RewardFactionID1"
                      placeholder="RewardFactionID1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionValue1">
                    <el-input
                      v-model="questTemplate.RewardFactionValue1"
                      placeholder="RewardFactionValue1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionOverride1">
                    <el-input
                      v-model="questTemplate.RewardFactionOverride1"
                      placeholder="RewardFactionOverride1"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RewardFactionID2">
                    <el-input
                      v-model="questTemplate.RewardFactionID2"
                      placeholder="RewardFactionID2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionValue2">
                    <el-input
                      v-model="questTemplate.RewardFactionValue2"
                      placeholder="RewardFactionValue2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionOverride2">
                    <el-input
                      v-model="questTemplate.RewardFactionOverride2"
                      placeholder="RewardFactionOverride2"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RewardFactionID3">
                    <el-input
                      v-model="questTemplate.RewardFactionID3"
                      placeholder="RewardFactionID3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionValue3">
                    <el-input
                      v-model="questTemplate.RewardFactionValue3"
                      placeholder="RewardFactionValue3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionOverride3">
                    <el-input
                      v-model="questTemplate.RewardFactionOverride3"
                      placeholder="RewardFactionOverride3"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RewardFactionID4">
                    <el-input
                      v-model="questTemplate.RewardFactionID4"
                      placeholder="RewardFactionID4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionValue4">
                    <el-input
                      v-model="questTemplate.RewardFactionValue4"
                      placeholder="RewardFactionValue4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionOverride4">
                    <el-input
                      v-model="questTemplate.RewardFactionOverride4"
                      placeholder="RewardFactionOverride4"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="RewardFactionID5">
                    <el-input
                      v-model="questTemplate.RewardFactionID5"
                      placeholder="RewardFactionID5"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionValue5">
                    <el-input
                      v-model="questTemplate.RewardFactionValue5"
                      placeholder="RewardFactionValue5"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardFactionOverride5">
                    <el-input
                      v-model="questTemplate.RewardFactionOverride5"
                      placeholder="RewardFactionOverride5"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-button type="primary" @click="() => store('quest_template')"
                >保存</el-button
              >
              <el-button @click="cancel">返回</el-button>
            </el-card>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="模版补充" name="quest_template_addon">
          <el-form
            :model="questTemplateAddon"
            label-position="right"
            label-width="120px"
          >
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="ID">
                    <el-input
                      v-model="questTemplateAddon.ID"
                      placeholder="ID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="MaxLevel">
                    <el-input
                      v-model="questTemplateAddon.MaxLevel"
                      placeholder="MaxLevel"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="AllowableClasses">
                    <el-input
                      v-model="questTemplateAddon.AllowableClasses"
                      placeholder="AllowableClasses"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="SourceSpellID">
                    <el-input
                      v-model="questTemplateAddon.SourceSpellID"
                      placeholder="SourceSpellID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="PrevQuestID">
                    <el-input
                      v-model="questTemplateAddon.PrevQuestID"
                      placeholder="PrevQuestID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="NextQuestID">
                    <el-input
                      v-model="questTemplateAddon.NextQuestID"
                      placeholder="NextQuestID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ExclusiveGroup">
                    <el-input
                      v-model="questTemplateAddon.ExclusiveGroup"
                      placeholder="ExclusiveGroup"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardMailTemplateID">
                    <el-input
                      v-model="questTemplateAddon.RewardMailTemplateID"
                      placeholder="RewardMailTemplateID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardMailDelay">
                    <el-input
                      v-model="questTemplateAddon.RewardMailDelay"
                      placeholder="RewardMailDelay"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredSkillID">
                    <el-input
                      v-model="questTemplateAddon.RequiredSkillID"
                      placeholder="RequiredSkillID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredSkillPoints">
                    <el-input
                      v-model="questTemplateAddon.RequiredSkillPoints"
                      placeholder="RequiredSkillPoints"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredMinRepFaction">
                    <el-input
                      v-model="questTemplateAddon.RequiredMinRepFaction"
                      placeholder="RequiredMinRepFaction"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredMaxRepFaction">
                    <el-input
                      v-model="questTemplateAddon.RequiredMaxRepFaction"
                      placeholder="RequiredMaxRepFaction"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredMinRepValue">
                    <el-input
                      v-model="questTemplateAddon.RequiredMinRepValue"
                      placeholder="RequiredMinRepValue"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RequiredMaxRepValue">
                    <el-input
                      v-model="questTemplateAddon.RequiredMaxRepValue"
                      placeholder="RequiredMaxRepValue"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="ProvidedItemCount">
                    <el-input
                      v-model="questTemplateAddon.ProvidedItemCount"
                      placeholder="ProvidedItemCount"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="SpecialFlags">
                    <el-input
                      v-model="questTemplateAddon.SpecialFlags"
                      placeholder="SpecialFlags"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-button
                type="primary"
                @click="() => store('quest_template_addon')"
                >保存</el-button
              >
              <el-button @click="cancel">返回</el-button>
            </el-card>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="任务奖励" name="quest_offer_reward">
          <el-form
            :model="questOfferReward"
            label-position="right"
            label-width="120px"
          >
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="ID">
                    <el-input
                      v-model="questOfferReward.ID"
                      placeholder="ID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Emote1">
                    <el-input
                      v-model="questOfferReward.Emote1"
                      placeholder="Emote1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Emote2">
                    <el-input
                      v-model="questOfferReward.Emote2"
                      placeholder="Emote2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Emote3">
                    <el-input
                      v-model="questOfferReward.Emote3"
                      placeholder="Emote3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="Emote4">
                    <el-input
                      v-model="questOfferReward.Emote4"
                      placeholder="Emote4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="EmoteDelay1">
                    <el-input
                      v-model="questOfferReward.EmoteDelay1"
                      placeholder="EmoteDelay1"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="EmoteDelay2">
                    <el-input
                      v-model="questOfferReward.EmoteDelay2"
                      placeholder="EmoteDelay2"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="EmoteDelay3">
                    <el-input
                      v-model="questOfferReward.EmoteDelay3"
                      placeholder="EmoteDelay3"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="EmoteDelay4">
                    <el-input
                      v-model="questOfferReward.EmoteDelay4"
                      placeholder="EmoteDelay4"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="RewardText">
                    <el-input
                      v-model="questOfferReward.RewardText"
                      placeholder="RewardText"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="VerifiedBuild">
                    <el-input
                      v-model="questOfferReward.VerifiedBuild"
                      placeholder="VerifiedBuild"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-button
                type="primary"
                @click="() => store('quest_offer_reward')"
                >保存</el-button
              >
              <el-button @click="cancel">返回</el-button>
            </el-card>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="任务需要物品" name="quest_request_items">
          <el-form
            :model="questRequestItems"
            label-position="right"
            label-width="120px"
          >
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="ID">
                    <el-input
                      v-model="questRequestItems.ID"
                      placeholder="ID"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="EmoteOnComplete">
                    <el-input
                      v-model="questRequestItems.EmoteOnComplete"
                      placeholder="EmoteOnComplete"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="EmoteOnIncomplete">
                    <el-input
                      v-model="questRequestItems.EmoteOnIncomplete"
                      placeholder="EmoteOnIncomplete"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="CompletionText">
                    <el-input
                      v-model="questRequestItems.CompletionText"
                      placeholder="CompletionText"
                    ></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="VerifiedBuild">
                    <el-input
                      v-model="questRequestItems.VerifiedBuild"
                      placeholder="VerifiedBuild"
                    ></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-button
                type="primary"
                @click="() => store('quest_request_items')"
                >保存</el-button
              >
              <el-button @click="cancel">返回</el-button>
            </el-card>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="任务开始生物" name="creature_quest_starter">
          <el-card style="margin-top: 16px">
            <el-button type="primary">新增</el-button>
            <el-button disabled>复制</el-button>
            <el-button type="danger" disabled>删除</el-button>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-table :data="creatureQuestStarters">
              <el-table-column prop="id" label="ID"></el-table-column>
              <el-table-column prop="quest" label="任务"></el-table-column>
            </el-table>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="任务结束生物" name="creature_quest_ender">
          <el-card style="margin-top: 16px">
            <el-button type="primary">新增</el-button>
            <el-button disabled>复制</el-button>
            <el-button type="danger" disabled>删除</el-button>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-table :data="creatureQuestEnders">
              <el-table-column prop="id" label="ID"></el-table-column>
              <el-table-column prop="quest" label="任务"></el-table-column>
            </el-table>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="任务开始物体" name="game_object_quest_starter">
          <el-card style="margin-top: 16px">
            <el-button type="primary">新增</el-button>
            <el-button disabled>复制</el-button>
            <el-button type="danger" disabled>删除</el-button>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-table :data="gameObjectQuestStarters">
              <el-table-column prop="id" label="ID"></el-table-column>
              <el-table-column prop="quest" label="任务"></el-table-column>
            </el-table>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="任务结束物体" name="game_object_quest_ender">
          <el-card style="margin-top: 16px">
            <el-button type="primary">新增</el-button>
            <el-button disabled>复制</el-button>
            <el-button type="danger" disabled>删除</el-button>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-table :data="gameObjectQuestEnders">
              <el-table-column prop="id" label="ID"></el-table-column>
              <el-table-column prop="quest" label="任务"></el-table-column>
            </el-table>
          </el-card>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { mapActions, mapState } from "vuex";

export default {
  data() {
    return {
      isCreating: true,
      loading: false,
      min: 0,
    };
  },
  computed: {
    ...mapState("quest", [
      "questTemplate",
      "questTemplateAddon",
      "questOfferReward",
      "questRequestItems",
      "creatureQuestStarters",
      "creatureQuestEnders",
      "gameObjectQuestStarters",
      "gameObjectQuestEnders",
    ]),
    localeName() {
      return this.questTemplate.LogTitle;
    },
    localeDescription() {
      return null;
    },
    disabled() {
      return !this.isCreating;
    },
  },
  methods: {
    ...mapActions("quest", [
      "storeQuestTemplate",
      "findQuestTemplate",
      "updateQuestTemplate",
      "createQuestTemplate",
    ]),
    store(module) {
      switch (module) {
        case "quest_template":
          this.loading = true;
          if (this.isCreating) {
            this.storeQuestTemplate(this.questTemplate);
          } else {
            this.updateQuestTemplate(this.questTemplate);
          }
          this.loading = false;
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
      let id = this.$route.params.id;
      let path = this.$route.path;
      if (path === "/quest/create") {
        await this.createQuestTemplate();
      } else {
        this.isCreating = false;
        await Promise.all([this.findQuestTemplate({ ID: id })]);
      }
      this.loading = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
