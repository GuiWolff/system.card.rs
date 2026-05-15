import 'package:flutter/material.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'System Card - RS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xfff7900a)),
      ),
      home: const PedidoPage(),
    );
  }
}
