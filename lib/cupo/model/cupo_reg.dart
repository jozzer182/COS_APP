import 'dart:convert';

import 'package:cos/resources/a_entero_2.dart';
import 'package:cos/resources/a_fecha.dart';

class CupoReg {
  String id;
  String clase;
  String sociedad;
  int proveedor;
  String nombre;
  int cupo;
  int restante;
  DateTime actualizado;
  CupoReg({
    required this.id,
    required this.clase,
    required this.sociedad,
    required this.proveedor,
    required this.nombre,
    required this.cupo,
    required this.restante,
    required this.actualizado,
  });

  List<String> toList() {
    return [
      id.toString(),
      clase.toString(),
      sociedad.toString(),
      proveedor.toString(),
      nombre.toString(),
      cupo.toString(),
      restante.toString(),
    ];
  }

  CupoReg copyWith({
    String? id,
    String? clase,
    String? sociedad,
    int? proveedor,
    String? nombre,
    int? cupo,
    int? restante,
    DateTime? actualizado,
  }) {
    return CupoReg(
      id: id ?? this.id,
      clase: clase ?? this.clase,
      sociedad: sociedad ?? this.sociedad,
      proveedor: proveedor ?? this.proveedor,
      nombre: nombre ?? this.nombre,
      cupo: cupo ?? this.cupo,
      restante: restante ?? this.restante,
      actualizado: actualizado ?? this.actualizado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clase': clase,
      'sociedad': sociedad,
      'proveedor': proveedor,
      'nombre': nombre,
      'cupo': cupo,
      'restante': restante,
      'actualizado': actualizado.millisecondsSinceEpoch,
    };
  }

  factory CupoReg.fromMap(Map<String, dynamic> map) {
    return CupoReg(
      id: map['id'].toString(),
      clase: map['clase'].toString(),
      sociedad: map['sociedad'].toString(),
      proveedor: aEntero(map['proveedor'].toString()),
      nombre: map['nombre'].toString(),
      cupo: aEntero(map['cupo'].toString()),
      restante: aEntero(map['restante'].toString()),
      actualizado: aFecha(map['actualizado'].toString()),
    );
  }

  factory CupoReg.fromInit() {
    return CupoReg(
      id: "",
      clase: "",
      sociedad: "",
      proveedor: aEntero(""),
      nombre: "",
      cupo: aEntero(""),
      restante: aEntero(""),
      actualizado: aFecha(""),
    );
  }

  String toJson() => json.encode(toMap());

  factory CupoReg.fromJson(String source) =>
      CupoReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CupoReg(id: $id, clase: $clase, sociedad: $sociedad, proveedor: $proveedor, nombre: $nombre, cupo: $cupo, restante: $restante, actualizado: $actualizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CupoReg &&
        other.id == id &&
        other.clase == clase &&
        other.sociedad == sociedad &&
        other.proveedor == proveedor &&
        other.nombre == nombre &&
        other.cupo == cupo &&
        other.restante == restante &&
        other.actualizado == actualizado;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clase.hashCode ^
        sociedad.hashCode ^
        proveedor.hashCode ^
        nombre.hashCode ^
        cupo.hashCode ^
        restante.hashCode ^
        actualizado.hashCode;
  }
}
