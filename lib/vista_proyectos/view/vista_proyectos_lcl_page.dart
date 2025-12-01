import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../procesado_lcls/model/procesado_lcls_reg.dart';
import '../../procesado_posiciones/view/procesado_posiciones_page.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';
import '../../resources/transicion_pagina.dart';

class ProyectosLclBigPage extends StatefulWidget {
  final String proyecto;
  const ProyectosLclBigPage({
    required this.proyecto,
    super.key,
  });

  @override
  State<ProyectosLclBigPage> createState() => _ProyectosLclBigPageState();
}

class _ProyectosLclBigPageState extends State<ProyectosLclBigPage> {
  String filter = '';
  bool soloVencido = false;
  int endList = 70;
  final ScrollController _controller = ScrollController();
  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        endList += 70;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state.procesadoLclsList == null) {
          return const Center(child: CircularProgressIndicator());
        }
        List<ToCelda> titulos = state.procesadoLclsList?.celdas ?? [];
        List<ProcesadoLclsReg> valores = state.procesadoLclsList?.list ?? [];
        valores = valores
            .where((e) => e.proyecto == widget.proyecto)
            .where(
              (e) => e.toMap().values.any(
                    (e) => e.toLowerCase().contains(filter.toLowerCase()),
                  ),
            )
            .where((e) => soloVencido ? e.vencido != 0 : true)
            .toList();
        List<ProcesadoLclsReg> valoresToShow = [];
        if (valores.length > endList) {
          valoresToShow = valores.sublist(0, endList);
        } else {
          valoresToShow = valores;
        }
        String proyecto = "";
        for (int i = 0; i < valores.length; i++) {
          ProcesadoLclsReg valor = valores[i];
          proyecto = valor.proyecto;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("VISTA POR LCL (Millones de pesos) $proyecto "),
            actions: [
              // ElevatedButton(
              //   onPressed: () {
              //     List<Map<String, dynamic>> datos = [];
              //     for (ProcesadoLclsReg bigLcl in valores) {
              //       List<Map<String, dynamic>> conformidades = bigLcl
              //               .conformidades?.list
              //               .map((e) => e.toMap())
              //               .toList() ??
              //           [];
              //       datos.addAll(conformidades);
              //     }
              //     // print(jsonEncode(datos));
              //     DescargaHojas().ahoraMap(
              //       datos: datos,
              //       nombre:
              //           "Conformidades ${valores.first.proyectos!.list.first.nombre}",
              //     );
              //   },
              //   child: const Text(
              //     'Descargar\nConformidades',
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              ElevatedButton(
                onPressed: () {
                  List<Map<String, dynamic>> datos =
                      valores.map((e) => e.toMap()).toList();
                  // print(jsonEncode(datos));
                  DescargaHojas().ahoraMap(
                    datos: datos,
                    nombre: "Lcls ${valores.first.proyecto}",
                  );
                },
                child: const Text(
                  'Descargar',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
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
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          soloVencido = !soloVencido;
                        });
                      },
                      child: Text(soloVencido ? 'Todos' : 'Solo Vencidos'),
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    for (ToCelda celda in titulos)
                      Expanded(
                        key: UniqueKey(),
                        flex: celda.flex,
                        child: Text(
                          celda.valor,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const Gap(5),
                Expanded(
                  child: SelectableRegion(
                    focusNode: FocusNode(),
                    selectionControls: emptyTextSelectionControls,
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: valoresToShow.length,
                      itemBuilder: (c, index) {
                        void goTo(Widget page) =>
                            Navigator.push(context, createRoute(page));
                        return InkWell(
                          onTap:
                              // (){},
                              () => goTo(
                            ProcesadoPosPage(
                              lcl: valoresToShow[index],
                              contrato: valoresToShow[index].contrato,
                            ),
                          ),

                          // onTap: () =>
                          //     goTo(LclBigPosPage(lcl: valoresToShow[index])),
                          // onDoubleTap: () => LclBigPosPage(lcl: valoresToShow[index]),
                          child: Row(
                            key: UniqueKey(),
                            children: [
                              for (ToCelda celda in valoresToShow[index].celdas)
                                Expanded(
                                  flex: celda.flex,
                                  child: Text(
                                    celda.valor,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: celda.color,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
