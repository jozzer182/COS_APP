import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AyudaPage extends StatefulWidget {
  AyudaPage({Key? key}) : super(key: key);

  @override
  State<AyudaPage> createState() => _AyudaPageState();
}

class _AyudaPageState extends State<AyudaPage> {
  Uri sharepoint = Uri.parse('https://enelcom.sharepoint.com/sites/ProjectManagementConstructionColombia/cm/SitePages/FEM.aspx');
  Uri inicioSesion = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EV3nISYP38RVmRlWEdXmDQsBhqFFvwDi5lcakqOeXPSETw?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=oAIhuR');
  Uri funcionalidadesJulio = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EX4CHUZiFQBDrs86c8n2Fe0ByWgZNzN3e7dlbz7MQYaG9A?e=fsSQhZ');
  Uri pedidoMaterial = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EV1Hubi5dZBDoexOomSrlRcBN-7DKAd8_XFYYza3RhpcHA?e=nxy2fR');
  Uri agregarMaterial = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EaGwAp-MeZRNrAUFSsGuCDoBjggeB7N2DYzyAIBeJH4UjQ?e=xhBOPw');
  Uri cambiosFichas = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EZiT0UDGuJZDkU60musO1ygB8VfDBNZ2znQxnhgJBQQTTQ?e=8aCUOi');
  Uri versionesDisponibilidad = Uri.parse('https://enelcom-my.sharepoint.com/:v:/g/personal/jose_zarabandad_enel_com/EcwZDkyWgCZQvcZpD0v9LpkBH4aMHgQWY6pWzY6vE38FmQ?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=wyodEo');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Más información'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: ()async{ await launchUrl(inicioSesion);}, child: const Text('Información General Sharepoint')),
            ElevatedButton(onPressed: ()async{ await launchUrl(inicioSesion);}, child: const Text('Inicio de sesión')),
            ElevatedButton(onPressed: ()async{ await launchUrl(funcionalidadesJulio);}, child: const Text('Funcionalidades Julio')),
            ElevatedButton(onPressed: ()async{ await launchUrl(pedidoMaterial);}, child: const Text('Pedido de material')),
            ElevatedButton(onPressed: ()async{ await launchUrl(agregarMaterial);}, child: const Text('Agregar material')),
            ElevatedButton(onPressed: ()async{ await launchUrl(cambiosFichas);}, child: const Text('Cambios en fichas')),
            ElevatedButton(onPressed: ()async{ await launchUrl(versionesDisponibilidad);}, child: const Text('Versiones y disponibilidad')),
          ],
        ),
      ),
    );
  }
}