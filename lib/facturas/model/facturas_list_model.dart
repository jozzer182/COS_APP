import '../../resources/titulo.dart';
import 'facturas_reg.dart';

class FacturasList {
  List<FacturasReg> list = [];

  bool cargaCorrecta = false;

  List<ToCelda> celdas = [
    ToCelda(valor: 'Ekbedoc', flex: 2),
    ToCelda(valor: 'Fecha', flex: 2),
    ToCelda(valor: 'Referencia', flex: 2),
    ToCelda(valor: 'Importe Bruto', flex: 2),
    ToCelda(valor: 'Iva', flex: 2),
    ToCelda(valor: 'Impuesto', flex: 2),
    ToCelda(valor: 'Factura', flex: 2),
    ToCelda(valor: 'Descripción', flex: 5),
    ToCelda(valor: 'Anulado', flex: 2),
    ToCelda(valor: 'Lcl', flex: 2),
    // ToCelda(valor: 'Actualizado', flex: 2),
  ];
}
