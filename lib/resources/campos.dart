import 'package:flutter/material.dart';

class AutocompleteField extends StatelessWidget {
  const AutocompleteField({
    super.key,
    required this.params,
  });


  final AutocompleteParams params;

  @override
  Widget build(BuildContext context) {
    final label = params.label;
    final opciones = params.opciones;
    final stringError = params.stringError;
    final controller = params.controller;
    final focusNode = params.focusNode;
    final keyField = params.keyField;
    return Expanded(
      flex: params.flex,
      child: RawAutocomplete<String>(
        textEditingController: controller,
        focusNode: focusNode,
        key: keyField,
        optionsBuilder: (
          TextEditingValue textEditingValue,
        ) {
          return opciones.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        optionsViewBuilder: (
          context,
          onSelected,
          options,
        ) {
          return Material(
            elevation: 4,
            child: ListView(
              children: options
                  .map(
                    (e) => ListTile(
                      title: Text(e),
                      onTap: () {
                        onSelected(e);
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        },
        fieldViewBuilder: (
          context,
          textEditingController,
          focusNode,
          onFieldSubmitted,
        ) {
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
              errorText: stringError,
            ),
          );
        },
      ),
    );
  }
}

class AutocompleteParams{
  final String label;
  final int flex;
  final List<String> opciones;
  final String? stringError;
  final TextEditingController controller;
  final FocusNode focusNode;
  final UniqueKey keyField;

  AutocompleteParams({
    required this.label,
    required this.flex,
    required this.opciones,
    required this.stringError,
    required this.controller,
    required this.focusNode,
    required this.keyField,
  });

}