import 'dart:convert';

import 'package:cos/resources/a_entero_2.dart';
import 'package:cos/resources/a_fecha.dart';

class ProveedoresReg {
  int proveedor;
  String nombreproveedor;
  DateTime fechacreado;
  String cuisupplier;
  String nit;
  String nit2;
  String telefono;
  String recpago;
  String claseimpuesto;
  DateTime actualizado;
  ProveedoresReg({
    required this.proveedor,
    required this.nombreproveedor,
    required this.fechacreado,
    required this.cuisupplier,
    required this.nit,
    required this.nit2,
    required this.telefono,
    required this.recpago,
    required this.claseimpuesto,
    required this.actualizado,
  });

  ProveedoresReg copyWith({
    int? proveedor,
    String? nombreproveedor,
    DateTime? fechacreado,
    String? cuisupplier,
    String? nit,
    String? nit2,
    String? telefono,
    String? recpago,
    String? claseimpuesto,
    DateTime? actualizado,
  }) {
    return ProveedoresReg(
      proveedor: proveedor ?? this.proveedor,
      nombreproveedor: nombreproveedor ?? this.nombreproveedor,
      fechacreado: fechacreado ?? this.fechacreado,
      cuisupplier: cuisupplier ?? this.cuisupplier,
      nit: nit ?? this.nit,
      nit2: nit2 ?? this.nit2,
      telefono: telefono ?? this.telefono,
      recpago: recpago ?? this.recpago,
      claseimpuesto: claseimpuesto ?? this.claseimpuesto,
      actualizado: actualizado ?? this.actualizado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'proveedor': proveedor,
      'nombreproveedor': nombreproveedor,
      'fechacreado': fechacreado.millisecondsSinceEpoch,
      'cuisupplier': cuisupplier,
      'nit': nit,
      'nit2': nit2,
      'telefono': telefono,
      'recpago': recpago,
      'claseimpuesto': claseimpuesto,
      'actualizado': actualizado.millisecondsSinceEpoch,
    };
  }

  factory ProveedoresReg.fromMap(Map<String, dynamic> map) {
    return ProveedoresReg(
      proveedor: aEntero(map['proveedor'].toString()),
      nombreproveedor: map['nombreproveedor'].toString(),
      fechacreado: aFecha(map['fechacreado'].toString()),
      cuisupplier: map['cuisupplier'].toString(),
      nit: map['nit'].toString(),
      nit2: map['nit2'].toString(),
      telefono: map['telefono'].toString(),
      recpago: map['recpago'].toString(),
      claseimpuesto: map['claseimpuesto'].toString(),
      actualizado: aFecha(map['actualizado'].toString()),
    );
  }

  factory ProveedoresReg.fromInit() {
    return ProveedoresReg(
      proveedor: aEntero(""),
      nombreproveedor: "",
      fechacreado: aFecha(""),
      cuisupplier: "",
      nit: "",
      nit2: "",
      telefono: "",
      recpago: "",
      claseimpuesto: "",
      actualizado: aFecha(""),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProveedoresReg.fromJson(String source) =>
      ProveedoresReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProveedoresReg(proveedor: $proveedor, nombreproveedor: $nombreproveedor, fechacreado: $fechacreado, cuisupplier: $cuisupplier, nit: $nit, nit2: $nit2, telefono: $telefono, recpago: $recpago, claseimpuesto: $claseimpuesto, actualizado: $actualizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProveedoresReg &&
        other.proveedor == proveedor &&
        other.nombreproveedor == nombreproveedor &&
        other.fechacreado == fechacreado &&
        other.cuisupplier == cuisupplier &&
        other.nit == nit &&
        other.nit2 == nit2 &&
        other.telefono == telefono &&
        other.recpago == recpago &&
        other.claseimpuesto == claseimpuesto &&
        other.actualizado == actualizado;
  }

  @override
  int get hashCode {
    return proveedor.hashCode ^
        nombreproveedor.hashCode ^
        fechacreado.hashCode ^
        cuisupplier.hashCode ^
        nit.hashCode ^
        nit2.hashCode ^
        telefono.hashCode ^
        recpago.hashCode ^
        claseimpuesto.hashCode ^
        actualizado.hashCode;
  }
}
