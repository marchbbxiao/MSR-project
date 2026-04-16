#!/bin/bash
cd ~/MSR-project
MSG="${1:-$(date '+%Y-%m-%d') 每日進度更新}"
echo "=== 準備推送 ==="
git status --short
echo ""
git add -A
git commit -m "$MSG" || echo "沒有新變更"
git push origin main
echo "=== 完成 ==="
