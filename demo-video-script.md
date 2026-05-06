# NapStop - App Store 审核演示视频脚本

## 视频要求
- 设备：真实 iPhone（推荐 iPhone 15/16 Pro Max）
- 时长：3-5 分钟
- 格式：MP4，1080p 或更高
- 录制方式：屏幕录制 + 可选的画中画展示设备

---

## 分镜脚本

### 场景 1：应用首次启动与权限请求（0:00-0:45）
**画面**：手机屏幕，显示主屏幕

| 时间 | 动作 | 解说词（可选字幕） |
|------|------|-------------------|
| 0:00 | 点击 NapStop 应用图标启动 | "Launching NapStop" |
| 0:05 | 显示位置权限弹窗 | "App requests location permission" |
| 0:10 | 点击 "Allow While Using App" | "User grants When In Use permission" |
| 0:15 | 显示后台位置权限弹窗 | "App requests Always location permission for background monitoring" |
| 0:20 | 点击 "Change to Always Allow" | "User grants Always permission - required for background alarm" |
| 0:25 | 显示通知权限弹窗 | "App requests notification permission for alerts" |
| 0:30 | 点击 "Allow" | "User grants notification permission" |
| 0:35 | 进入应用主界面 | "App main interface with current location" |

**关键展示点**：
- 清晰展示所有 3 个权限弹窗
- 说明为什么需要 "Always" 权限

---

### 场景 2：设置目的地闹钟（0:45-1:30）
**画面**：应用内，设置闹钟流程

| 时间 | 动作 | 解说词 |
|------|------|--------|
| 0:45 | 点击 "Search Destination" 按钮 | "User searches for a destination" |
| 0:55 | 输入 "Shanghai Railway Station" | "Entering destination name" |
| 1:00 | 从搜索结果中选择地点 | "Selecting from search results" |
| 1:05 | 地图显示目的地位置 | "Map shows destination location" |
| 1:10 | 调整到达半径（如 500 米） | "Setting arrival radius to 500 meters" |
| 1:15 | 调整接近半径（如 2000 米） | "Setting approach radius to 2 kilometers" |
| 1:20 | 点击 "Start Alarm" | "Starting the location alarm" |
| 1:25 | 显示 "Monitoring..." 状态 | "App is now monitoring location in background" |

**关键展示点**：
- 展示地图选点功能
- 展示半径调整
- 展示开始监控后的状态变化

---

### 场景 3：后台定位演示（1:30-3:00）
**画面**：手机屏幕，展示应用进入后台后的行为

| 时间 | 动作 | 解说词 |
|------|------|--------|
| 1:30 | 按下 Home 键/上滑，应用进入后台 | "App enters background - location monitoring continues" |
| 1:35 | 打开 iOS 设置 > 隐私与安全 > 定位服务 > NapStop | "Verifying location permission is set to 'Always'" |
| 1:45 | 显示 "Always" 已选中 | "Always permission confirmed" |
| 1:50 | 返回主屏幕，打开地图应用 | "User opens another app while NapStop runs in background" |
| 2:00 | 展示状态栏的定位箭头图标（蓝色/ hollow） | "iOS status bar shows location indicator - NapStop is active" |
| 2:10 | 锁屏，展示锁屏界面 | "Even when locked, NapStop monitors location" |
| 2:20 | 解锁，展示 Live Activity（如有） | "Live Activity shows monitoring status on lock screen" |
| 2:30 | 打开控制中心，展示 NapStop 不在前台 | "NapStop is not in app switcher foreground" |

**关键展示点**：
- ✅ 必须展示应用确实在后台运行
- ✅ 必须展示 iOS 状态栏的定位指示器
- ✅ 必须展示 "Always" 权限设置

---

### 场景 4：接近警报触发（3:00-3:45）
**画面**：手机锁屏或后台状态

| 时间 | 动作 | 解说词 |
|------|------|--------|
| 3:00 | 手机在后台/锁屏状态 | "App is running in background" |
| 3:05 | 接近通知弹出（横幅或锁屏） | "Approach notification fires when within 2km" |
| 3:10 | 展示通知内容："Approaching Shanghai Railway Station" | "Notification shows destination name" |
| 3:15 | 点击通知，返回应用 | "Tapping notification returns to app" |
| 3:20 | 应用显示 "Approaching" 状态 | "App shows approaching status with distance" |

