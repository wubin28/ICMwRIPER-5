#!/bin/bash
# 实际执行重命名，统一转为 bubble-<timestamp>.txt 格式
set -euo pipefail  # 开启严格模式，减少错误
echo "=== 开始实际重命名 ==="
echo "======================================"

# 遍历当前目录文件，排除已正确命名的文件
for file in *; do
    if [[ "$file" =~ ^bubble-2025-10.*\.txt$ ]]; then
        echo "✅ 已符合格式：$file（跳过）"
        continue
    fi

    # 提取时间戳（逻辑同预览脚本）
    timestamp=$(echo "$file" | sed -nE 's/.*(2025-10-[0-9]{2}--[0-9]{2}-[0-9]{2}).*/\1/p')
    if [ -z "$timestamp" ]; then
        timestamp=$(echo "$file" | sed -nE 's/.*(2025-10-[0-9]{2}).*/\1/p')
    fi

    # 执行重命名（跳过已存在的文件）
    if [ -n "$timestamp" ]; then
        new_name="bubble-${timestamp}.txt"
        if [ -f "$new_name" ]; then
            echo "⚠️  跳过：目标文件 '$new_name' 已存在（避免覆盖）"
        else
            mv "$file" "$new_name"
            echo "✅ 已重命名：'$file' → '$new_name'"
        fi
    else
        echo "❌ 跳过：无法从 '$file' 中提取时间戳"
    fi
done

echo "======================================"
echo "重命名完成"