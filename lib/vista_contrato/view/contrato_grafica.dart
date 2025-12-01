import 'package:cos/resources/to_mcop.dart';
import 'package:cos/vista_contrato/model/vista_contrato_reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/legend_widget.dart';
import 'contrato_grafica_barra.dart';
import 'contrato_grafica_linea.dart';

class ContratoGrafica extends StatefulWidget {
  final String contrato;
  const ContratoGrafica({
    required this.contrato,
    super.key,
  });

  @override
  State<ContratoGrafica> createState() => _ContratoGraficaState();
}

class _ContratoGraficaState extends State<ContratoGrafica> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state.vistaContratoList == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        VistaContratoReg vistaContratoReg =
            state.vistaContratoList!.list.firstWhere(
          (e) => e.contrato == widget.contrato,
        );
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardSAP(
                  number: vistaContratoReg.total,
                  title: 'Contratado',
                  color: const Color.fromRGBO(65, 185, 230, 1.0),
                ),
                const Gap(10),
                const Icon(Icons.remove),
                const Gap(10),
                cardSAP(
                  number: vistaContratoReg.consumo,
                  title: 'Consumido',
                  color: Colors.black,
                ),
                const Gap(10),
                const Icon(Icons.drag_handle),
                const Gap(10),
                cardSAP(
                  number: vistaContratoReg.restante,
                  title: 'Restante',
                  color: Colors.black,
                ),
              ],
            ),
            const Gap(10),
            Stack(
              children: [
                const Positioned(
                  top: -10, // Ajusta esta posición según sea necesario
                  left: 0,
                  right: 0,
                  child: Icon(
                    Icons.arrow_drop_up,
                    color: Colors.grey,
                    size: 30, // Ajusta el tamaño según sea necesario
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cardSAP(
                        number: vistaContratoReg.conformado,
                        title: 'Conformado',
                        color: const Color.fromRGBO(5, 85, 250, 1.0),
                      ),
                      const Gap(10),
                      cardSAP(
                        number: vistaContratoReg.vencido,
                        title: 'Vencido',
                        color: const Color.fromRGBO(255, 70, 135, 1.0),
                      ),
                      const Gap(10),
                      cardSAP(
                        number: vistaContratoReg.planificado,
                        title: 'Planificado',
                        color: const Color.fromRGBO(0, 140, 90, 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(10),
            LegendsListWidget(
              legends: [
                Legend('Contratado', const Color.fromRGBO(65, 185, 230, 1.0)),
                Legend('Conformado', const Color.fromRGBO(5, 85, 250, 1.0)),
                Legend('Vencido', const Color.fromRGBO(255, 70, 135, 1.0)),
                Legend('Planificado', const Color.fromRGBO(0, 140, 90, 1.0)),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContratoGraficaBarra(
                        valorContrato: vistaContratoReg.total,
                        conformado: vistaContratoReg.conformado,
                        vencido: vistaContratoReg.vencido,
                        planificado: vistaContratoReg.planificado,
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                if (state.lclConfList == null ||
                    state.lclConfList!.cargaCorrecta == false)
                  const SizedBox()
                else
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        ContratoGraficaLinea(
                          contrato: widget.contrato,
                          valorContrato: vistaContratoReg.total,
                          conformado: vistaContratoReg.conformado,
                          vencido: vistaContratoReg.vencido,
                          planificado: vistaContratoReg.planificado,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget cardSAP({
    required int number,
    required String title,
    required Color color,
  }) {
    // void goTo(Widget page) {
    //   Navigator.push(context, _createRoute(page));
    // }

    return SizedBox(
      width: 290,
      height: 54,
      child: InkWell(
        onTap: () {
          // goTo(Mb52Screen());
        },
        child: Card(
          color: Theme.of(context).colorScheme.onPrimary,
          elevation: 4.0,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Text(
                '$title: ${toMCOP(number, 1)} MCOP',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: color,
                      fontSize: 20,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
