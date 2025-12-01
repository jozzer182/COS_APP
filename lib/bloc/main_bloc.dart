// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:cos/cargacontratos/model/cargacontratos_model.dart';
import 'package:cos/conformidades/model/lcl_conf_list.dart';
import 'package:cos/vista_proyectos/model/vista_proyecto_list.dart';

import 'package:flutter/material.dart';

import '../cargacontratos/controller/cargacontratos_ctrl.dart';
import '../contratos/model/contratos_list.dart';
import '../cupo/model/cupo_list.dart';
import '../facturas/controller/facturas_list_ctrl.dart';
import '../facturas/model/facturas_list_model.dart';
import '../gac/model/gac_list.dart';
import '../conformidades/controller/lcl_conf_controller.dart';
import '../mensaje/controller/mensaje_actions.dart';
import '../posiciones/model/posiciones_list.dart';
import '../procesado_lcls/model/procesado_lcls_list.dart';
import '../procesado_posiciones/controller/procesado_posiciones_ctrl.dart';
import '../procesado_posiciones/model/procesado_posiciones_list.dart';
import '../proveedores/model/proveedores_list.dart';
import '../user/controller/user_actions.dart';
import '../user/model/user_model.dart';
import '../vista_contrato/model/vista_contrato_list.dart';
import '../vista_info/controller/vista_info_ctrl.dart';
import '../vista_info/model/vista_info_reg.dart';
import '../vista_personas/controller/vista_personas_controller.dart';
import '../vista_personas/model/vista_personas_list.dart';
import '../vista_proyectos/controller/vista_proyecto_controller.dart';
import 'action_color.dart';
import 'action_load.dart';
import 'action_loading.dart';
import 'action_porcentaje.dart';
import 'main__bl.dart';

part 'main_event.dart';
part 'main_state.dart';
part '../user/controller/user_events.dart';
part '../mensaje/controller/mensaje_events.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<Load>(((event, emit) => onLoad(Bl(emit, passState, add))));
    // on<NewMessage>((ev, em) => onNewMessage(ev, em, passState));
    on<Loading>((ev, em) => onLoading(ev, em, passState));
    on<ThemeChange>((ev, em) => onThemeChange(ev, em, passState));
    on<ThemeColorChange>((ev, em) => onThemeColorChange(ev, em, passState));
    on<Mensaje>((ev, em) => onMensaje(ev, em, passState));
    on<CambiarUsuario>((ev, em) => onCambiarUsuario(ev, em, passState));
    on<CambiarPorcentajeCarga>((ev, em) {
      return onCambiarPorcentajeCarga(ev, em, passState);
    });
    on<CambiarPorcentajeCargaDisponibilidad>((ev, em) {
      return onCambiarPorcentajeCargaDisponibilidad(ev, em, passState);
    });
  }
  MainState passState() => state;

  Bl get bl => Bl(emit, passState, add);

  VistaProyectosController get vistaProyectosController =>
      VistaProyectosController(bl);
  VistaPersonasController get vistaPersonasController =>
      VistaPersonasController(bl);
  CargaContratosListController get cargaContratosListController =>
      CargaContratosListController(bl);
  // VistaConfomidadesListController get vistaConfomidadesListController =>
  //     VistaConfomidadesListController(bl);
  VistaInfoController get vistaInfoController => VistaInfoController(bl);

  ProcesadoPosListController get procesadoPosListController =>
      ProcesadoPosListController(bl);
  
  ConformidadesListController get lclConfListController => ConformidadesListController(bl);
  FacturasListController get facturasListController =>
      FacturasListController(bl);

  load() => onLoad(Bl(emit, passState, add));
  mensaje({
    required String message,
    Color messageColor = Colors.red,
  }) {
    emit(
      state.copyWith(
        message: message,
        messageColor: messageColor,
        errorCounter: state.errorCounter + 1,
      ),
    );
  }
}
