import 'dart:convert';

import 'package:cos/procesado_lcls/model/procesado_lcls_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';
import '../../resources/future_group_add.dart';
import '../model/procesado_lcls_reg.dart';

class ProcesadoLclsListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;
  ProcesadoLclsList procesadoLclsList = ProcesadoLclsList();

  ProcesadoLclsListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get obtener async {
    // LclPosList lclPosList = LclPosList();
    List<String> contratos = state().cargaContratos!.list;

    // Divide la lista de contratos en batches de 20
    const int batchSize = 20;
    for (int i = 0; i < contratos.length; i += batchSize) {
      // Obtén un batch de contratos
      List<String> batch = contratos.sublist(
        i,
        i + batchSize > contratos.length ? contratos.length : i + batchSize,
      );

      // Procesa el batch actual
      FutureGroupDelayed futureG = FutureGroupDelayed();
      for (String contrato in batch) {
        futureG.addF(_llamada(contrato));
      }
      futureG.close();
      await futureG.future;
    }
    emit(state().copyWith(procesadoLclsList: procesadoLclsList));
    print("procesadoLclsList: ${procesadoLclsList.list.length}");
  }

  _llamada(String contrato) async {
    try {
      String url = EnvConfig.supabasePrincipalUrl;
      String key = EnvConfig.supabasePrincipalKey;

      var dataAsListMap = [];

      // Intentar obtener datos de Supabase
      try {
        final supabaseClient = SupabaseClient(url, key);
        final tableName = 'lcls_2_${contrato.toLowerCase()}';

        // Definir el tamaño de lote para cada consulta
        const int batchSize = 100000;
        int offset = 0;
        bool hasMoreData = true;
        int batchNumber = 1;

        // Cargar los datos en lotes hasta que no haya más o se produzca un error
        while (hasMoreData) {
          try {
            print(
              'Cargando lote $batchNumber (offset: $offset, limit: $batchSize)',
            );

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
              List<Map<String, dynamic>> batchData =
                  List<Map<String, dynamic>>.from(batchResponse);
              dataAsListMap.addAll(batchData);
              print(
                'Lote $batchNumber cargado: ${batchData.length} registros (total acumulado: ${dataAsListMap.length})',
              );

              // Si se recibieron menos registros que el tamaño del lote, ya no hay más datos
              if (batchData.length < batchSize) {
                hasMoreData = false;
                print(
                  'Último lote cargado con ${batchData.length} registros (menos que el tamaño de lote $batchSize)',
                );
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

        print(
          'Total de datos obtenidos desde Supabase: ${dataAsListMap.length} registros',
        );

        // Si no obtuvimos datos de Supabase, intentar con Google Script
        if (dataAsListMap.isEmpty) {
          bl.mensaje(
            message:
                'No se encontraron datos en BD_1 para los LCLS del contrato $contrato, intentando cargar desde otra BD...',
            messageColor: Colors.orange,
          );
          dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
        }
      } catch (e) {
        print('Error al cargar desde Supabase: $e');
        // Si hay error en Supabase, intentar con Google Script
        dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
      }

      if (dataAsListMap.isNotEmpty) {
        procesadoLclsList.list.addAll(
          dataAsListMap
              .map((e) => ProcesadoLclsReg.fromMap(e)..contrato = contrato)
              .toList(),
        );
      }
    } catch (e) {
      bl.errorCarga("LCL_2_$contrato", e);
    }
  }

  // Método auxiliar para obtener datos desde Google Script
  Future<dynamic> _obtenerDesdeGoogleScript(String contrato) async {
    print('Obteniendo datos desde Google Script para el contrato $contrato');
    Map<String, Object> dataSend = {
      'info': {'libro': 'LCLS_2_$contrato', 'hoja': contrato},
      'fname': "getHoja",
    };

    final Response response = await post(
      Uri.parse(EnvConfig.googleScriptDataUrl),
      body: jsonEncode(dataSend),
    );

    // print("jsonDecode(response.body) del contrato $contrato: ${jsonDecode(response.body)}");
    // print("type: ${jsonDecode(response.body).runtimeType}");
    return jsonDecode(response.body);
  }
}
