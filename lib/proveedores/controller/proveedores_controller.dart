import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';
import '../model/proveedores_list.dart';
import '../model/proveedores_reg.dart';

class ProveedoresListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  ProveedoresListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get obtener async {
    try {
      ProveedoresList proveedoresList = ProveedoresList();
      var dataAsListMap;
      String url = EnvConfig.supabasePrincipalUrl;
      String key = EnvConfig.supabasePrincipalKey;

      final supabase = SupabaseClient(url, key);

      // Primero intentar obtener datos de Supabase
      try {
        // final supabase = Supabase.instance.client;
        final response = await supabase.from('proveedores').select();

        if (response.isNotEmpty) {
          dataAsListMap = response;
          print(
            'Datos de proveedores obtenidos desde Supabase: ${dataAsListMap.length} registros',
          );
        } else {
          bl.mensaje(
            message:
                'No se encontraron datos en Supabase para los proveedores, intentando con Google Script...',
            messageColor: Colors.yellow,
          );
          // Si no hay datos en Supabase, intentar con Google Script
          dataAsListMap = await _obtenerDesdeGoogleScript();
        }
      } catch (e) {
        bl.mensaje(
          message:
              'Error llamando a Supabase: $e, intentando con Google Script...',
          messageColor: Colors.orange,
        );
        // Si hay error en Supabase, intentar con Google Script
        dataAsListMap = await _obtenerDesdeGoogleScript();
      }

      if (dataAsListMap is List && dataAsListMap.isNotEmpty) {
        proveedoresList.list.addAll(
          dataAsListMap.map((e) => ProveedoresReg.fromMap(e)).toList(),
        );
      } else {
        bl.mensaje(
          message: 'No se encontraron proveedores en ninguna fuente de datos',
          messageColor: Colors.red,
        );
      }
      emit(state().copyWith(proveedoresList: proveedoresList));
      print("Proveedores ${proveedoresList.list.length}");
    } catch (e) {
      bl.errorCarga("Proveedores", e);
    }
  }

  // Método auxiliar para obtener datos desde Google Script
  Future<dynamic> _obtenerDesdeGoogleScript() async {
    Map<String, Object> dataSend = {
      'info': {'libro': 'PROVEEDORES', 'hoja': 'PROVEEDORES'},
      'fname': "getHoja",
    };

    final Response response = await post(
      Uri.parse(EnvConfig.googleScriptDataUrl),
      body: jsonEncode(dataSend),
    );

    return jsonDecode(response.body);
  }
}
