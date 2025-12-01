import 'package:cos/cargacontratos/model/cargacontratos_model.dart';
import 'package:localstorage/localstorage.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';

class CargaContratosListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  // late CargaContratos cargaContratosState;

  CargaContratosListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
    // cargaContratosState = state().cargaContratos!;
  }

  get obtener async {
    CargaContratos cargaContratos = CargaContratos();
    LocalStorage storage = localStorage;
    await initLocalStorage();
    List<String> contratosCupo =
        state().cupoList?.list.map((e) => e.id).toList() ?? [];
    String? contratosLocalStorage = storage.getItem('contratos');
    List<String> contratos =
        contratosLocalStorage != null ? contratosLocalStorage.split(',') : [];
    cargaContratos.list =
        contratos.where((e) {
          return contratosCupo.contains(e);
        }).toList();
    if (cargaContratos.list.isEmpty) {
      cargaContratos.list.add('JA10128057');
    }
    emit(state().copyWith(cargaContratos: cargaContratos));
  }

  void agregar(String contrato, bool b) async {
    LocalStorage storage = localStorage;
    await initLocalStorage();
    // storage.setItem(contrato, b);
    String? contratosLocalStorage = storage.getItem('contratos');
    List<String> contratos =
        contratosLocalStorage != null ? contratosLocalStorage.split(',') : [];
    if (b) {
      if (!contratos.contains(contrato)) {
        contratos.add(contrato);
      }
    } else {
      if (contratos.contains(contrato)) {
        contratos.remove(contrato);
      }
    }
    String contratosString = contratos.join(',');
    storage.setItem('contratos', contratosString);
    CargaContratos cargaContratos = state().cargaContratos!;
    if (b) {
      cargaContratos.list.add(contrato);
    } else {
      cargaContratos.list.remove(contrato);
    }
    emit(state().copyWith(cargaContratos: cargaContratos));
  }
}
