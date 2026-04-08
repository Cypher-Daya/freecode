#!/usr/bin/env bash
set -euo pipefail

# free-code installer
# Usage: curl -fsSL https://raw.githubusercontent.com/Cypher-Daya/freecode/main/install.sh | bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

REPO="https://github.com/Cypher-Daya/freecode.git"
INSTALL_DIR="$HOME/free-code"
BUN_MIN_VERSION="1.3.11"

info()  { printf "${CYAN}[*]${RESET} %s\n" "$*"; }
ok()    { printf "${GREEN}[+]${RESET} %s\n" "$*"; }
warn()  { printf "${YELLOW}[!]${RESET} %s\n" "$*"; }
fail()  { printf "${RED}[x]${RESET} %s\n" "$*"; exit 1; }

header() {
  echo ""
  printf "${BOLD}${CYAN}  free-code${RESET}\n"
  printf "${DIM}  Claude Code 自由构建版${RESET}\n"
  echo ""
}

version_gte() {
  [ "$(printf '%s\n' "$1" "$2" | sort -V | head -1)" = "$2" ]
}

check_os() {
  case "$(uname -s)" in
    Darwin) OS="macos" ;;
    Linux)  OS="linux" ;;
    *)      fail "不支持的操作系统: $(uname -s)，仅支持 macOS 或 Linux" ;;
  esac
  ok "系统: $(uname -s) $(uname -m)"
}

check_git() {
  if ! command -v git &>/dev/null; then
    fail "git 未安装。请先安装:
    macOS:  xcode-select --install
    Linux:  sudo apt install git"
  fi
  ok "git: $(git --version | head -1)"
}

check_bun() {
  if command -v bun &>/dev/null; then
    ver="$(bun --version 2>/dev/null || echo "0.0.0")"
    if version_gte "$ver" "$BUN_MIN_VERSION"; then
      ok "bun: v${ver}"
      return
    fi
    warn "bun v${ver} 版本太低，需要 v${BUN_MIN_VERSION}+，正在升级..."
  else
    info "bun 未安装，正在安装..."
  fi
  install_bun
}

install_bun() {
  curl -fsSL https://bun.sh/install | bash
  export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
  export PATH="$BUN_INSTALL/bin:$PATH"
  if ! command -v bun &>/dev/null; then
    fail "bun 安装成功但找不到命令。
请把以下内容添加到你的 shell 配置文件 (~/.bashrc, ~/.zshrc 等):
  export PATH=\"\$HOME/.bun/bin:\$PATH\""
  fi
  ok "bun: v$(bun --version) (刚刚安装)"
}

clone_repo() {
  if [ -d "$INSTALL_DIR" ]; then
    warn "$INSTALL_DIR 已存在"
    info "正在拉取最新代码..."
    git -C "$INSTALL_DIR" pull --ff-only origin master 2>/dev/null || {
      warn "拉取失败，使用现有代码"
    }
  else
    info "正在克隆仓库..."
    git clone "$REPO" "$INSTALL_DIR"
  fi
  ok "源码位置: $INSTALL_DIR"
}

install_deps() {
  info "正在安装依赖..."
  cd "$INSTALL_DIR"
  bun install
  ok "依赖安装完成"
}

build_binary() {
  info "正在编译..."
  cd "$INSTALL_DIR"
  bun run build
  ok "编译完成: $INSTALL_DIR/cli"
}

link_binary() {
  local link_dir="$HOME/.local/bin"
  mkdir -p "$link_dir"

  ln -sf "$INSTALL_DIR/cli" "$link_dir/free-code"
  ok "已创建快捷命令: $link_dir/free-code"

  if ! echo "$PATH" | tr ':' '\n' | grep -qx "$link_dir"; then
    warn "$link_dir 不在 PATH 中"
    echo ""
    printf "  请把以下内容添加到你的 shell 配置文件 (~/.bashrc, ~/.zshrc 等):\n"
    printf "    export PATH=\"\$HOME/.local/bin:\$PATH\"\n"
    echo ""
  fi
}

header
info "开始安装..."
echo ""

check_os
check_git
check_bun
echo ""

clone_repo
install_deps
build_binary
link_binary

echo ""
printf "${GREEN}${BOLD}  安装完成！${RESET}\n"
echo ""
printf "  ${BOLD}运行命令:${RESET}\n"
printf "    free-code                          # 交互模式\n"
printf "    free-code -p \"你的问题\"             # 单次提问\n"
echo ""
printf "  ${BOLD}设置 API Key:${RESET}\n"
printf "    export ANTHROPIC_API_KEY=\"your_key\"\n"
printf "    export ANTHROPIC_BASE_URL=\"https://api.minimaxi.com/anthropic\"\n"
echo ""
printf "  ${DIM}源码: $INSTALL_DIR${RESET}\n"
printf "  ${DIM}程序: $INSTALL_DIR/cli${RESET}\n"
echo ""
