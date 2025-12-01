
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/main_bloc.dart';

class MensajeFirebase extends StatefulWidget {
  const MensajeFirebase({
    super.key,
  });

  @override
  State<MensajeFirebase> createState() => _MensajeFirebaseState();
}

class _MensajeFirebaseState extends State<MensajeFirebase> {
  final TextEditingController mensajeController = TextEditingController();

  @override
  void initState() {
    mensajeController.text = context.read<MainBloc>().state.mensaje;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        List<String> permisos = state.user!.permisos;
        bool puedeEditar = permisos.contains('editar_mensaje');
        if (puedeEditar) {
          DatabaseReference mensajeStream =
              FirebaseDatabase.instance.ref('mensaje');
          return Row(
            children: [
              const Text(
                'Mensaje: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 400,
                height: 30,
                child: TextField(
                  controller: mensajeController,
                  style: const TextStyle(fontSize: 12),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  
                  onChanged: (String value) {
                    mensajeStream.set(value);
                  },
                ),
              )
            ],
          );
        }
        return RichText(
            text: TextSpan(
          children: [
            const TextSpan(
              text: 'Mensaje: ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
            TextSpan(
              text: state.mensaje,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ));
      },
    );
  }
}
