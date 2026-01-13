<a name="readme-top"></a>

<div align="center">

  <h1>🚕 RYDO</h1>

  <img src="assets/images/rydo_banner.png" alt="Rydo Banner" width="100%" />

  <br />
  <br />

  [![Flutter](https://img.shields.io/badge/Flutter-3.27.0-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.6.0-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![OpenStreetMap](https://img.shields.io/badge/OpenStreetMap-Enabled-7EBC6F?style=for-the-badge&logo=openstreetmap&logoColor=white)](https://www.openstreetmap.org/)
  [![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

  <h3>A modern, open-source ride-hailing app template built with Flutter.</h3>
  
  <p align="center">
    Built to demonstrate complex UI interactions, map integration, and professional state management patterns.
    <br />
    <br />
    <a href="https://github.com/Choudhary-Khuzaim/Rydo/issues">Report Bug</a>
    ·
    <a href="https://github.com/Choudhary-Khuzaim/Rydo/issues">Request Feature</a>
  </p>
</div>

<details>
  <summary><b>📚 Table of Contents</b></summary>
  <ol>
    <li><a href="#-about-the-project">About The Project</a></li>
    <li><a href="#-whats-new">What's New</a></li>
    <li><a href="#-features">Features</a></li>
    <li><a href="#-tech-stack">Tech Stack</a></li>
    <li><a href="#-getting-started">Getting Started</a></li>
    <li><a href="#-contact">Contact</a></li>
  </ol>
</details>

---

## 📖 About The Project

Rydo is a ride-booking application project I'm building to explore advanced Flutter concepts. The goal is to create something that feels like a real production app—smooth animations, proper architecture, and a design that stands out.

It's not just a UI kit; I'm implementing actual logic for maps, navigation, and user flows. It's a work in progress, but it's shaping up to be a solid reference for anyone building location-based apps.

---

## 🆕 What's New
I've been working heavily on the core navigation and map experience. Here are the latest updates:

*   **Switch to OpenStreetMap**: Moved away from Google Maps to `flutter_map` with OpenStreetMap. It's faster, free, and gives us more control over the tile styling.
*   **Persistent Navigation Shell**: Completely refactored the navigation. The app now uses a `MainScreen` shell, so your bottom navigation bar stays visible even when you switch between Home and Trips tabs. No more jarring screen transitions.
*   **Floating "Glassmorphism" UI**: 
    *   The Bottom Navigation Bar and Search Bar now "float" above the map.
    *   Added a sleek blur (backdrop filter) effect to these elements, giving them a modern, premium feel similar to iOS interfaces.
*   **Refined "Trips" Screen**: A dedicated history tab that fits perfectly into the new navigation structure.

---

## 🌟 Features

*   **🗺️ Interactive Map**: tailored OpenStreetMap integration with custom markers for users and drivers.
*   **📍 Real-Time Location**: Uses the `geolocator` package to track and center the user's position on demand.
*   **🎨 Premium Design**:
    *   **Glassmorphism**: Translucent, blurred UI elements.
    *   **Animations**: Custom transitions for the Onboarding and Login flows.
    *   **Clean Layouts**: Focus on typography and whitespace.
*   **🛣️ Routing**: Visualizing paths between pickup and dropoff points (using polyline algorithms).

---

## 🛠 Tech Stack

*   **Frontend**: [Flutter](https://flutter.dev/) (Dart)
*   **Maps**: [flutter_map](https://pub.dev/packages/flutter_map) (OpenStreetMap)
*   **Location**: [geolocator](https://pub.dev/packages/geolocator)
*   **State Management**: `setState` (Migrating to Provider/Riverpod as complexity grows)

---

## 🚀 Getting Started

If you want to run this locally and mess around with the code:

1.  **Clone the repo**
    ```sh
    git clone https://github.com/Choudhary-Khuzaim/Rydo.git
    ```
2.  **Install dependencies**
    ```sh
    cd Rydo
    flutter pub get
    ```
3.  **Run the app**
    ```sh
    flutter run
    ```

**Note for Android Users:** Ensure you have the `<uses-permission android:name="android.permission.INTERNET"/>` in your Manifest, otherwise the map tiles won't load.

---

## 🤝 Contributing

If you have ideas or find bugs (I'm sure there are some!), feel free to open an issue or submit a PR. I'm always open to feedback on the code structure or design choices.

---

## 📞 Contact

**Khuzaim Sajjad** - [GitHub](https://github.com/Choudhary-Khuzaim)

Project Link: [https://github.com/Choudhary-Khuzaim/Rydo](https://github.com/Choudhary-Khuzaim/Rydo)

---
<div align="center">
  <p>© 2026 Rydo Project.</p>
</div>
