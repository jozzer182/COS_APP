import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';
import '../model/posiciones_list.dart';
import '../model/posiciones_reg.dart';

class PosicionesListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  PosicionesListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get obtener async {
    try {
      PosicionesList posicionesList = PosicionesList();
      var dataAsListMap;
      String url = EnvConfig.supabasePrincipalUrl;
      String key = EnvConfig.supabasePrincipalKey;

      final supabase = SupabaseClient(url, key);

      // Primero intentar obtener datos de Supabase
      try {
        // final supabase = Supabase.instance.client;
        final response = await supabase.from('posiciones').select();

        if (response.isNotEmpty) {
          dataAsListMap = response;
          print(
            'Datos de posiciones obtenidos desde Supabase: ${dataAsListMap.length} registros',
          );
        } else {
          bl.mensaje(
            message:
                'No se encontraron datos en Supabase para las posiciones, intentando con Google Script...',
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
        posicionesList.list.addAll(
          dataAsListMap.map((e) => PosicionesReg.fromMap(e)).toList(),
        );
      } else {
        bl.mensaje(
          message: 'No se encontraron posiciones en ninguna fuente de datos',
          messageColor: Colors.red,
        );
      }
      emit(state().copyWith(posicionesList: posicionesList));
      print("posicionesList ${posicionesList.list.length}");
    } catch (e) {
      bl.errorCarga("posicionesList", e);
    }
  }

  // Método auxiliar para obtener datos desde Google Script
  Future<dynamic> _obtenerDesdeGoogleScript() async {
    Map<String, Object> dataSend = {
      'info': {'libro': 'POSICIONES', 'hoja': 'POSICIONES'},
      'fname': "getHoja",
    };

    final Response response = await post(
      Uri.parse(EnvConfig.googleScriptDataUrl),
      body: jsonEncode(dataSend),
    );

    return jsonDecode(response.body);
  }
}
