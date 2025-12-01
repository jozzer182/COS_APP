// // ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

// import 'package:async/async.dart';
// import 'package:fem_app/bloc/main_bloc.dart';
// import 'package:fem_app/disponibilidad/controller/disponibilidad_controller.dart';
// import 'package:fem_app/resources/future_group_add.dart';

// import '../extratemp/model/extra_model.dart';
// import '../ficha/main/ficha/controller/fichas_action.dart';
// import '../nuevo/model/nuevo_model.dart';
// import 'main__bl.dart';

// onCalculatedData(Bl bl) async {
//   // print('onCalculatedData');
//   try {
//     Stopwatch stopwatch = Stopwatch()..start();
//     FutureGroupDelayed futureGroup = FutureGroupDelayed();
//     // futureGroup.addF(DisponibilidadController(bl).crear);
//     futureGroup.addF(DisponibilidadController(bl).crearConFechasOptimizado);
//     futureGroup.addF(onCrearNuevo(bl));
//     futureGroup.close();
//     await futureGroup.future;
//     print('calculatedData Group1 executed in ${stopwatch.elapsed}');
//     await Future.delayed(const Duration(milliseconds: 100));
//     FutureGroup futureGroup2 = FutureGroup();
//     Stopwatch stopwatch2 = Stopwatch()..start();
//     futureGroup2.add(FichasController(bl).onCrearFichas());
//     futureGroup2.close();
//     await futureGroup2.future;
//     print('calculatedData Group2 executed in ${stopwatch2.elapsed}');
//     stopwatch.stop();
//     stopwatch2.stop();
//   } on Exception catch (e) {
//     bl.errorCarga('Error en cálculo de datos', e);
//   }
// }

// Future<void> onCrearExtra(
//   event,
//   emit,
//   MainState Function() state,
// ) async {
//   Extra extra = Extra();
//   print('onCrearExtra');
//   try {
//     // nuevo.crear(fem: fem, budget: budget, maestro: maestro);
//     await extra.crear2;
//     emit(state().copyWith(extra: extra));
//     // print('plataforma: ${state().plataforma?.plataformaListSearch[0]}');
//   } catch (e) {
//     // print(e);
//     emit(state().copyWith(
//       errorCounter: state().errorCounter + 1,
//       message:
//           '🤕Error creando📞 la tabla de datos ExtraTemporal ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
//     ));
//   }
// }

// Future<void> onCrearNuevo(Bl bl) async {
//   var emit = bl.emit;
//   MainState Function() state = bl.state;
//   Nuevo nuevo = Nuevo();
//   try {
//     nuevo.crear2;
//     emit(state().copyWith(nuevo: nuevo));
//   } catch (e) {
//     bl.errorCarga("Nuevo", e);
//   }
// }
