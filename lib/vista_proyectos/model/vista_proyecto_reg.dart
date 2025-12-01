import 'dart:convert';

import 'package:cos/resources/titulo.dart';
import 'package:cos/resources/to_mcop.dart';
import 'package:flutter/material.dart';

class VistaProyectoReg {
  String wbe;
  String nombre;
  int contratos;
  int lcls;
  int consumo;
  int vencido;
  int planificado;
  int conformado;
  String usuario;
  List<String> contratoslist = [];
  List<String> usuarioslist = [];
  VistaProyectoReg({
    required this.wbe,
    required this.nombre,
    required this.contratos,
    required this.lcls,
    required this.consumo,
    required this.vencido,
    required this.planificado,
    required this.conformado,
    required this.usuario,
  });

  List<String> toList() {
    return [
      wbe.toString(),
      nombre.toString(),
      contratos.toString(),
      lcls.toString(),
      consumo.toString(),
      vencido.toString(),
      planificado.toString(),
      conformado.toString(),
      usuario.toString(),
      contratoslist.join(","),
      usuarioslist.join(","),
    ];
  }

  VistaProyectoReg copyWith({
    String? wbe,
    String? nombre,
    int? contratos,
    int? lcls,
    int? consumo,
    int? vencido,
    int? planificado,
    int? conformado,
    String? usuario,
  }) {
    return VistaProyectoReg(
      wbe: wbe ?? this.wbe,
      nombre: nombre ?? this.nombre,
      contratos: contratos ?? this.contratos,
      lcls: lcls ?? this.lcls,
      consumo: consumo ?? this.consumo,
      vencido: vencido ?? this.vencido,
      planificado: planificado ?? this.planificado,
      conformado: conformado ?? this.conformado,
      usuario: usuario ?? this.usuario,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wbe': wbe,
      'nombre': nombre,
      'contratos': contratos,
      'lcls': lcls,
      'consumo': consumo,
      'vencido': vencido,
      'planificado': planificado,
      'conformado': conformado,
      'usuario': usuario,
    };
  }

  factory VistaProyectoReg.fromMap(Map<String, dynamic> map) {
    return VistaProyectoReg(
      wbe: map['wbe'] ?? '',
      nombre: map['nombre'] ?? '',
      contratos: map['contratos']?.toInt() ?? 0,
      lcls: map['lcls']?.toInt() ?? 0,
      consumo: map['consumo']?.toInt() ?? 0,
      vencido: map['vencido']?.toInt() ?? 0,
      planificado: map['planificado']?.toInt() ?? 0,
      conformado: map['conformado']?.toInt() ?? 0,
      usuario: map['usuario'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VistaProyectoReg.fromJson(String source) =>
      VistaProyectoReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VistaProyectoReg(wbe: $wbe, nombre: $nombre, contratos: $contratos, lcls: $lcls, consumo: $consumo, vencido: $vencido, planificado: $planificado, conformado: $conformado, usuario: $usuario)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VistaProyectoReg &&
        other.wbe == wbe &&
        other.nombre == nombre &&
        other.contratos == contratos &&
        other.lcls == lcls &&
        other.consumo == consumo &&
        other.vencido == vencido &&
        other.planificado == planificado &&
        other.conformado == conformado &&
        other.usuario == usuario;
  }

  @override
  int get hashCode {
    return wbe.hashCode ^
        nombre.hashCode ^
        contratos.hashCode ^
        lcls.hashCode ^
        consumo.hashCode ^
        vencido.hashCode ^
        planificado.hashCode ^
        conformado.hashCode ^
        usuario.hashCode;
  }

  Color get colorVencido {
    bool esMayorAlRestante = vencido > 0;
    if (esMayorAlRestante) return Colors.red;
    return Colors.black;
  }

  Color get colorPlanificado{
    bool esMayorAlRestante = planificado > 0;
    if (esMayorAlRestante) return Colors.green;
    return Colors.black;
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: wbe.toString(), flex: 2),
        ToCelda(valor: nombre.toString(), flex: 6),
        ToCelda(valor: contratos.toString(), flex: 2),
        ToCelda(valor: lcls.toString(), flex: 2),
        ToCelda(valor: toMCOP(consumo, 1), flex: 2),
        ToCelda(valor: toMCOP(vencido, 1), flex: 2, color: colorVencido),
        ToCelda(valor: toMCOP(planificado, 1), flex: 2, color: colorPlanificado),
        ToCelda(valor: toMCOP(conformado, 1), flex: 2),
        ToCelda(valor: usuario.toString(), flex: 5),
      ];
}
