import 'dart:convert';

import 'package:flutter/material.dart';

import '../../resources/sumar_meses.dart';
import '../../resources/titulo.dart';
import '../../resources/to_mcop.dart';

class VistaContratoReg {
  String contrato;
  String gestor;
  String gac;
  String proveedor;
  String proceso;
  DateTime inicio;
  DateTime fin;
  int ctd;
  int total;
  int consumo;
  int restante;
  int saldoSap;
  int vencido;
  int planificado;
  int conformado;
  VistaContratoReg({
    required this.contrato,
    required this.gestor,
    required this.gac,
    required this.proveedor,
    required this.proceso,
    required this.inicio,
    required this.fin,
    required this.ctd,
    required this.total,
    required this.consumo,
    required this.restante,
    required this.saldoSap,
    required this.vencido,
    required this.planificado,
    required this.conformado,
  });

  int get porConsumo {
    if (total == 0 || consumo == 0) return -1;
    int porConsumoInterno = 100 * consumo ~/ total;
    return porConsumoInterno == 0 ? 1 : porConsumoInterno;
  }

  int get porTiempo {
    int totalMeses = monthsBetween(inicio, fin);
    if (totalMeses == 0) return -1;
    DateTime hoy = DateTime.now();
    int transcurrido = monthsBetween(inicio, hoy);
    return 100 * transcurrido ~/ totalMeses;
  }

  String get concepto {
    DateTime hoy = DateTime.now();
    if (fin.isBefore(hoy)) return 'Finalizado';
    if (porConsumo == -1 || porTiempo == -1) return '-';
    if (porConsumo - porTiempo > 10) {
      return "SobreEjecutado en ${porConsumo - porTiempo}%";
    }
    if (porTiempo - porConsumo > 10) {
      return "SubEjecutado en ${porTiempo - porConsumo}%";
    }
    return "ok";
  }

  Color? get conceptoColor {
    DateTime hoy = DateTime.now();
    if (fin.isBefore(hoy)) return Colors.grey;
    if (porConsumo == -1 || porTiempo == -1) return Colors.grey;
    int dif = (porConsumo - porTiempo).abs();
    if (dif >= 10 && dif < 15) return Colors.orange;
    if (dif >= 15 && dif < 20) return Colors.orange[700]!;
    if (dif >= 20 && dif < 25) return Colors.red[400]!;
    if (dif >= 25 && dif < 30) return Colors.red[600]!;
    if (dif >= 30 && dif < 35) return Colors.red[800]!;
    if (dif >= 35) return Colors.pink;
    return null;
  }

  Color get colorFinProy {
    DateTime hoy = DateTime.now();
    if (fin.isBefore(hoy)) {
      return Colors.grey;
    }
    if (porConsumo == -1 || porTiempo == -1) return Colors.grey;
    int transcurrido = monthsBetween(inicio, hoy);
    int totalMesesProy = 100 * transcurrido ~/ porConsumo;
    DateTime finProyectado = sumarMeses(inicio, totalMesesProy);
    //
    bool finUnMes =
        finProyectado.isBefore(DateTime.now().add(Duration(days: 30)));
    bool finTresMeses =
        finProyectado.isBefore(DateTime.now().add(Duration(days: 90)));
    bool finSeisMeses =
        finProyectado.isBefore(DateTime.now().add(Duration(days: 180)));
    bool finOchoMeses =
        finProyectado.isBefore(DateTime.now().add(Duration(days: 240)));
    if (finUnMes) return Colors.pink;
    if (finTresMeses) return Colors.red;
    if (finSeisMeses) return Colors.deepOrange;
    if (finOchoMeses) return Colors.orange;

    return Colors.black;
  }

  String get fechaFinProy {
    DateTime hoy = DateTime.now();
    if (fin.isBefore(hoy)) return '-';
    if (porConsumo == -1 || porTiempo == -1) return '-';
    if (porConsumo == 0 || porTiempo == 0) return '-';
    int transcurrido = monthsBetween(inicio, hoy);
    int totalMesesProy = 100 * transcurrido ~/ porConsumo;
    DateTime finProyectado = sumarMeses(inicio, totalMesesProy);
    return finProyectado.toString().substring(0, 7);
  }

  List<String> toList() {
    return [
      contrato.toString(),
      gestor,
      gac,
      proveedor.toString(),
      proceso,
      inicio.toString(),
      fin.toString(),
      ctd.toString(),
      total.toString(),
      consumo.toString(),
      restante.toString(),
      saldoSap.toString(),
      vencido.toString(),
      planificado.toString(),
      conformado.toString(),
    ];
  }

  VistaContratoReg copyWith({
    String? contrato,
    String? gestor,
    String? gac,
    String? proveedor,
    String? proceso,
    DateTime? inicio,
    DateTime? fin,
    int? ctd,
    int? total,
    int? consumo,
    int? restante,
    int? saldoSap,
    int? vencido,
    int? planificado,
    int? conformado,
  }) {
    return VistaContratoReg(
      contrato: contrato ?? this.contrato,
      gestor: gestor ?? this.gestor,
      gac: gac ?? this.gac,
      proveedor: proveedor ?? this.proveedor,
      proceso: proceso ?? this.proceso,
      inicio: inicio ?? this.inicio,
      fin: fin ?? this.fin,
      ctd: ctd ?? this.ctd,
      total: total ?? this.total,
      consumo: consumo ?? this.consumo,
      restante: restante ?? this.restante,
      saldoSap: saldoSap ?? this.saldoSap,
      vencido: vencido ?? this.vencido,
      planificado: planificado ?? this.planificado,
      conformado: conformado ?? this.conformado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contrato': contrato,
      'gestor': gestor,
      'gac': gac,
      'proveedor': proveedor,
      'proceso': proceso,
      'inicio': inicio.toString().substring(0, 10),
      'fin': fin.toString().substring(0, 10),
      'ctd': ctd,
      'total': total,
      'consumo': consumo,
      'restante': restante,
      'saldoSap': saldoSap,
      'vencido': vencido,
      'planificado': planificado,
      'conformado': conformado,
      '%consumo': porConsumo,
      '%tiempo': porTiempo,
      'concepto': concepto,
      'fechafinproyectada': fechaFinProy,
    };
  }

