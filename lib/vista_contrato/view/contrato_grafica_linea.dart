import 'package:cos/conformidades/model/lcl_conf_reg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistics/statistics.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/app_utils.dart';
import '../../resources/to_mcop.dart';

class ContratoGraficaLinea extends StatefulWidget {
  final String contrato;
  final int valorContrato;
  final int conformado;
  final int vencido;
  final int planificado;
  const ContratoGraficaLinea({
    required this.contrato,
    required this.valorContrato,
    required this.conformado,
    required this.vencido,
    required this.planificado,
    super.key,
  });

  @override
  State<ContratoGraficaLinea> createState() => _ContratoGraficaLineaState();
}

class _ContratoGraficaLineaState extends State<ContratoGraficaLinea> {
  var mainItems = <int, List<double>>{
    0: [
      2,
      3,
      2.5,
      // 8,
    ],
  };
  int touchedIndex = -1;
  double valorContatoNomalizado = 0;
  double max = 0;
  double usadopercent = 0;
  double conformadopercent = 0;
  double promedioConformado = 0;

  @override
  void initState() {
    mainItems.clear();
    max = [
      widget.valorContrato.toDouble(),
      widget.conformado.toDouble(),
      widget.vencido.toDouble(),
      widget.planificado.toDouble(),
    ].statistics.max;
    max += max * 0.1;
    double factor = 20 / max;
    valorContatoNomalizado = widget.valorContrato.toDouble() * factor;
    // print('valorContatoNomalizado: $valorContatoNomalizado');
    usadopercent = (widget.conformado + widget.planificado + widget.vencido) /
        widget.valorContrato.toDouble();
    conformadopercent =
        widget.conformado.toDouble() / widget.valorContrato.toDouble();
    mainItems[0] = [
      widget.conformado.toDouble() * factor,
      widget.vencido.toDouble() * factor,
      widget.planificado.toDouble() * factor,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if (state.lclConfList == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        Map<String, Map<String, int>> sumByMonth = {};
        List<ConformidadesReg> conformidades = state.lclConfList!.list
            .where((e) => e.contrato == widget.contrato)
            .toList();

        // Ordenar las conformidades por fecha (de la más antigua a la más reciente)
        conformidades.sort((a, b) => a.fecha.compareTo(b.fecha));

        for (ConformidadesReg reg in conformidades) {
          int importe = reg.importe;
          // LclPosReg pos =
          //     state.lclPosList!.list.firstWhere((e) => e.lcl == reg.lcl);
          // num iva = 1;
          // if (pos.indicadorimpuesto != "WC" && pos.indicadorimpuesto != "WD") {
          //   iva = 1.19;
          // }
          // importe = importe ~/ iva;
          // Obtener el mes y el año en formato 'YYYY-MM'
          String monthKey =
              '${reg.fecha.year}-${reg.fecha.month.toString().padLeft(2, '0')}';

          // Sumar los importes por mes
          if (sumByMonth.containsKey(monthKey)) {
            // sumByMonth[monthKey] = sumByMonth[monthKey]! + reg.importe;
            sumByMonth[monthKey]!['total'] =
                sumByMonth[monthKey]!['total']! + importe;
          } else {
            sumByMonth[monthKey] = {'total': importe, 'acumulado': 0};
          }
        }
        // Variable para llevar el total acumulado
        int totalAcumulado = 0;

        // Listar las claves (meses) en orden
        var sortedKeys = sumByMonth.keys.toList()..sort();
        // Actualizar el acumulado en el Map
        for (var month in sortedKeys) {
          totalAcumulado += sumByMonth[month]!['total']!; // Sumar al acumulado
          sumByMonth[month]!['acumulado'] =
              totalAcumulado; // Guardar el acumulado en el Map
        }
        // print('sumByMonth: $sumByMonth');

        if (sumByMonth.isNotEmpty) {
          promedioConformado = sumByMonth.values
              .map((e) => e['total']!.toDouble())
              .toList()
              .mean;
        }
        return Container(
          height: 400,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LineChart(
              LineChartData(
                  maxY: 20,
                  minY: 0,
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: valorContatoNomalizado,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: Color.fromRGBO(65, 185, 230, 1.0),
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      axisNameWidget: Text(
                          'Promedio Conformado: ${toMCOP(promedioConformado.toInt(), 1)} MCOP - MES '),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 0,
                        interval: 1,
                        getTitlesWidget: (value, meta) => SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 0,
                          child: Text(''),
                        ),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        getTitlesWidget: (value, meta) => SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 0,
                          child: Text(''),
                        ),
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        reservedSize: 62,
                        getTitlesWidget: (value, meta) => SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 0,
                          child: Text(
                            '${toMCOP((value * max / 20).toInt(), 1)} MCOP',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 32,
                        showTitles: true,
                        getTitlesWidget: (value, a) {
                          return SideTitleWidget(
                            axisSide: a.axisSide,
                            angle: AppUtils().degreeToRadian(90),
                            space: 0,
                            child: Text(
                              sumByMonth.isEmpty
                                  ? ''
                                  : sumByMonth.keys
                                      .elementAt(value.toInt())
                                      .substring(2),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      dotData: FlDotData(show: false),
                      color: const Color.fromRGBO(5, 85, 250, 1.0),
                      isStepLineChart: true,
                      spots: sumByMonth.isEmpty
                          ? [
                              FlSpot(0, 0),
                              FlSpot(1, 0),
                            ]
                          : sumByMonth.entries
                              .map((e) => FlSpot(
                                    sumByMonth.keys
                                        .toList()
                                        .indexOf(e.key)
                                        .toDouble(),
                                    e.value['acumulado']!.toDouble() * 20 / max,
                                  ))
                              .toList(),
                    ),
                  ],
                  rangeAnnotations: RangeAnnotations(
                    horizontalRangeAnnotations: [
                      HorizontalRangeAnnotation(
                        y1: mainItems[0]![0],
                        y2: mainItems[0]![0] + mainItems[0]![1],
                        color: const Color.fromRGBO(255, 70, 135, 1.0)
                            .withOpacity(0.3),
                      ),
                      HorizontalRangeAnnotation(
                        y1: mainItems[0]![0] + mainItems[0]![1],
                        y2: mainItems[0]![0] +
                            mainItems[0]![1] +
                            mainItems[0]![2],
                        color: const Color.fromRGBO(0, 140, 90, 1.0)
                            .withOpacity(0.3),
                      ),
                    ],
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((LineBarSpot touchedSpot) {
                          final TextStyle textStyle = TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          );
                          return LineTooltipItem(
                            sumByMonth.isEmpty
                                ? ''
                                : '${sumByMonth.keys.elementAt(touchedSpot.x.toInt())}\n${toMCOP(sumByMonth[sumByMonth.keys.elementAt(touchedSpot.x.toInt())]!['acumulado']!, 1)} MCOP',
                            textStyle,
                          );
                        }).toList();
                      },
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}
