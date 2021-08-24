<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>高级</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">高级</h3>
    </el-card>
    <el-row
      :gutter="16"
      :style="{
        maxHeight: `${calculateMaxHeight()}px`,
        overflow: 'auto',
      }"
    >
      <el-col :span="6" v-for="module of modules" :key="`${module.subtitle}-card`">
        <el-card
          shadow="hover"
          class="clickable-card"
          style="margin-top: 16px"
          @click.native="() => navigate(`/${module.route}`)"
        >
          <p class="summary-title">
            {{ module.title }}
            <span>{{ module.subtitle }}</span>
          </p>
          <p class="summary-content">{{ module.description }}</p>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  data() {
    return {
      modules: [{
        title: '成就',
        subtitle: 'Achievement',
        description: '游戏成就的详细信息及条件',
        route: 'achievement'
      }, {
        title: '区域',
        subtitle: 'Area Table',
        description: '游戏中的所有区域',
        route: 'area-table'
      }, {
        title: '货币',
        subtitle: 'Currency',
        description: '除金币外的其他货币',
        route: 'currency'
      }, {
        title: '表情文本',
        subtitle: 'Emotes Text',
        description: '表情的文本',
        route: 'emote-text'
      }, {
        title: '扩展价格',
        subtitle: 'Item Extended Cost',
        description: '购买物品时需要的其他货币',
        route: 'item-extended-cost'
      }, {
        title: '套装',
        subtitle: 'Item Set',
        description: '套装的部件及奖励',
        route: 'item-set'
      }, {
        title: '页面文本',
        subtitle: 'Page Text',
        description: '书籍的内容',
        route: 'page-text'
      }, {
        title: '任务声望奖励',
        subtitle: 'Quest Faction Reward',
        description: '任务奖励的声望值',
        route: 'quest-faction-reward'
      }, {
        title: '任务信息',
        subtitle: 'Quest Info',
        description: '任务的分类信息',
        route: 'quest-info'
      }, {
        title: '任务排序',
        subtitle: 'Quest Sort',
        description: '任务的另一部分分类信息',
        route: 'quest-sort'
      }, {
        title: '关联掉落',
        subtitle: 'Reference Loot Template',
        description: '关联掉落数据',
        route: 'reference-loot'
      }, {
        title: '缩放属性分配',
        subtitle: 'Scaling Stat Distribution',
        description: '用于设定传家宝的具体属性分配规则',
        route: 'scaling-stat-distribution'
      }, {
        title: '缩放属性值',
        subtitle: 'Scaling Stat Value',
        description: '每个等级的属性基准值',
        route: 'scaling-stat-value'
      }, {
        title: '附魔属性',
        subtitle: 'Spell Item Enchantment',
        description: '物品的附魔属性',
        route: 'spell-item-enchantment'
      }, {
        title: '天赋',
        subtitle: 'Talent',
        description: '天赋页面的技能',
        route: 'talent'
      }, {
        title: '天赋页',
        subtitle: 'Talent Tab',
        description: '天赋的分类信息',
        route: 'talent-tab'
      }]
    }
  },
  computed: {
    ...mapState("app", ["version", "clientHeight"]),
  },
  methods: {
    calculateMaxHeight() {
      return this.clientHeight - 154;
    },
    navigate(route) {
      this.$router.push(route);
    },
  },
};
</script>
