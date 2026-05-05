# Git Repositories

## Main App (iOS Application)

| Item | Value |
|------|-------|
| **Repository Name** | NapStop |
| **Git URL** | git@github.com:asunnyboy861/NapStop.git |
| **Repo URL** | https://github.com/asunnyboy861/NapStop |
| **Visibility** | Public |
| **Primary Language** | Swift |
| **GitHub Pages** | ✅ **ENABLED** (from `/docs` folder) |
| **Bundle ID** | com.zzoutuo.NapStop |
| **Deployment Target** | iOS 17.0 |
| **Architecture** | MVVM + @Observable |

## Policy Pages (Deployed from Main Repository /docs)

| Page | URL | Status |
|------|-----|--------|
| Landing Page | https://asunnyboy861.github.io/NapStop/ | ✅ Active |
| Support | https://asunnyboy861.github.io/NapStop/support.html | ✅ Active |
| Privacy Policy | https://asunnyboy861.github.io/NapStop/privacy.html | ✅ Active |

**Note**: Terms of Use not required for Paid Download apps.

## GitHub Actions Workflows

| Workflow | File | Trigger | Status |
|----------|------|---------|--------|
| Deploy to GitHub Pages | `.github/workflows/deploy.yml` | Push to main | ✅ Active |

## Build Verification

| Platform | Device | Status |
|----------|--------|--------|
| iOS Simulator | iPhone XS Max | ✅ Build Succeeded |
| iOS Simulator | iPad Pro 13-inch (M4) | ✅ Build Succeeded |

## Repository Structure

```
NapStop/
├── .github/
│   └── workflows/
│       └── deploy.yml              # GitHub Pages deployment workflow
├── NapStop/                        # iOS App Source Code
│   ├── NapStop.xcodeproj/          # Xcode Project
│   ├── NapStop/                    # Swift Source Files
│   │   ├── NapStopApp.swift        # App entry point
│   │   ├── ContentView.swift       # Root content view
│   │   ├── Views/
│   │   │   ├── Main/MainTabView.swift
│   │   │   ├── Alarm/
│   │   │   │   ├── SetAlarmView.swift
│   │   │   │   ├── AlarmActiveView.swift
│   │   │   │   └── AlarmRingingView.swift
│   │   │   ├── Map/DestinationSearchView.swift
│   │   │   ├── History/AlarmHistoryView.swift
│   │   │   └── Settings/
│   │   │       ├── SettingsView.swift
│   │   │       └── ContactSupportView.swift
│   │   ├── ViewModels/
│   │   │   ├── AlarmViewModel.swift
│   │   │   └── MapSearchViewModel.swift
│   │   ├── Services/
│   │   │   ├── LocationManager.swift
│   │   │   ├── AlarmPlayer.swift
│   │   │   ├── HapticManager.swift
│   │   │   ├── LiveActivityManager.swift
│   │   │   ├── NotificationManager.swift
│   │   │   └── SubwayFallbackManager.swift
│   │   ├── Models/
│   │   │   ├── AlarmDestination.swift
│   │   │   └── AlarmRecord.swift
│   │   └── Assets.xcassets/
│   │       └── AppIcon.appiconset/
│   └── Info.plist
├── NapStop-pic/                    # App Store Screenshots
│   └── iphone/
├── docs/                           # Policy Pages (GitHub Pages)
│   ├── index.html
│   ├── support.html
│   └── privacy.html
├── us.md                           # English Development Guide
├── keytext.md                      # App Store Metadata
├── capabilities.md                 # Capabilities Configuration
├── icon.md                         # App Icon Details
├── price.md                        # Pricing Configuration
└── nowgit.md                       # This File
```
