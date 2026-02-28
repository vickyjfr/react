#!/usr/bin/env node

// 包装脚本：获取 React Native config 并修复 iOS 项目路径
const path = require('path');
const { execSync } = require('child_process');

// 切换到 React Native 项目目录
process.chdir(path.join(__dirname, '../../react'));

// 获取原始配置
const configJson = execSync('npx --yes react-native config', { encoding: 'utf8' });
const config = JSON.parse(configJson);

// 修复 iOS 项目路径
config.project = config.project || {};
config.project.ios = {
  sourceDir: path.join(__dirname)
};

// 输出修复后的配置
console.log(JSON.stringify(config, null, 2));
