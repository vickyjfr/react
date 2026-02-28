#!/bin/bash

echo "清理 Metro 缓存..."
rm -rf node_modules/.cache
rm -rf /tmp/metro-*
rm -rf /tmp/haste-*

echo "清理完成！"
echo "请运行: npm start -- --reset-cache"
