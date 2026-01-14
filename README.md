<a name="readme-top"></a>

<div align="center">
  <h1>🚕 RYDO</h1>
  <p><b>Rethinking the Ride-Hailing Experience.</b></p>

  <img src="assets/images/rydo_banner.png" alt="Rydo Banner" width="100%" style="border-radius: 12px;" />

  <br />

  [![Flutter](https://img.shields.io/badge/Flutter-3.27.0-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.6.0-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![OpenStreetMap](https://img.shields.io/badge/OpenStreetMap-Enabled-7EBC6F?style=for-the-badge&logo=openstreetmap&logoColor=white)](https://www.openstreetmap.org/)
  [![Currency-PKR](https://img.shields.io/badge/Currency-PKR-006600?style=for-the-badge)](https://en.wikipedia.org/wiki/Pakistani_rupee)

  <p align="center">
    A high-fidelity, open-source ride-booking template built to showcase what’s possible with modern Flutter development.
    <br />
    <br />
    <a href="https://github.com/Choudhary-Khuzaim/Rydo/issues">Report Bug</a>
    ·
    <a href="https://github.com/Choudhary-Khuzaim/Rydo/issues">Request Feature</a>
  </p>
</div>

---

## � The Vision Behind Rydo

Most ride-hailing templates focus on just the UI. With Rydo, I wanted to go a step further. This project isn't just about pretty screens—it’s about handling real-world logic: persistent navigation, live location-to-address conversion, and a fully localized financial ecosystem (PKR).

I've built this as a reference point for developers who want to see how to implement "premium" feel features like **Glassmorphism**, smooth **Sliver** interactions, and **OpenStreetMap** integration without the heavy costs of Google Maps APIs.

---

## 🆕 Major Updates (v1.1)

I've been pushing quite a few changes lately to make the app feel like a complete product:

*   **Financial Ecosystem (PKR)**: The entire app has been localized for Pakistan. Every price, wallet balance, and transaction history now uses **PKR (Rs.)** with realistic local scaling.
*   **Persistent Shell Navigation**: Refactored the architecture to use a custom `MainScreen` shell. This means your bottom nav bar stays put while you switch between map, wallet, and history—providing a seamless iOS-like experience.
*   **The Wallet Suite**: More than just a static screen. We now have:
    *   **Top Up**: Integrated amount selection and mockup payment method handling.
    *   **Send Money**: A full transfer flow with person-to-person search and quick contacts.
    *   **Activity Log**: A detailed, categorized history of every ride and refill.
*   **Smart Address Detection**: The map now does more than just show a blue dot. It automatically resolves your GPS coordinates into human-readable area names (like "Gulberg, Lahore" or "Clifton, Karachi") in real-time.
*   **Account Hub**: A dedicated space for personal info, preferences, and security settings, all built with custom Sliver effects for that "premium" feel.

---

## 🌟 Core Features

*   **�️ Maps & Geolocation**: Built on `flutter_map` (OpenStreetMap). It’s lightweight, fast, and completely free to use.
*   **🎨 Glassmorphic UI**: High-end translucent effects on the floating search bar and bottom navigation.
*   **💰 Wallet Integration**: Full end-to-end flow for managing balances and tracking spending.
*   **⚡ Optimized Performance**: State is managed efficiently to ensure 60FPS map interactions even on mid-range devices.
*   **� Modern Components**: Custom ride selection sheets, animated splash screens, and professional form handling.

---

## 🛠 Tech Stack

*   **Framework**: [Flutter](https://flutter.dev/) (Dart)
*   **Tile Server**: [OpenStreetMap](https://www.openstreetmap.org/)
*   **Location Services**: [geolocator](https://pub.dev/packages/geolocator) & [geocoding](https://pub.dev/packages/geocoding)
*   **Icons**: [Cupertino Icons](https://pub.dev/packages/cupertino_icons) & FontAwesome
*   **Proposed State Management**: [Riverpod](https://riverpod.dev/) (Currently scaling from `setState`)

---

## 🚀 Getting Started

To get this up and running on your local machine:

1.  **Clone the Repository**
    ```sh
    git clone https://github.com/Choudhary-Khuzaim/Rydo.git
    ```
2.  **Bootstrap Dependencies**
    ```sh
    cd Rydo
    flutter pub get
    ```
3.  **Run with Hot Reload**
    ```sh
    flutter run
    ```

**Dev Note:** For Android builds, double-check that `INTERNET` and `ACCESS_FINE_LOCATION` permissions are enabled in your `AndroidManifest.xml` to allow map tiles to load correctly.

---

## 🛣 Future Roadmap

- [ ] Firebase Auth & OTP Integration
- [ ] Real-time Driver Tracking via WebSockets
- [ ] Wallet Payment Gateway (Stripe/JazzCash integration)
- [ ] Driver-side dedicated dashboard
- [ ] Dark Mode Support (Full dynamic theme switching)

---

## 🤝 Community & Contributions

If you find this project helpful, give it a ⭐️! 

Got a bug report or a feature request? Open an issue. Want to contribute code? PRs are always welcome. I'm especially looking for help with refining the routing algorithms and state management.

---

## 📞 Connect with Me

**Khuzaim Sajjad** - Full Stack Developer
*   [GitHub](https://github.com/Choudhary-Khuzaim)
*   [LinkedIn](https://www.linkedin.com/in/khuzaimsajjad/)

---
<div align="center">
  <p>© 2026 Rydo Project. Thinking Forward. Moving Faster.</p>
</div>
