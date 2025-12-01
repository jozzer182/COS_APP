import '../../resources/titulo.dart';
import 'vista_contrato_reg.dart';

class VistaContratoList {
  List<VistaContratoReg> list = [];

  List<ToCelda> celdas = [
    ToCelda(valor: 'Contrato', flex: 2),
    ToCelda(valor: 'Gestor', flex: 3),
    ToCelda(valor: 'SCS', flex: 3),
    ToCelda(valor: 'Proveedor', flex: 5),
    ToCelda(valor: 'Proceso', flex: 2),
    ToCelda(valor: 'Inicio', flex: 2),
    ToCelda(valor: 'Fin', flex: 2),
    ToCelda(valor: 'Ctd', flex: 1),
    ToCelda(valor: 'Total', flex: 2),
    ToCelda(valor: 'Consumo', flex: 2),
    ToCelda(valor: 'Restante', flex: 2),
    // ToCelda(valor: 'Saldo SAP', flex: 2),
    ToCelda(valor: 'Vencido', flex: 2),
    ToCelda(valor: 'Planificado', flex: 2),
    ToCelda(valor: 'Conformado', flex: 2),
    ToCelda(valor: '% Consumo', flex: 1),
    ToCelda(valor: '% Tiempo', flex: 1),
    ToCelda(valor: 'Concepto', flex: 3),
    ToCelda(valor: 'Fin Proy', flex: 2),
  ];
}
