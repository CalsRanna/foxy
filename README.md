# Foxy - 做最好的魔兽世界编辑器

Foxy 是一个专为魔兽世界私服开发设计的桌面级数据库管理工具，提供直观易用的界面来管理游戏数据。支持 Windows、macOS 和 Linux 平台。

## 🎯 核心功能

### 📊 数据管理
- **生物模板管理** - 创建、编辑和管理生物(NPC)数据
- **物品模板管理** - 完整的物品数据库编辑功能
- **任务模板管理** - 任务系统设计和管理
- **游戏对象管理** - 游戏世界中的物体管理
- **对话菜单管理** - NPC对话和交互菜单
- **智能脚本管理** - 高级AI脚本和行为逻辑

### 🔧 技术特性
- **MySQL数据库连接** - 直接连接魔兽世界数据库
- **本地配置存储** - 使用Isar进行本地设置加密存储
- **响应式状态管理** - 基于Signals的现代状态管理
- **类型安全路由** - 使用AutoRoute进行导航管理
- **桌面级体验** - 专为桌面环境优化的UI设计

### 🚀 快速开始

#### 环境要求
- Flutter 3.7.2 或更高版本
- MySQL服务器 (支持魔兽世界数据库)
- Windows 10+/macOS 10.15+/Linux Ubuntu 18.04+

#### 安装步骤

1. **克隆项目**
```bash
git clone https://github.com/CalsRanna/foxy.git
cd foxy
```

2. **安装依赖**
```bash
flutter pub get
flutter pub run build_runner build
```

3. **运行应用**
```bash
# Windows/macOS/Linux桌面
flutter run -d windows  # Windows
flutter run -d macos   # macOS
flutter run -d linux   # Linux
```

4. **首次配置**
启动应用后，通过引导界面配置数据库连接：
- 数据库主机地址
- 端口号 (默认3306)
- 数据库名称
- 用户名和密码

#### 构建发布版本

```bash
# Windows
flutter build windows

# macOS
flutter build macos

# Linux
flutter build linux
```

### 🏗️ 项目架构

#### 技术栈
- **Flutter** - 跨平台UI框架
- **Signals** - 响应式状态管理 (从Riverpod迁移)
- **AutoRoute** - 类型安全路由管理
- **MySQL** - 主数据库连接
- **Isar** - 本地NoSQL数据库
- **GetIt** - 依赖注入容器

#### 目录结构
```
lib/
├── page/           # 功能页面
│   ├── bootstrap/  # 初始化引导
│   ├── dashboard/  # 主工作台
│   ├── creature/   # 生物管理
│   ├── item/       # 物品管理
│   ├── quest/      # 任务管理
│   ├── game_object/# 游戏对象
│   ├── gossip_menu/# 对话菜单
│   ├── smart_script/# 智能脚本
│   └── setting/    # 设置页面
├── service/        # 业务逻辑层
├── model/          # 数据模型
├── provider/       # 状态管理 (Signals)
├── schema/         # 数据库模式
├── router/         # 路由配置
└── util/           # 工具类
```

### 🎮 功能模块详解

#### 1. 生物模板管理 (Creature Template)
- 生物基础属性编辑
- 掉落表管理
- 技能和行为配置
- 刷新点和路径设置

#### 2. 物品模板管理 (Item Template)
- 物品属性编辑
- 掉落来源管理
- 合成配方配置
- 装备属性设置

#### 3. 任务模板管理 (Quest Template)
- 任务链设计
- 奖励配置
- 前置条件设置
- 任务目标定义

#### 4. 智能脚本系统 (Smart Script)
- AI行为逻辑设计
- 事件响应系统
- 条件判断和动作执行
- 复杂的NPC交互逻辑

### 🛠️ 开发指南

#### 添加新功能模块
1. 创建对应的页面组件
2. 定义数据模型
3. 实现服务层逻辑
4. 配置路由和状态管理
5. 添加UI组件和交互

#### 数据库操作
```dart
// 示例：查询生物模板
final result = await creatureService.query(
  where: 'entry = ?',
  whereArgs: [1234],
);
```

#### 状态管理示例
```dart
// 使用Signals创建响应式状态
final counter = signal(0);
final isEven = computed(() => counter.value % 2 == 0);
```

### 🤝 贡献指南

我们欢迎社区贡献！请遵循以下步骤：

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

### 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

### 🙋‍♂️ 支持与联系

- **GitHub Issues**: [提交问题](https://github.com/CalsRanna/foxy/issues)
- **讨论区**: [GitHub Discussions](https://github.com/CalsRanna/foxy/discussions)
- **QQ群**: 123456789 (魔兽世界开发群)

### 🌟 致谢

感谢所有为魔兽世界私服开发社区做出贡献的开发者们！

---

**Foxy** - 让魔兽世界私服开发更简单、更高效！