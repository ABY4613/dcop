# SafeHer - Women Safety App Implementation Walkthrough

This document outlines the implementation of the **SafeHer** application, a real-time emergency response system built with Flutter and Firebase.

## 🏗️ Architecture: MVC (Model-View-Controller)

The project follows a strict separation of concerns to ensure scalability and maintainability.

### 1. Models (`lib/models/`)
- **`UserModel`**: Manages user data and roles (Woman, Guardian, Police).
- **`AlertModel`**: Represents an active SOS event with location and timestamp.
- **`GuardianModel`**: Links women to their emergency contacts.

### 2. Controllers (`lib/controllers/`)
- **`AuthController`**: Handles phone authentication logic and user state persistence.
- **`SosController`**: Manages the logic for triggering SOS alerts and location updates.

### 3. Services (`lib/services/`)
- **`FirebaseAuthService`**: Wrapper for Firebase Auth (Phone Login).
- **`FirestoreService`**: Handles all CRUD operations for users, alerts, and guardians.

### 4. Views (`lib/views/`)
- **`Auth/`**: Login and OTP verification screens.
- **`Home/`**: Main dashboard with the animated SOS button.
- **`Guardian/`**: Screens to add and view emergency contacts.
- **`Police/`**: Real-time dashboard for police to track active alerts.
- **`Map/`**: Live tracking via Google Maps.

---

## 🚀 Setup Requirements

Before running the application, please complete the following steps:

### 1. Firebase Configuration
1. Create a project in the [Firebase Console](https://console.firebase.google.com/).
2. Enable **Phone Authentication**.
3. Enable **Cloud Firestore**.
4. Run `flutterfire configure` in your terminal to generate `lib/firebase_options.dart`.

### 2. Google Maps API Key
Obtain an API key from [Google Cloud Console](https://console.cloud.google.com/) and add it to:
- **Android**: `android/app/src/main/AndroidManifest.xml`
- **iOS**: `ios/Runner/AppDelegate.swift`

### 3. Permissions
The app requires the following permissions:
- `Location` (Background & Foreground)
- `Camera` & `Microphone` (for evidence recording)
- `Notifications` (FCM)

---

## 🔥 Key Features Implemented
- **One-Tap SOS**: Triggers an alert with a 2-second pulse animation.
- **Real-Time GPS**: Captures the exact coordinates of the user during emergency.
- **Role-Based Routing**: Automatically directs users to the correct dashboard (Woman vs. Police) upon login.
- **Guardian Management**: Easy interface to store and manage safety contacts.
