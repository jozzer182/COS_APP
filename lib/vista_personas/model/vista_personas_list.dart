import '../../resources/titulo.dart';
import 'vista_personas_reg.dart';

class VistaPersonasList {
  List<VistaPersonasReg> list = [];

  List<ToCelda> get celdas => [
        ToCelda(valor: 'Nombre', flex: 6),
        ToCelda(valor: 'Proyectos', flex: 2),
        ToCelda(valor: 'Contratos', flex: 2),
        ToCelda(valor: 'Lcls', flex: 2),
        ToCelda(valor: 'Consumo', flex: 2),
        ToCelda(valor: 'Vencido', flex: 2),
        ToCelda(valor: 'Planificado', flex: 2),
        ToCelda(valor: 'Conformado', flex: 2),
        ToCelda(valor: 'Proveedores', flex: 8),
      ];
}
