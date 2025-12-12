# Worker Schedules (WorkLink iOS)

Smart scheduling app for managing factory shifts and worker transportation.  
Built for outsourcing companies and foreign workers in South Korea.

## 🚀 Overview

Worker Schedules is an iOS application that helps companies:

- Manage factories, departments and shifts
- Assign workers to factories and departments
- Control day / night shifts and weekly rotation
- Track attendance and “not coming / self-transport” statuses
- Use mock data while preparing for real backend integration

This repository is the **iOS client** for the broader *WorkLink* project.

## 🧩 Main Features

- 📍 Factory & department management UI  
- 👷 List of workers per factory and department  
- 🔁 Shift rotation (day / night) with weekly logic  
- 🚌 Transportation settings (company transport vs own car)  
- 📅 Weekly schedule view for factories  
- 🔔 Status updates when a worker can’t come or will go by himself  

> Note: this is a work-in-progress MVP focused on UI/UX and architecture.
> Backend (FastAPI + PostgreSQL) is developed in a separate project.

## 🛠 Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Architecture:** MVVM
- **Minimum iOS:** 16+  

## 🧱 Project Structure (high level)

```text
Worker-schedules/
 ├─ Models/          # Worker, Factory, Department, JobAd, Chat, etc.
 ├─ ViewModels/      # FactoryViewModel, CompanyHomeViewModel, ...
 ├─ Views/           # Screens for workers, companies, factories, chats
 ├─ Services/        # Mock data, helpers, routing
 └─ Resources/       # Assets, configuration


▶️ Running the App

Open the project in Xcode 15+

Select any iPhone simulator (iPhone 14+ recommended)

Run the app: Cmd + R

The app uses local mock data, so it works out of the box — no backend required.

📄 License

MIT – feel free to explore the code and architecture.
