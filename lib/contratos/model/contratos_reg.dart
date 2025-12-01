import 'dart:convert';

import 'package:cos/resources/a_entero_2.dart';
import 'package:cos/resources/a_fecha.dart';

class ContratosReg {
  String contrato;
  String clase;
  int proveedor;
  String organizacion;
  String grupo;
  String moneda;
  String tipocambio;
  DateTime fechadocumento;
  DateTime fechainicio;
  DateTime fechafin;
  int valorprevisto;
  String emisorfactura;
  String categoria;
  String catcontrato;
  String opcionporcentaje;
  String toleranciaporcentaje;
  String objetosintetico;
  DateTime zzdataprot;
  DateTime fechaperfeccionamiento;
  int importebase;
  String tiposuministro;
  String riesgo;
  String usuario;
  String grupoarticulos;
  String subcontratacion;
  String subcontratacionporcentaje;
  DateTime actualizado;
  ContratosReg({
    required this.contrato,
    required this.clase,
    required this.proveedor,
    required this.organizacion,
    required this.grupo,
    required this.moneda,
    required this.tipocambio,
    required this.fechadocumento,
    required this.fechainicio,
    required this.fechafin,
    required this.valorprevisto,
    required this.emisorfactura,
    required this.categoria,
    required this.catcontrato,
    required this.opcionporcentaje,
    required this.toleranciaporcentaje,
    required this.objetosintetico,
    required this.zzdataprot,
    required this.fechaperfeccionamiento,
    required this.importebase,
    required this.tiposuministro,
    required this.riesgo,
    required this.usuario,
    required this.grupoarticulos,
    required this.subcontratacion,
    required this.subcontratacionporcentaje,
    required this.actualizado,
  });

