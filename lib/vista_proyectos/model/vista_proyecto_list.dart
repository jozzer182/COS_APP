import '../../resources/titulo.dart';
import 'vista_proyecto_reg.dart';

class VistaProyectosList {
  List<VistaProyectoReg> list = [];

  List<ToCelda> get celdas => [
        ToCelda(valor: 'Wbe', flex: 2),
        ToCelda(valor: 'Nombre', flex: 6),
        ToCelda(valor: 'Contratos', flex: 2),
        ToCelda(valor: 'Lcls', flex: 2),
        ToCelda(valor: 'Consumo', flex: 2),
        ToCelda(valor: 'Vencido', flex: 2),
        ToCelda(valor: 'Planificado', flex: 2),
        ToCelda(valor: 'Conformado', flex: 2),
        ToCelda(valor: 'Usuario', flex: 5),
      ];
}