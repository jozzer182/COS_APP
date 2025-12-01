import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import '../../bloc/main_bloc.dart';

class CambiarColorApp extends StatelessWidget {
  const CambiarColorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Escoge un color'),
      content: SingleChildScrollView(
        child: MaterialColorPicker(
          allowShades: false,
          onMainColorChange: (value) {
            if (value != null) {
              BlocProvider.of<MainBloc>(
                context,
              ).add(ThemeColorChange(color: Color(value.value)));
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}
