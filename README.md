# COS+ - Control de Órdenes de Servicio

<div align="center">

<img src="images/customer_outline.png" alt="COS+ Logo" width="120"/>

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)

**Sistema integral de gestión de órdenes de servicio para el sector energético**

[Características](#-características) •
[Instalación](#-instalación) •
[Configuración](#-configuración) •
[Arquitectura](#-arquitectura) •
[Contacto](#-contacto)

</div>

---

## 📋 Descripción

**COS+** (Control de Órdenes de Servicio Plus) es una aplicación Flutter multiplataforma diseñada para la gestión integral de contratos, órdenes de servicio, facturas y conformidades en el sector energético. Permite el seguimiento en tiempo real de proyectos, control de proveedores y análisis de posiciones contractuales.

## ✨ Características

### 📊 Gestión de Datos
- **Contratos**: Administración completa de contratos con proveedores
- **Posiciones**: Control detallado de posiciones contractuales
- **Facturas**: Seguimiento y gestión de facturación
- **Conformidades**: Sistema de aprobación y conformidades
- **Proveedores**: Base de datos de proveedores integrada

### 🔐 Seguridad
- Autenticación con Firebase Auth
- Gestión de perfiles y permisos por roles
- Variables de entorno para credenciales sensibles
- Verificación de email para nuevos usuarios

### 📱 Multiplataforma
- ✅ Web (Chrome, Edge, Firefox)
- ✅ Windows Desktop
- ⏳ Android (configuración pendiente)
- ⏳ iOS (configuración pendiente)

### 🔄 Sincronización
- Sincronización en tiempo real con Firebase Realtime Database
- Integración con múltiples instancias de Supabase
- Fallback a Google Apps Script para datos legacy

## 🛠 Stack Tecnológico

| Categoría | Tecnología |
|-----------|------------|
| **Framework** | Flutter 3.7+ |
| **Lenguaje** | Dart 3.7+ |
| **State Management** | Flutter BLoC |
| **Backend** | Firebase (Auth, Realtime DB, Analytics) |
| **Base de Datos** | Supabase (PostgreSQL) |
| **APIs** | Google Apps Script |
| **Routing** | GetX |

## 📦 Instalación

### Prerrequisitos

- Flutter SDK >= 3.7.2
- Dart SDK >= 3.7.2
- Cuenta de Firebase con proyecto configurado
- Cuenta de Supabase con proyecto(s) configurado(s)

### Pasos de instalación

```bash
# 1. Clonar el repositorio
git clone https://github.com/jozzer182/COS_APP.git
cd COS_APP

# 2. Configurar variables de entorno
cp .env.example .env
# Edita .env con tus credenciales reales

# 3. Instalar dependencias
flutter pub get

# 4. Ejecutar la aplicación
flutter run -d chrome  # Para web
flutter run -d windows # Para Windows
```

## ⚙️ Configuración

### Variables de Entorno

El proyecto utiliza `flutter_dotenv` para gestionar credenciales de forma segura. Copia `.env.example` a `.env` y completa con tus valores:

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

📖 **Guía detallada**: Ver [docs/SETUP.md](docs/SETUP.md) para instrucciones completas.

## 🏗 Arquitectura

```
lib/
├── bloc/                    # State management (BLoC pattern)
│   ├── main_bloc.dart
│   ├── main_event.dart
│   └── main_state.dart
├── resources/               # Utilidades y configuración
│   ├── env_config.dart      # Acceso a variables de entorno
│   └── ...
├── contratos/               # Módulo de contratos
│   ├── controller/
│   ├── model/
│   └── view/
├── facturas/                # Módulo de facturas
├── posiciones/              # Módulo de posiciones
├── proveedores/             # Módulo de proveedores
├── conformidades/           # Módulo de conformidades
├── login/                   # Autenticación
├── Home/                    # Página principal
└── main.dart                # Entry point
```

### Patrón de Arquitectura

El proyecto sigue una arquitectura **MVC + BLoC**:

- **Model**: Clases de datos en `*/model/`
- **View**: Widgets de UI en `*/view/`
- **Controller**: Lógica de negocio en `*/controller/`
- **BLoC**: Gestión de estado centralizada en `bloc/`

## 🔒 Seguridad

Este proyecto maneja información sensible. Asegúrate de:

1. ✅ **NUNCA** commitear el archivo `.env`
2. ✅ Usar `.env.example` como referencia
3. ✅ Revisar `.gitignore` antes de hacer push
4. ✅ No hardcodear credenciales en el código

### Archivos excluidos del repositorio

- `.env` - Variables de entorno
- `android/app/google-services.json` - Configuración Firebase Android
- `ios/Runner/GoogleService-Info.plist` - Configuración Firebase iOS
- `*.csv` - Archivos de datos

## 📊 Dependencias Principales

```yaml
dependencies:
  flutter_bloc: ^9.1.0       # State management
  firebase_core: ^3.13.0     # Firebase base
  firebase_auth: ^5.5.2      # Autenticación
  firebase_database: ^11.3.5 # Realtime Database
  supabase_flutter: ^2.8.4   # Base de datos
  flutter_dotenv: ^5.2.1     # Variables de entorno
  get: ^4.6.6                # Routing y utilidades
  http: ^1.1.0               # HTTP requests
  fl_chart: ^0.64.0          # Gráficos
```

## 🤝 Contribución

1. Fork el proyecto
2. Crea tu feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push al branch (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📞 Contacto

**José Zarabanda**

- 📧 Email: jose_zarabandad@enel.com
- 🐙 GitHub: [@jozzer182](https://github.com/jozzer182)

---

<div align="center">

Desarrollado con ❤️ para ENEL Colombia

</div>