  ContratosReg copyWith({
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
    return ContratosReg(
      contrato: contrato ?? this.contrato,
      clase: clase ?? this.clase,
      proveedor: proveedor ?? this.proveedor,
      organizacion: organizacion ?? this.organizacion,
      grupo: grupo ?? this.grupo,
      moneda: moneda ?? this.moneda,
      tipocambio: tipocambio ?? this.tipocambio,
      fechadocumento: fechadocumento ?? this.fechadocumento,
      fechainicio: fechainicio ?? this.fechainicio,
      fechafin: fechafin ?? this.fechafin,
      valorprevisto: valorprevisto ?? this.valorprevisto,
      emisorfactura: emisorfactura ?? this.emisorfactura,
      categoria: categoria ?? this.categoria,
      catcontrato: catcontrato ?? this.catcontrato,
      opcionporcentaje: opcionporcentaje ?? this.opcionporcentaje,
      toleranciaporcentaje: toleranciaporcentaje ?? this.toleranciaporcentaje,
      objetosintetico: objetosintetico ?? this.objetosintetico,
      zzdataprot: zzdataprot ?? this.zzdataprot,
      fechaperfeccionamiento:
          fechaperfeccionamiento ?? this.fechaperfeccionamiento,
      importebase: importebase ?? this.importebase,
      tiposuministro: tiposuministro ?? this.tiposuministro,
      riesgo: riesgo ?? this.riesgo,
      usuario: usuario ?? this.usuario,
      grupoarticulos: grupoarticulos ?? this.grupoarticulos,
      subcontratacion: subcontratacion ?? this.subcontratacion,
      subcontratacionporcentaje:
          subcontratacionporcentaje ?? this.subcontratacionporcentaje,
      actualizado: actualizado ?? this.actualizado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contrato': contrato,
      'clase': clase,
      'proveedor': proveedor,
      'organizacion': organizacion,
      'grupo': grupo,
      'moneda': moneda,
      'tipocambio': tipocambio,
      'fechadocumento': fechadocumento.millisecondsSinceEpoch,
      'fechainicio': fechainicio.millisecondsSinceEpoch,
      'fechafin': fechafin.millisecondsSinceEpoch,
      'valorprevisto': valorprevisto,
      'emisorfactura': emisorfactura,
      'categoria': categoria,
      'catcontrato': catcontrato,
      'opcionporcentaje': opcionporcentaje,
      'toleranciaporcentaje': toleranciaporcentaje,
      'objetosintetico': objetosintetico,
      'zzdataprot': zzdataprot.millisecondsSinceEpoch,
      'fechaperfeccionamiento': fechaperfeccionamiento.millisecondsSinceEpoch,
      'importebase': importebase,
      'tiposuministro': tiposuministro,
      'riesgo': riesgo,
      'usuario': usuario,
      'grupoarticulos': grupoarticulos,
      'subcontratacion': subcontratacion,
      'subcontratacionporcentaje': subcontratacionporcentaje,
      'actualizado': actualizado.millisecondsSinceEpoch,
    };
  }

  factory ContratosReg.fromMap(Map<String, dynamic> map) {
    return ContratosReg(
      contrato: map['contrato'].toString(),
      clase: map['clase'].toString(),
      proveedor: aEntero(map['proveedor'].toString()),
      organizacion: map['organizacion'].toString(),
      grupo: map['grupo'].toString(),
      moneda: map['moneda'].toString(),
      tipocambio: map['tipocambio'].toString(),
      fechadocumento: aFecha(map['fechadocumento'].toString()),
      fechainicio: aFecha(map['fechainicio'].toString()),
      fechafin: aFecha(map['fechafin'].toString()),
      valorprevisto: aEntero(map['valorprevisto'].toString()),
      emisorfactura: map['emisorfactura'].toString(),
      categoria: map['categoria'].toString(),
      catcontrato: map['catcontrato'].toString(),
      opcionporcentaje: map['opcionporcentaje'].toString(),
      toleranciaporcentaje: map['toleranciaporcentaje'].toString(),
      objetosintetico: map['objetosintetico'].toString(),
      zzdataprot: aFecha(map['zzdataprot'].toString()),
      fechaperfeccionamiento: aFecha(map['fechaperfeccionamiento'].toString()),
      importebase: aEntero(map['importebase'].toString()),
      tiposuministro: map['tiposuministro'].toString(),
      riesgo: map['riesgo'].toString(),
      usuario: map['usuario'].toString(),
      grupoarticulos: map['grupoarticulos'].toString(),
      subcontratacion: map['subcontratacion'].toString(),
      subcontratacionporcentaje: map['subcontratacionporcentaje'].toString(),
      actualizado: aFecha(map['actualizado'].toString()),
    );
  }

  factory ContratosReg.fromInit() {
    return ContratosReg(
      contrato: "",
      clase: "",
      proveedor: aEntero(""),
      organizacion: "",
      grupo: "",
      moneda: "",
      tipocambio: "",
      fechadocumento: aFecha(""),
      fechainicio: aFecha(""),
      fechafin: aFecha(""),
      valorprevisto: 0,
      emisorfactura: "",
      categoria: "",
      catcontrato: "",
      opcionporcentaje: "",
      toleranciaporcentaje: "",
      objetosintetico: "",
      zzdataprot: aFecha(""),
      fechaperfeccionamiento: aFecha(""),
      importebase: aEntero(""),
      tiposuministro: "",
      riesgo: "",
      usuario: "",
      grupoarticulos: "",
      subcontratacion: "",
      subcontratacionporcentaje: "",
      actualizado: aFecha(""),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContratosReg.fromJson(String source) =>
      ContratosReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContratosReg(contrato: $contrato, clase: $clase, proveedor: $proveedor, organizacion: $organizacion, grupo: $grupo, moneda: $moneda, tipocambio: $tipocambio, fechadocumento: $fechadocumento, fechainicio: $fechainicio, fechafin: $fechafin, valorprevisto: $valorprevisto, emisorfactura: $emisorfactura, categoria: $categoria, catcontrato: $catcontrato, opcionporcentaje: $opcionporcentaje, toleranciaporcentaje: $toleranciaporcentaje, objetosintetico: $objetosintetico, zzdataprot: $zzdataprot, fechaperfeccionamiento: $fechaperfeccionamiento, importebase: $importebase, tiposuministro: $tiposuministro, riesgo: $riesgo, usuario: $usuario, grupoarticulos: $grupoarticulos, subcontratacion: $subcontratacion, subcontratacionporcentaje: $subcontratacionporcentaje, actualizado: $actualizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContratosReg &&
        other.contrato == contrato &&
        other.clase == clase &&
        other.proveedor == proveedor &&
        other.organizacion == organizacion &&
        other.grupo == grupo &&
        other.moneda == moneda &&
        other.tipocambio == tipocambio &&
        other.fechadocumento == fechadocumento &&
        other.fechainicio == fechainicio &&
        other.fechafin == fechafin &&
        other.valorprevisto == valorprevisto &&
        other.emisorfactura == emisorfactura &&
        other.categoria == categoria &&
        other.catcontrato == catcontrato &&
        other.opcionporcentaje == opcionporcentaje &&
        other.toleranciaporcentaje == toleranciaporcentaje &&
        other.objetosintetico == objetosintetico &&
        other.zzdataprot == zzdataprot &&
        other.fechaperfeccionamiento == fechaperfeccionamiento &&
        other.importebase == importebase &&
        other.tiposuministro == tiposuministro &&
        other.riesgo == riesgo &&
        other.usuario == usuario &&
        other.grupoarticulos == grupoarticulos &&
        other.subcontratacion == subcontratacion &&
        other.subcontratacionporcentaje == subcontratacionporcentaje &&
        other.actualizado == actualizado;
  }

  @override
  int get hashCode {
    return contrato.hashCode ^
        clase.hashCode ^
        proveedor.hashCode ^
        organizacion.hashCode ^
        grupo.hashCode ^
        moneda.hashCode ^
        tipocambio.hashCode ^
        fechadocumento.hashCode ^
        fechainicio.hashCode ^
        fechafin.hashCode ^
        valorprevisto.hashCode ^
        emisorfactura.hashCode ^
        categoria.hashCode ^
        catcontrato.hashCode ^
        opcionporcentaje.hashCode ^
        toleranciaporcentaje.hashCode ^
        objetosintetico.hashCode ^
        zzdataprot.hashCode ^
        fechaperfeccionamiento.hashCode ^
        importebase.hashCode ^
        tiposuministro.hashCode ^
        riesgo.hashCode ^
        usuario.hashCode ^
        grupoarticulos.hashCode ^
        subcontratacion.hashCode ^
        subcontratacionporcentaje.hashCode ^
        actualizado.hashCode;
  }
}
