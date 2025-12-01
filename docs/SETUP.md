# 🔧 Guía de Configuración - COS+

Esta guía te ayudará a configurar el proyecto COS+ en tu entorno de desarrollo local.

## 📋 Prerrequisitos

- **Flutter SDK** >= 3.7.2
- **Dart SDK** >= 3.7.2
- **Firebase Account** con proyecto configurado
- **Supabase Account** con proyecto(s) configurado(s)
- **Google Cloud Account** para Google Apps Script (opcional)

## 🚀 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/jozzer182/COS_APP.git
cd COS_APP
```

### 2. Configurar variables de entorno

1. Copia el archivo de plantilla:
```bash
cp .env.example .env
```

2. Edita `.env` con tus credenciales reales:
```bash
# Abre el archivo con tu editor preferido
code .env  # VS Code
notepad .env  # Windows
nano .env  # Linux/Mac
```

### 3. Obtener credenciales de Firebase

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto (o crea uno nuevo)
3. Ve a **Configuración del proyecto** > **General**
4. Desplázate hasta "Tus apps" y selecciona la app web
5. Copia los valores de configuración:
   - `apiKey` → `FIREBASE_API_KEY`
   - `appId` → `FIREBASE_APP_ID`
   - `messagingSenderId` → `FIREBASE_MESSAGING_SENDER_ID`
   - `projectId` → `FIREBASE_PROJECT_ID`
   - `authDomain` → `FIREBASE_AUTH_DOMAIN`
   - `databaseURL` → `FIREBASE_DATABASE_URL`
   - `storageBucket` → `FIREBASE_STORAGE_BUCKET`
   - `measurementId` → `FIREBASE_MEASUREMENT_ID`

### 4. Obtener credenciales de Supabase

1. Ve a [Supabase Dashboard](https://supabase.com/dashboard)
2. Selecciona tu proyecto
3. Ve a **Settings** > **API**
4. Copia:
   - **Project URL** → `SUPABASE_*_URL`
   - **anon public key** o **service_role key** → `SUPABASE_*_KEY`

> **Nota:** El proyecto usa 3 instancias de Supabase diferentes:
> - `SUPABASE_MAIN_*`: Para inicialización principal
> - `SUPABASE_PRINCIPAL_*`: Para datos de contratos, proveedores, etc.
> - `SUPABASE_PROCESADO_*`: Para posiciones procesadas

### 5. Configurar Google Apps Script (opcional)

Si necesitas las funciones de integración con Google Sheets:

1. Crea un nuevo proyecto en [Google Apps Script](https://script.google.com/)
2. Implementa las funciones necesarias (`getHoja`, `upload`)
3. Publica como aplicación web
4. Copia la URL → `GOOGLE_SCRIPT_DATA_URL` y `GOOGLE_SCRIPT_FILE_UPLOAD_URL`

### 6. Instalar dependencias

```bash
flutter pub get
```

### 7. Ejecutar la aplicación

```bash
# Para web
flutter run -d chrome

# Para Windows
flutter run -d windows

# Para Android
flutter run -d android
```

## 📁 Estructura del archivo .env

```env
# Firebase
FIREBASE_API_KEY=AIza...
FIREBASE_APP_ID=1:123456789:web:abc123
FIREBASE_MESSAGING_SENDER_ID=123456789
FIREBASE_PROJECT_ID=my-project
FIREBASE_AUTH_DOMAIN=my-project.firebaseapp.com
FIREBASE_DATABASE_URL=https://my-project-default-rtdb.firebaseio.com
FIREBASE_STORAGE_BUCKET=my-project.appspot.com
FIREBASE_MEASUREMENT_ID=G-XXXXXXXXXX

# Supabase Main
SUPABASE_MAIN_URL=https://xxxxx.supabase.co
SUPABASE_MAIN_KEY=eyJhbG...

# Supabase Principal
SUPABASE_PRINCIPAL_URL=https://xxxxx.supabase.co
SUPABASE_PRINCIPAL_KEY=eyJhbG...

# Supabase Procesado
SUPABASE_PROCESADO_URL=https://xxxxx.supabase.co
SUPABASE_PROCESADO_KEY=eyJhbG...

# Google Apps Script
GOOGLE_SCRIPT_DATA_URL=https://script.google.com/macros/s/.../exec
GOOGLE_SCRIPT_FILE_UPLOAD_URL=https://script.google.com/macros/s/.../exec
```

## ⚠️ Solución de Problemas

### Error: "No se encontró el archivo .env"

Asegúrate de que el archivo `.env` existe en la raíz del proyecto y tiene el formato correcto.

### Error de conexión a Firebase

1. Verifica que las credenciales en `.env` son correctas
2. Asegúrate de que tu proyecto Firebase tiene habilitado Authentication y Realtime Database
3. Verifica las reglas de seguridad de Firebase

### Error de conexión a Supabase

1. Verifica las URLs y keys en `.env`
2. Asegúrate de que las tablas necesarias existen en tu base de datos Supabase
3. Verifica las políticas de Row Level Security (RLS)

## 📞 Soporte

Si tienes problemas con la configuración, puedes:

1. Abrir un [Issue en GitHub](https://github.com/jozzer182/COS_APP/issues)
2. Contactar al desarrollador: jose_zarabandad@enel.com