  factory VistaContratoReg.fromMap(Map<String, dynamic> map) {
    return VistaContratoReg(
      contrato: map['contrato'] ?? '',
      gestor: map['gestor'] ?? '',
      gac: map['gac'] ?? '',
      proveedor: map['proveedor'] ?? '',
      proceso: map['proceso'] ?? '',
      inicio: DateTime.fromMillisecondsSinceEpoch(map['inicio']),
      fin: DateTime.fromMillisecondsSinceEpoch(map['fin']),
      ctd: map['ctd']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      consumo: map['consumo']?.toInt() ?? 0,
      restante: map['restante']?.toInt() ?? 0,
      saldoSap: map['saldoSap']?.toInt() ?? 0,
      vencido: map['vencido']?.toInt() ?? 0,
      planificado: map['planificado']?.toInt() ?? 0,
      conformado: map['conformado']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VistaContratoReg.fromJson(String source) =>
      VistaContratoReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VistaContratoReg(contrato: $contrato, proveedor: $proveedor, inicio: $inicio, fin: $fin, ctd: $ctd, total: $total, consumo: $consumo, restante: $restante, saldoSap: $saldoSap, vencido: $vencido, planificado: $planificado, conformado: $conformado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VistaContratoReg &&
        other.contrato == contrato &&
        other.proveedor == proveedor &&
        other.inicio == inicio &&
        other.fin == fin &&
        other.ctd == ctd &&
        other.total == total &&
        other.consumo == consumo &&
        other.restante == restante &&
        other.saldoSap == saldoSap &&
        other.vencido == vencido &&
        other.planificado == planificado &&
        other.conformado == conformado;
  }

  @override
  int get hashCode {
    return contrato.hashCode ^
        proveedor.hashCode ^
        inicio.hashCode ^
        fin.hashCode ^
        ctd.hashCode ^
        total.hashCode ^
        consumo.hashCode ^
        restante.hashCode ^
        saldoSap.hashCode ^
        vencido.hashCode ^
        planificado.hashCode ^
        conformado.hashCode;
  }

  Color get colorFin {
    bool finUnMes = fin.isBefore(DateTime.now().add(Duration(days: 30)));
    bool finTresMeses = fin.isBefore(DateTime.now().add(Duration(days: 90)));
    bool finSeisMeses = fin.isBefore(DateTime.now().add(Duration(days: 180)));
    bool finOchoMeses = fin.isBefore(DateTime.now().add(Duration(days: 240)));
    if (finUnMes) return Colors.pink;
    if (finTresMeses) return Colors.red;
    if (finSeisMeses) return Colors.deepOrange;
    if (finOchoMeses) return Colors.orange;

    return Colors.black;
  }

  Color get colorRestante {
    bool cinco = restante / total < 0.05;
    bool diez = restante / total < 0.1;
    bool veinte = restante / total < 0.2;
    if (cinco) return Colors.pinkAccent;
    if (diez) return Colors.red;
    if (veinte) return Colors.orange;
    return Colors.black;
  }

  Color get colorVencido {
    bool esMayorAlRestante = vencido > restante;
    if (esMayorAlRestante) return Colors.red;
    return Colors.black;
  }

  Color get colorSaldoSAP {
    bool tieneConsumo = consumo != 0;
    bool esDiferente =
        saldoSap + 90000 < restante || saldoSap - 90000 > restante;
    if (esDiferente && tieneConsumo) return Colors.red;
    return Colors.black;
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: contrato, flex: 2),
        ToCelda(valor: gestor.toUpperCase(), flex: 3),
        ToCelda(valor: gac.toUpperCase(), flex: 3),
        ToCelda(valor: proveedor.toUpperCase(), flex: 5),
        ToCelda(valor: proceso, flex: 2),
        ToCelda(valor: inicio.toString().substring(0, 10), flex: 2),
        ToCelda(
            valor: fin.toString().substring(0, 10), flex: 2, color: colorFin),
        ToCelda(valor: ctd.toString(), flex: 1),
        ToCelda(valor: toMCOP(total, 1), flex: 2),
        ToCelda(valor: toMCOP(consumo, 1), flex: 2),
        ToCelda(valor: toMCOP(restante, 1), flex: 2, color: colorRestante),
        // ToCelda(valor: toMCOP(saldoSap, 1), flex: 2, color: colorSaldoSAP),
        ToCelda(valor: toMCOP(vencido, 1), flex: 2, color: colorVencido),
        ToCelda(valor: toMCOP(planificado, 1), flex: 2),
        ToCelda(valor: toMCOP(conformado, 1), flex: 2),
        ToCelda(valor: "$porConsumo%", flex: 1),
        ToCelda(valor: "$porTiempo%", flex: 1),
        ToCelda(valor: concepto, flex: 3, color: conceptoColor),
        ToCelda(valor: fechaFinProy, flex: 2, color: colorFinProy),
      ];
}
