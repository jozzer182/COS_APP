import 'package:cos/vista_info/model/vista_info_reg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/main_bloc.dart';

/// Un componente para mostrar información de forma más elegante que un TextFormField
class InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final int flex;
  final bool isNumber;

  const InfoItem({
    required this.label,
    required this.value,
    this.flex = 1,
    this.isNumber = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            SelectableText(
              isNumber && value != "" && value != "null"
                  ? _formatNumber(value)
                  : value == "null"
                      ? "—"
                      : value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              toolbarOptions: const ToolbarOptions(
                copy: true,
                selectAll: true,
                cut: false,
                paste: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(String value) {
    try {
      final double? number = double.tryParse(value);
      if (number == null) return value;

      return number.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},');
    } catch (_) {
      return value;
    }
  }
}

class VistaInfoPage extends StatefulWidget {
  final String contrato;
  const VistaInfoPage({
    required this.contrato,
    super.key,
  });

  @override
  State<VistaInfoPage> createState() => _VistaInfoPageState();
}

class _VistaInfoPageState extends State<VistaInfoPage> {
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
    context.read<MainBloc>().vistaInfoController.calcular(widget.contrato);
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
        if (state.vistaInfo == null) {
          return const Center(child: CircularProgressIndicator());
        }
        VistaInfo data = state.vistaInfo!;
        return Scaffold(
          appBar: AppBar(
            title: const Text("INFORMACIÓN"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.contrato,
                      label: 'Contrato',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 3,
                      value: data.objetosintetico,
                      label: 'Objeto',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.proveedor.toString(),
                      label: 'Proveedor',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 3,
                      value: data.nombreproveedor.toString(),
                      label: 'Nombre Proveedor',
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.fechadocumento.toString().substring(0, 10),
                      label: 'Fecha Documento',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.fechainicio.toString().substring(0, 10),
                      label: 'Fecha Inicio',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.fechafin.toString().substring(0, 10),
                      label: 'Fecha Fin',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.zzdataprot.toString().substring(0, 10),
                      label: 'ZZ Data Prot',
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.fechaperfeccionamiento
                          .toString()
                          .substring(0, 10),
                      label: 'Fecha Perfeccionamiento',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.actualizado.toString().substring(0, 10),
                      label: 'Actualizado',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.fechacreado.toString().substring(0, 10),
                      label: 'Fecha Creado',
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.valorprevisto.toString(),
                      label: 'Valor Previsto',
                      isNumber: true,
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.importebase.toString(),
                      label: 'Importe Base',
                      isNumber: true,
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.grupo,
                      label: 'Grupo',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.moneda,
                      label: 'Moneda',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.tipocambio,
                      label: 'Tipo Cambio',
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.categoria,
                      label: 'Categoria',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.catcontrato,
                      label: 'Cat Contrato',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.opcionporcentaje,
                      label: 'Opción Porcentaje',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.toleranciaporcentaje,
                      label: 'Tolerancia Porcentaje',
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.emisorfactura,
                      label: 'Emisor Factura',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.tiposuministro,
                      label: 'Tipo Suministro',
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.riesgo,
                      label: 'Riesgo',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.usuario,
                      label: 'Usuario',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.grupoarticulos,
                      label: 'Grupo Articulos',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.subcontratacion,
                      label: 'Subcontratacion',
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.subcontratacionporcentaje,
                      label: 'Subcontratacion Porcentaje',
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.nit,
                      label: 'Nit',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.nit2,
                      label: 'Nit2',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.telefono,
                      label: 'Telefono',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.recpago,
                      label: 'Recpago',
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    InfoItem(
                      flex: 1,
                      value: data.cuisupplier,
                      label: 'Cuisupplier',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.claseimpuesto,
                      label: 'Clase Impuesto',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.clase,
                      label: 'Clase',
                    ),
                    const Gap(10),
                    InfoItem(
                      flex: 1,
                      value: data.organizacion,
                      label: 'Organizacion',
                    ),
                  ],
                ),
                const Gap(10),
              ],
            ),
          ),
        );
      },
    );
  }
}
