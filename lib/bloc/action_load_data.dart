import 'package:cos/gac/controller/gac_ctrl.dart';

import '../cargacontratos/controller/cargacontratos_ctrl.dart';
import '../contratos/controller/contratos_controller.dart';
import '../cupo/controller/cupo_list_controller.dart';
import '../posiciones/controller/posiciones_controller.dart';
import '../procesado_lcls/controller/procesado_lcls_ctrl.dart';
import '../proveedores/controller/proveedores_controller.dart';
import '../resources/future_group_add.dart';

import '../vista_contrato/controller/vista_contrato_controller.dart';
import 'main__bl.dart';
import 'main_bloc.dart';

onLoadData(Bl bl) async {
  try {
    MainState Function() state = bl.state;
    bool isLogged = state().user != null;
    if (!isLogged) {
      bl.mensaje(
          message:
              'Inicie sesión ó registrese si es la primera vez que ingresa.');
      return;
    }
    print('onLoadData');
    await CupoListController(bl).obtener;
    await CargaContratosListController(bl).obtener;

    FutureGroupDelayed fg1 = FutureGroupDelayed();
    fg1.addF(ContratosListController(bl).obtener);
    fg1.addF(ProveedoresListController(bl).obtener);
    fg1.addF(PosicionesListController(bl).obtener);
    fg1.addF(GacLisrController(bl).obtener);
    fg1.addF(ProcesadoLclsListController(bl).obtener);
    fg1.close();
    await fg1.future.then(
      (value) async {
        await VistaContratoListController(bl).calcular;
      },
    );

    // await EstudioSolController(bl).obtener;
    // await PlataformaMb51Controller(bl).obtener;
    // await CodigosConComplementosController(bl).onLoadCodigosConComplementos;
  } catch (e) {
    bl.mensaje(message: e.toString());
  }
}
