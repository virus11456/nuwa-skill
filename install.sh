#!/usr/bin/env bash
#
# 一鍵安裝「思維顧問團 + 達爾文」到 Claude Code 個人 skills 目錄
#   用法：在 repo 根目錄執行  bash install.sh
#
# 會把 skills/ 底下所有 skill（含 darwin-skill 達爾文自動進化器）
# 複製到 ~/.claude/skills/，之後開任何新的 Claude Code 對話都會自動載入待命。
#
set -e

DEST="${HOME}/.claude/skills"
SRC="$(cd "$(dirname "$0")" && pwd)/skills"

if [ ! -d "$SRC" ]; then
  echo "✗ 找不到 skills/ 目錄，請在 repo 根目錄執行此腳本。"
  exit 1
fi

mkdir -p "$DEST"
echo "→ 安裝目標：$DEST"
echo ""

count=0
for d in "$SRC"/*/; do
  [ -d "$d" ] || continue
  name="$(basename "$d")"
  [ -f "$d/SKILL.md" ] || continue   # 只裝真正的 skill（含 SKILL.md）
  echo "  安裝  $name"
  rm -rf "$DEST/$name"
  cp -R "$d" "$DEST/$name"
  count=$((count+1))
done

echo ""
echo "✅ 完成！共安裝 $count 個 skill 到 $DEST"
echo ""
echo "開一個新的 Claude Code 對話即可使用："
echo "  · 單一視角： 用芒格／馬斯克／蒂爾／賈伯斯／馬克老師 的角度看…"
echo "  · 多人圓桌： 用多Agent圓桌讓芒格、馬斯克、蒂爾討論：<你的決策>"
echo "  · 自動進化： 達爾文，幫我優化 <某個skill>"
echo "  · 蒸餾新人： 蒸餾 <某個人名>"
