import 'dart:convert';

import 'package:cos/cupo/model/cupo_list.dart';
import 'package:http/http.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';
import '../model/cupo_reg.dart';

class CupoListController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  CupoListController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get obtener async {
    try {
      CupoList cupoList = CupoList();
      Map<String, Object> dataSend = {
        'info': {
          'libro': 'CUPO',
          'hoja': 'CUPO',
        },
        'fname': "getHoja"
      };
      // print(jsonEncode(dataSend));
      final Response response = await post(
        Uri.parse(EnvConfig.googleScriptDataUrl),
        body: jsonEncode(dataSend),
      );
      var dataAsListMap = jsonDecode(response.body);
      if (dataAsListMap is List && dataAsListMap.isNotEmpty) {
        cupoList.list
            .addAll(dataAsListMap.map((e) => CupoReg.fromMap(e)).toList());
      }
      cupoList.list.sort((a, b) => a.nombre.compareTo(b.nombre));
      emit(state().copyWith(cupoList: cupoList));
      print("Cupo ${cupoList.list.length}");
    } catch (e) {
      bl.errorCarga("cupo", e);
    }
  }
}
