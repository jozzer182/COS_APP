import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/main_bloc.dart';

mostrarMensaje({
  required BuildContext context,
  required String mensaje,
  required Color color,
}) {
  print(mensaje);
  context.read<MainBloc>().mensaje(
        message: mensaje,
        messageColor: color,
      );
}
