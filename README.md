# COS+ - Service Order Control

<div align="center">

<img src="images/customer_outline.png" alt="COS+ Logo" width="120"/>

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)

**Comprehensive service order management system for the energy sector**

[Features](#-features) •
[Installation](#-installation) •
[Configuration](#-configuration) •
[Architecture](#-architecture) •
[Contact](#-contact)

</div>

---

## 📋 Description

**COS+** (Service Order Control Plus) is a multi-platform Flutter application designed for comprehensive management of contracts, service orders, invoices, and conformities in the energy sector. It enables real-time project tracking, vendor control, and contractual position analysis.

## ✨ Features

### 📊 Data Management
- **Contracts**: Complete contract management with vendors
- **Positions**: Detailed contractual position control
- **Invoices**: Invoice tracking and management
- **Conformities**: Approval and conformity system
- **Vendors**: Integrated vendor database

### 🔐 Security
- Firebase Auth authentication
- Profile and role-based permission management
- Environment variables for sensitive credentials
- Email verification for new users

### 📱 Multi-platform
- ✅ Web (Chrome, Edge, Firefox)
- ✅ Windows Desktop
- ⏳ Android (configuration pending)
- ⏳ iOS (configuration pending)

### 🔄 Synchronization
- Real-time synchronization with Firebase Realtime Database
- Integration with multiple Supabase instances
- Fallback to Google Apps Script for legacy data

## 🛠 Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter 3.7+ |
| **Language** | Dart 3.7+ |
| **State Management** | Flutter BLoC |
| **Backend** | Firebase (Auth, Realtime DB, Analytics) |
| **Database** | Supabase (PostgreSQL) |
| **APIs** | Google Apps Script |
| **Routing** | GetX |

## 📦 Installation

### Prerequisites

- Flutter SDK >= 3.7.2
- Dart SDK >= 3.7.2
- Firebase account with configured project
- Supabase account with configured project(s)

### Installation Steps

```bash
# 1. Clone the repository
git clone https://github.com/jozzer182/COS_APP.git
cd COS_APP

# 2. Configure environment variables
cp .env.example .env
# Edit .env with your actual credentials

# 3. Install dependencies
flutter pub get

# 4. Run the application
flutter run -d chrome  # For web
flutter run -d windows # For Windows
```

## ⚙️ Configuration

### Environment Variables

The project uses `flutter_dotenv` to manage credentials securely. Copy `.env.example` to `.env` and fill in your values:

```env
# Firebase Configuration
FIREBASE_API_KEY=your_api_key
FIREBASE_APP_ID=your_app_id
FIREBASE_PROJECT_ID=your_project_id
...

# Supabase Configuration
SUPABASE_MAIN_URL=https://your-project.supabase.co
SUPABASE_MAIN_KEY=your_key
...

# Google Apps Script
GOOGLE_SCRIPT_DATA_URL=https://script.google.com/macros/s/.../exec
```

📖 **Detailed Guide**: See [docs/SETUP.md](docs/SETUP.md) for complete instructions.

## 🏗 Architecture

```
lib/
├── bloc/                    # State management (BLoC pattern)
│   ├── main_bloc.dart
│   ├── main_event.dart
│   └── main_state.dart
├── resources/               # Utilities and configuration
│   ├── env_config.dart      # Environment variables access
│   └── ...
├── contratos/               # Contracts module
│   ├── controller/
│   ├── model/
│   └── view/
├── facturas/                # Invoices module
├── posiciones/              # Positions module
├── proveedores/             # Vendors module
├── conformidades/           # Conformities module
├── login/                   # Authentication
├── Home/                    # Home page
└── main.dart                # Entry point
```

### Architecture Pattern

The project follows an **MVC + BLoC** architecture:

- **Model**: Data classes in `*/model/`
- **View**: UI widgets in `*/view/`
- **Controller**: Business logic in `*/controller/`
- **BLoC**: Centralized state management in `bloc/`

## 🔒 Security

This project handles sensitive information. Make sure to:

1. ✅ **NEVER** commit the `.env` file
2. ✅ Use `.env.example` as reference
3. ✅ Review `.gitignore` before pushing
4. ✅ Don't hardcode credentials in code

### Files Excluded from Repository

- `.env` - Environment variables
- `android/app/google-services.json` - Firebase Android configuration
- `ios/Runner/GoogleService-Info.plist` - Firebase iOS configuration
- `*.csv` - Data files

## 📊 Main Dependencies

```yaml
dependencies:
  flutter_bloc: ^9.1.0       # State management
  firebase_core: ^3.13.0     # Firebase base
  firebase_auth: ^5.5.2      # Authentication
  firebase_database: ^11.3.5 # Realtime Database
  supabase_flutter: ^2.8.4   # Database
  flutter_dotenv: ^5.2.1     # Environment variables
  get: ^4.6.6                # Routing and utilities
  http: ^1.1.0               # HTTP requests
  fl_chart: ^0.64.0          # Charts
```

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📬 Contact

**José Zarabanda**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/zarabandajose/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/jozzer182)
[![Website](https://img.shields.io/badge/Website-FF7139?style=for-the-badge&logo=firefox&logoColor=white)](https://zarabanda-dev.web.app/)

---

<div align="center">

Developed with ❤️ for ENEL Colombia

</div>
