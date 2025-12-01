import 'dart:convert';

class User {
  final String uid;
  final String email;
  final String nombre;
  final String perfil;
  final String creado;
  final List<String> permisos;
  User({
    required this.uid,
    required this.email,
    required this.nombre,
    required this.perfil,
    required this.creado,
    required this.permisos,
  });

  User copyWith({
    String? uid,
    String? email,
    String? nombre,
    String? perfil,
    String? creado,
    List<String>? permisos,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      perfil: perfil ?? this.perfil,
      creado: creado ?? this.creado,
      permisos: permisos ?? this.permisos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nombre': nombre,
      'perfil': perfil,
      'creado': creado,
      'permisos': permisos,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      nombre: map['nombre'] ?? '',
      perfil: map['perfil'] ?? '',
      creado: map['creado'] ?? '',
      permisos: List<String>.from(map['permisos'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, nombre: $nombre, perfil: $perfil, creado: $creado, permisos: $permisos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.email == email &&
        other.nombre == nombre &&
        other.perfil == perfil &&
        other.creado == creado;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        nombre.hashCode ^
        perfil.hashCode ^
        creado.hashCode;
  }
}
