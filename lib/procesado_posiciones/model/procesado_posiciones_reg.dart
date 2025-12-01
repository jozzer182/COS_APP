import 'dart:convert';

import 'package:cos/resources/a_entero_2.dart';
import 'package:flutter/material.dart';

import '../../resources/titulo.dart';
import '../../resources/to_mcop.dart';

class ProcesadoPosicionesReg {
  String lcl;
  String pos;
  String indicadorimpuesto;
  String descripcion;
  String borrado;
  String entregafinal;
  int valorinicial;
  int conformado;
  int consumo;
  int comprometido;
  ProcesadoPosicionesReg({
    required this.lcl,
    required this.pos,
    required this.indicadorimpuesto,
    required this.descripcion,
    required this.borrado,
    required this.entregafinal,
    required this.valorinicial,
    required this.conformado,
    required this.consumo,
    required this.comprometido,
  });

  ProcesadoPosicionesReg copyWith({
    String? lcl,
    String? pos,
    String? indicadorimpuesto,
    String? descripcion,
    String? borrado,
    String? entregafinal,
    int? valorinicial,
    int? conformado,
    int? consumo,
    int? comprometido,
  }) {
    return ProcesadoPosicionesReg(
      lcl: lcl ?? this.lcl,
      pos: pos ?? this.pos,
      indicadorimpuesto: indicadorimpuesto ?? this.indicadorimpuesto,
      descripcion: descripcion ?? this.descripcion,
      borrado: borrado ?? this.borrado,
      entregafinal: entregafinal ?? this.entregafinal,
      valorinicial: valorinicial ?? this.valorinicial,
      conformado: conformado ?? this.conformado,
      consumo: consumo ?? this.consumo,
      comprometido: comprometido ?? this.comprometido,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lcl': lcl,
      'pos': pos,
      'indicadorimpuesto': indicadorimpuesto,
      'descripcion': descripcion,
      'borrado': borrado,
      'entregafinal': entregafinal,
      'valorinicial': valorinicial,
      'conformado': conformado,
      'consumo': consumo,
      'comprometido': comprometido,
    };
  }

  factory ProcesadoPosicionesReg.fromMap(Map<String, dynamic> map) {
    return ProcesadoPosicionesReg(
      lcl: map['lcl'].toString(),
      pos: map['pos'].toString(),
      indicadorimpuesto: map['indicadorimpuesto'].toString(),
      descripcion: map['descripcion'].toString(),
      borrado: map['borrado'].toString(),
      entregafinal: map['entregafinal'].toString(),
      valorinicial: aEntero(map['valorinicial'].toString()),
      conformado: aEntero(map['conformado'].toString()),
      consumo: aEntero(map['consumo'].toString()),
      comprometido: aEntero(map['comprometido'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProcesadoPosicionesReg.fromJson(String source) =>
      ProcesadoPosicionesReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProcesadoPosicionesReg(lcl: $lcl, pos: $pos, indicadorimpuesto: $indicadorimpuesto, descripcion: $descripcion, borrado: $borrado, entregafinal: $entregafinal, valorinicial: $valorinicial, conformado: $conformado, consumo: $consumo, comprometido: $comprometido)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProcesadoPosicionesReg &&
        other.lcl == lcl &&
        other.pos == pos &&
        other.indicadorimpuesto == indicadorimpuesto &&
        other.descripcion == descripcion &&
        other.borrado == borrado &&
        other.entregafinal == entregafinal &&
        other.valorinicial == valorinicial &&
        other.conformado == conformado &&
        other.consumo == consumo &&
        other.comprometido == comprometido;
  }

  @override
  int get hashCode {
    return lcl.hashCode ^
        pos.hashCode ^
        indicadorimpuesto.hashCode ^
        descripcion.hashCode ^
        borrado.hashCode ^
        entregafinal.hashCode ^
        valorinicial.hashCode ^
        conformado.hashCode ^
        consumo.hashCode ^
        comprometido.hashCode;
  }

  Color get colorConsumo {
    if (consumo == 0) return Colors.grey;
    return Colors.black;
  }

  Color get colorNeto {
    if (valorinicial == 0) return Colors.grey;
    return Colors.black;
  }

  Color get colorConformado {
    if (conformado == 0) return Colors.grey;
    if (conformado > (valorinicial + 100)) return Colors.green[700]!;
    return Colors.black;
  }

  Color get colorVencido {
    if (comprometido == 0) return Colors.grey;
    return Colors.black;
  }

  List<ToCelda> get celdas => [
        ToCelda(valor: pos.toString(), flex: 1),
        ToCelda(valor: descripcion.toString(), flex: 6),
        ToCelda(valor: indicadorimpuesto, flex: 1),
        ToCelda(valor: entregafinal, flex: 1),
        ToCelda(valor: borrado, flex: 1),
        ToCelda(
          valor: toMCOP(consumo, 1),
          flex: 2,
          color: colorConsumo,
        ),
        ToCelda(
          valor: toMCOP(valorinicial, 1),
          flex: 2,
          color: colorNeto,
        ),
        ToCelda(
          valor: toMCOP(conformado, 1),
          flex: 2,
          color: colorConformado,
        ),
        ToCelda(
          valor: toMCOP(comprometido, 1),
          flex: 2,
          color: colorVencido,
        ),
      ];
}
