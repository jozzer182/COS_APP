import 'package:cos/resources/to_mcop.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:statistics/statistics.dart';

import '../../resources/app_utils.dart';

class ContratoGraficaBarra extends StatefulWidget {
  final int valorContrato;
  final int conformado;
  final int vencido;
  final int planificado;

  const ContratoGraficaBarra({
    required this.valorContrato,
    required this.conformado,
    required this.vencido,
    required this.planificado,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ContratoGraficaBarraState();
}

class ContratoGraficaBarraState extends State<ContratoGraficaBarra> {
  static const double barWidth = 100;
  static const shadowOpacity = 0.2;
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

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget topTitles(double value, TitleMeta meta) {
    // const style = TextStyle(color: Colors.black, fontSize: 10);
    // String text;
    // switch (value.toInt()) {
    //   case 0:
    //     text = '';
    //     break;
    //   default:
    //     return Container();
    // }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(''),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    String text;
    if (value == 0) {
      text = '';
    } else {
      text = '';
    }
    return SideTitleWidget(
      angle: AppUtils().degreeToRadian(value < 0 ? -45 : 45),
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget rightTitles(double value, TitleMeta meta) {
    String text;
    if (value == 0) {
      text = '0';
    } else {
      value = value * max / 20;
      // value = value.ceil()
      text = '${toMCOP(value.ceil(), 1)} MCOP';
    }
    return SideTitleWidget(
      // angle: AppUtils().degreeToRadian(90),
      axisSide: meta.axisSide,
      space: 0,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 9,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  BarChartGroupData generateGroup(
    int x,
    double value1,
    double value2,
    double value3,
    // double value4,
  ) {
    final isTop = value1 > 0;
    final sum = value1 + value2 + value3;
    final isTouched = touchedIndex == x;
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: isTouched ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: sum,
          width: barWidth,
          borderRadius: isTop
              ? const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                )
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
          rodStackItems: [
            BarChartRodStackItem(
              0,
              value1,
              const Color.fromRGBO(5, 85, 250, 1.0),
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
            BarChartRodStackItem(
              value1,
              value1 + value2,
              const Color.fromRGBO(255, 70, 135, 1.0),
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
            BarChartRodStackItem(
              value1 + value2,
              value1 + value2 + value3,
              const Color.fromRGBO(0, 140, 90, 1.0),
              BorderSide(
                color: Colors.white,
                width: isTouched ? 2 : 0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool isShadowBar(int rodIndex) => rodIndex == 1;

  @override
  Widget build(BuildContext context) {
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
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            maxY: 20,
            minY: 0,
            groupsSpace: 12,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                fitInsideVertically: true,
                tooltipBgColor: Colors.white,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '',
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Contratado:\n${toMCOP(widget.valorContrato, 1)} MCOP\n',
                        style: const TextStyle(
                          color: Color.fromRGBO(65, 185, 230, 1.0),
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Planificado:\n${toMCOP(widget.planificado, 1)} MCOP\n',
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 140, 90, 1.0),
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: 'Vencido:\n${toMCOP(widget.vencido, 1)} MCOP\n',
                        style: const TextStyle(
                          color: Color.fromRGBO(255, 70, 135, 1.0),
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Conformado:\n${toMCOP(widget.conformado, 1)} MCOP\n',
                        style: const TextStyle(
                          color: Color.fromRGBO(5, 85, 250, 1.0),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                },
              ),
              handleBuiltInTouches: false,
              touchCallback: (FlTouchEvent event, barTouchResponse) {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  setState(() {
                    touchedIndex = -1;
                  });
                  return;
                }
                final rodIndex = barTouchResponse.spot!.touchedRodDataIndex;
                if (isShadowBar(rodIndex)) {
                  setState(() {
                    touchedIndex = -1;
                  });
                  return;
                }
                setState(() {
                  touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                });
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                axisNameWidget: Text(
                  'Usado: ${(usadopercent * 100).toStringAsFixed(1)} %,  Conformado: ${(conformadopercent * 100).toStringAsFixed(1)} %',
                ),
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 0,
                  getTitlesWidget: topTitles,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: bottomTitles,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: leftTitles,
                  interval: 5,
                  reservedSize: 42,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: rightTitles,
                  interval: 5,
                  reservedSize: 62,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              // checkToShowVerticalLine: (value) => value % 5 == 0,
              verticalInterval: valorContatoNomalizado,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: const Color.fromRGBO(65, 185, 230, 1.0),
                  // dashArray: [1, 2],
                );
              },
              // checkToShowHorizontalLine: (value) => value % 5 == 0,
              horizontalInterval: valorContatoNomalizado,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: const Color.fromRGBO(65, 185, 230, 1.0),
                );
              },
            ),
            borderData: FlBorderData(
              show: true,
            ),
            barGroups: mainItems.entries
                .map(
                  (e) => generateGroup(
                    e.key,
                    e.value[0],
                    e.value[1],
                    e.value[2],
                    // e.value[3],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
