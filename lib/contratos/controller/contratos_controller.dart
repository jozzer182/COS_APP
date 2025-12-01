import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';
import '../model/contratos_list.dart';
import '../model/contratos_reg.dart';

class ContratosListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  ContratosListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get obtener async {
    try {
      ContratosList contratosList = ContratosList();
      var dataAsListMap;

      String url = EnvConfig.supabasePrincipalUrl;
      String key = EnvConfig.supabasePrincipalKey;

      final supabase = SupabaseClient(url, key);

      // Primero intentar obtener datos de Supabase
      try {
        // final supabase = Supabase.instance.client;
        final response = await supabase.from('contratos').select();

        if (response.isNotEmpty) {
          dataAsListMap = response;
          print(
            'Datos de contratos obtenidos desde Supabase: ${dataAsListMap.length} registros',
          );
        } else {
          bl.mensaje(
            message:
                'No se encontraron datos en Supabase para los contratos, intentando con Google Script...',
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
        contratosList.list.addAll(
          dataAsListMap.map((e) => ContratosReg.fromMap(e)).toList(),
        );
      } else {
        bl.mensaje(
          message: 'No se encontraron contratos en ninguna fuente de datos',
          messageColor: Colors.red,
        );
      }
      emit(state().copyWith(contratosList: contratosList));
      print("Contratos ${contratosList.list.length}");
    } catch (e) {
      bl.errorCarga("Contratos", e);
    }
  }

  // Método auxiliar para obtener datos desde Google Script
  Future<dynamic> _obtenerDesdeGoogleScript() async {
    Map<String, Object> dataSend = {
      'info': {'libro': 'CONTRATOS', 'hoja': 'CONTRATOS'},
      'fname': "getHoja",
    };

    final Response response = await post(
      Uri.parse(EnvConfig.googleScriptDataUrl),
      body: jsonEncode(dataSend),
    );

    return jsonDecode(response.body);
  }
}
