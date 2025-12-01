import 'dart:convert';
import 'dart:ui';

import 'package:cos/resources/a_entero_2.dart';
import 'package:cos/resources/a_fecha.dart';
import 'package:flutter/material.dart';

import '../../resources/titulo.dart';
import '../../resources/to_mcop.dart';

class ProcesadoLclsReg {
  String lcl;
  String descripcion;
  String iva;
  int pos;
  int borrado;
  int entregafinal;
  int valorinicial;
  int conformado;
  int consumo;
  int vencido;
  int planificado;
  DateTime inicio;
  DateTime fin;
  String correo;
  String grupo;
  String proyecto;
  String wbe;
  String actualizado;
  String contrato = "";
  ProcesadoLclsReg({
    required this.lcl,
    required this.descripcion,
    required this.iva,
    required this.pos,
    required this.borrado,
    required this.entregafinal,
    required this.valorinicial,
    required this.conformado,
    required this.consumo,
    required this.vencido,
    required this.planificado,
    required this.inicio,
    required this.fin,
    required this.correo,
    required this.grupo,
    required this.proyecto,
    required this.wbe,
    required this.actualizado,
  });

  List<String> toList() {
    return [
      lcl,
      descripcion,
      iva,
      pos.toString(),
      borrado.toString(),
      entregafinal.toString(),
      valorinicial.toString(),
      conformado.toString(),
      consumo.toString(),
      vencido.toString(),
      planificado.toString(),
      inicio.toString(),
      fin.toString(),
      correo,
      grupo,
      proyecto,
      wbe,
      actualizado,
    ];
  }

  ProcesadoLclsReg copyWith({
    String? lcl,
    String? descripcion,
    String? iva,
    int? pos,
    int? borrado,
    int? entregafinal,
    int? valorinicial,
    int? conformado,
    int? consumo,
    int? vencido,
    int? planificado,
    DateTime? inicio,
    DateTime? fin,
    String? correo,
    String? grupo,
    String? proyecto,
    String? wbe,
    String? actualizado,
  }) {
    return ProcesadoLclsReg(
      lcl: lcl ?? this.lcl,
      descripcion: descripcion ?? this.descripcion,
      iva: iva ?? this.iva,
      pos: pos ?? this.pos,
      borrado: borrado ?? this.borrado,
      entregafinal: entregafinal ?? this.entregafinal,
      valorinicial: valorinicial ?? this.valorinicial,
      conformado: conformado ?? this.conformado,
      consumo: consumo ?? this.consumo,
      vencido: vencido ?? this.vencido,
      planificado: planificado ?? this.planificado,
      inicio: inicio ?? this.inicio,
      fin: fin ?? this.fin,
      correo: correo ?? this.correo,
      grupo: grupo ?? this.grupo,
      proyecto: proyecto ?? this.proyecto,
      wbe: wbe ?? this.wbe,
      actualizado: actualizado ?? this.actualizado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lcl': lcl,
      'descripcion': descripcion,
      'iva': iva,
      'pos': pos,
      'borrado': borrado,
      'entregafinal': entregafinal,
      'valorinicial': valorinicial,
      'conformado': conformado,
      'consumo': consumo,
      'vencido': vencido,
      'planificado': planificado,
      'inicio': inicio.toString().substring(0,10),
      'fin': fin.toString().substring(0,10),
      'correo': correo,
      'grupo': grupo,
      'proyecto': proyecto,
      'wbe': wbe,
      'contrato': contrato,
      'actualizado': actualizado,
    };
  }

  Map<String, dynamic> toMapContrato() {
    return {
      'lcl': lcl,
      'descripcion': descripcion,
      'iva': iva,
      'pos': pos,
      'borrado': borrado,
      'entregafinal': entregafinal,
      'valorinicial': valorinicial,
      'conformado': conformado,
      'consumo': consumo,
      'vencido': vencido,
      'planificado': planificado,
      'inicio': inicio.toString().substring(0,10),
      'fin': fin.toString().substring(0,10),
      'correo': correo,
      'grupo': grupo,
      'proyecto': proyecto,
      'wbe': wbe,
      'contrato': contrato,
      'actualizado': actualizado,
    };
  }

