<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
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
      <el-col :span="6">
        <el-card
          :style="{
            marginTop: '16px',
            minHeight: `${calculateMaxHeight() - 18}px`,
            maxHeight: `${calculateMaxHeight() - 18}px`,
            overflow: 'auto',
          }"
        >
          <el-input
            placeholder="输入关键字进行筛选"
            v-model="credential"
            clearable
          >
          </el-input>

          <el-tree
            :data="nodes"
            :props="defaultProps"
            default-expand-all
            node-key="key"
            highlight-current
            :filter-node-method="filterNode"
            :expand-on-click-node="false"
            :current-node-key="currentNodeKey"
            ref="tree"
            @node-click="handleClick"
            style="margin-top: 20px"
          >
          </el-tree>
        </el-card>
      </el-col>
      <el-col :span="18">
        <el-row :gutter="16">
          <el-col
            :span="8"
            v-for="module of modules"
            :key="`${module.subtitle}-card`"
          >
            <el-card
              shadow="hover"
              class="clickable-card"
              style="margin-top: 16px"
              @click.native="() => navigate(`/${module.key}`)"
            >
              <p class="summary-title">
                {{ module.title }}
                <span>{{ module.subtitle }}</span>
              </p>
              <p class="summary-content">{{ module.description }}</p>
            </el-card>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  data() {
    return {
      credential: "",
      defaultProps: {
        children: "children",
        label: (data) => `${data.title} ${data.subtitle}`,
      },
      checkedKeys: ["database", "dbc"],
      currentNodeKey: null,
      nodes: [
        {
          title: "数据库",
          subtitle: "",
          key: "database",
          children: [
            {
              title: "页面文本",
              subtitle: "Page Text",
              description: "书籍的内容",
              key: "page-text",
            },
            {
              title: "关联掉落",
              subtitle: "Reference Loot Template",
              description: "关联掉落数据",
              key: "reference-loot",
            },
          ],
        },
        {
          title: "DBC",
          subtitle: "",
          key: "dbc",
          children: [
            {
              title: "成就",
              subtitle: "Achievement",
              description: "游戏成就的详细信息及条件",
              key: "achievement",
            },
            {
              title: "区域",
              subtitle: "Area Table",
              description: "游戏中的所有区域",
              key: "area-table",
            },
            {
              title: "货币",
              subtitle: "Currency",
              description: "除金币外的其他货币",
              key: "currency",
            },
            {
              title: "表情文本",
              subtitle: "Emotes Text",
              description: "表情的文本",
              key: "emote-text",
            },
            {
              title: "扩展价格",
              subtitle: "Item Extended Cost",
              description: "购买物品时需要的其他货币",
              key: "item-extended-cost",
            },
            {
              title: "套装",
              subtitle: "Item Set",
              description: "套装的部件及奖励",
              key: "item-set",
            },
            {
              title: "任务声望奖励",
              subtitle: "Quest Faction Reward",
              description: "任务奖励的声望值",
              key: "quest-faction-reward",
            },
            {
              title: "任务信息",
              subtitle: "Quest Info",
              description: "任务的分类信息",
              key: "quest-info",
            },
            {
              title: "任务排序",
              subtitle: "Quest Sort",
              description: "任务的另一部分分类信息",
              key: "quest-sort",
            },
            {
              title: "缩放属性分配",
              subtitle: "Scaling Stat Distribution",
              description: "用于设定传家宝的具体属性分配规则",
              key: "scaling-stat-distribution",
            },
            {
              title: "缩放属性值",
              subtitle: "Scaling Stat Value",
              description: "每个等级的属性基准值",
              key: "scaling-stat-value",
            },
            {
              title: "附魔属性",
              subtitle: "Spell Item Enchantment",
              description: "物品的附魔对应的技能",
              key: "spell-item-enchantment",
            },
            {
              title: "天赋",
              subtitle: "Talent",
              description: "天赋页面的技能",
              key: "talent",
            },
            {
              title: "天赋页",
              subtitle: "Talent Tab",
              description: "天赋的分类信息",
              key: "talent-tab",
            },
          ],
        },
      ],
      modules: [],
    };
  },
  computed: {
    ...mapState("app", ["version", "clientHeight"]),
  },
  watch: {
    credential(value) {
      this.$refs.tree.filter(value);
    },
  },
  methods: {
    filterNode(value, data) {
      if (!value) {
        return true;
      } else {
        return (
          data.title.toLowerCase().indexOf(value.toLowerCase()) !== -1 ||
          data.subtitle.toLowerCase().indexOf(value.toLowerCase()) !== -1
        );
      }
    },
    handleClick(data, b, c) {
      if (this.currentNodeKey === data.key) {
        this.currentNodeKey = null;
        this.$refs.tree.setCurrentKey(null);
      } else {
        this.currentNodeKey = data.key;
      }
      this.generateModules(this.currentNodeKey);
    },
    calculateMaxHeight() {
      return this.clientHeight - 154;
    },
    navigate(key) {
      this.$router.push(key);
    },
    generateModules(key) {
      let flattedNodes = [].concat(
        this.nodes[0].children,
        this.nodes[1].children
      );
      let nodes = [];
      if (key === null) {
        nodes = flattedNodes;
      } else if (["database", "dbc"].includes(key)) {
        let index = ["database", "dbc"].indexOf(key);
        nodes = this.nodes[index].children;
      } else {
        for (let node of flattedNodes) {
          if (node.key === key) {
            nodes.push(node);
          }
        }
      }
      nodes.sort((a, b) => {
        let keyA = a.key.toLowerCase();
        let keyB = b.key.toLowerCase();
        if (keyA > keyB) {
          return 1;
        }
        if (keyA < keyB) {
          return -1;
        }
        return 0;
      });
      this.modules = nodes;
    },
  },
  mounted() {
    let currentKey = this.$refs.tree.getCurrentKey();
    this.generateModules(currentKey);
  },
};
</script>
