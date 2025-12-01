import 'package:cos/vista_info/model/vista_info_reg.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../contratos/model/contratos_reg.dart';
import '../../proveedores/model/proveedores_reg.dart';

class VistaInfoController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  VistaInfoController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  calcular(String contrato) async {
    ContratosReg contratoReg = state().contratosList?.list.firstWhere(
              (e) => e.contrato == contrato,
              orElse: () => ContratosReg.fromInit(),
            ) ??
        ContratosReg.fromInit();
    ProveedoresReg proveedorReg = state().proveedoresList?.list.firstWhere(
              (e) => e.proveedor == contratoReg.proveedor,
              orElse: () => ProveedoresReg.fromInit(),
            ) ??
        ProveedoresReg.fromInit();

    VistaInfo vistaInfo = VistaInfo(
      nombreproveedor: proveedorReg.nombreproveedor,
      fechacreado: proveedorReg.fechacreado,
      cuisupplier: proveedorReg.cuisupplier,
      nit: proveedorReg.nit,
      nit2: proveedorReg.nit2,
      telefono: proveedorReg.telefono,
      recpago: proveedorReg.recpago,
      claseimpuesto: proveedorReg.claseimpuesto,
      contrato: contratoReg.contrato,
      clase: contratoReg.clase,
      proveedor: contratoReg.proveedor,
      organizacion: contratoReg.organizacion,
      grupo: contratoReg.grupo,
      moneda: contratoReg.moneda,
      tipocambio: contratoReg.tipocambio,
      fechadocumento: contratoReg.fechadocumento,
      fechainicio: contratoReg.fechainicio,
      fechafin: contratoReg.fechafin,
      valorprevisto: contratoReg.valorprevisto,
      emisorfactura: contratoReg.emisorfactura,
      categoria: contratoReg.categoria,
      catcontrato: contratoReg.catcontrato,
      opcionporcentaje: contratoReg.opcionporcentaje,
      toleranciaporcentaje: contratoReg.toleranciaporcentaje,
      objetosintetico: contratoReg.objetosintetico,
      zzdataprot: contratoReg.zzdataprot,
      fechaperfeccionamiento: contratoReg.fechaperfeccionamiento,
      importebase: contratoReg.importebase,
      tiposuministro: contratoReg.tiposuministro,
      riesgo: contratoReg.riesgo,
      usuario: contratoReg.usuario,
      grupoarticulos: contratoReg.grupoarticulos,
      subcontratacion: contratoReg.subcontratacion,
      subcontratacionporcentaje: contratoReg.subcontratacionporcentaje,
      actualizado: contratoReg.actualizado,
    );

    emit(state().copyWith(vistaInfo: vistaInfo));
  }
}
