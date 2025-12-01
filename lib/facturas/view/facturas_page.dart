import 'package:cos/resources/a_entero_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/descarga_hojas.dart';
import '../../resources/titulo.dart';
import '../model/facturas_reg.dart';


class FacturasPage extends StatefulWidget {
  final String contrato;
  const FacturasPage({
    required this.contrato,
    super.key,
  });

  @override
  State<FacturasPage> createState() => _FacturasPageState();
}

class _FacturasPageState extends State<FacturasPage> {
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
    // context.read<MainBloc>().facturasListController.obtener(
    //       widget.contrato,
    //     );
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
        if (state.facturasList == null) {
          return const Center(child: CircularProgressIndicator());
        }
        List<ToCelda> titulos = state.facturasList?.celdas ?? [];
        List<FacturasReg> valores = state.facturasList?.list ?? [];
        valores = valores
            // .where((e) => e.contrato == widget.contrato)
            .where(
              (e) => e.toList().any(
                    (e) => e.toLowerCase().contains(filter.toLowerCase()),
                  ),
            )
            .toList();
        List<FacturasReg> valoresToShow = [];
        if (valores.length > endList) {
          valoresToShow = valores.sublist(0, endList);
        } else {
          valoresToShow = valores;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("FACTURAS (Millones de pesos)"),
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
                    nombre: "Facturas ${widget.contrato}",
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
                          child: Container(
                            color: aEntero(valoresToShow[index].importebruto) < 0
                                ? Colors.red[100]
                                : null,
                            child: Row(
                              key: UniqueKey(),
                              children: [
                                // Checkbox(
                                //   value: state.cargaContratos?.list
                                //       .contains(valoresToShow[index].contrato),
                                //   onChanged: (b) async {
                                //     context
                                //         .read<MainBloc>()
                                //         .cargaContratosListController
                                //         .agregar(
                                //           valoresToShow[index].contrato,
                                //           b ?? false,
                                //         );
                                //   },
                                // ),
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