**关键展示点**：
- ✅ 展示后台通知触发
- ✅ 展示 Critical Alert 声音（如果环境允许录音）

---

### 场景 5：到达警报触发（3:45-4:30）
**画面**：手机锁屏或后台状态

| 时间 | 动作 | 解说词 |
|------|------|--------|
| 3:45 | 手机在后台/锁屏状态 | "Continuing to monitor in background" |
| 3:50 | 到达通知弹出 | "Arrival notification fires when within 500m" |
| 3:55 | 展示通知内容："You have arrived at Shanghai Railway Station!" | "Critical alert notification with sound" |
| 4:00 | 点击通知，返回应用 | "User opens app from notification" |
| 4:05 | 应用显示 "Wake Up!" 响铃界面 | "Alarm ringing screen with dismiss button" |
| 4:10 | 点击 "DISMISS ALARM" | "User dismisses the alarm" |
| 4:15 | 返回主界面，显示历史记录 | "Alarm history is saved" |

**关键展示点**：
- ✅ 展示到达时的 Critical Alert 通知
- ✅ 展示响铃界面
- ✅ 展示历史记录保存

---

### 场景 6：历史记录查看（4:30-5:00）
**画面**：应用内历史记录页面

| 时间 | 动作 | 解说词 |
|------|------|--------|
| 4:30 | 点击 "History" 标签 | "Viewing alarm history" |
| 4:35 | 展示历史记录列表 | "Past alarms with timestamps and locations" |
| 4:40 | 点击某条记录查看详情 | "Detailed alarm record with map" |
| 4:50 | 展示设置页面（可选） | "App settings and support" |

---

## 录制技巧

### 屏幕录制方法
**iOS 自带屏幕录制**：
1. 设置 > 控制中心 > 添加 "屏幕录制"
2. 从右上角下滑打开控制中心
3. 长按屏幕录制按钮，开启麦克风（如需旁白）
4. 点击开始录制

**Mac + 数据线**：
1. 连接 iPhone 到 Mac
2. 打开 QuickTime Player
3. 文件 > 新建影片录制
4. 点击录制按钮旁的小箭头，选择 iPhone

### 画中画展示（推荐）
- 使用 OBS 或 CapCut 后期编辑
- 左下角放置手机实拍画面（展示真实设备）
- 主画面为屏幕录制内容

### 音频建议
- 添加背景音乐（轻柔，不干扰）
- 或添加字幕说明每个步骤
- 关键操作点添加文字标注

---

## 视频上传

1. 上传至 YouTube（设为不公开/仅限链接）
2. 或上传至 Vimeo/云盘
3. 确保链接无需登录即可访问
4. 将链接粘贴到 App Store Connect > App Review Information > Notes

---

## App Store Connect Notes 文案

```
Demo Video: [YOUR_VIDEO_LINK_HERE]

This video demonstrates NapStop's background location monitoring feature on a physical iPhone device.

Key demonstrations:
1. Location permission request (When In Use → Always)
2. Notification permission request with Critical Alerts
3. Setting up a destination alarm with custom radius
4. App running in background with iOS location indicator visible
5. Approach notification firing while app is in background
6. Arrival Critical Alert notification with sound while phone is locked
7. Alarm ringing screen and dismiss functionality
8. Alarm history saved after completion

The app uses background location (UIBackgroundModes: location) to monitor the user's proximity to their destination and trigger alerts even when the app is not in the foreground. Critical Alert notifications are used for the alarm sound, which bypasses silent mode without requiring audio background mode.
```

---

## 快速拍摄清单

- [ ] 在真实 iPhone 上安装最新版本（1.0 build 2）
- [ ] 重置位置权限（设置 > 隐私 > 定位服务 > NapStop > 永不，然后重新打开应用）
- [ ] 准备测试目的地（建议：家附近 2-5 公里的地点）
- [ ] 开始屏幕录制
- [ ] 展示权限请求流程
- [ ] 设置目的地闹钟
- [ ] 将应用切换到后台
- [ ] 展示 iOS 设置中的 "Always" 权限
- [ ] 锁屏展示 Live Activity（如有）
- [ ] 模拟接近和到达（可步行或驾车测试）
- [ ] 展示通知触发
- [ ] 展示响铃界面
- [ ] 展示历史记录
- [ ] 停止录制并导出
- [ ] 上传视频并获取链接
- [ ] 粘贴到 App Store Connect Notes
