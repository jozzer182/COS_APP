// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:translator/translator.dart';
import '../bloc/main_bloc.dart';
import '../resources/mostrar_mensaje.dart';
import '../resources/transicion_pagina.dart';
import 'forgot_password_page.dart';
import 'sign_up_enel_page.dart';

class LoginPage extends StatefulWidget {
  final AsyncSnapshot<User?> snapshot;

  const LoginPage({
    required this.snapshot,
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool wasCliked = false;
  bool isReadyForLogin = false;
  bool isReadyForRevcovery = false;
  GoogleTranslator translator = GoogleTranslator();

  SliverGridDelegateWithMaxCrossAxisExtent gridDelegate =
      const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 150,
    childAspectRatio: 4,
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
  );

  @override
  void initState() {
    emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void goTo(Widget page) {
      Navigator.push(context, createRoute(page));
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double widthFields = screenWidth > 400 ? 400 : screenWidth;
    TextStyle? headlineMedium = Theme.of(context).textTheme.headlineMedium;
    TextStyle? titleMedium = Theme.of(context).textTheme.titleMedium;
    isReadyForLogin = !widget.snapshot.hasData &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
    isReadyForRevcovery = emailController.text.isNotEmpty &&
        emailController.text.toLowerCase().contains('@enel.com');
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(colors: [
                  const Color.fromARGB(255, 245, 66, 221),
                  Colors.blue.shade900,
                  const Color.fromARGB(255, 100, 0, 131),
                ]).createShader(bounds
                    // Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                    ),
                child: Column(
                  children: [
                    Image.asset(
                      'images/customer_outline.png',
                      height: 150,
                    ),
                    // Text('SAM', style: const TextStyle(fontSize: 40)),
                  ],
                ),
              ),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(colors: [
                  const Color.fromARGB(255, 245, 66, 221),
                  Colors.blue.shade900,
                  const Color.fromARGB(255, 100, 0, 131),
                ]).createShader(bounds
                    // Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                    ),
                child: const Column(
                  children: [
                    Text('COS+', style: TextStyle(fontSize: 40)),
                  ],
                ),
              ),
              Text('Bienvenido', style: headlineMedium),
              const Gap(8),
              Text(
                'Por favor, inicia sesión para continuar',
                style: titleMedium,
              ),
              Text(
                'Si es la primera vez que ingresa, por favor registrese',
                style: titleMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              SizedBox(
                width: widthFields,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Gap(8),
              SizedBox(
                width: widthFields,
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const Gap(8),
              SizedBox(
                width: widthFields,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: !isReadyForLogin
                          ? null
                          : () async {
                              try {
                                await signIn();
                                context.read<MainBloc>().add(Load());
                              } on FirebaseAuthException catch (e) {
                                String errorString = e.message ?? '';
                                RegExp regExp = RegExp(r'\(auth\/(.*?)\)');
                                String? code =
                                    regExp.firstMatch(errorString)?.group(1);
                                print(code);
                                Translation mensaje =
                                    await translator.translate(
                                  e.message.toString(),
                                  to: 'es',
                                );
                                mostrarMensaje(
                                  context: context,
                                  mensaje: mensaje.text.replaceAll(
                                    'Se produjo un error desconocido: FirebaseError: Firebase:',
                                    '',
                                  ),
                                  color: Colors.grey,
                                );
                              }
                            },
                      child: const Text('Iniciar sesión'),
                    ),
                    ElevatedButton(
                      onPressed: !widget.snapshot.hasData
                          ? null
                          : () async {
                              try {
                                if (!wasCliked) {
                                  await FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification();
                                  mostrarMensaje(
                                    context: context,
                                    mensaje: 'Se ha enviado un correo de verificación, ' +
                                        'por favor revise su bandeja de entrada, ' +
                                        'de click en el enlace y vuelva a iniciar sesión.',
                                    color: Colors.green,
                                  );
                                } else {
                                  mostrarMensaje(
                                    context: context,
                                    mensaje: 'Revise su bandeja de entrada, ' +
                                        'de click en el enlace y vuelva a intentarlo, ' +
                                        'el mensaje puede estar en Spam',
                                    color: Colors.orange,
                                  );
                                }
                                setState(() {
                                  wasCliked = true;
                                });
                              } catch (e) {
                                print(e);
                              }
                              try {
                                await FirebaseAuth.instance.currentUser
                                    ?.reload();
                                await FirebaseAuth.instance.signOut();
                              } catch (es) {
                                print(es);
                              }
                            },
                      child: const Text('Validar Email'),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              TextButton(
                onPressed: () {
                  goTo(const SignUpEnelPage());
                },
                child: const Text("Registrarse ENEL"),
              ),
              // TextButton(
              //   onPressed: () {
              //     goTo(const SignUpContPage());
              //   },
              //   child: const Text("Registrarse Contrato"),
              // ),
              TextButton(
                child: const Text('Olvidé la contraseña'),
                onPressed: () => goTo(const ForgotPasswordPage()),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: const Text('Borrar Credenciales/Caché'),
              ),
              // TextButton(
              //   onPressed: () {
              //     launchUrl(
              //       Uri.parse(
              //         'https://enelcom.sharepoint.com/sites/ProjectManagementConstructionColombia/cm/SitePages/FEM.aspx',
              //       ),
              //     );
              //   },
              //   child: const Text('Más información'),
              // ),
              // TextButton(
              //   onPressed: () {
              //     print(context.read<MainBloc>().hello());
              //   },
              //   child: const Text('Prueba de Bloc'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registrarUsuario() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  Future<void> signIn() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
