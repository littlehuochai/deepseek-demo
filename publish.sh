#!/bin/sh
# 把本机改好的站点推到你的 GitHub 仓库（Token 只在终端里输入，不会写进文件）
set -e
cd "$(dirname "$0")"

printf 'GitHub 用户名: '
read -r GH_USER
printf '仓库名（例如 deepseek-demo）: '
read -r GH_REPO
printf 'Personal Access Token（粘贴时不显示）: '
stty -echo
read -r TOKEN
stty echo
printf '\n'

git push "https://$GH_USER:$TOKEN@github.com/$GH_USER/$GH_REPO.git" main:main

printf '\n推送完成。接下来去仓库 Settings → Pages，Source 选 Deploy from a branch，分支选 main、目录选 / (root)，保存。\n'
printf '等一两分钟后访问：https://%s.github.io/%s/\n' "$GH_USER" "$GH_REPO"