  factory ProcesadoLclsReg.fromMap(Map<String, dynamic> map) {
    return ProcesadoLclsReg(
      lcl: map['lcl'].toString(),
      descripcion: map['descripcion'].toString(),
      iva: map['iva'].toString(),
      pos: aEntero(map['pos'].toString()),
      borrado: aEntero(map['borrado'].toString()),
      entregafinal: aEntero(map['entregafinal'].toString()),
      valorinicial: aEntero(map['valorinicial'].toString()),
      conformado: aEntero(map['conformado'].toString()),
      consumo: aEntero(map['consumo'].toString()),
      vencido: aEntero(map['vencido'].toString()),
      planificado: aEntero(map['planificado'].toString()),
      inicio: aFecha(map['inicio'].toString()),
      fin: aFecha(map['fin'].toString()),
      correo: map['correo'].toString(),
      grupo: map['grupo'].toString(),
      proyecto: map['proyecto'].toString(),
      wbe: map['wbe'].toString(),
      actualizado: map['actualizado'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProcesadoLclsReg.fromJson(String source) =>
      ProcesadoLclsReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProcesadoLcls(lcl: $lcl, descripcion: $descripcion, iva: $iva, pos: $pos, borrado: $borrado, entregafinal: $entregafinal, valorinicial: $valorinicial, conformado: $conformado, consumo: $consumo, vencido: $vencido, planificado: $planificado, inicio: $inicio, fin: $fin, correo: $correo, grupo: $grupo, proyecto: $proyecto, wbe: $wbe, actualizado: $actualizado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProcesadoLclsReg &&
        other.lcl == lcl &&
        other.descripcion == descripcion &&
        other.iva == iva &&
        other.pos == pos &&
        other.borrado == borrado &&
        other.entregafinal == entregafinal &&
        other.valorinicial == valorinicial &&
        other.conformado == conformado &&
        other.consumo == consumo &&
        other.vencido == vencido &&
        other.planificado == planificado &&
        other.inicio == inicio &&
        other.fin == fin &&
        other.correo == correo &&
        other.grupo == grupo &&
        other.proyecto == proyecto &&
        other.wbe == wbe &&
        other.actualizado == actualizado;
  }

  @override
  int get hashCode {
    return lcl.hashCode ^
        descripcion.hashCode ^
        iva.hashCode ^
        pos.hashCode ^
        borrado.hashCode ^
        entregafinal.hashCode ^
        valorinicial.hashCode ^
        conformado.hashCode ^
        consumo.hashCode ^
        vencido.hashCode ^
        planificado.hashCode ^
        inicio.hashCode ^
        fin.hashCode ^
        correo.hashCode ^
        grupo.hashCode ^
        proyecto.hashCode ^
        wbe.hashCode ^
        actualizado.hashCode;
  }

  Color get colorVencido {
    if (vencido == 0) return Colors.grey;
    return Colors.black;
  }

  Color get colorPlanificado {
    if (planificado == 0) return Colors.grey;
    return Colors.black;
  }

  Color get colorConsumo {
    if (consumo == 0) return Colors.grey;
    return Colors.black;
  }

  Color get colorConformidad {
    if (conformado == 0) return Colors.grey;
    return Colors.black;
  }

  Color get colorFin {
    // if (posiciones.vencido == 0) return Colors.black;
    bool finUnMes = fin.isBefore(DateTime.now().subtract(Duration(days: 30)));
    bool finTresMeses =
        fin.isBefore(DateTime.now().subtract(Duration(days: 90)));
    bool finSeisMeses =
        fin.isBefore(DateTime.now().subtract(Duration(days: 180)));
    bool finOchoMeses =
        fin.isBefore(DateTime.now().subtract(Duration(days: 240)));
    if (finOchoMeses) return Colors.pink;
    if (finSeisMeses) return Colors.red;
    if (finTresMeses) return Colors.deepOrange;
    if (finUnMes) return Colors.orange[700]!;
    return Colors.orange;
  }

  List<ToCelda> get celdas {
    // bool nullproyectos = proyectos == null;
    // String proyectosJoin = nullproyectos ? "" : proyectos!.proyectos;

    return [
      ToCelda(valor: lcl, flex: 2),
      ToCelda(valor: iva, flex: 1),
      ToCelda(valor: descripcion, flex: 5),
      ToCelda(valor: pos.toString(), flex: 1),
      ToCelda(valor: entregafinal.toString(), flex: 1),
      ToCelda(valor: borrado.toString(), flex: 1),
      ToCelda(
        valor: toMCOP(valorinicial, 1),
        flex: 2,
        color: colorConsumo,
      ),
      ToCelda(
        valor: toMCOP(consumo, 1),
        flex: 2,
        color: colorConsumo,
      ),
      ToCelda(
        valor: toMCOP(vencido, 1),
        flex: 2,
        color: colorVencido,
      ),
      ToCelda(
        valor: toMCOP(planificado, 1),
        flex: 2,
        color: colorPlanificado,
      ),
      ToCelda(
        valor: toMCOP(conformado, 1),
        flex: 2,
        color: colorConformidad,
      ),
      ToCelda(valor: proyecto, flex: 4),
      ToCelda(valor: inicio.toIso8601String().substring(0, 10), flex: 2),
      ToCelda(
        valor: fin.toIso8601String().substring(0, 10),
        flex: 2,
        color: colorFin,
      ),
      ToCelda(valor: correo, flex: 5),
      ToCelda(valor: grupo, flex: 2),
    ];
  }
}
