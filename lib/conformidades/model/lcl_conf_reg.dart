import 'dart:convert';

import 'package:cos/resources/a_entero_2.dart';
import 'package:cos/resources/a_fecha.dart';

import '../../resources/titulo.dart';
import '../../resources/to_mcop.dart';

class ConformidadesReg {
  String contrato = '';
  int conformidad;
  String descripcion;
  int importe;
  DateTime fecha;
  String creadopor;
  String liberadopor;
  int lcl;
  DateTime actualizado;

  ConformidadesReg({
    required this.contrato,
    required this.conformidad,
    required this.descripcion,
    required this.importe,
    required this.fecha,
    required this.creadopor,
    required this.liberadopor,
    required this.lcl,
    required this.actualizado,
  });

  List<String> toList() {
    return [
      contrato,
      conformidad.toString(),
      descripcion,
      importe.toString(),
      fecha.toString(),
      creadopor,
      liberadopor,
      lcl.toString(),
    ];
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: conformidad.toString(), flex: 1),
        ToCelda(valor: descripcion, flex: 4),
        ToCelda(valor: toMCOP(importe, 1), flex: 1),
        ToCelda(valor: fecha.toIso8601String().substring(0, 10), flex: 2),
        ToCelda(valor: creadopor.toUpperCase(), flex: 3),
        ToCelda(valor: liberadopor, flex: 4),
        ToCelda(valor: lcl.toString(), flex: 1),
        // ToCelda(valor: usuariofinal, flex: 2),
      ];

  ConformidadesReg copyWith({
    String? contrato,
    int? conformidad,
    String? descripcion,
    int? importe,
    DateTime? fecha,
    String? creadopor,
    String? liberadopor,
    int? lcl,
    DateTime? actualizado,
  }) {
    return ConformidadesReg(
      contrato: contrato ?? this.contrato,
      conformidad: conformidad ?? this.conformidad,
      descripcion: descripcion ?? this.descripcion,
      importe: importe ?? this.importe,
      fecha: fecha ?? this.fecha,
      creadopor: creadopor ?? this.creadopor,
      liberadopor: liberadopor ?? this.liberadopor,
      lcl: lcl ?? this.lcl,
      actualizado: actualizado ?? this.actualizado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contrato': contrato,
      'conformidad': conformidad.toString(),
      'descripcion': descripcion,
      'importe': importe.toString(),
      'fecha': fecha.toIso8601String().substring(0, 10),
      'creadopor': creadopor,
      'liberadopor': liberadopor,
      'lcl': lcl.toString(),
      'actualizado': actualizado.toString(),
    };
  }

  factory ConformidadesReg.fromMap(Map<String, dynamic> map) {
    return ConformidadesReg(
      contrato: map['contrato'].toString(),
      conformidad: aEntero(map['conformidad'].toString()),
      descripcion: map['descripcion'].toString(),
      importe: aEntero(map['importe'].toString()),
      fecha: aFecha(map['fecha'].toString()),
      creadopor: map['creadopor'].toString(),
      liberadopor: map['liberadopor'].toString(),
      lcl: aEntero(map['lcl'].toString()),
      actualizado: aFecha(map['actualizado'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConformidadesReg.fromJson(String source) =>
      ConformidadesReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LclConfReg(contrato: $contrato, conformidad: $conformidad, descripcion: $descripcion, importe: $importe, fecha: $fecha, creadopor: $creadopor, liberadopor: $liberadopor, lcl: $lcl, actualizado: $actualizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConformidadesReg &&
        other.contrato == contrato &&
        other.conformidad == conformidad &&
        other.descripcion == descripcion &&
        other.importe == importe &&
        other.fecha == fecha &&
        other.creadopor == creadopor &&
        other.liberadopor == liberadopor &&
        other.lcl == lcl &&
        other.actualizado == actualizado;
  }

  @override
  int get hashCode {
    return contrato.hashCode ^
        conformidad.hashCode ^
        descripcion.hashCode ^
        importe.hashCode ^
        fecha.hashCode ^
        creadopor.hashCode ^
        liberadopor.hashCode ^
        lcl.hashCode ^
        actualizado.hashCode;
  }
}
