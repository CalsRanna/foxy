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
            <quest-template-title-localizer
              v-model="questTemplate.LogTitle"
              placeholder="LogTitle"
            ></quest-template-title-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="类型">
            <el-select
              v-model="questTemplate.QuestType"
              placeholder="QuestType"
            >
              <el-option :value="0" label="自动完成任务"></el-option>
              <el-option :value="1" label="未激活任务"></el-option>
              <el-option :value="2" label="普通任务"></el-option>
              <el-option :value="3" label="世界任务"></el-option>
            </el-select>
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
          <el-form-item label="等级">
            <el-input-number
              v-model="questTemplate.QuestLevel"
              controls-position="right"
              placeholder="QuestLevel"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最低等级">
            <el-input-number
              v-model="questTemplate.MinLevel"
              controls-position="right"
              placeholder="MinLevel"
            ></el-input-number>
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
          <el-form-item label="标识">
            <flag-editor
              title="标识编辑器"
              v-model="questTemplate.Flags"
              :flags="flags"
              placeholder="Flags"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="开始物品">
            <item-template-selector
              v-model="questTemplate.StartItem"
              placeholder="StartItem"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="建议队伍人数">
            <el-input-number
              v-model="questTemplate.SuggestedGroupNum"
              controls-position="right"
              placeholder="SuggestedGroupNum"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="时间限制">
            <el-input-number
              v-model="questTemplate.TimeAllowed"
              controls-position="right"
              placeholder="TimeAllowed"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要击杀玩家">
            <el-input-number
              v-model="questTemplate.RequiredPlayerKills"
              controls-position="right"
              placeholder="RequiredPlayerKills"
            ></el-input-number>
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
          <el-form-item label="详情">
            <quest-template-details-localizer
              v-model="questTemplate.QuestDescription"
              placeholder="QuestDescription"
            ></quest-template-details-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="目标描述">
            <quest-template-objectives-localizer
              v-model="questTemplate.LogDescription"
              placeholder="LogDescription"
            ></quest-template-objectives-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="结束描述">
            <quest-template-end-text-localizer
              v-model="questTemplate.AreaDescription"
              placeholder="AreaDescription"
            ></quest-template-end-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="完成描述">
            <quest-template-completed-text-localizer
              v-model="questTemplate.QuestCompletionLog"
              placeholder="QuestCompletionLog"
            ></quest-template-completed-text-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="目标">
            <quest-template-objective-text1-localizer
              v-model="questTemplate.ObjectiveText1"
              placeholder="ObjectiveText1"
            ></quest-template-objective-text1-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="目标">
            <quest-template-objective-text2-localizer
              v-model="questTemplate.ObjectiveText2"
              placeholder="ObjectiveText2"
            ></quest-template-objective-text2-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="目标">
            <quest-template-objective-text3-localizer
              v-model="questTemplate.ObjectiveText3"
              placeholder="ObjectiveText3"
            ></quest-template-objective-text3-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="目标">
            <quest-template-objective-text4-localizer
              v-model="questTemplate.ObjectiveText4"
              placeholder="ObjectiveText4"
            ></quest-template-objective-text4-localizer>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="物品掉落">
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
          <el-form-item label="物品掉落">
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
          <el-form-item label="物品掉落">
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
          <el-form-item label="物品掉落">
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
          <el-form-item label="需要声望">
            <faction-selector
              v-model="questTemplate.RequiredFactionId1"
              placeholder="RequiredFactionId1"
            ></faction-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="questTemplate.RequiredFactionValue1"
              controls-position="right"
              placeholder="RequiredFactionValue1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要声望">
            <faction-selector
              v-model="questTemplate.RequiredFactionId2"
              placeholder="RequiredFactionId2"
            ></faction-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="questTemplate.RequiredFactionValue2"
              controls-position="right"
              placeholder="RequiredFactionValue2"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="需要生物或物体">
            <el-input
              v-model="questTemplate.RequiredNpcOrGo1"
              placeholder="RequiredNpcOrGo1"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="questTemplate.RequiredNpcOrGoCount1"
              controls-position="right"
              placeholder="RequiredNpcOrGoCount1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要生物或物体">
            <el-input
              v-model="questTemplate.RequiredNpcOrGo2"
              placeholder="RequiredNpcOrGo2"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="questTemplate.RequiredNpcOrGoCount2"
              controls-position="right"
              placeholder="RequiredNpcOrGoCount2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要生物或物体">
            <el-input
              v-model="questTemplate.RequiredNpcOrGo3"
              placeholder="RequiredNpcOrGo3"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="questTemplate.RequiredNpcOrGoCount3"
              controls-position="right"
              placeholder="RequiredNpcOrGoCount3"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要生物或物体">
            <el-input
              v-model="questTemplate.RequiredNpcOrGo4"
              placeholder="RequiredNpcOrGo4"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="questTemplate.RequiredNpcOrGoCount4"
              controls-position="right"
              placeholder="RequiredNpcOrGoCount4"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
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
          <el-form-item label="奖励经验难度">
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
          <el-form-item label="奖励额外金钱">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardBonusMoney"
              placeholder="RewardBonusMoney"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励头衔">
            <char-title-selector
              v-model="questTemplate.RewardTitle"
              placeholder="RewardTitle"
            ></char-title-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励下一个任务">
            <quest-template-selector
              v-model="questTemplate.RewardNextQuest"
              placeholder="RewardNextQuest"
            ></quest-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励法术">
            <spell-selector
              v-model="questTemplate.RewardSpell"
              placeholder="RewardSpell"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励施放法术">
            <spell-selector
              v-model="questTemplate.RewardDisplaySpell"
              placeholder="RewardDisplaySpell"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励竞技场点数">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardArenaPoints"
              placeholder="RewardArenaPoints"
            ></el-input-number>
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
          <el-form-item label="奖励击杀荣誉">
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
          <el-form-item>
            <hint-label
              label="奖励声望"
              :tooltip="rewardFactionIdTooltip"
              slot="label"
            ></hint-label>
            <faction-selector
              v-model="questTemplate.RewardFactionID1"
              placeholder="RewardFactionID1"
            ></faction-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="声望值"
              :tooltip="rewardFactionValueIdTooltip"
              slot="label"
            ></hint-label>
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue1"
              placeholder="RewardFactionValue1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="覆盖"
              :tooltip="rewardFactionValueIdOverrideTooltip"
              slot="label"
            ></hint-label>
            <el-input-number
              v-model="questTemplate.RewardFactionOverride1"
              controls-position="right"
              placeholder="RewardFactionOverride1"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="奖励声望">
            <faction-selector
              v-model="questTemplate.RewardFactionID2"
              placeholder="RewardFactionID2"
            ></faction-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="声望值">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue2"
              placeholder="RewardFactionValue2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="覆盖">
            <el-input-number
              v-model="questTemplate.RewardFactionOverride2"
              controls-position="right"
              placeholder="RewardFactionOverride2"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="奖励声望">
            <faction-selector
              v-model="questTemplate.RewardFactionID3"
              placeholder="RewardFactionID3"
            ></faction-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="声望值">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue3"
              placeholder="RewardFactionValue3"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="覆盖">
            <el-input-number
              v-model="questTemplate.RewardFactionOverride3"
              controls-position="right"
              placeholder="RewardFactionOverride3"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="奖励声望">
            <faction-selector
              v-model="questTemplate.RewardFactionID4"
              placeholder="RewardFactionID4"
            ></faction-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="声望值">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue4"
              placeholder="RewardFactionValue4"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="覆盖">
            <el-input-number
              v-model="questTemplate.RewardFactionOverride4"
              controls-position="right"
              placeholder="RewardFactionOverride4"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="奖励声望">
            <faction-selector
              v-model="questTemplate.RewardFactionID5"
              placeholder="RewardFactionID5"
            ></faction-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="声望值">
            <el-input-number
              controls-position="right"
              v-model="questTemplate.RewardFactionValue5"
              placeholder="RewardFactionValue5"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="覆盖">
            <el-input-number
              v-model="questTemplate.RewardFactionOverride5"
              controls-position="right"
              placeholder="RewardFactionOverride5"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="地图">
            <el-input
              v-model="questTemplate.POIContinent"
              placeholder="POIContinent"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="X坐标">
            <el-input-number
              v-model="questTemplate.POIx"
              controls-position="right"
              placeholder="POIx"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Y坐标">
            <el-input-number
              v-model="questTemplate.POIy"
              controls-position="right"
              placeholder="POIy"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="优先级">
            <el-input
              v-model="questTemplate.POIPriority"
              placeholder="POIPriority"
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
import {
  flags,
  rewardFactionIdTooltip,
  rewardFactionValueIdTooltip,
  rewardFactionValueIdOverrideTooltip,
} from "@/locales/quest";
import { mapState, mapActions } from "vuex";
import HintLabel from "@/components/HintLabel";
import QuestTemplateTitleLocalizer from "@/views/Quest/components/QuestTemplateTitleLocalizer";
import QuestTemplateDetailsLocalizer from "@/views/Quest/components/QuestTemplateDetailsLocalizer";
import QuestTemplateObjectivesLocalizer from "@/views/Quest/components/QuestTemplateObjectivesLocalizer";
import QuestTemplateEndTextLocalizer from "@/views/Quest/components/QuestTemplateEndTextLocalizer";
import QuestTemplateCompletedTextLocalizer from "@/views/Quest/components/QuestTemplateCompletedTextLocalizer";
import QuestTemplateObjectiveText1Localizer from "@/views/Quest/components/QuestTemplateObjectiveText1Localizer";
import QuestTemplateObjectiveText2Localizer from "@/views/Quest/components/QuestTemplateObjectiveText2Localizer";
import QuestTemplateObjectiveText3Localizer from "@/views/Quest/components/QuestTemplateObjectiveText3Localizer";
import QuestTemplateObjectiveText4Localizer from "@/views/Quest/components/QuestTemplateObjectiveText4Localizer";
import ItemTemplateSelector from "@/components/ItemTemplateSelector";
import QuestTemplateSelector from "@/components/QuestTemplateSelector";
import SpellSelector from "@/components/SpellSelector";
import FactionSelector from "@/components/FactionSelector";
import FlagEditor from "@/components/FlagEditor";
import CharTitleSelector from "@/components/CharTitleSelector.vue";

export default {
  data() {
    return {
      flags: flags,
      rewardFactionIdTooltip: rewardFactionIdTooltip,
      rewardFactionValueIdTooltip: rewardFactionValueIdTooltip,
      rewardFactionValueIdOverrideTooltip: rewardFactionValueIdOverrideTooltip,
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
    HintLabel,
    FlagEditor,
    QuestTemplateTitleLocalizer,
    QuestTemplateDetailsLocalizer,
    QuestTemplateObjectivesLocalizer,
    QuestTemplateEndTextLocalizer,
    QuestTemplateCompletedTextLocalizer,
    QuestTemplateObjectiveText1Localizer,
    QuestTemplateObjectiveText2Localizer,
    QuestTemplateObjectiveText3Localizer,
    QuestTemplateObjectiveText4Localizer,
    ItemTemplateSelector,
    QuestTemplateSelector,
    SpellSelector,
    FactionSelector,
    CharTitleSelector,
  },
};
</script>
