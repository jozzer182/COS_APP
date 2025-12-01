part of '../bloc/main_bloc.dart';

@immutable
abstract class MainEvent {}

class Load extends MainEvent {}

enum TypeMessage { error, message }

class Loading extends MainEvent {
  final bool isLoading;
  Loading({
    required this.isLoading,
  });
}

class LoadData extends MainEvent {}



//-------------------EVENTOS ESPECIALES PARA PEDIDOS-------------------

class ThemeChange extends MainEvent {
  ThemeChange();
}

class ThemeColorChange extends MainEvent {
  final Color color;
  ThemeColorChange({
    required this.color,
  });
}

class CambiarPorcentajeCarga extends MainEvent {
  final int porcentaje;
  CambiarPorcentajeCarga({
    required this.porcentaje,
  });
}

class CambiarPorcentajeCargaDisponibilidad extends MainEvent {
  final String porcentaje;
  CambiarPorcentajeCargaDisponibilidad({
    required this.porcentaje,
  });
}

class Cargar2023 extends MainEvent {
  final bool cargar;
  Cargar2023({
    required this.cargar,
  });
}