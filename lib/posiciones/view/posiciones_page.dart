import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';
import '../model/posiciones_reg.dart';

class PosicionesPage extends StatefulWidget {
  final String contrato;
  const PosicionesPage({
    required this.contrato,
    super.key,
  });

  @override
  State<PosicionesPage> createState() => _PosicionesPageState();
}

class _PosicionesPageState extends State<PosicionesPage> {
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

  // LocalStorage storage = LocalStorage('contratos.json');

  @override
  void initState() {
    _controller.addListener(_onScroll);
    // context.read<MainBloc>().vistaConfomidadesListController.calcular;
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
        if (state.vistaContratoList == null) {
          return const Center(child: CircularProgressIndicator());
        }
        List<ToCelda> titulos = state.posicionesList?.celdas ?? [];
        List<PosicionesReg> valores = state.posicionesList?.list ?? [];
        valores = valores
            .where((e) => e.contrato == widget.contrato)
            .where(
              (e) => e.toList().any(
                    (e) => e.toLowerCase().contains(filter.toLowerCase()),
                  ),
            )
            .toList();
        List<PosicionesReg> valoresToShow = [];
        if (valores.length > endList) {
          valoresToShow = valores.sublist(0, endList);
        } else {
          valoresToShow = valores;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("POSICIONES (Millones de pesos)"),
            actions: [
              const Gap(5),
              ElevatedButton(
                onPressed: () {
                  print(
                      'state.vistaContratoList!.list ${state.vistaContratoList!.list.length}');
                  List<Map<String, dynamic>> datos = valores
                      // .vistaContratoList!.list
                      .map((e) => e.toMap())
                      .toList();
                  // print(jsonEncode(datos));
                  DescargaHojas().ahoraMap(
                    datos: datos,
                    nombre: "Posiciones ${widget.contrato}",
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
                    // const SizedBox(
                    //   width: 32,
                    // ),
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
                          onTap: () {
                            //   goTo(
                            //   ContratoPage(
                            //     contrato: valoresToShow[index].contrato,
                            //   ),
                            // );
                          },
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
                                      color: celda.color,
                                      fontSize: 11,
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
