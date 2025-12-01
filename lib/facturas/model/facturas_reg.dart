import 'package:cos/resources/to_mcop.dart';

import '../../resources/a_entero_2.dart';
import '../../resources/titulo.dart';

class FacturasReg {
  String ekbedoc;
  String fechadoc;
  String referencia;
  String importebruto;
  String iva;
  String impuesto;
  String factura;
  String descripcion;
  String anulado;
  String lcl;
  String actualizado;
  String contrato = '';
  FacturasReg({
    required this.ekbedoc,
    required this.fechadoc,
    required this.referencia,
    required this.importebruto,
    required this.iva,
    required this.impuesto,
    required this.factura,
    required this.descripcion,
    required this.anulado,
    required this.lcl,
    required this.actualizado,
  });
  FacturasReg copyWith({
    String? ekbedoc,
    String? fechadoc,
    String? referencia,
    String? importebruto,
    String? iva,
    String? impuesto,
    String? factura,
    String? descripcion,
    String? anulado,
    String? lcl,
    String? actualizado,
  }) {
    return FacturasReg(
      ekbedoc: ekbedoc ?? this.ekbedoc,
      fechadoc: fechadoc ?? this.fechadoc,
      referencia: referencia ?? this.referencia,
      importebruto: importebruto ?? this.importebruto,
      iva: iva ?? this.iva,
      impuesto: impuesto ?? this.impuesto,
      factura: factura ?? this.factura,
      descripcion: descripcion ?? this.descripcion,
      anulado: anulado ?? this.anulado,
      lcl: lcl ?? this.lcl,
      actualizado: actualizado ?? this.actualizado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ekbedoc': ekbedoc,
      'fechadoc': fechadoc,
      'referencia': referencia,
      'importebruto': importebruto,
      'iva': iva,
      'impuesto': impuesto,
      'factura': factura,
      'descripcion': descripcion,
      'anulado': anulado,
      'lcl': lcl,
      'actualizado': actualizado,
    };
  }

  factory FacturasReg.fromMap(Map<String, dynamic> map) {
    return FacturasReg(
      ekbedoc: map['ekbedoc'].toString(),
      fechadoc: map['fechadoc'].toString().substring(0, 10),
      referencia: map['referencia'].toString(),
      importebruto: map['importebruto'].toString(),
      iva: map['iva'].toString(),
      impuesto: map['impuesto'].toString(),
      factura: map['factura'].toString(),
      descripcion: map['descripcion'].toString(),
      anulado: map['anulado'].toString(),
      lcl: map['lcl'].toString(),
      actualizado: map['actualizado'].toString(),
    );
  }

  List<ToCelda> get celdas {
    return [
      ToCelda(valor: ekbedoc, flex: 2),
      ToCelda(valor: fechadoc, flex: 2),
      ToCelda(valor: referencia, flex: 2),
      ToCelda(valor: toMCOP(aEntero(importebruto), 1), flex: 2),
      ToCelda(valor: toMCOP(aEntero(iva), 1), flex: 2),
      ToCelda(valor: impuesto, flex: 2),
      ToCelda(valor: factura, flex: 2),
      ToCelda(valor: descripcion, flex: 5),
      ToCelda(valor: anulado, flex: 2),
      ToCelda(valor: lcl.replaceAll(";", "\n"), flex: 2),
    ];
  }

  List<String> toList() {
    return [
      ekbedoc,
      fechadoc,
      referencia,
      importebruto,
      iva,
      impuesto,
      factura,
      descripcion,
      anulado,
      lcl,
    ];
  }
}
