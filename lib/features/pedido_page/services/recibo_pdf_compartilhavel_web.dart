import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

Future<XFile> criarReciboPdfCompartilhavel({
  required Uint8List pdfBytes,
  required String nomeArquivo,
}) async {
  return XFile.fromData(
    pdfBytes,
    name: nomeArquivo,
    mimeType: 'application/pdf',
  );
}
