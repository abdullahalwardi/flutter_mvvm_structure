# Flutter MVVM Structure Diagram

## Project Architecture Overview

```
flutter_mvvm_structure/
│
├── 📱 Mobile Platforms
│   ├── android/           (Android-specific code & build config)
│   ├── ios/               (iOS-specific code & build config)
│   ├── macos/             (macOS-specific code & build config)
│   ├── windows/           (Windows-specific code & build config)
│   └── linux/             (Linux-specific code & build config)
│
├── 🌐 Web Platform
│   └── web/               (Web-specific code & assets)
│
├── 📦 Dependencies & Configuration
│   ├── pubspec.yaml       (Project dependencies & metadata)
│   ├── analysis_options.yaml
│   ├── devtools_options.yaml
│   ├── l10n.yaml          (Localization configuration)
│   └── flutter_mvvm_structure.iml
│
├── 🎨 Assets
│   └── assets/
│       ├── fonts/         (Custom fonts)
│       ├── icons/         (Icon assets)
│       ├── images/        (Image assets)
│       ├── lottie/        (Lottie animations)
│       ├── svg/           (SVG files)
│       └── videos/        (Video assets)
│
├── 🏗️ Build Output
│   └── build/             (Generated build artifacts)
│
├── 🛠️ Scripts
│   └── bin/
│       ├── deep_link.sh   (Deep linking setup)
│       ├── export.sh      (Export configuration)
│       ├── rename.sh      (Rename project)
│       ├── run.sh         (Run script)
│       └── uninstall.sh   (Uninstall script)
│
├── 🧪 Tests
│   └── test/
│       └── widget_test.dart
│
└── 📁 Main Application Code
    └── lib/
        ├── main.dart           (App entry point)
        ├── app.dart            (App configuration)
        ├── common_lib.dart     (Common exports)
        │
        ├── 📊 Data & state (Riverpod providers live here)
        ├── data/
        │   ├── datasources/    (Local & Remote data sources)
        │   ├── models/         (Data models)
        │   ├── providers/      (Riverpod codegen — domain-aligned with controllers)
        │   ├── repositories/   (Mapping + orchestration — call Retrofit clients)
        │   └── services/       (Dio, interceptors, clients/ Retrofit per Swagger controller)
        │
        ├── 🎯 Features (UI + feature components; flat layout)
        └── src/
            ├── login/            (Example feature)
            │   ├── login_page.dart
            │   └── components/   (Feature-only UI building blocks)
            │
            └── entry_point.dart (App entry point logic)
        │
        ├── 🛣️ Navigation
        └── router/             (Go Router configuration)
        │
        ├── 🌍 Localization
        └── l10n/               (Translation files)
        │
        ├── 📝 Generated Code
        └── gen/                (Freezed, JSON serialization, etc.)
        │
        ├── 🎨 UI Theme
        └── theme/              (Colors, typography, themes)
        │
        ├── 🔧 Utilities
        ├── utils/              (Helper functions, extensions)
        ├── logger/             (Logging utilities)
        └── paging/             (Pagination utilities)
```

## MVVM Layer Breakdown

```
┌─────────────────────────────────────────────────────────┐
│                    UI Layer (Presentation)               │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Feature root + components (no presentation/screens) │  │
│  │  - src/<feature>/<feature>_page.dart              │  │
│  │  - src/<feature>/components/                      │  │
│  │  Examples: login (phone entry), otp_verification   │  │
│  │  (shared OTP), create_account (profile setup) —    │  │
│  │  not every auth step under `login/`.               │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│         Provider layer (business / page state)         │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Riverpod codegen in data/providers/               │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│              Data Layer (Repositories & Services)        │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Repositories                                     │  │
│  │  - data/repositories/                             │  │
│  └───────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Services                                         │  │
│  │  - data/services/ (Dio http/, clients/ Retrofit) │  │
│  └───────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Models                                           │  │
│  │  - data/models/ (Freezed, JSON serializable)      │  │
│  └───────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────┐  │
│  │  Data Sources                                     │  │
│  │  - data/datasources/                              │  │
│  │    - Remote (API via Retrofit & Dio)              │  │
│  │    - Local (SharedPreferences, Isar)              │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

## Key Technologies & Dependencies

### State Management
- **flutter_riverpod** (^2.1.1) - Immutable state management
- **hooks_riverpod** - Riverpod hooks integration
- **flutter_hooks** - Functional component approach
- **riverpod_annotation** - Code generation for providers

### Networking & Serialization
- **dio** (^5.0.1) - HTTP client
- **retrofit** (>=4.0.0 <5.0.0) - Type-safe REST client
- **json_annotation** - JSON serialization

### Models & Immutability
- **freezed_annotation** - Immutable models & union types
- **riverpod_state** - State management helpers

### Routing
- **go_router** (^16.0.0) - Navigation management
- **responsive_framework** - Responsive UI support

### UI & Styling
- **flutter_svg** (^2.0.2) - SVG rendering
- **google_fonts** - Custom fonts
- **cupertino_icons** - iOS-style icons

### Localization
- **flutter_localizations** - Localization support
- **intl** (^0.20.2) - Internationalization

### Utilities
- **logger** (^2.0.2) - Logging
- **shared_preferences** - Local key-value storage

## Feature Module Structure

Each feature under `lib/src/<feature>/` uses a **flat** layout (no `presentation/`, `screens/`, or `viewmodels/`):

```
feature/
├── <feature>_page.dart     (entry route — widget class *Page)
├── components/             (Reusable feature-local UI)
└── models/                 (optional — only if UI needs a dedicated type)
```

Riverpod providers (state, async, repository calls) live in **`lib/data/providers/`**, not under `src/`.

## Navigation Flow

```
main.dart → app.dart → router/ (Go Router) → src/entry_point.dart → Features
```

---

**Architecture Pattern**: Layered UI + Riverpod providers (`data/providers`) + repositories/services
**Code Generation**: Freezed, JSON serialization, Go Router, Riverpod Providers
