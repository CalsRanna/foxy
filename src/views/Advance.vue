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
          @click.native="() => navigate('/scaling-stat-distribution')"
        >
          <p class="summary-title">
            缩放属性分配<span>Scaling Stat Distribution</span>
          </p>
          <p class="summary-content">用于设定传家宝的具体属性分配规则</p>
        </el-card>
      </el-col>
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
          @click.native="() => navigate('/talent')"
        >
          <p class="summary-title">天赋<span>Talent</span></p>
          <p class="summary-content">天赋页面的技能</p>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="16" style="margin-top: 16px">
      <el-col :span="6">
        <el-card
          shadow="hover"
          class="clickable-card"
          @click.native="() => navigate('/talent-tab')"
        >
          <p class="summary-title">天赋页<span>Talent</span></p>
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
