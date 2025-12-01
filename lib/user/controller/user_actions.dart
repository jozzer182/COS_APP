// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:bloc/bloc.dart';
import '/user/model/user_model.dart' as userModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';

onCrearUsuario(Bl bl) async {
  var emit = bl.emit;
  MainState Function() state = bl.state;
  User? userFirebase = FirebaseAuth.instance.currentUser;
  bool noHayUsuario = userFirebase == null;
  if (noHayUsuario) {
    bl.mensaje(message: 'Inicie sesión ó registrese si es la primera vez que ingresa.');
    return;
  }
  String uid = userFirebase.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  DataSnapshot perfil = await ref.child('perfiles/$uid').get();
  bool noHayInformacion = !perfil.exists;
  if (noHayInformacion) {
    bl.mensaje(message: '🤕Error llamando📞 la tabla de datos Perfiles.');
    return;
  }
  // print('perfil: ${perfil.value}');
  // print('perfil type: ${perfil.value.runtimeType}');
  
  // Verificar si el valor es nulo
  if (perfil.value == null) {
    bl.mensaje(message: '🤕Error: Datos de perfil son nulos.');
    return;
  }
  
  // Verificar si el valor es un Map
  if (!(perfil.value is Map<Object?, Object?>)) {
    bl.mensaje(message: '🤕Error: El formato de perfil ha cambiado, no es un mapa.');
    return;
  }
  
  // Convertir a Map<String, dynamic> independientemente del tipo recibido
  Map<String, dynamic> perfilMap = {};
  
  // Si el valor es un mapa (sea LinkedMap u otro tipo), convertir cada entrada
  (perfil.value as Map<Object?, Object?>).forEach((key, value) {
    // Asegurar que las claves sean String
    String keyStr = key.toString();
    perfilMap[keyStr] = value;
  });
  
  // Verificar si existe el campo perfil
  if (!perfilMap.containsKey('perfil') || perfilMap['perfil'] == null) {
    bl.mensaje(message: '🤕Error: El campo "perfil" no existe o es nulo.');
    return;
  }
  
  String perfilNombre = perfilMap['perfil'].toString();
  
  // Verificar si existe el campo nombre
  if (!perfilMap.containsKey('nombre') || perfilMap['nombre'] == null) {
    bl.mensaje(message: '🤕Error: El campo "nombre" no existe o es nulo.');
    return;
  }
  
  DataSnapshot permisos = await ref.child('permisos/$perfilNombre').get();
  bool noHayPermisos = !permisos.exists;
  if (noHayPermisos) {
    bl.mensaje(message: '🤕Error llamando📞 la tabla de datos Permisos.');
    return;
  }
  
  List<String> permisosList = [];
  if (permisos.value != null) {
    if (permisos.value is List) {
      // Si es una lista, convertir cada elemento a String
      List<dynamic> permisosRaw = permisos.value as List<dynamic>;
      permisosList = permisosRaw.map((e) => e.toString()).toList();
    } else {
      bl.mensaje(message: '🤕Error: El formato de permisos ha cambiado, no es una lista.');
      return;
    }
  }
  
  userModel.User user = userModel.User(
    uid: uid,
    email: userFirebase.email ?? '',
    nombre: perfilMap['nombre'].toString(),
    perfil: perfilNombre,
    creado: userFirebase.metadata.creationTime.toString(),
    permisos: permisosList,
  );
  emit(state().copyWith(user: user));
}

onCambiarUsuario(
  CambiarUsuario event,
  Emitter<MainState> emit,
  MainState Function() state,
) {
  try {
    emit(
      state().copyWith(
        user: event.user,
      ),
    );
  } catch (e) {
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message: '🤕Error en CambiarUsuario ' +
          '⚠️$e => ${e.runtimeType}, ' +
          'intente recargar la página🔄, ' +
          'total errores: ${state().errorCounter + 1}',
    ));
  }
}
