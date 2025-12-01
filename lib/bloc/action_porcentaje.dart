

import 'main_bloc.dart';

onCambiarPorcentajeCarga(
  CambiarPorcentajeCarga event,
  emit,
  MainState Function() state,
) {
  print('onCambiarPorcentajeCarga');
  emit(state()
      .copyWith(porcentajecarga: (event.porcentaje + state().porcentajecarga)));
}

onCambiarPorcentajeCargaDisponibilidad(
  CambiarPorcentajeCargaDisponibilidad event,
  emit,
  MainState Function() state,
) {
  print('onCambiarPorcentajeCargaDisponibilidad');
  emit(state().copyWith(porcentajecargadisponibilidad: event.porcentaje));
}
