#!/bin/bash

# 1. 在这里定义你的集合（用空格隔开）
TARGET_NAMES=("20O1" "20O2" "20O3" "21O1" "21O2" "21O3" "24O1" "24O2" "24O3" "51O1" "51O2" "79O1" "79O2" "79O3" "80O1"  "80O2" "87O1" "87O2" "87O3")

DEST_DIR="Organized_Files"
mkdir -p "$DEST_DIR"

echo "开始扫描并迁移文件..."

# 2. 遍历数组中的每一个名字
for name in "${TARGET_NAMES[@]}"; do
    
    # 查找匹配的文件（find 默认会递归搜索当前目录及所有深层子目录）
    count=$(find . -type f -name "*${name}*" ! -path "./${DEST_DIR}/*" | wc -l)
    
    if [ "$count" -gt 0 ]; then
        count=$(echo $count | tr -d ' ') 
        echo "发现 $count 个包含 '$name' 的文件，正在迁移..."
        
        target_folder="${DEST_DIR}/${name}"
        mkdir -p "$target_folder"
        
        # 核心修改：使用 mv 替代 cp，实现迁移并减少存储占用
        # 强烈建议保留 -n 参数（不覆盖已存在的文件）
        find . -type f -name "*${name}*" ! -path "./${DEST_DIR}/*" -exec mv -n {} "$target_folder/" \;
    else
        echo "未找到包含 '$name' 的文件，已跳过。"
    fi
done

echo "===================================="
echo "文件分类迁移完毕！"