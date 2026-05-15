import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ReciboImpressaoService {
  const ReciboImpressaoService();

  Future<bool> imprimirPdf({
    required Uint8List pdfBytes,
    required String nomeArquivo,
  }) {
    return Printing.layoutPdf(
      name: nomeArquivo,
      format: PdfPageFormat.a4,
      dynamicLayout: false,
      onLayout: (_) async => pdfBytes,
    );
  }
}
