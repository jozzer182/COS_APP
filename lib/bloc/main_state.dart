part of '../bloc/main_bloc.dart';

class MainState {
  String mensaje;
  String message;
  String dialogMessage;
  int messageCounter;
  int errorCounter;
  Color messageColor;
  bool isLoading;
  bool isLoadingFem;
  bool isDark = false;
  Color? themeColor;
  String? year;
  int porcentajecarga;
  String? porcentajecargadisponibilidad;
  bool cargar2023 = true;
  ConformidadesList? lclConfList;
  ProveedoresList? proveedoresList;
  ContratosList? contratosList;
  VistaContratoList? vistaContratoList;
  CupoList? cupoList;
  PosicionesList? posicionesList;
  VistaProyectosList? vistaProyectosList;
  VistaPersonasList? vistaPersonasList;
  CargaContratos? cargaContratos;
  // VistaConformidadesList? vistaConformidadesList;
  VistaInfo? vistaInfo;
  ProcesadoLclsList? procesadoLclsList;
  ProcesadoPosicionesList? procesadoPosicionesList;
  GacList? gacList;
  FacturasList? facturasList;

  User? user;

  MainState({
    this.mensaje = '',
    this.message = '',
    this.dialogMessage = 'Mensaje de prueba',
    this.messageCounter = 0,
    this.errorCounter = 0,
    this.messageColor = Colors.red,
    this.isLoading = false,
    this.isLoadingFem = false,
    this.isDark = false,
    this.themeColor,
    this.year,
    this.porcentajecarga = 0,
    this.porcentajecargadisponibilidad,
    this.cargar2023 = true,
    this.user,
    this.lclConfList,
    this.proveedoresList,
    this.contratosList,
    this.vistaContratoList,
    this.cupoList,
    this.posicionesList,
    this.vistaProyectosList,
    this.vistaPersonasList,
    this.cargaContratos,
    // this.vistaConformidadesList,
    this.vistaInfo,
    this.procesadoLclsList,
    this.procesadoPosicionesList,
    this.gacList,
    this.facturasList,
  });

  initial() {
    mensaje = '';
    message = '';
    dialogMessage = '';
    messageCounter = 0;
    errorCounter = 0;
    messageColor = Colors.red;
    isLoading = false;
    isLoadingFem = false;
    isDark = false;
    themeColor = null;
    year = null;
    porcentajecarga = 0;
    porcentajecargadisponibilidad = null;
    cargar2023 = true;
    user = null;
    lclConfList = null;
    proveedoresList = null;
    contratosList = null;
    vistaContratoList = null;
    cupoList = null;
    posicionesList = null;
    vistaProyectosList = null;
    vistaPersonasList = null;
    cargaContratos = null;
    // vistaConformidadesList = null;
    vistaInfo = null;
    procesadoLclsList = null;
    procesadoPosicionesList = null;
    gacList = null;
    facturasList = null;
  }

  MainState copyWith({
    String? mensaje,
    String? message,
    String? dialogMessage,
    int? messageCounter,
    int? errorCounter,
    Color? messageColor,
    bool? isLoading,
    bool? isLoadingFem,
    bool? isDark,
    Color? themeColor,
    String? year,
    int? porcentajecarga,
    String? porcentajecargadisponibilidad,
    bool? cargar2023,
    User? user,
    ConformidadesList? lclConfList,
    ProveedoresList? proveedoresList,
    ContratosList? contratosList,
    VistaContratoList? vistaContratoList,
    CupoList? cupoList,
    PosicionesList? posicionesList,
    VistaProyectosList? vistaProyectosList,
    VistaPersonasList? vistaPersonasList,
    CargaContratos? cargaContratos,
    // VistaConformidadesList? vistaConformidadesList,
    VistaInfo? vistaInfo,
    ProcesadoLclsList? procesadoLclsList,
    ProcesadoPosicionesList? procesadoPosicionesList,
    GacList? gacList,
    FacturasList? facturasList,
  }) {
    return MainState(
      mensaje: mensaje ?? this.mensaje,
      message: message ?? this.message,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      messageCounter: messageCounter ?? this.messageCounter,
      errorCounter: errorCounter ?? this.errorCounter,
      messageColor: messageColor ?? this.messageColor,
      isLoading: isLoading ?? this.isLoading,
      isLoadingFem: isLoadingFem ?? this.isLoadingFem,
      isDark: isDark ?? this.isDark,
      themeColor: themeColor ?? this.themeColor,
      year: year ?? this.year,
      porcentajecarga: porcentajecarga ?? this.porcentajecarga,
      porcentajecargadisponibilidad:
          porcentajecargadisponibilidad ?? this.porcentajecargadisponibilidad,
      cargar2023: cargar2023 ?? this.cargar2023,
      user: user ?? this.user,
      lclConfList: lclConfList ?? this.lclConfList,
      proveedoresList: proveedoresList ?? this.proveedoresList,
      contratosList: contratosList ?? this.contratosList,
      vistaContratoList: vistaContratoList ?? this.vistaContratoList,
      cupoList: cupoList ?? this.cupoList,
      posicionesList: posicionesList ?? this.posicionesList,
      vistaProyectosList: vistaProyectosList ?? this.vistaProyectosList,
      vistaPersonasList: vistaPersonasList ?? this.vistaPersonasList,
      cargaContratos: cargaContratos ?? this.cargaContratos,
      // vistaConformidadesList:
      //     vistaConformidadesList ?? this.vistaConformidadesList,
      vistaInfo: vistaInfo ?? this.vistaInfo,
      procesadoLclsList: procesadoLclsList ?? this.procesadoLclsList,
      procesadoPosicionesList:
          procesadoPosicionesList ?? this.procesadoPosicionesList,
      gacList: gacList ?? this.gacList,
      facturasList: facturasList ?? this.facturasList,
    );
  }
}
