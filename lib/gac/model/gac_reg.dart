import 'dart:convert';

class GacReg {
  String contrato;
  String zona;
  String gac;
  String gestor;
  String observacion;
  GacReg({
    required this.contrato,
    required this.zona,
    required this.gac,
    required this.gestor,
    required this.observacion,
  });

  List<String> toList() {
    return [
      contrato,
      zona,
      gac,
      gestor,
      observacion,
    ];
  }

  GacReg copyWith({
    String? contrato,
    String? zona,
    String? gac,
    String? gestor,
    String? observacion,
  }) {
    return GacReg(
      contrato: contrato ?? this.contrato,
      zona: zona ?? this.zona,
      gac: gac ?? this.gac,
      gestor: gestor ?? this.gestor,
      observacion: observacion ?? this.observacion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contrato': contrato,
      'zona': zona,
      'gac': gac,
      'gestor': gestor,
      'observacion': observacion,
    };
  }

  factory GacReg.fromMap(Map<String, dynamic> map) {
    return GacReg(
      contrato: map['contrato'].toString(),
      zona: map['zona'].toString(),
      gac: map['gac'].toString(),
      gestor: map['gestor'].toString(),
      observacion: map['observacion'].toString(),
    );
  }

  factory GacReg.fromInit() {
    return GacReg(
      contrato: '',
      zona: '',
      gac: '',
      gestor: '',
      observacion: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GacReg.fromJson(String source) => GacReg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GacReg(contrato: $contrato, zona: $zona, gac: $gac, gestor: $gestor, observacion: $observacion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GacReg &&
        other.contrato == contrato &&
        other.zona == zona &&
        other.gac == gac &&
        other.gestor == gestor &&
        other.observacion == observacion;
  }

  @override
  int get hashCode {
    return contrato.hashCode ^
        zona.hashCode ^
        gac.hashCode ^
        gestor.hashCode ^
        observacion.hashCode;
  }
}
