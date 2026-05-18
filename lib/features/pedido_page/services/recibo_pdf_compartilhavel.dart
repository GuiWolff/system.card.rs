import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';
import 'package:system_card_rs/features/pedido_page/services/recibo_pdf_compartilhavel_web.dart'
    if (dart.library.io) 'package:system_card_rs/features/pedido_page/services/recibo_pdf_compartilhavel_io.dart'
    as recibo_pdf_compartilhavel;

Future<XFile> criarReciboPdfCompartilhavel({
  required Uint8List pdfBytes,
  required String nomeArquivo,
}) {
  return recibo_pdf_compartilhavel.criarReciboPdfCompartilhavel(
    pdfBytes: pdfBytes,
    nomeArquivo: nomeArquivo,
  );
}
