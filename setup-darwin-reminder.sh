#!/usr/bin/env bash
#
# 為 Claude Code 加一個「改 SKILL.md 時，提醒你可以叫達爾文優化」的 hook。
#   用法：bash setup-darwin-reminder.sh
#
# 特性：
#   - 寫入使用者層級 ~/.claude/settings.json，merge 不覆蓋既有設定（mcpServers / 其他 hooks 都保留）
#   - 冪等：已經裝過就直接跳過，不會重複加
#   - 動手前自動備份 settings.json
#
set -e

SETTINGS="${HOME}/.claude/settings.json"
mkdir -p "${HOME}/.claude"

command -v jq >/dev/null 2>&1 || { echo "✗ 需要 jq，請先安裝：brew install jq"; exit 1; }

# settings.json 不存在就建一個空的
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"

# 冪等檢查：已經有「達爾文」提醒 hook 就跳過
if jq -e '.. | .command? // empty | select(type=="string" and test("達爾文"))' "$SETTINGS" >/dev/null 2>&1; then
  echo "ℹ️  達爾文提醒 hook 已存在，略過。"
  exit 0
fi

cp "$SETTINGS" "$SETTINGS.bak.$(date +%Y%m%d-%H%M%S)"
echo "→ 已備份 $SETTINGS"

# 用 quoted heredoc 安全載入 hook 指令（內含的 $ 不展開）
read -r -d '' HOOKCMD <<'EOF' || true
f=$(jq -r '.tool_input.file_path // .tool_response.filePath // ""' 2>/dev/null); case "$f" in *SKILL.md) printf '%s' '{"systemMessage":"💡 你剛改了一個 skill，可以說「達爾文，幫我優化它」讓它評分進化（skill 打分）"}';; esac
EOF

jq --arg cmd "$HOOKCMD" \
  '.hooks.PostToolUse += [{"matcher":"Write|Edit","hooks":[{"type":"command","command":$cmd}]}]' \
  "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"

echo "✅ 已加入「改 SKILL.md 時提醒叫達爾文」的 hook 到 $SETTINGS"
echo "→ 當前 Claude Code 請開一次 /hooks（或重啟）即可生效；之後任何新對話自動生效。"
echo "→ 這是本機個人設定，不會被推到 GitHub。"
