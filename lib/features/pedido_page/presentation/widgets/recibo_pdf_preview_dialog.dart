import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

typedef ReciboPdfPreviewContentBuilder =
    Widget Function(
      BuildContext context,
      Uint8List pdfBytes,
      String nomeArquivo,
    );

class ReciboPdfPreviewDialog extends StatelessWidget {
  const ReciboPdfPreviewDialog({
    required this.pdfBytes,
    required this.nomeArquivo,
    this.previewBuilder,
    super.key,
  });

  final Uint8List pdfBytes;
  final String nomeArquivo;
  final ReciboPdfPreviewContentBuilder? previewBuilder;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final tamanho = MediaQuery.sizeOf(context);
    final largura = (tamanho.width - 64).clamp(320.0, 920.0).toDouble();
    final altura = (tamanho.height - 180).clamp(360.0, 760.0).toDouble();

    return AlertDialog(
      key: const ValueKey('recibo-pdf-preview-dialog'),
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Row(
        children: [
          Icon(Icons.picture_as_pdf_outlined, color: colorScheme.primary),
          const SizedBox(width: 10),
          const Expanded(child: Text('Prévia do PDF')),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      content: SizedBox(
        width: largura,
        height: altura,
        child:
            previewBuilder?.call(context, pdfBytes, nomeArquivo) ??
            _ReciboPdfPreviewContent(
              pdfBytes: pdfBytes,
              nomeArquivo: nomeArquivo,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}

class _ReciboPdfPreviewContent extends StatelessWidget {
  const _ReciboPdfPreviewContent({
    required this.pdfBytes,
    required this.nomeArquivo,
  });

  final Uint8List pdfBytes;
  final String nomeArquivo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRect(
      child: PdfPreview(
        key: const ValueKey('recibo-pdf-preview-content'),
        build: (_) async => pdfBytes,
        initialPageFormat: PdfPageFormat.a4,
        maxPageWidth: 620,
        allowPrinting: false,
        allowSharing: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        useActions: false,
        pdfFileName: nomeArquivo,
        scrollViewDecoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
        ),
        loadingWidget: const Center(child: CircularProgressIndicator()),
        onError: (context, error) {
          return Center(
            child: Text(
              'Não foi possível renderizar a prévia do PDF.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colorScheme.error),
            ),
          );
        },
      ),
    );
  }
}
