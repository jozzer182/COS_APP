// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

// import 'package:fem_app/codigosconcomplementos/view/codigosconcomplementos_page.dart';

import 'package:cos/cupo/model/cupo_reg.dart';
import 'package:cos/resources/descarga_hojas.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

// import 'package:fem_app/versiones/versiones_page.dart';

import '../bloc/main_bloc.dart';
import '../cupo/model/cupo_list.dart';
import '../gestorusuarios/view/gestorusuraios_page.dart';
import '../user/view/user_page.dart';
import '../version.dart';
import '../vista_contrato/view/vista_contrato_page.dart';
import '../vista_personas/view/vista_personas_page.dart';
import '../vista_proyectos/view/vista_proyectos_page.dart';
import 'dialog/home_page_cambiar_color.dart';
import 'widgets/home_page_fila_widgets.dart';
import 'widgets/home_page_simple_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('mensaje');
  TextEditingController busqueda = TextEditingController();
  bool marcar = false;

  @override
  void initState() {
    FirebaseAnalytics.instance.logLogin();
    busqueda.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        String perfil = state.user?.perfil ?? 'desactivado';
        if (perfil == 'desactivado') {
          return const Text('Datos de usuario cargando o perfil desactivado');
        }
        CupoList? cupo = state.cupoList;
        List<CupoReg> cupoList = [];
        if (cupo != null) {
          cupoList = cupo.list;
          if (busqueda.text.isNotEmpty) {
            cupoList = cupoList
                .where((e) => e.toList().any((el) =>
                    el.toUpperCase().contains(busqueda.text.toUpperCase())))
                .toList();
          }
        }

        return Scaffold(
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Version().data,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  "Conectado como: ${FirebaseAuth.instance.currentUser!.email}" +
                      "\n Fecha y hora: ${DateTime.now().toString().substring(0, 16)}, " +
                      "Página actual: Home",
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.right,
                )
              ],
            ),
          ],
          appBar: AppBar(
            title: const Text('COS+'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: BlocSelector<MainBloc, MainState, bool>(
                selector: (state) => state.isLoading,
                builder: (context, state) {
                  // print('called');
                  return state
                      ? const LinearProgressIndicator()
                      : const SizedBox();
                },
              ),
            ),
            actions: [
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Última actualización:\n$ultimaActualizacion',
              //       textAlign: TextAlign.center,
              //     ),
              //   ],
              // ),
              const Gap(5),
              ElevatedButton(
                onPressed: () {
                  print(
                      'state.procesadoLclsList!.list ${state.procesadoLclsList!.list.length}');
                  List<Map<String, dynamic>> datos = state
                      .procesadoLclsList!.list
                      .map((e) => e.toMap())
                      .toList();
                  // print(jsonEncode(datos));
                  DescargaHojas().ahoraMap(
                    datos: datos,
                    nombre: "BIG LCL",
                  );
                },
                child: const Text('Big LCL'),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Get.to(
              //       AyudaPage(),
              //       transition: transition.Transition.cupertino,
              //     );
              //   },
              //   child: const Text(
              //     'Más \nInformación',
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<MainBloc>().load();
                },
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const CambiarColorApp(),
                ),
                icon: const Icon(Icons.color_lens),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  BlocProvider.of<MainBloc>(context).add(ThemeChange());
                },
                icon: const Icon(Icons.brightness_4_outlined),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UserPage();
                  }));
                },
                icon: const Icon(Icons.account_circle),
              ),
              ElevatedButton(
                child: const Center(
                  child: Text(
                    'Cerrar\nSesión',
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                List<String> permisos = state.user!.permisos;
                bool esContratista = state.user!.perfil == 'contratista';
                //Guard para que no se muestre la pantalla a los contratistas por ahora
                if (esContratista) {
                  return const Center(
                    child: Text('En construcción'),
                  );
                }
                // print('permisos: $permisos');
                // print('permisos.contains("nuevo"): ${permisos.contains("nuevo")}');
                // print('porcentaje: $porcentaje');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Gap(2),
                    // const MensajeFirebase(),
                    // const Gap(6),
                    // Text('${state.porcentajecarga}%'),
                    const Gap(10),
                    // Text("Fichas de Equipos y Materiales", style: titleStyle),
                    FilaWidgets(
                      children: [
                        SimpleCard(
                          disabled: state.vistaContratoList == null,
                          page: const VistaContratoPage(),
                          title: "Vista Contratos",
                          image: 'images/vistacontrato.png',
                          mediumOpacity: true,
                          isSecondary: true,
                        ),
                        SimpleCard(
                          disabled: state.vistaContratoList == null,
                          page: const VistaProyectoPage(),
                          title: "Vista Proyectos",
                          image: 'images/project.png',
                          mediumOpacity: true,
                          isSecondary: true,
                        ),
                        SimpleCard(
                          disabled: state.vistaContratoList == null,
                          page: const VistaPersonasPage(),
                          title: "Vista Personas",
                          image: 'images/pm.png',
                          mediumOpacity: true,
                          isSecondary: true,
                        ),
                        SimpleCard(
                          disabled: false,
                          page: const GestorUsuariosPage(),
                          title: "Gestor Usuarios",
                          image: 'images/network.png',
                          esPermitido: permisos.contains('total'),
                        ),
                      ],
                    ),
                    const Gap(8),
                    const Gap(12),
                    const Text(
                      "Carga Elementos",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cupo',
                          style: TextStyle(
                            color: state.cupoList == null
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        Text(
                          'Contratos',
                          style: TextStyle(
                            color: state.contratosList == null
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        Text(
                          'Proveedores',
                          style: TextStyle(
                            color: state.proveedoresList == null
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        // Text(
                        //   'Lcl Fecha',
                        //   style: TextStyle(
                        //     color: state.lclFechaList == null
                        //         ? Colors.red
                        //         : Colors.green,
                        //   ),
                        // ),
                        // Text(
                        //   'Proyectos',
                        //   style: TextStyle(
                        //     color: state.proyectosList == null
                        //         ? Colors.red
                        //         : Colors.green,
                        //   ),
                        // ),
                        // Text(
                        //   'Obj-Wbe',
                        //   style: TextStyle(
                        //     color: state.objWbeList == null
                        //         ? Colors.red
                        //         : Colors.green,
                        //   ),
                        // ),
                        Text(
                          'GAC',
                          style: TextStyle(
                            color: state.gacList == null
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        Text(
                          'Contato Posiciones',
                          style: TextStyle(
                            color: state.posicionesList == null
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        Text(
                          'LCLs',
                          style: TextStyle(
                            color: state.procesadoLclsList == null
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        // Text(
                        //   'Ped-Obj',
                        //   style: TextStyle(
                        //     color: state.pedObjList == null
                        //         ? Colors.red
                        //         : Colors.green,
                        //   ),
                        // ),
                        // Text(
                        //   'Ekbe',
                        //   style: TextStyle(
                        //     color: state.lclEkbeList == null
                        //         ? Colors.red
                        //         : Colors.green,
                        //   ),
                        // ),
                        // Text(
                        //   'Lcl-Obj',
                        //   style: TextStyle(
                        //     color: state.lclObjList == null
                        //         ? Colors.red
                        //         : Colors.green,
                        //   ),
                        // ),
                      ],
                    ),
                    const Gap(12),
                    const Row(
                      children: [
                        Text(
                          "Contratos a Cargar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Gap(10),
                        Text(
                            '(para cargar más contratos, seleccionelos y vuelva a cargar la página)')
                      ],
                    ),
                    const Gap(10),
                    if (state.cupoList != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          SizedBox(
                            width: 400,
                            child: TextField(
                              controller: busqueda,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Búsqueda'),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              for (var reg in cupoList) {
                                context
                                    .read<MainBloc>()
                                    .cargaContratosListController
                                    .agregar(
                                      reg.id,
                                      !marcar,
                                    );
                              }
                              setState(() {
                                marcar = !marcar;
                              });
                            },
                            child:
                                Text(marcar ? 'Desmarcar Todo' : 'Marcar Todo'),
                          ),
                        ],
                      ),
                    const Gap(5),
                    if (state.cupoList != null && state.contratosList != null)
                      for (var index in List.generate(
                          (cupoList.length / 2).ceilToDouble().toInt(),
                          (index) => index))
                        Builder(builder: (context) {
                          CupoReg reg = cupoList[index * 2];
                          int indice2 = index * 2 + 1;
                          if (cupoList.length <= index * 2 + 1) {
                            indice2 = index * 2;
                          }
                          CupoReg reg2 = state.cupoList!.list[indice2];
                          String obj1 = state.contratosList?.list
                                  .firstWhereOrNull((e) =>
                                      e.contrato.toString() ==
                                      reg.id.toString())
                                  ?.objetosintetico ??
                              '';
                          String obj2 = state.contratosList?.list
                                  .firstWhereOrNull((e) =>
                                      e.contrato.toString() ==
                                      reg2.id.toString())
                                  ?.objetosintetico ??
                              '';

                          return Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: state.cargaContratos?.list
                                          .contains(reg.id),
                                      onChanged: (b) async {
                                        context
                                            .read<MainBloc>()
                                            .cargaContratosListController
                                            .agregar(
                                              reg.id,
                                              b ?? false,
                                            );
                                      },
                                    ),
                                    Text(reg.id),
                                    const Gap(5),
                                    Tooltip(
                                      message: obj1,
                                      child: Text(reg.nombre),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: state.cargaContratos?.list
                                          .contains(reg2.id),
                                      onChanged: (b) async {
                                        context
                                            .read<MainBloc>()
                                            .cargaContratosListController
                                            .agregar(
                                              reg2.id,
                                              b ?? false,
                                            );
                                      },
                                    ),
                                    Text(reg2.id),
                                    const Gap(5),
                                    Tooltip(
                                      message: obj2,
                                      child: Text(reg2.nombre),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),

                    // FilaWidgets(
                    //   children: [
                    //     SimpleCard(
                    //       disabled: state.versiones == null,
                    //       page: const VersionOficialPage(),
                    //       title: "Versiones Oficiales",
                    //       image: 'images/version.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.disponibilidad == null,
                    //       page: const DisponibilidadPage(),
                    //       title: "Disponibilidad$cargaDisponibilidad",
                    //       image: 'images/delivery-box.png',
                    //       mediumOpacity: true,
                    //       isSecondary: true,
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.disponibilidad == null,
                    //       page: const AnalisisCodigoPage(),
                    //       title: "Detalle Disponibilidad",
                    //       image: 'images/prediction.png',
                    //       isSecondary: true,
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.disponibilidad == null,
                    //       page: const DisponibilidadGraficaPage(),
                    //       // fun: () => launchUrl(
                    //       //   Uri.parse(
                    //       //     'https://lookerstudio.google.com/reporting/9804dafb-214c-4cea-b04e-072708438172',
                    //       //   ),
                    //       // ),
                    //       title: "Gráfica",
                    //       image: 'images/chart.png',
                    //       isSecondary: true,
                    //       // color: Colors.white,
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.alertaProyectos == null,
                    //       page: const AlertaProyectosPage(),
                    //       title: "Alerta por proyecto",
                    //       image: 'images/danger.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.fechasFEM == null,
                    //       page: const FechasFEMPage(),
                    //       title: "Fechas FEM",
                    //       image: 'images/schedule2.png',
                    //     ),
                    //   ],
                    // ),
                    // const Gap(12),
                    // Text("Presupuesto", style: titleStyle),
                    // const Gap(12),
                    // FilaWidgets(
                    //   children: [
                    //     SimpleCard(
                    //       disabled: state.budget == null,
                    //       page: const BudgetPage(),
                    //       title: "Budget",
                    //       image: 'images/salary.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.fem == null,
                    //       page: const BusquedaFichasE4ePage(),
                    //       title: "Búsqueda Fichas E4E",
                    //       image: 'images/se.png',
                    //       isSecondary: true,
                    //     ),
                    //   ],
                    // ),
                    // const Gap(12),
                    // Text("Códigos Material", style: titleStyle),
                    // FilaWidgets(
                    //   children: [
                    //     SimpleCard(
                    //       disabled: state.codigosOficiales == null,
                    //       page: const CodigosOficialesPage(),
                    //       title: "Códigos Oficiales",
                    //       image: 'images/codigosoficiales.png',
                    //     ),
                    //     const Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text('+'),
                    //       ],
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.codigosAdicionales == null,
                    //       page: const CodigosAdicionalesPage(),
                    //       title: "Códigos Adicionales",
                    //       image: 'images/folder.png',
                    //     ),
                    //     const Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text('='),
                    //       ],
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.codigosHabilitados == null,
                    //       page: const CodigosHabilitadosPage(),
                    //       title: "Códigos Habilitados",
                    //       image: 'images/approved.png',
                    //     ),
                    //   ],
                    // ),
                    // const Gap(5),
                    // FilaWidgets(
                    //   children: [
                    //     SimpleCard(
                    //       disabled: state.aportacion == null,
                    //       page: const AportacionPage(),
                    //       title: "Aportación",
                    //       image: 'images/aportacion.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.sustitutos == null,
                    //       page: const SustitutosPage(),
                    //       title: "Sustitutos",
                    //       image: 'images/replacement.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.codigosPorAprobar == null,
                    //       page: const CodigosPorAprobarPage(),
                    //       title: "Códigos por Aprobar",
                    //       image: "images/poraprobar.png",
                    //     ),
                    //     // SimpleCard(
                    //     //   disabled: state.codigosConComplementos == null,
                    //     //   page: const CodigosConComplementosPage(),
                    //     //   title: "Códigos Complementos",
                    //     //   image: "images/complementary.png",
                    //     // ),
                    //   ],
                    // ),
                    // const Gap(12),
                    // Text("Datos de SAP", style: titleStyle),
                    // FilaWidgets(
                    //   children: [
                    //     SimpleCard(
                    //       disabled: state.plataforma == null,
                    //       page: const PlataformaPage(),
                    //       title: "Plataforma",
                    //       image: 'images/warehouse.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.oe == null,
                    //       page: const OePage(),
                    //       title: "Órdenes",
                    //       image: 'images/order.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.oeMes == null,
                    //       page: const OeMesPage2(),
                    //       title: "Órdenes Mes",
                    //       image: 'images/schedule.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.mm60 == null,
                    //       page: const Mm60Page(),
                    //       title: "MM60",
                    //       image: 'images/inventory.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: state.wbe == null,
                    //       page: const WbePage(),
                    //       title: "WBE",
                    //       image: 'images/diagram.png',
                    //     ),
                    //   ],
                    // ),
                    // const Gap(12),
                    // Text("Datos generales", style: titleStyle),
                    // FilaWidgets(
                    //   children: [
                    //     SimpleCard(
                    //       disabled: state.pdis == null,
                    //       page: const PdisPage(),
                    //       title: "Pdis",
                    //       image: 'images/pushcart.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: false,
                    //       page: const GestorUsuariosPage(),
                    //       title: "Gestor Usuarios",
                    //       image: 'images/network.png',
                    //       esPermitido: permisos.contains('gestor_usuarios'),
                    //     ),
                    //     const SimpleCard(
                    //       disabled: false,
                    //       page: HistoricoPage(),
                    //       title: "Histórico (2022-2023)",
                    //       image: 'images/his.png',
                    //     ),
                    //     SimpleCard(
                    //       disabled: false,
                    //       page: null,
                    //       fun: () => launchUrl(
                    //         Uri.parse(
                    //           'https://enelcom.sharepoint.com/sites/FEM',
                    //         ),
                    //       ),
                    //       title: "Noticias",
                    //       image: 'images/news.png',
                    //       color: Colors.blue[100],
                    //     ),
                    //   ],
                    // ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
