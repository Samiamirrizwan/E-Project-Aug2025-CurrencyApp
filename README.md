# E-Project-Aug2025-CurrencyApp
The app is designed to meet the financial needs of a broad user base, including individuals, travelers, and businesses.

# CurrenSee - Currency Conversion Flutter App

![Project Banner](https://placehold.co/1200x300/4285f4/ffffff?text=CurrenSee&font=raleway)

Welcome to the CurrenSee project repository. This application is a real-time currency conversion tool designed to meet the needs of travelers, individuals, and businesses. This project is being developed for and aims to provide a robust, user-friendly, and scalable financial tool.

## Project Objectives

The primary goal is to create a live, synchronous eProject that simulates a real-world development environment. The application will serve as a comprehensive tool for currency management, allowing users to:

* Perform real-time currency conversions.
* Track historical exchange rate data.
* Set personalized rate alerts.
* Stay updated with market news and trends.
* Manage their conversion history and preferences.

## Tech Stack

* **Framework:** Flutter
* **Language:** Dart
* **State Management:** Flutter Riverpod
* **Backend & Database:** Firebase (Authentication, Firestore, Cloud Functions for Notifications)
* **API:** A reliable currency exchange rate API (e.g., exchangeratesapi.io, openexchangerates.org)
* **Charting:** `fl_chart` or similar package for historical data.

## Team Roles & Responsibilities

This project is structured for a team of six. To ensure equal contribution, responsibilities are divided into specialized domains.

| Member | Role | Primary Responsibilities |
| :--- | :--- | :--- |
| **Team Member 1** | **Project Lead & Auth Specialist** | - Manages project board & tasks.<br>- Implements User Registration & Authentication (email/pass, social).<br>- Manages app security and Firebase integration. |
| **Team Member 2** | **Core Logic & API Specialist** | - Implements real-time currency conversion logic.<br>- Integrates external exchange rate API.<br>- Manages data models and repository patterns. |
| **Team Member 3** | **UI/UX Lead & Frontend Dev** | - Develops the main UI for Currency Conversion & Currency List screens.<br>- Ensures UI is intuitive, responsive, and accessible.<br>- Manages the overall theme and design system. |
| **Team Member 4** | **Features & Frontend Dev** | - Implements Exchange Rate Info (with charts) & Conversion History screens.<br>- Implements User Preferences and Feedback sections. |
| **Team Member 5** | **Advanced Features & Backend Dev** | - Implements Rate Alerts using Firebase Cloud Functions for push notifications.<br>- Implements Currency News & Market Trends feed.<br>- Manages backend logic for notifications. |
| **Team Member 6** | **QA, Docs & Support Specialist**| - Implements User Support/Help Center.<br>- Writes user & developer documentation.<br>- Conducts testing, manages error handling, and creates the final demo video. |

## Project Breakdown: A Phased Approach

We will follow a laddered, step-by-step implementation plan.

### **Phase 1: Foundation & Core Functionality (Weeks 1-2)**
1.  **Setup:** Initialize Flutter project, set up Firebase, and establish Git repository.
2.  **Authentication:** Implement login and registration screens and logic (**Team Member 1**).
3.  **Core Conversion UI:** Build the main converter screen UI (**Team Member 3**).
4.  **API Integration:** Connect to the currency API and fetch real-time rates (**Team Member 2**).
5.  **Basic Conversion:** Implement the logic to calculate and display converted amounts (**Team Member 2**).

### **Phase 2: Feature Expansion (Weeks 3-4)**
1.  **Currency List:** Create a searchable and filterable list of all currencies (**Team Member 3**).
2.  **Conversion History:** Store and display past conversions for logged-in users (**Team Member 4**).
3.  **Historical Data:** Implement the exchange rate information screen with historical charts (**Team Member 4**).
4.  **User Preferences:** Allow users to set a default currency (**Team Member 4**).

### **Phase 3: Advanced Features & Polish (Weeks 5-6)**
1.  **Rate Alerts:** Implement UI for setting alerts (**Team Member 5**).
2.  **Push Notifications:** Set up backend logic to send notifications when rates are met (**Team Member 5**).
3.  **News Feed:** Integrate a news source for market trends (**Team Member 5**).
4.  **Support & Feedback:** Build the help center and feedback submission forms (**Team Member 6**).

### **Phase 4: Testing, Documentation & Deployment (Weeks 7-8)**
1.  **Testing:** Thoroughly test all features and fix bugs (**Team Member 6**).
2.  **Documentation:** Finalize user guides and developer documentation (**Team Member 6**).
3.  **Performance Tuning:** Optimize for responsiveness and loading time.
4.  **Final Video:** Create a complete application demo video (**Team Member 6**).
5.  **Release:** Prepare for deployment.

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd currensee
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

## Git Workflow

* All work must be done on feature branches (e.g., `feature/user-auth`, `feature/conversion-ui`).
* Create a Pull Request (PR) to merge into the `develop` branch.
* The `main` branch is for stable releases only.

Let's build a robust and valuable application together!
