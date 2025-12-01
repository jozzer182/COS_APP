import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration class to access environment variables
/// All sensitive credentials are stored in .env file and accessed through this class
class EnvConfig {
  // ========================================
  // Firebase Configuration
  // ========================================
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  static String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';
  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get firebaseAuthDomain =>
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
  static String get firebaseDatabaseUrl =>
      dotenv.env['FIREBASE_DATABASE_URL'] ?? '';
  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  static String get firebaseMeasurementId =>
      dotenv.env['FIREBASE_MEASUREMENT_ID'] ?? '';

  // ========================================
  // Supabase Main Configuration (main.dart)
  // ========================================
  static String get supabaseMainUrl => dotenv.env['SUPABASE_MAIN_URL'] ?? '';
  static String get supabaseMainKey => dotenv.env['SUPABASE_MAIN_KEY'] ?? '';

  // ========================================
  // Supabase Principal Configuration (controllers)
  // ========================================
  static String get supabasePrincipalUrl =>
      dotenv.env['SUPABASE_PRINCIPAL_URL'] ?? '';
  static String get supabasePrincipalKey =>
      dotenv.env['SUPABASE_PRINCIPAL_KEY'] ?? '';

  // ========================================
  // Supabase Procesado Configuration (posiciones procesadas)
  // ========================================
  static String get supabaseProcesadoUrl =>
      dotenv.env['SUPABASE_PROCESADO_URL'] ?? '';
  static String get supabaseProcesadoKey =>
      dotenv.env['SUPABASE_PROCESADO_KEY'] ?? '';

  // ========================================
  // Google Apps Script APIs
  // ========================================
  static String get googleScriptDataUrl =>
      dotenv.env['GOOGLE_SCRIPT_DATA_URL'] ?? '';
  static String get googleScriptFileUploadUrl =>
      dotenv.env['GOOGLE_SCRIPT_FILE_UPLOAD_URL'] ?? '';
}

