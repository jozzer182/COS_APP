import 'package:cos/procesado_lcls/model/procesado_lcls_reg.dart';

import '../../resources/titulo.dart';

class ProcesadoLclsList {
  List<ProcesadoLclsReg> list = [];

  List<ToCelda> celdas = [
    ToCelda(valor: 'Lcl', flex: 2),
    ToCelda(valor: 'Iva', flex: 1),
    ToCelda(valor: 'Descripción', flex: 5),
    ToCelda(valor: 'Ctd', flex: 1),
    ToCelda(valor: 'Final', flex: 1),
    ToCelda(valor: 'Borrado', flex: 1),
    ToCelda(valor: 'Valor Inicial', flex: 2),
    ToCelda(valor: 'Consumo', flex: 2),
    ToCelda(valor: 'Vencido', flex: 2),
    ToCelda(valor: 'Planificado', flex: 2),
    ToCelda(valor: 'Conformado', flex: 2),
    ToCelda(valor: 'Proyecto', flex: 4),
    ToCelda(valor: 'Inicio', flex: 2),
    ToCelda(valor: 'Fin', flex: 2),
    ToCelda(valor: 'Usuario', flex: 5),
    ToCelda(valor: 'Grupo', flex: 2),
  ];
}
