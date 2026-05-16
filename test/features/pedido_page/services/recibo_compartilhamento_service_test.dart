import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plus/share_plus.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  test('compartilharPorEmail usa PDF em bytes e nome previsível', () async {
    final bytes = Uint8List.fromList([37, 80, 68, 70]);
    ShareParams? paramsRecebidos;
    final service = ReciboCompartilhamentoService(
      compartilharPdf: (params) async {
        paramsRecebidos = params;
        return const ShareResult('mail', ShareResultStatus.success);
      },
    );

    final resultado = await service.compartilharPorEmail(
      pdfBytes: bytes,
      nomeArquivo: 'recibo-0042.pdf',
      destinatarioEmail: 'cliente@exemplo.com',
    );

    expect(resultado.status, ReciboCompartilhamentoStatus.concluido);
    expect(
      resultado.mensagem,
      'Compartilhamento por e-mail aberto pela folha do sistema. '
      'Destinatário sugerido: cliente@exemplo.com.',
    );
    expect(paramsRecebidos, isNotNull);
    expect(paramsRecebidos!.subject, 'Recibo em PDF');
    expect(
      paramsRecebidos!.text,
      'Destinatário sugerido: cliente@exemplo.com\n\n'
      'Segue o recibo em PDF.',
    );
    expect(paramsRecebidos!.fileNameOverrides, ['recibo-0042.pdf']);
    expect(paramsRecebidos!.files, hasLength(1));
    expect(paramsRecebidos!.files!.single.mimeType, 'application/pdf');
    expect(await paramsRecebidos!.files!.single.readAsBytes(), bytes);
  });

  test('compartilharPorWhatsapp envia PDF sem texto nem assunto', () async {
    final bytes = Uint8List.fromList([37, 80, 68, 70]);
    ShareParams? paramsRecebidos;
    final service = ReciboCompartilhamentoService(
      compartilharPdf: (params) async {
        paramsRecebidos = params;
        return const ShareResult('whatsapp', ShareResultStatus.success);
      },
    );

    final resultado = await service.compartilharPorWhatsapp(
      pdfBytes: bytes,
      nomeArquivo: 'recibo-0042.pdf',
    );

    expect(resultado.status, ReciboCompartilhamentoStatus.concluido);
    expect(
      resultado.mensagem,
      'Recibo enviado para compartilhamento por WhatsApp.',
    );
    expect(paramsRecebidos, isNotNull);
    expect(paramsRecebidos!.title, 'Compartilhar recibo por WhatsApp');
    expect(paramsRecebidos!.text, isNull);
    expect(paramsRecebidos!.subject, isNull);
    expect(paramsRecebidos!.fileNameOverrides, ['recibo-0042.pdf']);
    expect(paramsRecebidos!.files, hasLength(1));
    expect(paramsRecebidos!.files!.single.mimeType, 'application/pdf');
    expect(await paramsRecebidos!.files!.single.readAsBytes(), bytes);
  });

  test('compartilharPorWhatsapp trata dismiss como cancelamento', () async {
    final service = ReciboCompartilhamentoService(
      compartilharPdf: (_) async {
        return const ShareResult('', ShareResultStatus.dismissed);
      },
    );

    final resultado = await service.compartilharPorWhatsapp(
      pdfBytes: Uint8List.fromList([1, 2, 3]),
      nomeArquivo: 'recibo-0042.pdf',
    );

    expect(resultado.cancelado, isTrue);
    expect(resultado.mensagem, 'Compartilhamento por WhatsApp cancelado.');
  });

  test('salvarArquivo grava bytes e retorna caminho escolhido', () async {
    final bytes = Uint8List.fromList([1, 2, 3, 4]);
    Uint8List? bytesRecebidos;
    String? nomeArquivoRecebido;
    final service = ReciboCompartilhamentoService(
      salvarPdf:
          ({
            required String dialogTitle,
            required String fileName,
            required FileType type,
            required List<String> allowedExtensions,
            required Uint8List bytes,
            required bool lockParentWindow,
          }) async {
            nomeArquivoRecebido = fileName;
            bytesRecebidos = bytes;
            return r'C:\recibos\recibo-0042.pdf';
          },
    );

    final resultado = await service.salvarArquivo(
      pdfBytes: bytes,
      nomeArquivo: 'recibo-0042.pdf',
    );

    expect(resultado.status, ReciboCompartilhamentoStatus.concluido);
    expect(resultado.caminho, r'C:\recibos\recibo-0042.pdf');
    expect(nomeArquivoRecebido, 'recibo-0042.pdf');
    expect(bytesRecebidos, bytes);
  });

  test('salvarArquivo trata null como cancelamento fora da web', () async {
    final service = ReciboCompartilhamentoService(
      isWeb: false,
      salvarPdf:
          ({
            required String dialogTitle,
            required String fileName,
            required FileType type,
            required List<String> allowedExtensions,
            required Uint8List bytes,
            required bool lockParentWindow,
          }) async {
            return null;
          },
    );

    final resultado = await service.salvarArquivo(
      pdfBytes: Uint8List.fromList([1]),
      nomeArquivo: 'recibo-0042.pdf',
    );

    expect(resultado.cancelado, isTrue);
    expect(resultado.mensagem, 'Salvamento cancelado.');
  });

  test('salvarArquivo trata null na web como download iniciado', () async {
    final service = ReciboCompartilhamentoService(
      isWeb: true,
      salvarPdf:
          ({
            required String dialogTitle,
            required String fileName,
            required FileType type,
            required List<String> allowedExtensions,
            required Uint8List bytes,
            required bool lockParentWindow,
          }) async {
            return null;
          },
    );

    final resultado = await service.salvarArquivo(
      pdfBytes: Uint8List.fromList([1]),
      nomeArquivo: 'recibo-0042.pdf',
    );

    expect(resultado.status, ReciboCompartilhamentoStatus.concluido);
    expect(resultado.mensagem, 'Download do recibo iniciado pelo navegador.');
  });
}
