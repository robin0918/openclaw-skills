# OpenClaw Skills 中文说明
# 技能管理和记录文档

## 📊 技能来源说明

### 三种来源

| 来源 | 存储路径 | 特点 |
|------|----------|--------|
| **Bundled** | `C:\Users\Administrator\AppData\Roaming\npm\node_modules\openclaw\skills\` | OpenClaw 官方自带，稳定可靠，无法修改 |
| **Managed** | `C:\Users\Administrator\.openclaw\skills\` | OpenClaw 官方托管，持续更新，需外部依赖 |
| **Workspace** | `C:\Users\Administrator\.openclaw\workspace\skills\` | 用户自定义工作区，完全掌控 |

---

## 📂 技能功能分类

### 1. 工具/平台集成类 (7 个)

**Bundled (3 个)**
| 技能 | 描述 | 依赖 |
|------|--------|------|
| bluebubbles | BlueBubbles 外部通道插件 | - |
| coding-agent | Codex/Claude Code/OpenCode/Pi Coding Agent 后台进程 | - |
| skill-creator | 创建有效技能的指南工具 | - |

**Managed (4 个)**
| 技能 | 描述 | 依赖 |
|------|--------|------|
| claude-code-local | Claude Code 本地集成 | Claude CLI |
| find-skills | 技能查找安装 | ClawdHub CLI |
| video-subtitles | 视频字幕生成 | Whisper API |
| web-search-plus | 多源智能搜索 | Serper/Tavily/Exa API |
| websearch-standard | 标准多源搜索 | - |

---

### 2. 内容创作类 (5 个) - 全部 Workspace

| 技能 | 描述 |
|------|--------|
| social-content | LinkedIn/Twitter/Instagram/TikTok/Facebook 社交内容创作 |
| marketing-ideas | SaaS/软件产品营销创意和策略 |
| slack-gif-creator | Slack 动画 GIF 创建工具 |
| algorithmic-art | 使用 p5.js 创建算法艺术 |
| canvas-design | 创建视觉艺术 .png 和 .pdf 文档 |
| theme-factory | 工件主题样式工具包 |

---

### 3. 数据分析类 (3 个) - 全部 Managed

| 技能 | 描述 |
|------|--------|
| apify-influencer-discovery | Apify 达人发现、验证真实性、跟踪合作表现 | Spotify API |
| influencer-analyzer | 分析 Instagram/YouTube/TikTok 网红账号数据 | Instagram API |
| influencer-evaluator | 评估 Instagram/YouTube/TikTok 网红综合评分 | Topol API |

---

### 4. 文档处理类 (4 个) - 全部 Workspace

| 技能 | 描述 |
|------|--------|
| docx | Word 文档创建、编辑、分析 |
| pdf | PDF 文本提取、表格处理、合并/拆分 |
| pptx | PPTX 演示文稿创建、编辑、分析 |
| xlsx | Excel 表格创建、编辑、分析 |

---

### 5. 开发工具类 (4 个) - 全部 Workspace

| 技能 | 描述 |
|------|--------|
| mcp-builder | 创建高质量 MCP 服务器（Python/Node/TypeScript） |
| web-artifacts-builder | 创建复杂 Claude AI HTML 工件（React/Tailwind） |
| webapp-testing | Playwright 网页应用测试工具 |
| template-skill | 技能模板描述 |

---

### 6. 营销/商务类 (4 个) - 全部 Workspace

| 技能 | 描述 |
|------|--------|
| content-marketing | 内容营销策略指导 |
| ecommerce-platform-specialist | Shopify 电商平台专家指导 |
| ecommerce-seo-audit | 电商 SEO 审计，产品页面优化 |
| Shipping-logistics | 英/美/加物流、海关、关税专家 |

---

### 7. 设计/艺术/品牌类 (3 个) - 全部 Workspace

| 技能 | 描述 |
|------|--------|
| brand-guidelines | 应用 Anthropic 官方品牌颜色和排版 |
| frontend-design | 创建高质量前端界面 |
| internal-comms | 内部通讯资源库模板 |

---

### 8. 基础/核心类 (7 个) - 全部 Workspace

| 技能 | 描述 |
|------|--------|
| customer-service | 全方位客户服务支持 |
| doc-coauthoring | 指导用户完成文档协作工作流程 |
| influencer-marketing | Instagram/YouTube/TikTok 网红营销专家 |
| influencer-outreach-template | Instagram/YouTube/TikTok 网红合作模板 |
| internationalization-i18n | 实现 i18n 国际化和本地化 |

---

## 📝 技能安装/卸载记录

### 安装记录模板

```yaml
# YYYY-MM-DD

## 新增技能
- name: [skill-name]
  description: [技能描述]
  category: [分类]
  source: [Bundled/Managed/Workspace]
  installed_at: [安装时间]
```

### 卸载记录模板

```yaml
# YYYY-MM-DD

## 卸载技能
- name: [skill-name]
  uninstalled_at: [卸载时间]
  reason: [卸载原因]
```

---

## 🔧 快捷命令

```bash
# 查看所有技能
openclaw skills list

# 检查技能状态
openclaw skills check

# 查看某个技能详情
openclaw skills info <skill-name>

# 重启 gateway 应用新配置
openclaw gateway --force
```

---

## 📂 Git 仓库

| 仓库地址 | 说明 |
|----------|--------|
| https://github.com/robin0918/openclaw-skills | OpenClaw 技能配置文档 |

---

## 📝 技能更新记录

### 2026-02-01

**优化完成**: skill-creator 触发条件已优化

添加了中文触发关键词，让 OpenClaw 更智能识别何时使用 skill-creator：
- "创建技能" / "create skill" / "new skill"
- "新建技能" / "new skill" / "add skill"
- "开发技能" / "develop skill" / "build skill"
- "写一个技能" / "write a skill" / "add a new skill"
- "做一个技能" / "create a skill" / "make a skill"
- "技能配置" / "skill config" / "configure skill"
- "修改技能" / "edit skill" / "update skill"
- "技能模板" / "skill template" / "use skill template"
- "初始化技能" / "init skill" / "initialize skill"
- "打包技能" / "package skill"
- "SKILL.md" (编辑 SKILL.md 文件本身)

---

*最后更新时间: 2026-02-01*
