import 'dart:convert';

import 'package:cos/gac/model/gac_list.dart';
import 'package:http/http.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';
import '../model/gac_reg.dart';

class GacLisrController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  GacLisrController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get obtener async {
    try {
      GacList gacList = GacList();
      Map<String, Object> dataSend = {
        'info': {
          'libro': 'GAC',
          'hoja': 'GAC',
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
        gacList.list
            .addAll(dataAsListMap.map((e) => GacReg.fromMap(e)).toList());
      }
      // gacList.list.sort((a, b) => a.nombre.compareTo(b.nombre));
      emit(state().copyWith(gacList: gacList));
      print("GAC ${gacList.list.length}");
    } catch (e) {
      bl.errorCarga("cupo", e);
    }
  }
}
