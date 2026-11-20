# 当前满意版本（2026-11-20）

线上地址：https://littlehuochai.github.io/deepseek-demo/
仓库：https://github.com/littlehuochai/deepseek-demo （tag `good-2026-11-20`，commit `3683c64`）

## 相对官方 chat-demo 的改动

源码在 `/root/workspace/chat-demo-mobile`，构建产物同步到 `/root/workspace/chat-demo-site`。

1. **公式定界符兼容**（`src/services/markdown/parse.ts`）
   - 解析前把 `\[...\]`、`\(...\)`、裸的 `\begin{aligned}` 统一成 `$$...$$` / `$...$`
   - 跳过代码块、行内代码和已有公式；保留列表缩进，不拆散列表

2. **思考过程默认收起**（`src/components/messages/ReplyArea.tsx`）
   - `useState(true)` → `useState(false)`，只留一行标题，点开才看过程

3. **窄屏防横向溢出**（`src/app/mobile.css`、`MessageList.module.css`）
   - 页面禁止被内容撑宽；消息列允许收缩
   - 表格、独立公式在各自框内左右滑动
   - 不改字号、间距，排版保持 demo 原样

4. **系统提示词保持原样**
   - 仍是 `该助手为DeepSeek，由深度求索公司创造。`
   - 模型仍是 `deepseek-flash`
   - `latest_reminder` 机制未动（日期,星期,地区,Web,语言）

## 重建与发布

```sh
cd /root/workspace/chat-demo-mobile
pnpm install      # 首次
pnpm build

cd /root/workspace/chat-demo-site
rm -rf static index.html && cp -r ../chat-demo-mobile/dist/. .
touch .nojekyll
git add -A && git commit -m "..." && git push origin main
```

GitHub Pages 约 1 分钟自动生效。

## 回退到这个版本

```sh
cd /root/workspace/chat-demo-site
git checkout good-2026-11-20 -- .
git commit -am "回退到 good-2026-11-20" && git push origin main
```

## 数据导入

导入器要求每个会话的图片紧跟在该会话之后（或统一放在索引之后按 ID 匹配），
否则会报 `backupIncomplete`。合并多份导出时按这个顺序写 ZIP：

```
manifest.json
chat_sessions/{id}.json
chat_sessions/{id}_files/...   ← 紧跟所属会话
chat_session_index.json
```

已完成：导入 244 个对话（旧 240 + 新 4），旧包里的图片未导入以控制体积。
