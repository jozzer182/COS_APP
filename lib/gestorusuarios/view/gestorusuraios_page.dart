import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GestorUsuariosPage extends StatefulWidget {
  const GestorUsuariosPage({super.key});

  @override
  State<GestorUsuariosPage> createState() => _GestorUsuariosPageState();
}

class _GestorUsuariosPageState extends State<GestorUsuariosPage> {
  DatabaseReference perfilesStream = FirebaseDatabase.instance.ref('perfiles');
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestor de Usuarios')),
      body: Center(
        child: SizedBox(
          width: 600,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(20),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      filter = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Búsqueda',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Gap(20),
                StreamBuilder<DatabaseEvent>(
                    stream: perfilesStream.onValue,
                    builder: (context, snapshot) {
                      print('gestorusuarios: tipo recibido: ${snapshot.data?.snapshot.value.runtimeType}');
                      
                      // Verificar si hay datos
                      if (snapshot.data?.snapshot.value == null) {
                        return const Center(child: Text('No hay datos disponibles'));
                      }
                      
                      // Verificar si es un mapa
                      if (!(snapshot.data?.snapshot.value is Map)) {
                        return const Center(child: Text('El formato de datos ha cambiado'));
                      }
                      
                      // Crear nuevo mapa
                      Map<String, dynamic> listaDePerfiles = {};
                      
                      // Convertir de Map<Object?, Object?> a Map<String, dynamic>
                      Map originalMap = snapshot.data!.snapshot.value as Map;
                      originalMap.forEach((k, v) {
                        // Solo incluir entradas que son mapas (perfiles de usuario)
                        if (v is Map) {
                          // Convertir el perfil interno también
                          Map<String, dynamic> perfil = {};
                          // ignore: unnecessary_cast
                          (v as Map).forEach((pk, pv) {
                            perfil[pk.toString()] = pv;
                          });
                          listaDePerfiles[k.toString()] = perfil;
                        } else {
                          listaDePerfiles[k.toString()] = v;
                        }
                      });
                      
                      // Imprimir los datos para depuración
                      print('Perfiles procesados:');
                      listaDePerfiles.forEach((key, value) {
                        if (value is Map) {
                          print('Usuario $key: $value');
                          print('  - Nombre: ${value['nombre']}');
                          print('  - Email: ${value['email']}');
                          print('  - Correo: ${value['correo']}');
                        }
                      });
                      
                      if (filter.isNotEmpty) {
                        listaDePerfiles.removeWhere((key, value) {
                          // Verificación de tipo antes de acceder a las propiedades
                          if (value is Map) {
                            String nombre = (value['nombre'] ?? '').toString().toLowerCase();
                            String email = (value['email'] ?? '').toString().toLowerCase();
                            String filterLower = filter.toLowerCase();
                            return !nombre.contains(filterLower) && !email.contains(filterLower);
                          }
                          return true; // Eliminar entradas que no son mapas
                        });
                      }
                      return SelectableRegion(
                        focusNode: FocusNode(),
                        selectionControls: emptyTextSelectionControls,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (MapEntry<String, dynamic> perfil
                                in listaDePerfiles.entries)
                              Card(
                                key: ValueKey(perfil.key),
                                elevation: 2,
                                child: ListTile(
                                  title: Text(perfil.value['nombre'] ?? "Sin nombre"),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Intentar mostrar el email desde diferentes posibles campos
                                      if (perfil.value['correo'] != null)
                                        Text("Email: ${perfil.value['correo']}"),
                                      if (perfil.value['email'] != null && perfil.value['correo'] == null)
                                        Text("Email: ${perfil.value['email']}"),
                                      if (perfil.value['correo'] == null && perfil.value['email'] == null)
                                        const Text("Email no disponible"),
                                      // Text("UID: ${perfil.key}"),
                                    ],
                                  ),
                                  trailing: SizedBox(
                                    width: 200,
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Perfil',
                                        border: OutlineInputBorder(),
                                      ),
                                      value: perfil.value['perfil'],
                                      onChanged: (value) {
                                        perfilesStream.update({
                                          '${perfil.key}/perfil': value,
                                        });
                                      },
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'funcional',
                                          child: Text('FUNCIONAL'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'ppyc',
                                          child: Text('PP&C'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'desactivado',
                                          child: Text('DESACTIVADO'),
                                        ),
                                        // DropdownMenuItem(
                                        //   value: 'funcional',
                                        //   child: Tooltip(
                                        //     message: 'Se incluye ingeniería',
                                        //     child: Text('FUNCIONAL'),
                                        //   ),
                                        // ),
                                        // DropdownMenuItem(
                                        //   value: 'pm',
                                        //   child: Text('PM'),
                                        // ),
                                        // DropdownMenuItem(
                                        //   value: 'normas',
                                        //   child: Text('NORMAS'),
                                        // ),
                                        // DropdownMenuItem(
                                        //   value: 'contratista',
                                        //   child: Text('CONTRATISTA'),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
