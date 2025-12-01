import 'dart:convert';

import 'package:cos/resources/to_mcop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../resources/titulo.dart';

class VistaPersonasReg {
  String nombre;
  int proyectos;
  int contratos;
  int lcls;
  int consumo;
  int vencido;
  int planificado;
  int conformado;
  String proveedores;
  List<String> contratoslist = [];
  List<String> proyectoslist = [];
  List<String> proveedoreslist = [];
  VistaPersonasReg({
    required this.nombre,
    required this.proyectos,
    required this.contratos,
    required this.lcls,
    required this.consumo,
    required this.vencido,
    required this.planificado,
    required this.conformado,
    required this.proveedores,
  });

  List<String> toList() {
    return [
      nombre.toString(),
      proyectos.toString(),
      contratos.toString(),
      lcls.toString(),
      consumo.toString(),
      vencido.toString(),
      planificado.toString(),
      conformado.toString(),
      proveedores.toString(),
    ];
  }

  VistaPersonasReg copyWith({
    String? nombre,
    int? proyectos,
    int? contratos,
    int? lcls,
    int? consumo,
    int? vencido,
    int? planificado,
    int? conformado,
    String? contratosString,
    List<String>? contratoslist,
    List<String>? proyectoslist,
  }) {
    return VistaPersonasReg(
      nombre: nombre ?? this.nombre,
      proyectos: proyectos ?? this.proyectos,
      contratos: contratos ?? this.contratos,
      lcls: lcls ?? this.lcls,
      consumo: consumo ?? this.consumo,
      vencido: vencido ?? this.vencido,
      planificado: planificado ?? this.planificado,
      conformado: conformado ?? this.conformado,
      proveedores: contratosString ?? this.proveedores,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'proyectos': proyectos,
      'contratos': contratos,
      'lcls': lcls,
      'consumo': consumo,
      'vencido': vencido,
      'planificado': planificado,
      'conformado': conformado,
      'contratosString': proveedores,
      'contratoslist': contratoslist,
      'proyectoslist': proyectoslist,
    };
  }

  factory VistaPersonasReg.fromMap(Map<String, dynamic> map) {
    return VistaPersonasReg(
      nombre: map['nombre'] ?? '',
      proyectos: map['proyectos']?.toInt() ?? 0,
      contratos: map['contratos']?.toInt() ?? 0,
      lcls: map['lcls']?.toInt() ?? 0,
      consumo: map['consumo']?.toInt() ?? 0,
      vencido: map['vencido']?.toInt() ?? 0,
      planificado: map['planificado']?.toInt() ?? 0,
      conformado: map['conformado']?.toInt() ?? 0,
      proveedores: map['contratosString'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VistaPersonasReg.fromJson(String source) =>
      VistaPersonasReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VistaProyectoReg(nombre: $nombre, proyectos: $proyectos, contratos: $contratos, lcls: $lcls, consumo: $consumo, vencido: $vencido, planificado: $planificado, conformado: $conformado, contratosString: $proveedores, contratoslist: $contratoslist, proyectoslist: $proyectoslist)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VistaPersonasReg &&
        other.nombre == nombre &&
        other.proyectos == proyectos &&
        other.contratos == contratos &&
        other.lcls == lcls &&
        other.consumo == consumo &&
        other.vencido == vencido &&
        other.planificado == planificado &&
        other.conformado == conformado &&
        other.proveedores == proveedores &&
        listEquals(other.contratoslist, contratoslist) &&
        listEquals(other.proyectoslist, proyectoslist);
  }

  @override
  int get hashCode {
    return nombre.hashCode ^
        proyectos.hashCode ^
        contratos.hashCode ^
        lcls.hashCode ^
        consumo.hashCode ^
        vencido.hashCode ^
        planificado.hashCode ^
        conformado.hashCode ^
        proveedores.hashCode ^
        contratoslist.hashCode ^
        proyectoslist.hashCode;
  }

  Color get colorVencido {
    bool esMayorAlRestante = vencido > 0;
    if (esMayorAlRestante) return Colors.red;
    return Colors.black;
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: nombre, flex: 6),
        ToCelda(valor: proyectos.toString(), flex: 2),
        ToCelda(valor: contratos.toString(), flex: 2),
        ToCelda(valor: lcls.toString(), flex: 2),
        ToCelda(valor: toMCOP(consumo, 1), flex: 2),
        ToCelda(valor: toMCOP(vencido, 1), flex: 2, color: colorVencido),
        ToCelda(valor: toMCOP(planificado, 1), flex: 2),
        ToCelda(valor: toMCOP(conformado, 1), flex: 2),
        ToCelda(valor: proveedoreslist.toSet().join('\n'), flex: 8),
      ];
}
