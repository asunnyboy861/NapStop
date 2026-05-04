# Capabilities Configuration

## Analysis
Based on operation guide analysis:
- GPS location tracking and geofencing (core feature)
- Background location updates (alarm must work while app is in background)
- Audio playback for alarm sound (must bypass silent mode)
- Local notifications (backup alarm)
- MapKit for destination selection
- CoreMotion for subway/tunnel fallback
- ActivityKit for Live Activities
- WidgetKit for home screen widget
- Apple Watch companion (Phase 2)

## Auto-Configured Capabilities
| Capability | Status | Method |
|------------|--------|--------|
| Location Services (Always + When In Use) | ✅ Configured | Info.plist keys |
| Background Modes - Location Updates | ✅ Configured | Info.plist |
| Background Modes - Audio | ✅ Configured | Info.plist |
| MapKit | ✅ Available | Framework (no capability needed) |
| CoreMotion | ✅ Available | Framework (no capability needed) |
| UserNotifications | ✅ Available | Framework (no capability needed) |
| ActivityKit | ✅ Available | Framework (iOS 16.1+, no capability needed) |
| WidgetKit | ✅ Available | Framework (no capability needed) |

## Manual Configuration Required
| Capability | Status | Steps |
|------------|--------|-------|
| Apple Watch App Target | ⏳ Phase 2 | Add Watch App target in Xcode, configure App Groups |

## No Configuration Needed
- Push Notifications (using local notifications only, not remote)
- iCloud / CloudKit (all data is local)
- In-App Purchase (one-time paid download, no IAP)
- HealthKit (not applicable)
- Camera / Photo Library (not applicable)
- Siri (not applicable)

## Info.plist Keys Required
| Key | Value |
|-----|-------|
| NSLocationAlwaysAndWhenInUseUsageDescription | "NapStop needs your location to alert you when approaching your destination, even when you're sleeping." |
| NSLocationWhenInUseUsageDescription | "NapStop needs your location to set up your destination alarm." |
| UIBackgroundModes | ["location", "audio"] |
| UISupportsIndirectInputEvents | YES |

## Verification
- Build succeeded after configuration: Pending
- All entitlements correct: Pending
