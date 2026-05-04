# NapStop - iOS Development Guide

## Executive Summary

NapStop is a GPS location-based alarm app designed for commuters who nap on buses, trains, and subways. It ensures users never miss their stop by combining geofencing, background location tracking, and silent-mode audio bypass. Unlike competitors, NapStop offers Apple Watch haptic wake-up, Live Activities with Dynamic Island, subway/tunnel GPS fallback via accelerometer, and overshoot detection — features no competitor provides together. All data is processed 100% on-device with zero network requests, ensuring maximum privacy.

**Target Audience**: Daily commuters (18-50), students (15-25), business travelers (30-55) in the US market.

**Key Differentiators**:
- Apple Watch haptic vibration wake-up (no competitor offers this)
- Live Activities + Dynamic Island real-time distance display
- Subway/tunnel GPS fallback using CoreMotion accelerometer
- Overshoot detection safety net (detects if you passed your stop)
- Silent mode audio bypass via AVAudioSession .playback category
- One-time purchase (no subscription fatigue)
- 100% local data, zero network requests, maximum privacy

## Competitive Analysis

| App | Strengths | Weaknesses | Our Advantage |
|-----|-----------|------------|---------------|
| DistAlarm (4.5/5) | GPS+Geofencing dual mode, 20km radius, silent bypass, GPS loss alert | No Apple Watch, no Live Activities | Apple Watch haptics, Live Activities, overshoot detection |
| Remindah (4.3/5) | Stop-moving detection, overshoot safety net, 100% privacy | No Apple Watch, no Dynamic Island | Apple Watch, Live Activities, Dynamic Island, subway fallback |
| WakePoint (4.0/5) | Live Activities, Dynamic Island, Widget | Subscription model (user反感), free version limited | One-time purchase, Apple Watch, subway fallback |
| Glarm (4.0/5) | Live Activities, 30km radius | No Apple Watch, basic UI | Apple Watch, polished UI, overshoot detection |
| Doze (4.4/5) | No ads, approach alert, time backup | No Apple Watch, no Live Activities | Apple Watch, Live Activities, subway fallback |
| WakeMeHere (3.8/5) | Smart location suggestions | Ads, outdated UI, battery drain | No ads, modern UI, battery optimized |

## Apple Design Guidelines Compliance

- **Location Services (5.1.5)**: App clearly explains why location is needed at first launch with custom alert. Location is core functionality — app cannot work without it. We provide graceful fallback UI when location is denied.
- **Background Modes (2.5.4)**: Background location updates used only for geofencing/alarm purpose. Background indicator shown. User explicitly starts/stops monitoring.
- **Audio**: AVAudioSession .playback category used only for alarm sound when approaching destination. Not used for background audio playback.
- **Privacy (5.1.1)**: All data stored locally with SwiftData. Zero network requests. No analytics. No third-party SDKs. Privacy policy clearly states data practices.
- **HIG Location**: Custom location usage description strings in Info.plist explain each permission request clearly.
- **HIG Notifications**: Alarm notifications are critical alerts that bypass Do Not Disturb. User explicitly opts in.
- **HIG Live Activities**: Used for real-time distance display on lock screen. User starts/stops explicitly. Content is relevant and timely.

## Technical Architecture

- **Language**: Swift 5.9+
- **Framework**: SwiftUI (primary), no UIKit
- **Data**: SwiftData (local only, no CloudKit)
- **Location**: CoreLocation + CLLocationManager
- **Map**: MapKit + MKLocalSearch
- **Audio**: AVFoundation + AVAudioSession
- **Motion**: CoreMotion (subway fallback)
- **Live Activities**: ActivityKit
- **Notifications**: UserNotifications
- **Widget**: WidgetKit
- **Apple Watch**: WatchKit + SwiftUI (separate target)
- **Architecture**: MVVM + @Observable (iOS 17+)
- **Concurrency**: async/await + Actor, no Combine

## Module Structure

