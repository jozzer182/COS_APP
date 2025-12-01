
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:translator/translator.dart';

import '../resources/mostrar_mensaje.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  String? errorPassworReset;
  bool isSent = false;

  @override
  void initState() {
    emailController.addListener(emailValido);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar contraseña'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Se enviará un correo para el cambio de la contraseña, solo a usuarios registrados.',
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                const Gap(30),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Correo',
                    border: const OutlineInputBorder(),
                    errorText: errorPassworReset,
                    errorMaxLines: 4,
                  ),
                ),
                const Gap(30),
                ElevatedButton(
                  onPressed: isSent ||
                          emailController.text.isEmpty ||
                          errorPassworReset != null
                      ? null
                      : () async {
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: emailController.text);
                            setState(() {
                              isSent = true;
                            });
                            // ignore: use_build_context_synchronously
                            mostrarMensaje(
                              context: context,
                              mensaje: 'Se envió el correo de recuperación',
                              color: Colors.green,
                            );
                          } catch (e) {
                            GoogleTranslator translator = GoogleTranslator();
                            Translation mensaje = await translator.translate(
                              e.toString(),
                              to: 'es',
                            );
                            setState(() {
                              errorPassworReset = mensaje.text;
                            });
                          }
                        },
                  child: const Text('Enviar correo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void emailValido() {
    String email = emailController.text;
    if (email.isEmpty) {
      setState(() {
        errorPassworReset = 'El correo no puede estar vacío';
      });
    } else if (!email.toLowerCase().contains('@')) {
      setState(() {
        errorPassworReset = 'El correo debe tener un @';
      });
    } else {
      setState(() {
        errorPassworReset = null;
      });
    }
  }
}
