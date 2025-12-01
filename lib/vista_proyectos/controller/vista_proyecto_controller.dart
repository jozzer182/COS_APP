import 'package:cos/vista_proyectos/model/vista_proyecto_reg.dart';

import '../../bloc/main__bl.dart';
import '../../bloc/main_bloc.dart';
import '../../procesado_lcls/model/procesado_lcls_reg.dart';
import '../model/vista_proyecto_list.dart';

class VistaProyectosController {
  final Bl bl;
  late MainState Function() state;
  late var emit;
  late void Function(MainEvent p1) add;

  VistaProyectosController(this.bl) {
    emit = bl.emit;
    state = bl.state;
    add = bl.add;
  }

  get calcular async {
    bl.startLoading;
    
    await Future.delayed(const Duration(milliseconds: 100));
    
    VistaProyectosList vistaProyectosList = VistaProyectosList();
    List<VistaProyectoReg> list = vistaProyectosList.list;
    
    // Usar un mapa para acceso más rápido por proyecto
    Map<String, VistaProyectoReg> proyectosMap = {};

    List<ProcesadoLclsReg> lclbiglist = state().procesadoLclsList?.list ?? [];
    
    // Procesar todos los LCLs de manera más eficiente
    for (ProcesadoLclsReg lcl in lclbiglist) {
      String proyecto = lcl.proyecto;
      String wbe = lcl.wbe;
      
      // Usar el mapa para rápido acceso y verificación
      if (!proyectosMap.containsKey(proyecto)) {
        var nuevoProyecto = VistaProyectoReg(
          wbe: wbe,
          nombre: proyecto,
          contratos: 0,
          lcls: 0,
          consumo: 0,
          vencido: 0,
          planificado: 0,
          conformado: 0,
          usuario: "",
        );
        
        list.add(nuevoProyecto);
        proyectosMap[proyecto] = nuevoProyecto;
      }
      
      // Acceso directo al proyecto por su clave
      VistaProyectoReg proyectoReg = proyectosMap[proyecto]!;
      
      // Actualizar valores
      proyectoReg.lcls += 1;
      proyectoReg.consumo += lcl.consumo;
      proyectoReg.vencido += lcl.vencido;
      proyectoReg.planificado += lcl.planificado;
      proyectoReg.conformado += lcl.conformado;
      proyectoReg.contratoslist.add(lcl.contrato);
      proyectoReg.usuarioslist.add(lcl.correo);
    }
    
    // Actualizar los valores derivados una sola vez fuera del bucle principal
    for (var proyectoReg in list) {
      proyectoReg.contratos = proyectoReg.contratoslist.toSet().length;
      proyectoReg.usuario = proyectoReg.usuarioslist.toSet().join("\n");
    }

    // Ordenar de manera más eficiente
    list.sort((b, a) => a.vencido.compareTo(b.vencido)); // Invertimos a y b para ordenar directamente
    vistaProyectosList.list = list;
    
    bl.stopLoading;
    emit(state().copyWith(vistaProyectosList: vistaProyectosList));
  }
}
