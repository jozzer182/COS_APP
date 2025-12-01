import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String? errorName;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = context.read<MainBloc>().state.user?.nombre ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Page')),
      body: Center(
        child: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
              if (state.user == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.user!.nombre.isEmpty) {
                errorName = 'El nombre no puede estar vacío';
              } else {
                errorName = null;
              }
              DatabaseReference userStream =
                  FirebaseDatabase.instance.ref('perfiles/${state.user!.uid}');
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<DatabaseEvent>(
                      stream: userStream.onValue,
                      builder: (context, snapshot) {
                        return TextField(
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
                          onChanged: (String value) {
                            userStream.update({'nombre': value});
                          },
                        );
                      }),
                  const Gap(30),
                  TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: state.user?.email),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                      // errorText: errorMail,
                      errorMaxLines: 2,
                    ),
                  ),
                  const Gap(30),
                  TextFormField(
                    enabled: false,
                    controller: TextEditingController(text: state.user?.perfil),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock_person),
                      labelText: 'Perfil',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Gap(30),
                  //permisos
                  

                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
