<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item>高级</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">高级</h3>
    </el-card>
    <el-row :gutter="16" style="margin-top: 16px">
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/area-table')"
        >
          <p class="summary-title">区域<span>Area Table</span></p>
          <p class="summary-content">游戏中的所有区域</p>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/emote-text')"
        >
          <p class="summary-title">表情文本<span>Emote Text</span></p>
          <p class="summary-content">表情的文本</p>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/item-set')"
        >
          <p class="summary-title">套装<span>Item Set</span></p>
          <p class="summary-content">套装的部件及奖励</p>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/quest-faction-reward')"
        >
          <p class="summary-title">
            任务声望奖励<span>Quest Faction Reward</span>
          </p>
          <p class="summary-content">任务奖励的声望值</p>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="16" style="margin-top: 16px">
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/quest-info')"
        >
          <p class="summary-title">任务信息<span>Quest Info</span></p>
          <p class="summary-content">任务的分类信息</p>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/quest-sort')"
        >
          <p class="summary-title">任务排序<span>Quest Sort</span></p>
          <p class="summary-content">任务的另一部分分类信息</p>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/reference-loot')"
        >
          <p class="summary-title">
            关联掉落<span>Reference Loot Template</span>
          </p>
          <p class="summary-content">关联掉落数据</p>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/scaling-stat-distribution')"
        >
          <p class="summary-title">
            缩放属性分配<span>Scaling Stat Distribution</span>
          </p>
          <p class="summary-content">用于设定传家宝的具体属性分配规则</p>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="16" style="margin-top: 16px">
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/scaling-stat-value')"
        >
          <p class="summary-title">缩放属性值<span>Scaling Stat Value</span></p>
          <p class="summary-content">每个等级的属性具体值</p>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/talent')"
        >
          <p class="summary-title">天赋<span>Talent</span></p>
          <p class="summary-content">天赋页面的技能</p>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/talent-tab')"
        >
          <p class="summary-title">天赋页<span>Talent Tab</span></p>
          <p class="summary-content">天赋页的相关信息</p>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  methods: {
    navigate(route) {
      this.$router.push(route);
    },
  },
};
</script>
