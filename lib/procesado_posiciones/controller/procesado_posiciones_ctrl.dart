import 'dart:convert';

import 'package:cos/procesado_posiciones/model/procesado_posiciones_list.dart';
import 'package:cos/procesado_posiciones/model/procesado_posiciones_reg.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';

class ProcesadoPosListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  ProcesadoPosListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  obtener(String contrato, String lcl) async {
    String url = EnvConfig.supabaseProcesadoUrl;
    String key = EnvConfig.supabaseProcesadoKey;
    if (state().procesadoPosicionesList != null &&
        state().procesadoPosicionesList!.contrato == contrato &&
        state().procesadoPosicionesList!.lcl == lcl) {
      return;
    }
    bl.startLoading;
    ProcesadoPosicionesList procesadoPosicionesList = ProcesadoPosicionesList();
    procesadoPosicionesList.contrato = contrato;
    procesadoPosicionesList.lcl = lcl;
    try {
      var dataAsListMap;

      // Primero intentar obtener datos de Supabase con el cliente específico para este módulo
      try {
        // Crear un cliente específico con la URL y clave de este módulo
        final supabaseClient = SupabaseClient(url, key);

        final response = await supabaseClient
            .from('lcls_pos_${contrato.toLowerCase()}')
            .select()
            .eq('lcl', lcl)
            .range(0, 500);

        if (response.isNotEmpty) {
          dataAsListMap = response;
          print(
              'Datos de posiciones obtenidos desde Supabase específico: ${dataAsListMap.length} registros');
        } else {
          print('response.toString(): ${response.toString()}');
          bl.mensaje(
              message:
                  'No se encontraron datos en Supabase para las posiciones del contrato $contrato',
              messageColor: Colors.yellow);
          // Si no hay datos en Supabase, intentar con Google Script
          dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
        }
      } catch (e) {
        bl.errorCarga(
          'Error llamando a Supabase para posiciones del contrato $contrato: ${e.toString()}, intentando con Llamar nuevamente a Supabase...',
          e,
        );
        await Future.delayed(const Duration(seconds: 2));
        try {
          // Crear un cliente específico con la URL y clave de este módulo
          final supabaseClient = SupabaseClient(url, key);

          final response = await supabaseClient
              .from('lcls_pos_${contrato.toLowerCase()}')
              .select()
              .eq('lcl', lcl)
              .range(0, 500);

          if (response.isNotEmpty) {
            dataAsListMap = response;
            print(
                'Datos de posiciones obtenidos desde Supabase específico: ${dataAsListMap.length} registros');
          } else {
            print('response.toString(): ${response.toString()}');
            bl.mensaje(
                message:
                    'No se encontraron datos en Supabase para las posiciones del contrato $contrato',
                messageColor: Colors.yellow);
            // Si no hay datos en Supabase, intentar con Google Script
            dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
          }
        } catch (e) {
          bl.errorCarga(
            'Error llamando a Supabase para posiciones del contrato $contrato: ${e.toString()}, intentando con Google Script...',
            e,
          );
          await Future.delayed(Duration(seconds: 2));

          // Si hay error en Supabase, intentar con Google Script
          dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
        }

        // Si hay error en Supabase, intentar con Google Script
        // dataAsListMap = await _obtenerDesdeGoogleScript(contrato);
      }

      if (dataAsListMap is List && dataAsListMap.isNotEmpty) {
        // Eliminar registros duplicados antes de procesarlos
        // La combinación de 'lcl' y 'pos' debería identificar un registro único
        final uniqueRecords = <String, dynamic>{};
        final duplicateCount = dataAsListMap.length;

        for (var record in dataAsListMap) {
          // Crear una clave única usando lcl y pos
          final String uniqueKey = '${record['lcl']}_${record['pos']}';
          // Solo conservar el primer registro con esa clave única
          if (!uniqueRecords.containsKey(uniqueKey)) {
            uniqueRecords[uniqueKey] = record;
          }
        }

        // Convertir el mapa de registros únicos de nuevo a una lista
        dataAsListMap = uniqueRecords.values.toList();

        final removedCount = duplicateCount - dataAsListMap.length;
        if (removedCount > 0) {
          print('Se eliminaron $removedCount registros duplicados');
        }

        procesadoPosicionesList.list.addAll(dataAsListMap
            .map((e) => ProcesadoPosicionesReg.fromMap(e))
            .toList());
        procesadoPosicionesList.cargaCorrecta = true;
      } else {
        bl.mensaje(
            message:
                'El contrato $contrato no tiene POSICIONES en ninguna fuente de datos',
            messageColor: Colors.orange);
      }
      print("LCLS_POS_2: ${procesadoPosicionesList.list.length}");
    } catch (e) {
      if (e.runtimeType == ClientException) {
        bl.mensaje(
            message: 'El contrato $contrato, no tiene POSICIONES en COS',
            messageColor: Colors.orange);
      } else {
        bl.errorCarga("LCL_POS_2_$contrato", e);
      }
    }
    emit(state().copyWith(procesadoPosicionesList: procesadoPosicionesList));
    bl.stopLoading;
  }

  // Método auxiliar para obtener datos desde Google Script
  Future<dynamic> _obtenerDesdeGoogleScript(String contrato) async {
    Map<String, Object> dataSend = {
      'info': {
        'libro': 'LCLS_POS_2_$contrato',
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

  // NO SE PUEDE CONECTAR UN BD DE POSTGRE DESDE FLUTTER WEB :(
  // Future<bool> posicionesQuery(String lcl, String contrato) async {
  //   ProcesadoPosicionesList procesadoPosicionesList = ProcesadoPosicionesList();
  //   final connection = PostgreSQLConnection(
  //     "10.152.166.117", // Host
  //     5432, // Puerto por defecto de PostgreSQL
  //     "spotfire_uoat", // Nombre de la base de datos
  //     username: "SpotfireUOAT", // Usuario
  //     password: "whisw)04", // Contraseña
  //   );

  //   try {
  //     // Conectar a la base de datos
  //     await connection.open();

  //     // Nombre de la tabla dinámica
  //     final tableName = 'cos_lcl_pos_$contrato';

  //     // Consulta SQL
  //     final query = 'SELECT * FROM $tableName WHERE lcl = @lcl';

  //     // Ejecutar la consulta
  //     final results = await connection.mappedResultsQuery(
  //       query,
  //       substitutionValues: {'lcl': lcl},
  //     );

  //     // Cerrar la conexión
  //     await connection.close();

  //     // Retornar los resultados
  //     final dataAsListMap = results.map((row) => row[tableName]!).toList();

  //     if (dataAsListMap is List && dataAsListMap.isNotEmpty) {
  //       procesadoPosicionesList.list.addAll(dataAsListMap
  //           .map((e) => ProcesadoPosicionesReg.fromMap(e))
  //           .toList());
  //     }
  //     emit(state().copyWith(procesadoPosicionesList: procesadoPosicionesList));
  //     return true;
  //   } catch (e) {
  //     // Manejo de errores
  //     print('Error al consultar la base de datos: $e');
  //     await connection.close();
  //     return false;
  //     // rethrow;
  //   }
  // }
}
