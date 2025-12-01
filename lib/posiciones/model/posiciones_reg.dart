import 'dart:convert';

import 'package:cos/resources/a_entero_2.dart';
import 'package:cos/resources/a_fecha.dart';
import 'package:cos/resources/to_mcop.dart';

import '../../resources/titulo.dart';

class PosicionesReg {
  String contrato;
  int posicion;
  String fechamodificacion;
  String descripcion;
  String grupoarticulos;
  int precioneto;
  int valorbruto;
  String indicadorimpuesto;
  String iliimitado;
  String tipoimputacion;
  int valorprevisto;
  int valorefectivo;
  String paquetenumero;
  String solpedido;
  String solpedidopos;
  int subtotaltres;
  String solicitante;
  String jaggaerrefpos;
  DateTime actualizado;
  PosicionesReg({
    required this.contrato,
    required this.posicion,
    required this.fechamodificacion,
    required this.descripcion,
    required this.grupoarticulos,
    required this.precioneto,
    required this.valorbruto,
    required this.indicadorimpuesto,
    required this.iliimitado,
    required this.tipoimputacion,
    required this.valorprevisto,
    required this.valorefectivo,
    required this.paquetenumero,
    required this.solpedido,
    required this.solpedidopos,
    required this.subtotaltres,
    required this.solicitante,
    required this.jaggaerrefpos,
    required this.actualizado,
  });

  List<String> toList() {
    return [
      contrato,
      posicion.toString(),
      fechamodificacion,
      descripcion,
      grupoarticulos,
      precioneto.toString(),
      valorbruto.toString(),
      indicadorimpuesto,
      iliimitado,
      tipoimputacion,
      valorprevisto.toString(),
      valorefectivo.toString(),
      paquetenumero,
      solpedido,
      solpedidopos,
      subtotaltres.toString(),
      solicitante,
      jaggaerrefpos,
      actualizado.toString(),
    ];
  }

  PosicionesReg copyWith({
    String? contrato,
    int? posicion,
    String? fechamodificacion,
    String? descripcion,
    String? grupoarticulos,
    int? precioneto,
    int? valorbruto,
    String? indicadorimpuesto,
    String? iliimitado,
    String? tipoimputacion,
    int? valorprevisto,
    int? valorefectivo,
    String? paquetenumero,
    String? solpedido,
    String? solpedidopos,
    int? subtotaltres,
    String? solicitante,
    String? jaggaerrefpos,
    DateTime? actualizado,
  }) {
    return PosicionesReg(
      contrato: contrato ?? this.contrato,
      posicion: posicion ?? this.posicion,
      fechamodificacion: fechamodificacion ?? this.fechamodificacion,
      descripcion: descripcion ?? this.descripcion,
      grupoarticulos: grupoarticulos ?? this.grupoarticulos,
      precioneto: precioneto ?? this.precioneto,
      valorbruto: valorbruto ?? this.valorbruto,
      indicadorimpuesto: indicadorimpuesto ?? this.indicadorimpuesto,
      iliimitado: iliimitado ?? this.iliimitado,
      tipoimputacion: tipoimputacion ?? this.tipoimputacion,
      valorprevisto: valorprevisto ?? this.valorprevisto,
      valorefectivo: valorefectivo ?? this.valorefectivo,
      paquetenumero: paquetenumero ?? this.paquetenumero,
      solpedido: solpedido ?? this.solpedido,
      solpedidopos: solpedidopos ?? this.solpedidopos,
      subtotaltres: subtotaltres ?? this.subtotaltres,
      solicitante: solicitante ?? this.solicitante,
      jaggaerrefpos: jaggaerrefpos ?? this.jaggaerrefpos,
      actualizado: actualizado ?? this.actualizado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contrato': contrato,
      'posicion': posicion,
      'fechamodificacion': fechamodificacion,
      'descripcion': descripcion,
      'grupoarticulos': grupoarticulos,
      'precioneto': precioneto,
      'valorbruto': valorbruto,
      'indicadorimpuesto': indicadorimpuesto,
      'iliimitado': iliimitado,
      'tipoimputacion': tipoimputacion,
      'valorprevisto': valorprevisto,
      'valorefectivo': valorefectivo,
      'paquetenumero': paquetenumero,
      'solpedido': solpedido,
      'solpedidopos': solpedidopos,
      'subtotaltres': subtotaltres,
      'solicitante': solicitante,
      'jaggaerrefpos': jaggaerrefpos,
      'actualizado': actualizado.toString(),
    };
  }

