import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<XFile> criarReciboPdfCompartilhavel({
  required Uint8List pdfBytes,
  required String nomeArquivo,
}) async {
  final temporario = await getTemporaryDirectory();
  final diretorio = Directory(
    path.join(
      temporario.path,
      'recibos_compartilhados',
      DateTime.now().microsecondsSinceEpoch.toString(),
    ),
  );
  await diretorio.create(recursive: true);

  final arquivo = File(path.join(diretorio.path, nomeArquivo));
  await arquivo.writeAsBytes(pdfBytes, flush: true);

  return XFile(
    arquivo.path,
    name: nomeArquivo,
    mimeType: 'application/pdf',
    length: pdfBytes.length,
  );
}
