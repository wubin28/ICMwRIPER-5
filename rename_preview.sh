#!/bin/bash
# 预览重命名命令，不实际执行
echo "=== 重命名预览（仅打印命令，不执行）==="
echo "======================================"

# 遍历当前目录文件，排除已正确命名的文件（bubble-2025-10xxx.txt）
for file in *; do
    # 跳过已符合格式的文件
    if [[ "$file" =~ ^bubble-2025-10.*\.txt$ ]]; then
        continue
    fi

    # 提取时间戳：优先提取 "2025-10-xx--xx-xx" 格式，其次提取 "2025-10-xx" 格式
    timestamp=$(echo "$file" | sed -nE 's/.*(2025-10-[0-9]{2}--[0-9]{2}-[0-9]{2}).*/\1/p')
    if [ -z "$timestamp" ]; then
        timestamp=$(echo "$file" | sed -nE 's/.*(2025-10-[0-9]{2}).*/\1/p')
    fi

    # 若提取到时间戳，构建新文件名并打印命令
    if [ -n "$timestamp" ]; then
        new_name="bubble-${timestamp}.txt"
        echo "mv '$file' '$new_name'"  # 打印命令，不执行
    else
        echo "⚠️  跳过：无法从 '$file' 中提取时间戳"
    fi
done

echo "======================================"
echo "预览结束，未修改任何文件"