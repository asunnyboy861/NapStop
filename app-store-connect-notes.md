# App Store Connect - App Review Notes

## Demo Video

**Video URL**: [PASTE_YOUR_VIDEO_LINK_HERE]

---

## Background Location Justification

NapStop is a GPS location alarm app designed for travelers who need to sleep or rest during transit. The app requires background location monitoring to alert users when they are approaching or arriving at their destination, even when the app is not in the foreground.

### Why "Always" Location Permission is Required

1. **Core Functionality**: The primary feature is background location monitoring. Users set a destination and expect to be alerted while the app runs in the background.

2. **User Scenarios**:
   - Sleeping on a train/bus and needing to wake up before the stop
   - Reading or working during commute and wanting an arrival reminder
   - Traveling in unfamiliar areas where missing a stop would cause significant inconvenience

3. **Technical Implementation**:
   - Uses `CLLocationManager` with `allowsBackgroundLocationUpdates = true`
   - Uses geofencing (`CLCircularRegion`) for efficient battery usage
   - Background location indicator is shown to users (blue bar/arrow)
   - Location updates pause automatically when not monitoring

### Background Location Usage

- **Trigger**: Only active when user explicitly starts an alarm
- **Duration**: Until user arrives at destination or manually stops the alarm
- **Battery Optimization**: Uses geofencing with 50-meter distance filter
- **User Control**: User can stop monitoring at any time

### Permissions Demonstrated in Video

1. **Location (When In Use)** → Requested on first launch for map display
2. **Location (Always)** → Requested when starting first alarm for background monitoring
3. **Notifications (with Critical Alerts)** → Requested for alarm alerts that bypass silent mode

---

## Critical Alert Notification Usage

The app uses Critical Alert notifications (authorized with `.criticalAlert` option) for alarm sounds. This allows the alarm to bypass the device's silent mode and Do Not Disturb settings without requiring the `audio` background mode.

- **Sound**: `UNNotificationSound.defaultCritical`
- **Use Case**: Arrival and overshoot alarms when app is in background or device is locked
- **User Control**: Can be disabled in iOS Settings > Notifications > NapStop

---

## Demo Video Contents

The attached demo video shows the following on a physical iPhone device:

1. **00:00-00:45** - First launch and permission requests (Location When In Use → Always, Notifications)
2. **00:45-01:30** - Setting up a destination alarm with map search and radius configuration
3. **01:30-03:00** - App running in background with iOS location indicator visible, verification of "Always" permission in Settings
4. **03:00-03:45** - Approach notification firing while app is in background
5. **03:45-04:30** - Arrival Critical Alert notification with sound, alarm ringing screen
6. **04:30-05:00** - Alarm history and app settings

---

## Reply to Reviewer

Dear App Review Team,

Thank you for your feedback. We have prepared a demo video demonstrating NapStop's background location monitoring feature on a physical iPhone device.

**Video Link**: [PASTE_VIDEO_LINK]

The video demonstrates:
- The app requesting and receiving "Always" location permission
- Background location monitoring with visible iOS status bar indicator
- Geofencing-based approach and arrival notifications
- Critical Alert notifications that bypass silent mode
- The complete user flow from setting an alarm to receiving alerts

Background location is essential for NapStop because users need to be alerted while the app is in the background (e.g., while sleeping on a train or when the phone is in their pocket). The app only activates background location when the user explicitly starts an alarm and stops automatically when the alarm is dismissed or the destination is reached.

Please let us know if you need any additional information.

Best regards,
[Your Name]
NapStop Development Team
