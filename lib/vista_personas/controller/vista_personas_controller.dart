import 'package:cos/vista_personas/model/vista_personas_reg.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../procesado_lcls/model/procesado_lcls_reg.dart';
import '../model/vista_personas_list.dart';

class VistaPersonasController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  VistaPersonasController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get calcular async {
    bl.startLoading;
    // Eliminación del retraso artificial
    await Future.delayed(const Duration(milliseconds: 100));
    
    VistaPersonasList vistaPersonasList = VistaPersonasList();
    List<VistaPersonasReg> list = vistaPersonasList.list;
    
    // Crear un mapa para acceso rápido a las personas por nombre
    Map<String, VistaPersonasReg> personasMap = {};
    
    // Precarga de datos para evitar búsquedas repetidas
    var contratosList = state().contratosList?.list ?? [];
    var proveedoresList = state().proveedoresList?.list ?? [];
    
    // Crear mapas para acceso rápido a contratos y proveedores
    Map<String, int> contratosProveedorMap = {};
    Map<int, String> proveedoresNombreMap = {};
    
    for (var contrato in contratosList) {
      contratosProveedorMap[contrato.contrato] = contrato.proveedor;
    }
    
    for (var proveedor in proveedoresList) {
      proveedoresNombreMap[proveedor.proveedor] = proveedor.nombreproveedor;
    }
    
    List<ProcesadoLclsReg> lclbiglist = state().procesadoLclsList?.list ?? [];
    
    // Procesar LCLs de manera más eficiente
    for (ProcesadoLclsReg lcl in lclbiglist) {
      String persona = lcl.correo;
      
      // Usar el mapa para acceso rápido
      if (!personasMap.containsKey(persona)) {
        var nuevaPersona = VistaPersonasReg(
          nombre: persona,
          proyectos: 0,
          contratos: 0,
          lcls: 0,
          consumo: 0,
          vencido: 0,
          planificado: 0,
          conformado: 0,
          proveedores: '',
        );
        
        list.add(nuevaPersona);
        personasMap[persona] = nuevaPersona;
      }
      
      // Acceder directamente por el mapa
      VistaPersonasReg personasReg = personasMap[persona]!;
      
      // Actualizar valores básicos
      personasReg.lcls += 1;
      personasReg.consumo += lcl.consumo;
      personasReg.vencido += lcl.vencido;
      personasReg.planificado += lcl.planificado;
      personasReg.conformado += lcl.conformado;
      personasReg.contratoslist.add(lcl.contrato);
      
      // Obtener proveedor de manera más eficiente
      int numproveedor = contratosProveedorMap[lcl.contrato] ?? 0;
      String proveedor = proveedoresNombreMap[numproveedor] ?? '';
      
      personasReg.proveedoreslist.add(proveedor);
      personasReg.proyectoslist.add(lcl.proyecto);
    }
    
    // Actualizar valores derivados fuera del bucle principal
    for (var personaReg in list) {
      personaReg.contratos = personaReg.contratoslist.toSet().length;
      personaReg.proveedores = personaReg.proveedoreslist.toSet().join("\n");
      personaReg.proyectos = personaReg.proyectoslist.toSet().length;
    }
    
    // Ordenar de manera más eficiente
    list.sort((b, a) => a.vencido.compareTo(b.vencido)); // Invertir a y b directamente en vez de sort+reverse
    
    vistaPersonasList.list = list;
    bl.stopLoading;
    emit(state().copyWith(vistaPersonasList: vistaPersonasList));
  }
}
