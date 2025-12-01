import 'package:cos/procesado_posiciones/model/procesado_posiciones_reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';

import '../../procesado_lcls/model/procesado_lcls_reg.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';

class ProcesadoPosPage extends StatefulWidget {
  final ProcesadoLclsReg lcl;
  final String contrato;
  const ProcesadoPosPage({
    required this.lcl,
    required this.contrato,
    super.key,
  });

  @override
  State<ProcesadoPosPage> createState() => _ProcesadoPosPageState();
}

class _ProcesadoPosPageState extends State<ProcesadoPosPage> {
  String filter = '';
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
    context
        .read<MainBloc>()
        .procesadoPosListController
        .obtener(widget.contrato, widget.lcl.lcl);
    //make call pto postgree with lcl y contract..
    print("widget.lcl.lcl: ${widget.lcl.lcl}");
    print("widget.lcl.contrato: ${widget.lcl.contrato}");
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
        if (state.procesadoPosicionesList == null || state.procesadoPosicionesList!.lcl != widget.lcl.lcl) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  " ${widget.lcl.lcl} VISTA POR POSICIÓN (Millones de pesos)"),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        print(
            'state.procesadoPosicionesList!.cargaCorrecta: ${state.procesadoPosicionesList!.cargaCorrecta}');
        if (state.procesadoPosicionesList!.cargaCorrecta == false && state.procesadoPosicionesList!.lcl == widget.lcl.lcl) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  " ${widget.lcl.lcl} VISTA POR POSICIÓN (Millones de pesos)"),
            ),
            body: const Center(
              child: Text(
                'Las posiciones de LCL de este contrato no están disponibles en COS. 🙁',
              ),
            ),
          );
        }
        List<ToCelda> titulos = state.procesadoPosicionesList?.celdas ?? [];
        List<ProcesadoPosicionesReg> valores =
            state.procesadoPosicionesList?.list ?? [];
        valores = valores
            .where((e) => e.lcl == widget.lcl.lcl)
            .where(
              (e) => e.toMap().values.any(
                    (e) => e
                        .toString()
                        .toLowerCase()
                        .contains(filter.toLowerCase()),
                  ),
            )
            .toList();
        List<ProcesadoPosicionesReg> valoresToShow = [];
        if (valores.length > endList) {
          valoresToShow = valores.sublist(0, endList);
        } else {
          valoresToShow = valores;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
                " ${widget.lcl.lcl} VISTA POR POSICIÓN (Millones de pesos)"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  List<Map<String, dynamic>> datos =
                      valores.map((e) => e.toMap()).toList();
                  // print(jsonEncode(datos));
                  DescargaHojas().ahoraMap(
                    datos: datos,
                    nombre: "Posiciones Lcl ${valores.first.lcl}",
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
                        return InkWell(
                          onTap: () {},
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
