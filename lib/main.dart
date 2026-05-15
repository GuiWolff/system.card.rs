import 'package:flutter/material.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';
import 'package:system_card_rs/utils/tema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'System Card - RS',
      theme: TemaApp.temaClaro(),
      darkTheme: TemaApp.temaEscuro(),
      themeMode: ThemeMode.light,
      home: const PedidoPage(),
    );
  }
}
