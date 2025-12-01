// import 'package:localstorage/localstorage.dart';


// import 'main__bl.dart';
// import 'main_bloc.dart';

// onCargar2023(
//   Cargar2023 event,
//   emit,
//   MainState Function() state,
// ) async {
//   LocalStorage storage = localStorage;
//   await initLocalStorage();
//   storage.setItem('cargar', event.cargar);
//   emit(state().copyWith(cargar2023: event.cargar));
// }

// onCargar2023Loader(Bl bl) async {
//   var emit = bl.emit;
//   MainState Function() state = bl.state;
//   LocalStorage storage = localStorage;
//   await initLocalStorage();
//   bool? cargar = storage.getItem('cargar');
//   emit(state().copyWith(cargar2023: cargar));
// }
