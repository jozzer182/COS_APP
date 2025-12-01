import '../../resources/titulo.dart';
import 'lcl_conf_reg.dart';

class ConformidadesList {
  List<ConformidadesReg> list = [];
  String contrato = '';
  bool cargaCorrecta = false;

  List<ToCelda> celdas = [
    ToCelda(valor: 'Conformidad', flex: 1),
    ToCelda(valor: 'Descripcicion', flex: 4),
    ToCelda(valor: 'Importe', flex: 1),
    ToCelda(valor: 'Fecha\nContabilización', flex: 2),
    ToCelda(valor: 'Creado Por', flex: 3),
    ToCelda(valor: 'Liberado Por', flex: 4),
    ToCelda(valor: 'Lcl', flex: 1),
    // ToCelda(valor: 'Usuario LCL', flex: 2),
  ];

  // List<ToCelda> celdas = [
  //   ToCelda(valor: 'Lcl', flex: 2),
  //   ToCelda(valor: 'Conformidad', flex: 2),
  //   ToCelda(valor: 'Importe', flex: 2),
  //   ToCelda(valor: 'Fecha Contabilización', flex: 2),
  // ];
}
