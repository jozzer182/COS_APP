// ignore_for_file: use_build_context_synchronously

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:translator/translator.dart';

import '../resources/mostrar_mensaje.dart';

class SignUpContPage extends StatefulWidget {
  const SignUpContPage({super.key});

  @override
  State<SignUpContPage> createState() => _SignUpContPageState();
}

class _SignUpContPageState extends State<SignUpContPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController perfilController = TextEditingController();
  DatabaseReference dominiosStream = FirebaseDatabase.instance.ref('dominios');
  String? selectedItemPerfil = 'funcional';
  String? errorName;
  String? errorMail;
  String? errorPassword;
  List<String> dominios = [];

  void nombreValido() {
    if (nameController.text.isEmpty) {
      setState(() {
        errorName = 'El nombre no puede estar vacío';
      });
    } else {
      setState(() {
        errorName = null;
      });
    }
  }

  void emailValido() {
    String email = emailController.text;
    bool esDominioPermitido = dominios.contains(
      "@${emailController.text.split('@').last.toLowerCase()}",
    );
    if (email.isEmpty) {
      setState(() {
        errorMail = 'El correo no puede estar vacío';
      });
    } else if (!email.toLowerCase().contains('@')) {
      setState(() {
        errorMail = 'El correo debe contener un @';
      });
    } else if (!esDominioPermitido) {
      setState(() {
        errorMail = 'Dominio no permitido.';
      });
    } else {
      setState(() {
        errorMail = null;
      });
    }
  }

  void passwordValido() {
    String password = passwordController.text;
    if (password.isEmpty) {
      setState(() {
        errorPassword = 'La contraseña no puede estar vacía';
      });
    } else if (password.length < 6) {
      setState(() {
        errorPassword = 'La contraseña debe tener al menos 6 caracteres';
      });
    } else {
      setState(() {
        errorPassword = null;
      });
    }
  }

  @override
  void initState() {
    nameController.addListener(nombreValido);
    emailController.addListener(emailValido);
    passwordController.addListener(passwordValido);
    perfilController.text = 'contratista';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de contratistas'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: StreamBuilder<DatabaseEvent>(
                stream: dominiosStream.onValue,
                builder: (context, dominiosSnapshot) {
                  if (dominiosSnapshot.hasError) {
                    return const Text('Error cargando los dominios.');
                  }
                  if (!dominiosSnapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var dominiosRaw = dominiosSnapshot.data!.snapshot.value;
                  if (dominiosRaw is! List) {
                    return const Text('No hay dominios.');
                  }
                  dominios = dominiosRaw.map((e) => e.toString()).toList();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Favor indique su correo corporativo y una contraseña para acceder al aplicativo.',
                        maxLines: 5,
                        textAlign: TextAlign.center,
                      ),
                      const Gap(5),
                      Text(
                        'Dominios Permitidos: ${dominios.toSet().join(', ').toLowerCase()}',
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      const Gap(30),
                      TextField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          labelText: 'Nombre - Apellido',
                          border: const OutlineInputBorder(),
                          errorMaxLines: 2,
                          errorText: errorName,
                          hintText: 'Ej: Juan Perez',
                        ),
                      ),
                      const Gap(30),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          labelText: 'Correo',
                          border: const OutlineInputBorder(),
                          errorText: errorMail,
                          errorMaxLines: 2,
                        ),
                      ),
                      const Gap(30),
                      TextField(
                        enabled: false,
                        controller: perfilController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_person),
                          labelText: 'Perfil',
                          border: const OutlineInputBorder(),
                          errorText: errorMail,
                          errorMaxLines: 2,
                        ),
                      ),
                      const Gap(30),
                      TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Contraseña',
                          border: const OutlineInputBorder(),
                          errorText: errorPassword,
                        ),
                      ),
                      const Gap(30),
                      ElevatedButton(
                        onPressed: isEmpty ? null : () => logicaRegistro(),
                        child: const Text('Registrarse'),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  logicaRegistro() async {
    bool hayErrores =
        errorName != null || errorMail != null || errorPassword != null;
    if (hayErrores) {
      mostrarMensaje(
        context: context,
        mensaje: 'Favor corregir los errores antes de continuar.',
        color: Colors.red,
      );
      return;
    }

    UserCredential? userCredential = await registrarUsuario();
    bool registroFallido = userCredential == null;
    if (registroFallido) {
      mostrarMensaje(
        context: context,
        mensaje: 'Error al registrar el usuario (userCredential nulo).',
        color: Colors.red,
      );
      return;
    }

    String? uid = userCredential.user?.uid;
    bool uidEsNulo = uid == null;
    if (uidEsNulo) {
      mostrarMensaje(
        context: context,
        mensaje: 'Error al registrar el usuario (UID nulo).',
        color: Colors.red,
      );
      return;
    }

    await userCredential.user?.updateDisplayName(nameController.text);
    await userCredential.user?.updatePhotoURL(selectedItemPerfil);
    try {
      await FirebaseDatabase.instance.ref("perfiles/$uid").set({
        "perfil": selectedItemPerfil,
        "nombre": nameController.text,
        "correo": emailController.text,
      });
      await FirebaseAnalytics.instance.logSignUp(
        signUpMethod: "Email_ENEL",
        parameters: {
          'perfil': selectedItemPerfil??'',
          'nombre': nameController.text,
          'correo': emailController.text,
        },
      );
      Navigator.pop(context);
      mostrarMensaje(
        context: context,
        mensaje: 'Por favor revise su correo para verificar su cuenta.',
        color: Colors.green,
      );
    } catch (e) {
      GoogleTranslator translator = GoogleTranslator();
      Translation mensaje = await translator.translate(
        e.toString(),
        to: 'es',
      );
      mostrarMensaje(
        context: context,
        mensaje: mensaje.text,
        color: Colors.red,
      );
    }

    // Navigator.pop(context);
  }

  Future<UserCredential?> registrarUsuario() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      GoogleTranslator translator = GoogleTranslator();
      Translation mensaje = await translator.translate(
        e.message.toString(),
        to: 'es',
      );
      mostrarMensaje(
        context: context,
        mensaje: mensaje.text,
        color: Colors.red,
      );
      return null;
    }
  }
}
