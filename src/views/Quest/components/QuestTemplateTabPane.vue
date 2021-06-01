<template>
  <el-form :model="questTemplate" label-position="right" label-width="120px">
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="questTemplate.ID"
              controls-position="right"
              placeholder="ID"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="名称">
            <quest-template-localizer
              v-model="questTemplate.LogTitle"
              placeholder="LogTitle"
            ></quest-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="类型">
            <el-input
              v-model="questTemplate.QuestType"
              placeholder="QuestType"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="等级">
            <el-input
              v-model="questTemplate.QuestLevel"
              placeholder="QuestLevel"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最小等级">
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
          <el-form-item label="建议队伍人数">
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
          <el-form-item label="标识">
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
          <el-form-item label="允许种族">
            <flag-editor
              title="允许种族编辑器"
              v-model="questTemplate.AllowableRaces"
              :flags="allowableRaces"
              placeholder="AllowableRace"
            ></flag-editor>
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
      <el-row :gutter="16">
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
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="任务详情">
            <quest-template-localizer
              v-model="questTemplate.QuestDescription"
              placeholder="QuestDescription"
            ></quest-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="任务日志描述">
            <quest-template-localizer
              v-model="questTemplate.LogDescription"
              placeholder="LogDescription"
            ></quest-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="AreaDescription">
            <quest-template-localizer
              v-model="questTemplate.AreaDescription"
              placeholder="AreaDescription"
            ></quest-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="QuestCompletionLog">
            <quest-template-localizer
              v-model="questTemplate.QuestCompletionLog"
              placeholder="QuestCompletionLog"
            ></quest-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="ObjectiveText1">
            <quest-template-localizer
              v-model="questTemplate.ObjectiveText1"
              placeholder="ObjectiveText1"
            ></quest-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="ObjectiveText2">
            <quest-template-localizer
              v-model="questTemplate.ObjectiveText2"
              placeholder="ObjectiveText2"
            ></quest-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="ObjectiveText3">
            <quest-template-localizer
              v-model="questTemplate.ObjectiveText3"
              placeholder="ObjectiveText3"
            ></quest-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="ObjectiveText4">
            <quest-template-localizer
              v-model="questTemplate.ObjectiveText4"
              placeholder="ObjectiveText4"
            ></quest-template-localizer>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="需要物品">
            <item-template-selector
              v-model="questTemplate.RequiredItemId1"
              placeholder="RequiredItemId1"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RequiredItemCount1"
              placeholder="RequiredItemCount1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要物品">
            <item-template-selector
              v-model="questTemplate.RequiredItemId2"
              placeholder="RequiredItemId2"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RequiredItemCount2"
              placeholder="RequiredItemCount2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要物品">
            <item-template-selector
              v-model="questTemplate.RequiredItemId3"
              placeholder="RequiredItemId3"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RequiredItemCount3"
              placeholder="RequiredItemCount3"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要物品">
            <item-template-selector
              v-model="questTemplate.RequiredItemId4"
              placeholder="RequiredItemId4"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RequiredItemCount4"
              placeholder="RequiredItemCount4"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要物品">
            <item-template-selector
              v-model="questTemplate.RequiredItemId5"
              placeholder="RequiredItemId5"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RequiredItemCount5"
              placeholder="RequiredItemCount5"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要物品">
            <item-template-selector
              v-model="questTemplate.RequiredItemId6"
              placeholder="RequiredItemId6"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RequiredItemCount6"
              placeholder="RequiredItemCount6"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
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
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="ItemDrop1">
            <item-template-selector
              v-model="questTemplate.ItemDrop1"
              placeholder="ItemDrop1"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.ItemDropQuantity1"
              placeholder="ItemDropQuantity1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="ItemDrop2">
            <item-template-selector
              v-model="questTemplate.ItemDrop2"
              placeholder="ItemDrop2"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.ItemDropQuantity2"
              placeholder="ItemDropQuantity2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="ItemDrop3">
            <item-template-selector
              v-model="questTemplate.ItemDrop3"
              placeholder="ItemDrop3"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.ItemDropQuantity3"
              placeholder="ItemDropQuantity3"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="ItemDrop4">
            <item-template-selector
              v-model="questTemplate.ItemDrop4"
              placeholder="ItemDrop4"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.ItemDropQuantity4"
              placeholder="ItemDropQuantity4"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="奖励标题">
            <el-input
              v-model="questTemplate.RewardTitle"
              placeholder="RewardTitle"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励天赋点">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardTalents"
              placeholder="RewardTalents"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RewardArenaPoints">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardArenaPoints"
              placeholder="RewardArenaPoints"
            ></el-input-number>
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
          <el-form-item label="奖励金钱">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardMoney"
              placeholder="RewardMoney"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RewardBonusMoney">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardBonusMoney"
              placeholder="RewardBonusMoney"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RewardDisplaySpell">
            <spell-selector
              v-model="questTemplate.RewardDisplaySpell"
              placeholder="RewardDisplaySpell"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励技能">
            <spell-selector
              v-model="questTemplate.RewardSpell"
              placeholder="RewardSpell"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励荣誉">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardHonor"
              placeholder="RewardHonor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="RewardKillHonor">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardKillHonor"
              placeholder="RewardKillHonor"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardItem1"
              placeholder="RewardItem1"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardAmount1"
              placeholder="RewardAmount1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardItem2"
              placeholder="RewardItem2"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardAmount2"
              placeholder="RewardAmount2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardItem3"
              placeholder="RewardItem3"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardAmount3"
              placeholder="RewardAmount3"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardItem4"
              placeholder="RewardItem4"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardAmount4"
              placeholder="RewardAmount4"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="可选奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardChoiceItemID1"
              placeholder="RewardChoiceItemID1"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardChoiceItemQuantity1"
              placeholder="RewardChoiceItemQuantity1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="可选奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardChoiceItemID2"
              placeholder="RewardChoiceItemID2"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardChoiceItemQuantity2"
              placeholder="RewardChoiceItemQuantity2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="可选奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardChoiceItemID3"
              placeholder="RewardChoiceItemID3"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardChoiceItemQuantity3"
              placeholder="RewardChoiceItemQuantity3"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="可选奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardChoiceItemID4"
              placeholder="RewardChoiceItemID4"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardChoiceItemQuantity4"
              placeholder="RewardChoiceItemQuantity4"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="可选奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardChoiceItemID5"
              placeholder="RewardChoiceItemID5"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardChoiceItemQuantity5"
              placeholder="RewardChoiceItemQuantity5"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="可选奖励物品">
            <item-template-selector
              v-model="questTemplate.RewardChoiceItemID6"
              placeholder="RewardChoiceItemID6"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardChoiceItemQuantity6"
              placeholder="RewardChoiceItemQuantity6"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
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
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue1"
              placeholder="RewardFactionValue1"
            ></el-input-number>
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
      <el-row :gutter="16">
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
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue2"
              placeholder="RewardFactionValue2"
            ></el-input-number>
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
      <el-row :gutter="16">
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
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue3"
              placeholder="RewardFactionValue3"
            ></el-input-number>
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
      <el-row :gutter="16">
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
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue4"
              placeholder="RewardFactionValue4"
            ></el-input-number>
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
      <el-row :gutter="16">
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
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue5"
              placeholder="RewardFactionValue5"
            ></el-input-number>
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
      <el-button type="primary" :loading="loading" @click="store">
        保存
      </el-button>
      <el-button @click="cancel">返回</el-button>
    </el-card>
  </el-form>
