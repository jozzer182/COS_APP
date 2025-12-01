import 'dart:convert';

import '../../contratos/model/contratos_reg.dart';

class VistaInfo extends ContratosReg {
  String nombreproveedor;
  DateTime fechacreado;
  String cuisupplier;
  String nit;
  String nit2;
  String telefono;
  String recpago;
  String claseimpuesto;
  VistaInfo({
    required this.nombreproveedor,
    required this.fechacreado,
    required this.cuisupplier,
    required this.nit,
    required this.nit2,
    required this.telefono,
    required this.recpago,
    required this.claseimpuesto,
    required super.contrato,
    required super.clase,
    required super.proveedor,
    required super.organizacion,
    required super.grupo,
    required super.moneda,
    required super.tipocambio,
    required super.fechadocumento,
    required super.fechainicio,
    required super.fechafin,
    required super.valorprevisto,
    required super.emisorfactura,
    required super.categoria,
    required super.catcontrato,
    required super.opcionporcentaje,
    required super.toleranciaporcentaje,
    required super.objetosintetico,
    required super.zzdataprot,
    required super.fechaperfeccionamiento,
    required super.importebase,
    required super.tiposuministro,
    required super.riesgo,
    required super.usuario,
    required super.grupoarticulos,
    required super.subcontratacion,
    required super.subcontratacionporcentaje,
    required super.actualizado,
  });

  List<String> toList() {
    return [
      nombreproveedor,
      fechacreado.toString(),
      cuisupplier,
      nit,
      nit2,
      telefono,
      recpago,
      claseimpuesto,
      contrato,
      clase,
      proveedor.toString(),
      organizacion,
      grupo,
      moneda,
      tipocambio,
      fechadocumento.toString(),
      fechainicio.toString(),
      fechafin.toString(),
      valorprevisto.toString(),
      emisorfactura,
      categoria,
      catcontrato,
      opcionporcentaje,
      toleranciaporcentaje,
      objetosintetico,
      zzdataprot.toString(),
      fechaperfeccionamiento.toString(),
      importebase.toString(),
      tiposuministro,
      riesgo,
      usuario,
      grupoarticulos,
      subcontratacion,
      subcontratacionporcentaje,
      actualizado.toString(),
    ];
  }

  @override
  VistaInfo copyWith({
    String? nombreproveedor,
    DateTime? fechacreado,
    String? cuisupplier,
    String? nit,
    String? nit2,
    String? telefono,
    String? recpago,
    String? claseimpuesto,
    String? contrato,
    String? clase,
    int? proveedor,
    String? organizacion,
    String? grupo,
    String? moneda,
    String? tipocambio,
    DateTime? fechadocumento,
    DateTime? fechainicio,
    DateTime? fechafin,
    int? valorprevisto,
    String? emisorfactura,
    String? categoria,
    String? catcontrato,
    String? opcionporcentaje,
    String? toleranciaporcentaje,
    String? objetosintetico,
    DateTime? zzdataprot,
    DateTime? fechaperfeccionamiento,
    int? importebase,
    String? tiposuministro,
    String? riesgo,
    String? usuario,
    String? grupoarticulos,
    String? subcontratacion,
    String? subcontratacionporcentaje,
    DateTime? actualizado,
  }) {
    return VistaInfo(
      nombreproveedor: nombreproveedor ?? this.nombreproveedor,
      fechacreado: fechacreado ?? this.fechacreado,
      cuisupplier: cuisupplier ?? this.cuisupplier,
      nit: nit ?? this.nit,
      nit2: nit2 ?? this.nit2,
      telefono: telefono ?? this.telefono,
      recpago: recpago ?? this.recpago,
      claseimpuesto: claseimpuesto ?? this.claseimpuesto,
      contrato: contrato ?? super.contrato,
      clase: clase ?? super.clase,
      proveedor: proveedor ?? super.proveedor,
      organizacion: organizacion ?? super.organizacion,
      grupo: grupo ?? super.grupo,
      moneda: moneda ?? super.moneda,
      tipocambio: tipocambio ?? super.tipocambio,
      fechadocumento: fechadocumento ?? super.fechadocumento,
      fechainicio: fechainicio ?? super.fechainicio,
      fechafin: fechafin ?? super.fechafin,
      valorprevisto: valorprevisto ?? super.valorprevisto,
      emisorfactura: emisorfactura ?? super.emisorfactura,
      categoria: categoria ?? super.categoria,
      catcontrato: catcontrato ?? super.catcontrato,
      opcionporcentaje: opcionporcentaje ?? super.opcionporcentaje,
      toleranciaporcentaje: toleranciaporcentaje ?? super.toleranciaporcentaje,
      objetosintetico: objetosintetico ?? super.objetosintetico,
      zzdataprot: zzdataprot ?? super.zzdataprot,
      fechaperfeccionamiento:
          fechaperfeccionamiento ?? super.fechaperfeccionamiento,
      importebase: importebase ?? super.importebase,
      tiposuministro: tiposuministro ?? super.tiposuministro,
      riesgo: riesgo ?? super.riesgo,
      usuario: usuario ?? super.usuario,
      grupoarticulos: grupoarticulos ?? super.grupoarticulos,
      subcontratacion: subcontratacion ?? super.subcontratacion,
      subcontratacionporcentaje:
          subcontratacionporcentaje ?? super.subcontratacionporcentaje,
      actualizado: actualizado ?? super.actualizado,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'nombreproveedor': nombreproveedor,
      'fechacreado': fechacreado.millisecondsSinceEpoch,
      'cuisupplier': cuisupplier,
      'nit': nit,
      'nit2': nit2,
      'telefono': telefono,
      'recpago': recpago,
      'claseimpuesto': claseimpuesto,
    };
  }

