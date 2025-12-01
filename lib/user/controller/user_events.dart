part of '../../bloc/main_bloc.dart';

class CrearUsuario extends MainEvent {}

class CambiarUsuario extends MainEvent {
  final User user;
  CambiarUsuario(this.user);
}
