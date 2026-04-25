# Roo Code DeepSeek Enhancement Patches | 为你的roocode启用deepseekv4模型

**中文** | [English](#english)

---

<a id="english"></a>

## 🇨🇳 中文

为 Roo Code 的 **DeepSeek 提供商** 添加自定义 Model ID、Base URL、上下文窗口、最大输出 Token 等高级选项，并修复自定义模型启用 thinking mode 的问题。

> 🎯 **核心思路**：不修改 OpenAI Compatible，直接增强 DeepSeek 专用提供商。DeepSeekHandler 后端已原生支持所有功能，唯一缺失的是 UI 输入框和一个编译检测条件。

### 📦 补丁清单

| # | 补丁 | 作用 |
|---|------|------|
| 1 | `patch-deepseek-ui.cjs` | DeepSeek 设置页添加 **Model ID** + **Base URL** 输入框 |
| 2 | `patch-deepseek-thinking.cjs` | 修复自定义模型 ID 的 **thinking mode** 检测 |
| 3 | `patch-deepseek-options.cjs` | 添加 **Context Window** + **Max Output Tokens** 高级选项 |

### 🚀 快速开始

```bash
node patch-deepseek-ui.cjs
node patch-deepseek-thinking.cjs
node patch-deepseek-options.cjs
# 重启 VS Code
```

### ⚙️ 配置

Roo Code 设置 → API 提供商 → **DeepSeek**

| 字段 | 示例 | 说明 |
|------|------|------|
| **API Key** | `sk-xxxxxxxx` | DeepSeek API 密钥 |
| **Model ID** | `deepseek-v4-flash` | 自定义模型 ID |
| **Base URL** | `https://api.deepseek.com` | API 端点（可选） |
| **Context Window** | `1000000` | 上下文窗口大小（V4 支持最大 1M） |
| **Max Output Tokens** | `65536` | 最大输出 Token 数 |

### 🔧 补丁说明

**补丁 1：** DeepSeek 原本只有 Model ID 下拉框（固定选项），无 Base URL 输入框。后端 `DeepSeekHandler` 早已支持 `apiModelId` 和 `deepSeekBaseUrl`，仅 UI 未暴露。

**补丁 2：** 源码中 `isThinkingModel` 检查 `deepseek-reasoner` **和** `deepseek-v4`，但编译后只保留了前者，导致自定义模型 ID 报 400 错误。补丁恢复了缺失的条件。

**补丁 3：** 添加自定义上下文窗口和最大输出 Token 选项。DeepSeek V4 支持最大 1M 上下文窗口，但默认硬编码为 128K。此补丁修改 UI 和后端，允许用户自定义这些值。同时隐藏了原有的 Model Picker 下拉菜单（避免与 Model ID 文本框冲突），通过将 `"deepseek"` 加入 `kco` 排除列表实现。

### 🧠 交错思考

同轮次内保留 `reasoning_content`，跨轮次自动清除（DeepSeek API 设计）。

---

## 🇬🇧 English

Enhance Roo Code's **DeepSeek provider** with custom Model ID, Base URL, Context Window, Max Output Tokens, and fix thinking mode detection for custom model IDs.

> 🎯 **Core idea**: Instead of modifying OpenAI Compatible, enhance the DeepSeek-specific provider. The `DeepSeekHandler` backend already natively supports all features — only the UI inputs and a compiled check were missing.

### 📦 Patches

| # | Patch | Purpose |
|---|-------|---------|
| 1 | `patch-deepseek-ui.cjs` | Adds **Model ID** + **Base URL** inputs to DeepSeek settings |
| 2 | `patch-deepseek-thinking.cjs` | Fixes **thinking mode** detection for custom model IDs |
| 3 | `patch-deepseek-options.cjs` | Adds **Context Window** + **Max Output Tokens** advanced options |

### 🚀 Quick Start

```bash
node patch-deepseek-ui.cjs
node patch-deepseek-thinking.cjs
node patch-deepseek-options.cjs
# Restart VS Code
```

### ⚙️ Configuration

Roo Code Settings → API Provider → **DeepSeek**

| Field | Example | Description |
|-------|---------|-------------|
| **API Key** | `sk-xxxxxxxx` | DeepSeek API key |
| **Model ID** | `deepseek-v4-flash` | Custom model ID |
| **Base URL** | `https://api.deepseek.com` | API endpoint (optional) |
| **Context Window** | `1000000` | Context window size (V4 supports up to 1M) |
| **Max Output Tokens** | `65536` | Maximum output token count |

### 🔧 How It Works

**Patch 1:** The DeepSeek settings UI originally only had a Model ID dropdown (fixed options) and no Base URL field. The backend `DeepSeekHandler` already supported `apiModelId` and `deepSeekBaseUrl` — just the UI was missing.

**Patch 2:** The TypeScript source checks both `deepseek-reasoner` **and** `deepseek-v4` for thinking mode, but the compiled `extension.js` only kept the first condition. This caused HTTP 400 errors when using custom model IDs like `deepseek-v4-flash`.

**Patch 3:** Adds custom Context Window and Max Output Tokens options. DeepSeek V4 supports up to 1M context window, but defaults are hardcoded to 128K. This patch modifies both UI and backend to allow users to customize these values. It also hides the original Model Picker dropdown (to avoid conflicts with the Model ID text input) by adding `"deepseek"` to the `kco` exclusion list.

### 🧠 Interleaved Thinking

`reasoning_content` is preserved within the same turn (across tool calls) and cleared on new user messages — by DeepSeek API design.

---

## 📁 Files

| File | Description |
|------|-------------|
| `patch-deepseek-ui.cjs` | UI patch: Model ID + Base URL inputs |
| `patch-deepseek-thinking.cjs` | Backend patch: thinking mode fix |
| `patch-deepseek-options.cjs` | Advanced options: Context Window + Max Output Tokens |
| `plan.md` | Technical design document |
