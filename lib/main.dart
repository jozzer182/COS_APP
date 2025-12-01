import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'bloc/main_bloc.dart';
import 'Home/home_page.dart';
import 'listener_messages_errors.dart';
import 'login/login_page.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/user/model/user_model.dart' as userModel;
import 'resources/mostrar_mensaje.dart';
import 'resources/env_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

void main() async {
  // FirebaseDatabase database = FirebaseDatabase.instance;
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Load environment variables FIRST
    await dotenv.load(fileName: ".env");
    
    await initLocalStorage();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.setLanguageCode("es");
    await FirebaseAnalytics.instance.logAppOpen();

    // Inicializar Supabase usando variables de entorno
    await supabase.Supabase.initialize(
      url: EnvConfig.supabaseMainUrl,
      anonKey: EnvConfig.supabaseMainKey,
      debug: false, // Configura en false para producción
    );

    runApp(const MyApp());
  } catch (e) {
    print(e);
    print('Error al inicializar Firebase');
    print(e.runtimeType);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color? themeColor;
  bool isDark = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc()..add(Load()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<MainBloc, MainState>(
            listenWhen:
                (previous, current) => previous.isDark != current.isDark,
            listener: (context, state) {
              setState(() {
                isDark = state.isDark;
              });
            },
          ),
          BlocListener<MainBloc, MainState>(
            listenWhen:
                (previous, current) =>
                    previous.themeColor != current.themeColor,
            listener: (context, state) {
              setState(() {
                themeColor = state.themeColor;
              });
            },
          ),
        ],
        child: GetMaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          themeMode: ThemeMode.light,
          theme: ThemeData(
            colorSchemeSeed: themeColor ?? Colors.deepPurple,
            brightness: isDark ? Brightness.dark : Brightness.light,
          ),
          title: 'COS+',
          debugShowCheckedModeBanner: false,
          home: ListenerCustom(
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, userSnap) {
                if (userSnap.hasData && userSnap.data!.emailVerified) {
                  DatabaseReference mensajeStream = FirebaseDatabase.instance
                      .ref('mensaje');
                  return StreamBuilder<DatabaseEvent>(
                    stream: mensajeStream.onValue,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<DatabaseEvent> mensajeSnap,
                    ) {
                      if (mensajeSnap.hasError) {
                        return Text('Error: ${mensajeSnap.error}');
                      }
                      if (mensajeSnap.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      String? mensaje =
                          mensajeSnap.data?.snapshot.value.toString();
                      context.read<MainBloc>().add(Mensaje(mensaje ?? ''));
                      DatabaseReference userStream = FirebaseDatabase.instance
                          .ref('perfiles/${userSnap.data!.uid}');
                      return StreamBuilder<DatabaseEvent>(
                        stream: userStream.onValue,
                        builder: (context, perfilSnap) {
                          if (perfilSnap.hasError) {
                            mostrarMensaje(
                              context: context,
                              mensaje: 'Error de lectura del Perfil de Usuario (Stream)',
                              color: Colors.red,
                            );
                            return Text('Error: ${perfilSnap.error}');
                          }
                          if (perfilSnap.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          
                          // print('se recibio realmente un : ${perfilSnap.data?.snapshot.value.runtimeType}');
                          
                          // Verificar si hay datos
                          if (perfilSnap.data?.snapshot.value == null) {
                            mostrarMensaje(
                              context: context,
                              mensaje: 'Error: No hay datos de perfil',
                              color: Colors.red,
                            );
                            return const HomePage();
                          }
                          
                          // Verificar si es un mapa
                          if (!(perfilSnap.data!.snapshot.value is Map)) {
                            mostrarMensaje(
                              context: context,
                              mensaje: 'Error: El formato de perfil no es un mapa',
                              color: Colors.red,
                            );
                            return const HomePage();
                          }
                          
                          // Crear nuevo mapa
                          Map<String, dynamic> perfilMap = {};
                          
                          // Convertir de Map<Object?, Object?> a Map<String, dynamic>
                          Map originalMap = perfilSnap.data!.snapshot.value as Map;
                          originalMap.forEach((k, v) {
                            perfilMap[k.toString()] = v;
                          });
                          
                          // Verificar perfil
                          String? perfilNombre = perfilMap['perfil']?.toString();
                          if (perfilNombre == null) {
                            mostrarMensaje(
                              context: context,
                              mensaje: 'Error: Campo perfil no encontrado',
                              color: Colors.red,
                            );
                            return const HomePage();
                          }
                          
                          DatabaseReference permisosStream = FirebaseDatabase
                              .instance
                              .ref('permisos/$perfilNombre');
                          return StreamBuilder<DatabaseEvent>(
                            stream: permisosStream.onValue,
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<DatabaseEvent> permisosSnap,
                            ) {
                              if (permisosSnap.hasError) {
                                mostrarMensaje(
                                  context: context,
                                  mensaje:
                                      'Error de lectura de los Permisos de Usuario',
                                  color: Colors.red,
                                );
                                return Text('Error: ${permisosSnap.error}');
                              }
                              if (permisosSnap.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              bool seRecibioUnaLista =
                                  permisosSnap.data?.snapshot.value
                                      is List<dynamic>;
                              if (!seRecibioUnaLista) {
                                mostrarMensaje(
                                  context: context,
                                  mensaje:
                                      'Error de lectura de los Permisos de Usuario No se recibió una lista',
                                  color: Colors.red,
                                );
                                return const HomePage();
                              }
                              List<dynamic> permisosRaw =
                                  permisosSnap.data?.snapshot.value
                                      as List<dynamic>;
                              List<String> permisosList =
                                  permisosRaw.map((e) => e.toString()).toList();
                              userModel.User user = userModel.User(
                                uid: userSnap.data!.uid,
                                email: userSnap.data!.email ?? '',
                                nombre: perfilMap['nombre'] ?? '',
                                perfil: perfilMap['perfil'] ?? '',
                                creado:
                                    userSnap.data!.metadata.creationTime
                                        .toString(),
                                permisos: permisosList,
                              );
                              context.read<MainBloc>().add(
                                CambiarUsuario(user),
                              );
                              return const HomePage();
                            },
                          );
                        },
                      );
                    },
                  );
                }
                return LoginPage(snapshot: userSnap);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

void showErrorMessage(BuildContext context, MainState state) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 8),
      backgroundColor: state.messageColor,
      content: Text(state.message),
    ),
  );
}