</template>

<script>
import QuestTemplateLocalizer from "@/views/Quest/components/QuestTemplateLocalizer";
import ItemTemplateSelector from "@/components/ItemTemplateSelector";
import SpellSelector from "@/components/SpellSelector";

import { mapState, mapActions } from "vuex";
import FlagEditor from "@/components/FlagEditor";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("initiator", ["chrRaces"]),
    ...mapState("questTemplate", ["questTemplate"]),
    ...mapState("questTemplateLocale", ["questTemplateLocales"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
    allowableRaces() {
      return this.chrRaces.map((chrRace) => {
        return {
          index: chrRace.ID,
          flag: Math.pow(2, chrRace.ID - 1),
          name: chrRace.Name_Lang_zhCN,
          comment: chrRace.ClientFileString,
        };
      });
    },
  },
  methods: {
    ...mapActions("questTemplate", [
      "storeQuestTemplate",
      "findQuestTemplate",
      "updateQuestTemplate",
      "createQuestTemplate",
    ]),
    ...mapActions("questTemplateLocale", ["searchQuestTemplateLocales"]),
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeQuestTemplate(this.questTemplate);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateQuestTemplate({
          credential: this.credential,
          questTemplate: this.questTemplate,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
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
      if (this.$route.path == "/quest/create") {
        this.creating = true;
        await Promise.all([
          this.createQuestTemplate(),
          this.searchQuestTemplateLocales({ ID: 0 }),
        ]);
      } else {
        await Promise.all([
          this.findQuestTemplate(this.credential),
          this.searchQuestTemplateLocales(this.credential),
        ]);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    FlagEditor,
    QuestTemplateLocalizer,
    ItemTemplateSelector,
    SpellSelector,
  },
};
</script>
