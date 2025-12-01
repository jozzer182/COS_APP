import 'package:cos/contratos/model/contratos_reg.dart';
import 'package:cos/gac/model/gac_reg.dart';
import 'package:cos/vista_contrato/model/vista_contrato_list.dart';
import 'package:cos/vista_contrato/model/vista_contrato_reg.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../cupo/model/cupo_reg.dart';
import '../../procesado_lcls/model/procesado_lcls_reg.dart';

class VistaContratoListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  VistaContratoListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get calcular async {
    VistaContratoList vistaContratoList = VistaContratoList();
    List<VistaContratoReg> list = vistaContratoList.list;

    List<CupoReg> cupo = state().cupoList?.list ?? [];

    List<String> contratos = state().cargaContratos!.list;

    List<ProcesadoLclsReg> procesadoLclslist =
        state().procesadoLclsList?.list ?? [];
    List<ContratosReg> contratosList = state().contratosList?.list ?? [];
    List<GacReg> gacList = state().gacList?.list ?? [];

    for (String contrato in contratos) {
      int proveedorNumber = cupo
          .firstWhere(
            (e) => e.id == contrato,
            orElse: () => CupoReg.fromInit(),
          )
          .proveedor;
      String proveedor = cupo
          .firstWhere(
            (e) => e.proveedor == proveedorNumber,
            orElse: () => CupoReg.fromInit(),
          )
          .nombre;
      DateTime inicio = contratosList
          .firstWhere(
            (e) => e.contrato == contrato,
            orElse: () => ContratosReg.fromInit(),
          )
          .fechainicio;
      DateTime fin = contratosList
          .firstWhere(
            (e) => e.contrato == contrato,
            orElse: () => ContratosReg.fromInit(),
          )
          .fechafin;
      // int total = posicionesList
      //     .where((e) => e.contrato == contrato)
      //     .fold(0, (prev, e) => prev + e.valorprevisto);
      int totalInContrato = cupo
          .firstWhere(
            (e) => e.id == contrato,
            orElse: () => CupoReg.fromInit(),
          )
          .cupo;
      // if (totalInContrato > total)
      int total = totalInContrato;
      int usado = procesadoLclslist
          .where((e) => e.contrato == contrato)
          .fold(0, (prev, e) => prev + e.consumo);
      int saldo = total - usado;
      int saldoSap = cupo
          .firstWhere(
            (e) => e.id == contrato,
            orElse: () => CupoReg.fromInit(),
          )
          .restante;
      int conformado = procesadoLclslist
          .where((e) => e.contrato == contrato)
          .fold(0, (prev, e) => prev + e.conformado);
      int vencido = procesadoLclslist
          .where((e) => e.contrato == contrato)
          .fold(0, (prev, e) => prev + e.vencido);
      int planificado = procesadoLclslist
          .where((e) => e.contrato == contrato)
          .fold(0, (prev, e) => prev + e.planificado);
      int ctd = procesadoLclslist.where((e) => e.contrato == contrato).length;
      String gestor = gacList
          .firstWhere(
            (e) => e.contrato == contrato,
            orElse: () => GacReg.fromInit(),
          )
          .gestor;
      String gac = gacList
          .firstWhere(
            (e) => e.contrato == contrato,
            orElse: () => GacReg.fromInit(),
          )
          .gac;
      String proceso = gacList
          .firstWhere(
            (e) => e.contrato == contrato,
            orElse: () => GacReg.fromInit(),
          )
          .zona;

      list.add(
        VistaContratoReg(
          contrato: contrato,
          gestor: gestor,
          gac: gac,
          proveedor: proveedor,
          proceso: proceso,
          inicio: inicio,
          fin: fin,
          total: total,
          consumo: usado,
          restante: saldo,
          saldoSap: saldoSap,
          conformado: conformado,
          vencido: vencido,
          planificado: planificado,
          ctd: ctd,
        ),
      );
    }
    list.sort((a, b) => a.vencido.compareTo(b.vencido));
    list = list.reversed.toList();
    vistaContratoList.list = list;
    emit(state().copyWith(vistaContratoList: vistaContratoList));
  }
}
