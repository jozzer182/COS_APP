// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class FieldDesplegable extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final int? flex;
  final Iterable<String> opciones;
  final Color color;
  // final CampoFicha campo;
  final String label;
  final int item;
  String initialValue;
  final bool tachado;
  final Color colorfondo;
  final bool edit;
  FieldDesplegable({
    required this.flex,
    required this.opciones,
    required this.color,
    // required this.campo,
    required this.label,
    required this.initialValue,
    this.colorfondo = Colors.transparent,
    this.tachado = false,
    this.edit = false,
    this.item = -1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!edit) {
      controller.text = initialValue;
      if (flex == null) {
        return SizedBox(
          height: 40,
          child: readField(),
        );
      }
      return Expanded(
        flex: flex!,
        child: readField(),
      );
    }
    initialValue = initialValue.toLowerCase();
    if (flex == null) {
      return SizedBox(
        height: 40,
        child: _intField(context),
      );
    }
    return Expanded(
      flex: flex!,
      child: _intField(context),
    );
  }

  DropdownButtonFormField<String> _intField(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      isExpanded: true,
      onChanged: (value) {
        // context.read<MainBloc>().fichasController().onCambiarFicha(
        //       item: item,
        //       campo: campo,
        //       valor: value.toString(),
        //     );
      },
      items: opciones
          .toSet()
          .map((e) => DropdownMenuItem(
              value: e.toLowerCase(), child: Text(e.toLowerCase())))
          .toList(),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  TextField readField() {
    return TextField(
        textAlign: TextAlign.center,
        controller: controller,
        onChanged: (value) {
          controller.text = initialValue;
        },
        decoration: InputDecoration(
          
          filled: true,
          fillColor: colorfondo,
          contentPadding: const EdgeInsets.all(8.0),
          labelText: label,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: 12,
          decoration: tachado ? TextDecoration.lineThrough : null,
        ));
  }
}
