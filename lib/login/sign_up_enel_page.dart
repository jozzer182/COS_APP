// ignore_for_file: use_build_context_synchronously

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:translator/translator.dart';

import '../resources/mostrar_mensaje.dart';

class SignUpEnelPage extends StatefulWidget {
  const SignUpEnelPage({super.key});

  @override
  State<SignUpEnelPage> createState() => _SignUpEnelPageState();
}

class _SignUpEnelPageState extends State<SignUpEnelPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? selectedItemPerfil = 'funcional';
  String? errorName;
  String? errorMail;
  String? errorPassword;

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
    bool esEnel = email.toLowerCase().contains('@enel.com');
    bool esOca = email.toLowerCase().contains('@ocaglobal.com');
    if (email.isEmpty) {
      setState(() {
        errorMail = 'El correo no puede estar vacío';
      });
    } else if (!esEnel && !esOca) {
      setState(() {
        errorMail = 'El correo debe ser corporativo (@enel.com)';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty;
    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: Center(
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Favor indique su correo corporativo "@enel.com" y una contraseña para acceder al aplicativo, no se sincronizará con la contraseña de red.',
                  maxLines: 5,
                  textAlign: TextAlign.center,
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
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_person),
                    labelText: 'Perfil',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'funcional',
                      child: Text('ÚNICO'),
                    ),
                    // DropdownMenuItem(
                    //   value: 'pm',
                    //   child: Text('PM'),
                    // ),
                    // DropdownMenuItem(
                    //   value: 'normas',
                    //   child: Text('NORMAS'),
                    // ),
                  ],
                  value: selectedItemPerfil,
                  onChanged: (String? value) {
                    setState(() {
                      selectedItemPerfil = value;
                    });
                  },
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
            ),
          ),
        ),
      ),
    );
  }

  logicaRegistro() async {
    bool noHayErrores =
        errorName == null && errorMail == null && errorPassword == null;
    if (noHayErrores) {
      UserCredential? userCredential = await registrarUsuario();
      bool registroExitoso = userCredential != null;
      if (registroExitoso) {
        String? uid = userCredential.user?.uid;
        bool uidNoEsNulo = uid != null;
        if (uidNoEsNulo) {
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
                'perfil': selectedItemPerfil??'funcional',
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
        }
      }
      // Navigator.pop(context);
    } else {
      mostrarMensaje(
        context: context,
        mensaje: 'Favor corregir los errores antes de continuar.',
        color: Colors.red,
      );
    }
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
