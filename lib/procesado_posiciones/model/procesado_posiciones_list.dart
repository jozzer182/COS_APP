import 'package:cos/procesado_posiciones/model/procesado_posiciones_reg.dart';

import '../../resources/titulo.dart';

class ProcesadoPosicionesList {
  List<ProcesadoPosicionesReg> list = [];
  bool cargaCorrecta = false;
  String contrato = '';
  String lcl = '';

  List<ToCelda> get celdas => [
        ToCelda(valor: 'Posición', flex: 1),
        ToCelda(valor: 'Descripción', flex: 6),
        ToCelda(valor: 'Iva', flex: 1),
        ToCelda(valor: 'Final', flex: 1),
        ToCelda(valor: 'Borrado', flex: 1),
        ToCelda(valor: 'Consumo', flex: 2),
        ToCelda(valor: 'Neto', flex: 2),
        ToCelda(valor: 'Conformado', flex: 2),
        ToCelda(valor: 'Vencido', flex: 2),
      ];
}