  factory VistaInfo.fromMap(Map<String, dynamic> map) {
    return VistaInfo(
      nombreproveedor: map['nombreproveedor'] ?? '',
      fechacreado: DateTime.fromMillisecondsSinceEpoch(map['fechacreado']),
      cuisupplier: map['cuisupplier'] ?? '',
      nit: map['nit'] ?? '',
      nit2: map['nit2'] ?? '',
      telefono: map['telefono'] ?? '',
      recpago: map['recpago'] ?? '',
      claseimpuesto: map['claseimpuesto'] ?? '',
      contrato: map['contrato'] ?? '',
      clase: map['clase'] ?? '',
      proveedor: map['proveedor'] ?? 0,
      organizacion: map['organizacion'] ?? '',
      grupo: map['grupo'] ?? '',
      moneda: map['moneda'] ?? '',
      tipocambio: map['tipocambio'] ?? '',
      fechadocumento:
          DateTime.fromMillisecondsSinceEpoch(map['fechadocumento']),
      fechainicio: DateTime.fromMillisecondsSinceEpoch(map['fechainicio']),
      fechafin: DateTime.fromMillisecondsSinceEpoch(map['fechafin']),
      valorprevisto: map['valorprevisto'] ?? 0,
      emisorfactura: map['emisorfactura'] ?? '',
      categoria: map['categoria'] ?? '',
      catcontrato: map['catcontrato'] ?? '',
      opcionporcentaje: map['opcionporcentaje'] ?? '',
      toleranciaporcentaje: map['toleranciaporcentaje'] ?? '',
      objetosintetico: map['objetosintetico'] ?? '',
      zzdataprot: DateTime.fromMillisecondsSinceEpoch(map['zzdataprot']),
      fechaperfeccionamiento:
          DateTime.fromMillisecondsSinceEpoch(map['fechaperfeccionamiento']),
      importebase: map['importebase'] ?? 0,
      tiposuministro: map['tiposuministro'] ?? '',
      riesgo: map['riesgo'] ?? '',
      usuario: map['usuario'] ?? '',
      grupoarticulos: map['grupoarticulos'] ?? '',
      subcontratacion: map['subcontratacion'] ?? '',
      subcontratacionporcentaje: map['subcontratacionporcentaje'] ?? '',
      actualizado: DateTime.fromMillisecondsSinceEpoch(map['actualizado']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory VistaInfo.fromJson(String source) =>
      VistaInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VistaInfo(nombreproveedor: $nombreproveedor, fechacreado: $fechacreado, cuisupplier: $cuisupplier, nit: $nit, nit2: $nit2, telefono: $telefono, recpago: $recpago, claseimpuesto: $claseimpuesto)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VistaInfo &&
        other.nombreproveedor == nombreproveedor &&
        other.fechacreado == fechacreado &&
        other.cuisupplier == cuisupplier &&
        other.nit == nit &&
        other.nit2 == nit2 &&
        other.telefono == telefono &&
        other.recpago == recpago &&
        other.claseimpuesto == claseimpuesto;
  }

  @override
  int get hashCode {
    return nombreproveedor.hashCode ^
        fechacreado.hashCode ^
        cuisupplier.hashCode ^
        nit.hashCode ^
        nit2.hashCode ^
        telefono.hashCode ^
        recpago.hashCode ^
        claseimpuesto.hashCode;
  }
}