```
NapStop/
├── NapStopApp.swift
├── Views/
│   ├── Main/
│   │   ├── MainTabView.swift
│   │   └── ContentView.swift
│   ├── Alarm/
│   │   ├── SetAlarmView.swift
│   │   ├── AlarmActiveView.swift
│   │   └── AlarmRingingView.swift
│   ├── Map/
│   │   ├── DestinationSearchView.swift
│   │   └── DestinationMapView.swift
│   ├── History/
│   │   └── AlarmHistoryView.swift
│   └── Settings/
│       ├── SettingsView.swift
│       └── ContactSupportView.swift
├── ViewModels/
│   ├── AlarmViewModel.swift
│   └── MapSearchViewModel.swift
├── Services/
│   ├── LocationManager.swift
│   ├── AlarmPlayer.swift
│   ├── OvershootDetector.swift
│   ├── SubwayFallbackManager.swift
│   ├── LiveActivityManager.swift
│   ├── NotificationManager.swift
│   └── HapticManager.swift
├── Models/
│   ├── AlarmDestination.swift
│   └── AlarmRecord.swift
├── Widgets/
│   └── NapStopWidget.swift
└── Resources/
    └── alarm.mp3
```

## Implementation Flow

1. Create data models (AlarmDestination, AlarmRecord) with SwiftData
2. Implement LocationManager with CoreLocation + Geofencing
3. Implement AlarmPlayer with AVAudioSession .playback for silent bypass
4. Implement OvershootDetector for passed-stop detection
5. Implement SubwayFallbackManager with CoreMotion
6. Implement LiveActivityManager with ActivityKit
7. Implement NotificationManager for local notification backup
8. Build SetAlarmView with MapKit destination picker + search
9. Build AlarmActiveView with real-time distance display
10. Build AlarmRingingView with dismiss interaction
11. Build MainTabView with tab navigation
12. Build SettingsView with policy links and preferences
13. Build ContactSupportView with feedback form
14. Build AlarmHistoryView with past alarm records
15. Add NapStopWidget with WidgetKit
16. Add Apple Watch companion app (Phase 2)
17. Configure Info.plist with all required permissions
18. Test on iPhone and iPad simulators

## UI/UX Design Specifications

- **Color Scheme**: 
  - Primary: Deep Blue (#1A3A5C) — trust, reliability, navigation
  - Accent: Vibrant Orange (#FF6B35) — alert, energy, urgency
  - Background: Light Gray (#F5F5F7) — clean, modern
  - Success: Green (#34C759) — arrived, safe
  - Warning: Yellow (#FFCC00) — approaching
  - Danger: Red (#FF3B30) — overshoot, alarm

- **Typography**: 
  - SF Pro Display for headings
  - SF Pro Text for body
  - Large bold numbers for distance display

- **Layout**:
  - Tab-based navigation: Alarm | Map | History | Settings
  - Card-based alarm setup flow
  - Map-centric destination selection
  - Full-screen alarm ringing view with large dismiss button
  - iPad: max content width 720pt, centered

- **Animations**:
  - Pulse animation on approach alert
  - Smooth distance countdown
  - Haptic feedback on alarm start/stop
  - Map pin drop animation

## Code Generation Rules

- Architecture: MVVM + @Observable (iOS 17+)
- Concurrency: async/await + Actor, no Combine
- Data: SwiftData, no CoreData
- UI: Pure SwiftUI, no UIKit
- Location permission: Request "Always", degrade to "While Using"
- Background: Background Location Updates + Geofencing dual insurance
- Audio: AVAudioSession.Category.playback to bypass silent mode
- Privacy: All data 100% local, zero network requests
- Error handling: Every location update failure must have fallback
- No code comments unless explicitly asked
- No emoji in code
- Single responsibility per module
- Follow "Rule of Three" for code abstraction

## Build & Deployment Checklist

- [ ] Info.plist: NSLocationAlwaysAndWhenInUseUsageDescription
- [ ] Info.plist: NSLocationWhenInUseUsageDescription
- [ ] Info.plist: UIBackgroundModes: location
- [ ] Info.plist: UIBackgroundModes: audio (for alarm)
- [ ] Capability: Location Updates background mode
- [ ] Capability: Audio background mode
- [ ] Capability: Push Notifications (for local notifications)
- [ ] Bundle ID: com.zzoutuo.NapStop
- [ ] Deployment Target: iOS 17.0
- [ ] App Icon: 1024x1024 generated
- [ ] Test on iPhone XS Max simulator
- [ ] Test on iPad Pro 13-inch (M4) simulator
- [ ] No secrets in source code
- [ ] Privacy Policy page deployed
- [ ] Support page deployed