  factory PosicionesReg.fromMap(Map<String, dynamic> map) {
    return PosicionesReg(
      contrato: map['contrato'].toString(),
      posicion: aEntero(map['posicion'].toString()),
      fechamodificacion: map['fechamodificacion'].toString(),
      descripcion: map['descripcion'].toString(),
      grupoarticulos: map['grupoarticulos'].toString(),
      precioneto: aEntero(map['precioneto'].toString()),
      valorbruto: aEntero(map['valorbruto'].toString()),
      indicadorimpuesto: map['indicadorimpuesto'].toString(),
      iliimitado: map['iliimitado'].toString(),
      tipoimputacion: map['tipoimputacion'].toString(),
      valorprevisto: aEntero(map['valorprevisto'].toString()),
      valorefectivo: aEntero(map['valorefectivo'].toString()),
      paquetenumero: map['paquetenumero'].toString(),
      solpedido: map['solpedido'].toString(),
      solpedidopos: map['solpedidopos'].toString(),
      subtotaltres: aEntero(map['subtotaltres'].toString()),
      solicitante: map['solicitante'].toString(),
      jaggaerrefpos: map['jaggaerrefpos'].toString(),
      actualizado: aFecha(map['actualizado'].toString()),
    );
  }

  factory PosicionesReg.fromInit() {
    return PosicionesReg(
      contrato: "",
      posicion: aEntero(""),
      fechamodificacion: "",
      descripcion: "",
      grupoarticulos: "",
      precioneto: aEntero(""),
      valorbruto: aEntero(""),
      indicadorimpuesto: "",
      iliimitado: "",
      tipoimputacion: "",
      valorprevisto: aEntero(""),
      valorefectivo: aEntero(""),
      paquetenumero: "",
      solpedido: "",
      solpedidopos: "",
      subtotaltres: aEntero(""),
      solicitante: "",
      jaggaerrefpos: "",
      actualizado: aFecha(""),
    );
  }

  String toJson() => json.encode(toMap());

  factory PosicionesReg.fromJson(String source) =>
      PosicionesReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PosicionesReg(contrato: $contrato, posicion: $posicion, fechamodificacion: $fechamodificacion, descripcion: $descripcion, grupoarticulos: $grupoarticulos, precioneto: $precioneto, valorbruto: $valorbruto, indicadorimpuesto: $indicadorimpuesto, iliimitado: $iliimitado, tipoimputacion: $tipoimputacion, valorprevisto: $valorprevisto, valorefectivo: $valorefectivo, paquetenumero: $paquetenumero, solpedido: $solpedido, solpedidopos: $solpedidopos, subtotaltres: $subtotaltres, solicitante: $solicitante, jaggaerrefpos: $jaggaerrefpos, actualizado: $actualizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PosicionesReg &&
        other.contrato == contrato &&
        other.posicion == posicion &&
        other.fechamodificacion == fechamodificacion &&
        other.descripcion == descripcion &&
        other.grupoarticulos == grupoarticulos &&
        other.precioneto == precioneto &&
        other.valorbruto == valorbruto &&
        other.indicadorimpuesto == indicadorimpuesto &&
        other.iliimitado == iliimitado &&
        other.tipoimputacion == tipoimputacion &&
        other.valorprevisto == valorprevisto &&
        other.valorefectivo == valorefectivo &&
        other.paquetenumero == paquetenumero &&
        other.solpedido == solpedido &&
        other.solpedidopos == solpedidopos &&
        other.subtotaltres == subtotaltres &&
        other.solicitante == solicitante &&
        other.jaggaerrefpos == jaggaerrefpos &&
        other.actualizado == actualizado;
  }

  @override
  int get hashCode {
    return contrato.hashCode ^
        posicion.hashCode ^
        fechamodificacion.hashCode ^
        descripcion.hashCode ^
        grupoarticulos.hashCode ^
        precioneto.hashCode ^
        valorbruto.hashCode ^
        indicadorimpuesto.hashCode ^
        iliimitado.hashCode ^
        tipoimputacion.hashCode ^
        valorprevisto.hashCode ^
        valorefectivo.hashCode ^
        paquetenumero.hashCode ^
        solpedido.hashCode ^
        solpedidopos.hashCode ^
        subtotaltres.hashCode ^
        solicitante.hashCode ^
        jaggaerrefpos.hashCode ^
        actualizado.hashCode;
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: posicion.toString(), flex: 2),
        ToCelda(valor: fechamodificacion.substring(0, 10), flex: 2),
        ToCelda(valor: descripcion, flex: 6),
        ToCelda(valor: grupoarticulos, flex: 2),
        ToCelda(valor: indicadorimpuesto, flex: 2),
        ToCelda(valor: toMCOP(precioneto, 1), flex: 2),
        ToCelda(valor: toMCOP(valorbruto, 1), flex: 2),
        ToCelda(valor: toMCOP(valorprevisto, 1), flex: 2),
        ToCelda(valor: toMCOP(valorefectivo, 1), flex: 2),
        ToCelda(valor: toMCOP(subtotaltres, 1), flex: 2),
        ToCelda(valor: solpedido, flex: 2),
        ToCelda(valor: solpedidopos, flex: 2),
        ToCelda(valor: solicitante, flex: 2),
        ToCelda(valor: iliimitado, flex: 2),
        ToCelda(valor: tipoimputacion, flex: 2),
        ToCelda(valor: paquetenumero, flex: 2),
        ToCelda(valor: jaggaerrefpos, flex: 2),
      ];
}
