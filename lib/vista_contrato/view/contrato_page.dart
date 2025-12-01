import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/main_bloc.dart';
import '../../facturas/view/facturas_page.dart';
import '../../posiciones/view/posiciones_page.dart';
import '../../procesado_lcls/view/procesado_lcls_page.dart';
import '../../resources/transicion_pagina.dart';
import '../../conformidades/view/vista_conformidades.dart';
import '../../vista_info/view/vista_info_page.dart';
import 'contrato_grafica.dart';

class ContratoPage extends StatefulWidget {
  final String contrato;
  const ContratoPage({
    required this.contrato,
    super.key,
  });

  @override
  State<ContratoPage> createState() => _ContratoPageState();
}

class _ContratoPageState extends State<ContratoPage> {
  @override
  void initState() {
    // context
    //     .read<MainBloc>()
    //     .procesadoPosListController
    //     .obtener(widget.contrato);
    context.read<MainBloc>().lclConfListController.llamada(widget.contrato);
    context.read<MainBloc>().facturasListController.obtener(
          widget.contrato,
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        String nombre = state.cupoList!.list
            .firstWhere((e) => e.id == widget.contrato)
            .nombre;
        String ultimaActualizacion = state.procesadoLclsList?.list
                .where((e) => e.contrato == widget.contrato)
                .first
                .actualizado ??
            'Error';
        return Scaffold(
          appBar: AppBar(
            title: Text('CONTRATO ${widget.contrato} - $nombre'),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Última actualización:\n$ultimaActualizacion',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ContratoGrafica(
                    contrato: widget.contrato,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          goTo(
                            context,
                            ProcesadoLclsPage(
                              contrato: widget.contrato,
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'LCL\'s',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed:
                            // null,
                            state.lclConfList == null ||
                                    state.lclConfList!.cargaCorrecta == false
                                ? null
                                : () {
                                    goTo(
                                      context,
                                      ConformidadesPage(
                                        contrato: widget.contrato,
                                      ),
                                    );
                                  },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Conformidades',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: state.facturasList == null ||
                                state.facturasList!.cargaCorrecta == false
                            ? null
                            : () {
                                goTo(
                                  context,
                                  FacturasPage(
                                    contrato: widget.contrato,
                                  ),
                                );
                              },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Facturas',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed:
                            // null,
                            () {
                          goTo(
                            context,
                            PosicionesPage(
                              contrato: widget.contrato,
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Posiciones',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          goTo(
                            context,
                            VistaInfoPage(
                              contrato: widget.contrato,
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Información',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
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
