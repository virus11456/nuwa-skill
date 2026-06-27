# 思維顧問團 · Distilled Minds

由 [女娲 · Skill造人術](https://github.com/alchaincyf/nuwa-skill) 蒸餾出的人物視角 Skill 合集，可在 Claude Code 中作為「思維顧問」使用。

## 包含的 Skill

| Skill | 角色 | 核心視角 |
|---|---|---|
| `munger-perspective` | 查理·芒格 | 理性、逆向思維、避免愚蠢、能力圈 |
| `elon-musk-perspective` | 伊隆·馬斯克 | 第一性原理、快速試錯、極致風險容忍 |
| `thiel-perspective` | 彼得·蒂爾 | 逆向真理、垄断 vs 競爭、明確的樂觀 |
| `steve-jobs-perspective` | 史蒂夫·賈伯斯 | 科技×人文、極致專注、簡約與品味 |
| `advisory-dialogue` | 圓桌主持 | 讓多個人物**真實交鋒**、收斂出決策地圖 |

每個人物 Skill 都基於約 50 個一手/二手來源深度調研，提煉了 6–7 個核心心智模型、10 條決策啟發式、完整表達 DNA、誠實邊界，調研過程保存在各自的 `references/research/` 內，完全自包含。

## 安裝（在任何裝置）

把這些 skill 複製到你的個人 skills 目錄即可：

```bash
# 1. clone 這個 repo
git clone https://github.com/virus11456/nuwa-skill.git

# 2. 把 skills 複製到 Claude Code 個人 skills 目錄
mkdir -p ~/.claude/skills
cp -R nuwa-skill/skills/* ~/.claude/skills/
```

之後**開任何新的 Claude Code 對話都會自動載入**，不用再設定。

> 注意：這些是 **Claude Code**（CLI / 桌面版 / IDE 擴充）用的本機 skill。claude.ai 一般網頁聊天和手機 App 不會讀取本機 `~/.claude/skills/`，無法使用。

## 怎麼用

**單一視角**（直接叫名字）：
```
用芒格的視角看一下我這個決策：……
從產品/體驗的角度（賈伯斯）幫我想想這個 App
```

**多人圓桌討論**（讓他們真實辯論）：
```
用多Agent圓桌讓芒格、馬斯克、蒂爾、賈伯斯討論：[你的決策]
```
- 句子裡帶「多Agent」→ 每個人物是**獨立 agent**，各自獨立推理、互相反駁（最真實）。
- 不帶「多Agent」→ 由單一模型分飾多角，較快較省。
- 可只挑其中幾位（2–3 人通常比 4 人更聚焦）。
- 加「讓他們吵到底」可進入深度辯論。

## 想蒸餾更多人物？

本 repo 根目錄就是「女娲 · Skill造人術」生成器。在 Claude Code 裡說「蒸餾 XX」即可自動調研並生成新的 `XX-perspective` skill。

---

> Skill 由 [女娲 · Skill造人術](https://github.com/alchaincyf/nuwa-skill) 生成 · 創建者 [花叔](https://x.com/AlchainHust)
