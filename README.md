# free-code

Claude Code 自由构建版。去除了遥测、去除了限制、开启了所有实验功能。

---

## 快速开始

### Windows

```powershell
# 1. 克隆仓库
git clone https://github.com/Cypher-Daya/freecode.git
cd freecode

# 2. 安装依赖
bun install

# 3. 编译
bun run build

# 4. 运行
.\cli.exe
```

### Linux / macOS

```bash
# 1. 克隆仓库
git clone https://github.com/Cypher-Daya/freecode.git
cd freecode

# 2. 安装依赖
bun install

# 3. 编译
bun run build

# 4. 运行
./cli
```

---

## 一键安装（Linux / macOS）

```bash
curl -fsSL https://raw.githubusercontent.com/Cypher-Daya/freecode/main/install.sh | bash
```

---

## 使用方法

```bash
# 设置 API Key（使用第三方 API 如 MiniMax）
$env:ANTHROPIC_API_KEY="your_api_key"           # Windows PowerShell
$env:ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"  # Windows
export ANTHROPIC_API_KEY="your_api_key"          # Linux/macOS
export ANTHROPIC_BASE_URL="https://api.minimaxi.com/anthropic"  # Linux/macOS

# 或者用 OAuth 登录
./cli /login

# 运行
./cli
```

---

## 如果 bun 命令找不到

安装 Bun：

**Windows (PowerShell):**
```powershell
irm bun.sh | iex
```

**Linux / macOS:**
```bash
curl -fsSL https://bun.sh/install | bash
```

---

## 编译选项

| 命令 | 输出文件 | 说明 |
|------|---------|------|
| `bun run build` | `./cli` | 标准版 |
| `bun run build:dev` | `./cli-dev` | 开发版（带版本号） |
| `bun run build:dev:full` | `./cli-dev` | 全功能版（所有实验功能） |
| `bun run dev` | 无 | 直接运行源码（无需编译） |
