import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';
import '../model/lcl_conf_list.dart';
import '../model/lcl_conf_reg.dart';

class ConformidadesListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  ConformidadesList initLclConfList = ConformidadesList();

  ConformidadesListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }


  llamada(String contrato) async {
    if (state().lclConfList != null &&
        state().lclConfList!.contrato == contrato) {
      return;
    }
    String url = EnvConfig.supabasePrincipalUrl;
    String key = EnvConfig.supabasePrincipalKey;

    bl.startLoading;
    initLclConfList.contrato = contrato;
    try {
      var dataAsListMap = <Map<String, dynamic>>[];

      // Intentar obtener datos de Supabase
      try {
        final supabaseClient = SupabaseClient(url, key);
        final tableName = 'conf_${contrato.toLowerCase()}';
        
        // Definir el tamaño de lote para cada consulta
        const int batchSize = 100000;
        int offset = 0;
        bool hasMoreData = true;
        int batchNumber = 1;
        
        // Cargar los datos en lotes hasta que no haya más o se produzca un error
        while (hasMoreData) {
          try {
            print('Cargando lote $batchNumber (offset: $offset, limit: $batchSize)');
            
            final batchResponse = await supabaseClient
                .from(tableName)
                .select()
                .range(offset, offset + batchSize - 1);
            
            // Si la respuesta está vacía, significa que ya no hay más datos
            if (batchResponse.isEmpty) {
              hasMoreData = false;
              print('No hay más datos disponibles después del offset $offset');
            } else {
              // Agregar los datos del lote actual al resultado final
              List<Map<String, dynamic>> batchData = List<Map<String, dynamic>>.from(batchResponse);
              dataAsListMap.addAll(batchData);
              print('Lote $batchNumber cargado: ${batchData.length} registros (total acumulado: ${dataAsListMap.length})');
              
              // Si se recibieron menos registros que el tamaño del lote, ya no hay más datos
              if (batchData.length < batchSize) {
                hasMoreData = false;
                print('Último lote cargado con ${batchData.length} registros (menos que el tamaño de lote $batchSize)');
              } else {
                // Preparar para el siguiente lote
                offset += batchSize;
                batchNumber++;
              }
            }
          } catch (e) {
            // Si ocurre un error en este lote, terminamos la carga y usamos lo que tenemos
            print('Error al cargar el lote $batchNumber: $e');
            hasMoreData = false;
            
            // Solo registramos el error si es el primer lote y no tenemos datos
            if (batchNumber == 1 && dataAsListMap.isEmpty) {
              throw e; // Re-lanzar el error para que sea manejado por el catch exterior
            }
          }
        }
        
        print('Total de datos obtenidos desde Supabase: ${dataAsListMap.length} registros');
        
        // Si no obtuvimos datos de Supabase, intentar con Google Script
        if (dataAsListMap.isEmpty) {
          bl.mensaje(
              message:
                  'No se encontraron datos en Supabase para las conformidades del contrato $contrato',
              messageColor: Colors.yellow);
          dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
        }
      } catch (e) {
        bl.errorCarga("CONFORMIDADES_$contrato", e);
        // Si hay error en Supabase, intentar con Google Script
        dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
      }

      if (dataAsListMap.isNotEmpty) {
        initLclConfList.list.addAll(
          dataAsListMap
              .map((e) => ConformidadesReg.fromMap(e)..contrato = contrato)
              .toList(),
        );
        initLclConfList.cargaCorrecta = true;
      } else {
        bl.mensaje(
            message:
                'El contrato $contrato no tiene CONFORMIDADES en ninguna fuente de datos',
            messageColor: Colors.orange);
      }
      print("LCLS_Conf: ${initLclConfList.list.length}");
    } catch (e) {
      if (e.runtimeType == ClientException) {
        bl.mensaje(
            message: 'El contrato $contrato, no tiene CONFORMIDADES en COS',
            messageColor: Colors.orange);
      } else {
        bl.errorCarga("CONFORMIDADES_$contrato", e);
      }
    }
    emit(state().copyWith(lclConfList: initLclConfList));
    bl.stopLoading;
  }

  // Método auxiliar para obtener datos desde Google Script
  Future<dynamic> _obtenerDesdeGoogleScript(String contrato) async {
    Map<String, Object> dataSend = {
      'info': {
        'libro': 'CONFORMIDADES_$contrato',
        'hoja': contrato,
      },
      'fname': "getHoja"
    };

    final Response response = await post(
      Uri.parse(EnvConfig.googleScriptDataUrl),
      body: jsonEncode(dataSend),
    );

    return jsonDecode(response.body);
  }
}
