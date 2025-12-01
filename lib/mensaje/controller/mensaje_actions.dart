import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/main_bloc.dart';

onMensaje(
  Mensaje event,
  Emitter<MainState> emit,
  MainState Function() state,
) {
  try {
    emit(
      state().copyWith(
        mensaje: event.mensaje,
      ),
    );
  } catch (e) {
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error en mensaje ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}
