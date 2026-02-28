# HybridRNApp - iOS 混合应用集成 React Native 0.78.3

## 项目概述

这是一个 iOS 原生应用（使用 SwiftUI）集成 React Native 0.78.3 的混合应用项目。与标准的 React Native 项目不同，本项目将 React Native 作为一个模块嵌入到现有的 iOS 原生应用中，实现原生界面和 React Native 界面的混合使用。

## 项目结构

```
HybridRNApp/
├── ios/HybridRNApp/          # iOS 原生应用项目
│   ├── HybridRNApp/          # Swift 源代码
│   │   ├── HybridRNAppApp.swift      # SwiftUI App 入口
│   │   ├── AppDelegate.swift         # UIKit AppDelegate（支持 RN）
│   │   ├── ContentView.swift         # SwiftUI 主视图
│   │   ├── ViewController.swift      # UIKit 视图控制器
│   │   ├── RNViewController.swift    # React Native 容器控制器
│   │   ├── RNContainerView.swift     # SwiftUI 包装的 RN 视图
│   │   └── SceneDelegate.swift       # Scene 管理
│   ├── Podfile                       # CocoaPods 依赖配置
│   └── rn-config-wrapper.js          # RN CLI 配置包装脚本
└── react/                    # React Native 项目
    ├── App.tsx               # React Native 应用入口
    ├── index.js              # RN 注册入口
    ├── package.json          # Node 依赖
    ├── babel.config.js       # Babel 配置
    ├── metro.config.js       # Metro 打包配置
    └── react-native.config.js # RN CLI 配置
```

## 与标准 React Native 项目的主要区别

### 1. 项目结构差异

**标准 React Native 项目：**
- React Native 是主项目
- iOS 代码在 `ios/` 目录下作为子项目
- 使用 `react-native init` 创建
- 项目根目录包含 `package.json`

**本混合项目：**
- iOS 原生应用是主项目
- React Native 在独立的 `react/` 目录下
- iOS 和 React Native 是平级的独立模块
- 两个独立的项目根目录

### 2. Podfile 配置差异

**标准项目 Podfile：**
```ruby
require_relative '../node_modules/react-native/scripts/react_native_pods'

use_react_native!(
  :path => '../node_modules/react-native'
)
```

**本项目 Podfile：**
```ruby
# 使用绝对路径配置
react_native_project_root = '/Users/hualai/test/HybridRNApp/react'
react_native_path = File.join(react_native_project_root, 'node_modules/react-native')

# 加载 RN 脚本
require File.join(react_native_path, 'scripts/react_native_pods')

# 使用相对路径（因为内部会拼接）
use_react_native!(
  :path => '../../react/node_modules/react-native',
  :app_path => '../../react',
  :hermes_enabled => true
)

# 使用自定义配置脚本进行 autolinking
config_command = ['node', File.join(__dir__, 'rn-config-wrapper.js')]
use_native_modules!(config_command)
```

### 3. React Native CLI 配置

**标准项目：**
- CLI 自动检测 iOS 项目位置
- `react-native.config.js` 通常为空或不需要

**本项目：**
```javascript
// react/react-native.config.js
module.exports = {
  project: {
    ios: {
      sourceDir: '../ios/HybridRNApp',  // 指向独立的 iOS 项目
    },
  },
};
```

由于 CLI 无法自动检测，需要自定义配置包装脚本：
```javascript
// ios/HybridRNApp/rn-config-wrapper.js
// 修复 project.ios.sourceDir 路径
config.project.ios = {
  sourceDir: path.join(__dirname)
};
```

### 4. iOS 应用架构差异

**标准项目：**
- 使用 UIKit AppDelegate
- 整个应用就是 React Native

**本项目：**
- SwiftUI App 结构
- 使用 `@UIApplicationDelegateAdaptor` 桥接 AppDelegate
- 原生视图和 RN 视图混合使用
- 通过 `RNViewController` 和 `RNContainerView` 嵌入 RN 内容

### 5. Babel 配置

**React Native 0.78.3 使用新的 Babel preset：**
```javascript
// babel.config.js
module.exports = {
  presets: ['module:@react-native/babel-preset'],  // 新包名
};
```

旧版本使用 `module:metro-react-native-babel-preset`（已废弃）

## 关键修改说明

### 1. Podfile 优化（支持 RN 0.78.3 Autolinking）

**问题：**
- 混合应用结构导致路径复杂
- React Native CLI 无法自动检测 iOS 项目
- `use_native_modules!` 需要正确的配置

**解决方案：**
1. 使用绝对路径加载 RN 脚本
2. 使用相对路径传递给 `use_react_native!`（避免路径拼接错误）
3. 创建 `rn-config-wrapper.js` 修复 CLI 配置
4. 正确配置 `use_native_modules!` 实现自动链接

### 2. AppDelegate 支持

**问题：**
- SwiftUI App 结构不提供 `window` 属性
- React Native 需要 UIKit AppDelegate

**解决方案：**
```swift
// HybridRNAppApp.swift
@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

// AppDelegate.swift
@objc(AppDelegate)
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    // ...
}
```

### 3. Metro 和 Babel 配置

**问题：**
- Flow 类型语法转换错误
- 版本不匹配

**解决方案：**
```json
// package.json
{
  "devDependencies": {
    "@react-native/babel-preset": "0.78.3",
    "metro-react-native-babel-preset": "0.78.3"
  }
}
```

```javascript
// babel.config.js
module.exports = {
  presets: ['module:@react-native/babel-preset'],
};
```

### 4. 依赖版本对齐

确保所有 React Native 相关包版本一致：
- `react-native`: 0.78.3
- `@react-native/babel-preset`: 0.78.3
- `@react-native/metro-config`: 0.78.3
- `metro`: 0.81.3

## 使用方法

### 安装依赖

```bash
# 安装 React Native 依赖
cd react
npm install

# 安装 iOS 依赖
cd ../ios/HybridRNApp
pod install
```

### 运行应用

```bash
# 启动 Metro bundler
cd react
npm start

# 在 Xcode 中打开并运行
open ios/HybridRNApp/HybridRNApp.xcworkspace
```

### 清理缓存

```bash
cd react
rm -rf node_modules/.cache
npm start -- --reset-cache
```

## 注意事项

1. **路径配置**：Podfile 中的绝对路径需要根据实际项目位置修改
2. **版本兼容**：确保 React Native 和相关工具链版本一致
3. **缓存清理**：修改配置后需要清理 Metro 缓存
4. **Xcode 配置**：确保 `AppDelegate.swift` 已添加到 Xcode 项目中

## 适用场景

- 现有 iOS 应用需要集成 React Native 功能
- 需要原生性能的核心功能 + RN 的快速迭代能力
- 渐进式迁移：逐步将原生页面改为 RN 实现
- 混合团队：iOS 原生开发 + React Native 开发并行

## 技术栈

- **iOS**: SwiftUI + UIKit
- **React Native**: 0.78.3
- **JavaScript**: React 19.0.0
- **构建工具**: CocoaPods, Metro, Babel
- **语言**: Swift 5, TypeScript/JavaScript

## 参考资料

- [React Native 官方文档 - Integration with Existing Apps](https://reactnative.dev/docs/integration-with-existing-apps)
- [React Native 0.78 Release Notes](https://github.com/facebook/react-native/releases/tag/v0.78.0)
- [CocoaPods 官方文档](https://cocoapods.org/)
