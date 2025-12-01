import 'dart:convert';

import 'package:cos/facturas/model/facturas_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';
import '../model/facturas_reg.dart';

class FacturasListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  FacturasListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  obtener(String contrato) async {
    FacturasList facturasList = FacturasList();
    try {
      var dataAsListMap;
      String url = EnvConfig.supabasePrincipalUrl;
      String key = EnvConfig.supabasePrincipalKey;

      final supabase = SupabaseClient(url, key);

      // Primero intentar obtener datos de Supabase
      try {
        // final supabase = Supabase.instance.client;
        final response =
            await supabase.from('facturas_${contrato.toLowerCase()}').select();

        if (response.isNotEmpty) {
          dataAsListMap = response;
          print(
            'Datos de facturas obtenidos desde Supabase: ${dataAsListMap.length} registros',
          );
        } else {
          emit(
            state().copyWith(
              message:
                  'No se encontraron datos en Supabase para las facturas, intentando con Google Script...',
              messageColor: Colors.yellow,
            ),
          );
          // Si no hay datos en Supabase, intentar con Google Script
          dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
        }
      } catch (e) {
        emit(
          state().copyWith(
            message:
                'Error llamando a Supabase: $e, intentando con Google Script...',
            messageColor: Colors.orange,
          ),
        );
        // Si hay error en Supabase, intentar con Google Script
        dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
      }

      if (dataAsListMap is List && dataAsListMap.isNotEmpty) {
        facturasList.list.addAll(
          dataAsListMap
              .map((e) => FacturasReg.fromMap(e)..contrato = contrato)
              .toList(),
        );
        facturasList.cargaCorrecta = true;
      } else {
        bl.mensaje(
          message:
              'No se encontraron facturas para el contrato $contrato en ninguna fuente de datos',
          messageColor: Colors.red,
        );
      }
    } catch (e) {
      if (e.runtimeType == ClientException) {
        bl.mensaje(
          message: 'No se han podido cargar las facturas del contrato',
          messageColor: Colors.yellow,
        );
      } else {
        bl.errorCarga("Facturas_$contrato", e);
      }
    }

    emit(state().copyWith(facturasList: facturasList));
    print("FacturasListController: ${facturasList.list.length}");
  }

  // Método auxiliar para obtener datos desde Google Script
  Future<dynamic> _obtenerDesdeGoogleScript(String contrato) async {
    Map<String, Object> dataSend = {
      'info': {'libro': 'FACTURAS_$contrato', 'hoja': contrato},
      'fname': "getHoja",
    };

    final Response response = await post(
      Uri.parse(EnvConfig.googleScriptDataUrl),
      body: jsonEncode(dataSend),
    );

    return jsonDecode(response.body);
  }
}
