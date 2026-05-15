import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

enum ReciboCompartilhamentoStatus { concluido, cancelado }

enum ReciboCompartilhamentoCanal { email, whatsapp }

class ReciboCompartilhamentoResultado {
  const ReciboCompartilhamentoResultado({
    required this.status,
    required this.mensagem,
    this.caminho,
  });

  final ReciboCompartilhamentoStatus status;
  final String mensagem;
  final String? caminho;

  bool get cancelado => status == ReciboCompartilhamentoStatus.cancelado;
}

typedef ReciboCompartilharPdf =
    Future<ShareResult> Function(ShareParams params);

typedef ReciboSalvarPdf =
    Future<String?> Function({
      required String dialogTitle,
      required String fileName,
      required FileType type,
      required List<String> allowedExtensions,
      required Uint8List bytes,
      required bool lockParentWindow,
    });

class ReciboCompartilhamentoService {
  const ReciboCompartilhamentoService({
    this.compartilharPdf = _compartilharPdfPadrao,
    this.salvarPdf = _salvarPdfPadrao,
    this.isWeb = kIsWeb,
  });

  final ReciboCompartilharPdf compartilharPdf;
  final ReciboSalvarPdf salvarPdf;
  final bool isWeb;

  Future<ReciboCompartilhamentoResultado> compartilharPorEmail({
    required Uint8List pdfBytes,
    required String nomeArquivo,
    Rect? origemCompartilhamento,
  }) {
    return _compartilhar(
      canal: ReciboCompartilhamentoCanal.email,
      pdfBytes: pdfBytes,
      nomeArquivo: nomeArquivo,
      origemCompartilhamento: origemCompartilhamento,
    );
  }

  Future<ReciboCompartilhamentoResultado> compartilharPorWhatsapp({
    required Uint8List pdfBytes,
    required String nomeArquivo,
    Rect? origemCompartilhamento,
  }) {
    return _compartilhar(
      canal: ReciboCompartilhamentoCanal.whatsapp,
      pdfBytes: pdfBytes,
      nomeArquivo: nomeArquivo,
      origemCompartilhamento: origemCompartilhamento,
    );
  }

  Future<ReciboCompartilhamentoResultado> salvarArquivo({
    required Uint8List pdfBytes,
    required String nomeArquivo,
  }) async {
    final caminho = await salvarPdf(
      dialogTitle: 'Salvar recibo em PDF',
      fileName: nomeArquivo,
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
      bytes: pdfBytes,
      lockParentWindow: true,
    );

    if (caminho == null) {
      if (isWeb) {
        return const ReciboCompartilhamentoResultado(
          status: ReciboCompartilhamentoStatus.concluido,
          mensagem: 'Download do recibo iniciado pelo navegador.',
        );
      }

      return const ReciboCompartilhamentoResultado(
        status: ReciboCompartilhamentoStatus.cancelado,
        mensagem: 'Salvamento cancelado.',
      );
    }

    return ReciboCompartilhamentoResultado(
      status: ReciboCompartilhamentoStatus.concluido,
      mensagem: 'Recibo salvo em $caminho.',
      caminho: caminho,
    );
  }

  Future<ReciboCompartilhamentoResultado> _compartilhar({
    required ReciboCompartilhamentoCanal canal,
    required Uint8List pdfBytes,
    required String nomeArquivo,
    Rect? origemCompartilhamento,
  }) async {
    final resultado = await compartilharPdf(
      ShareParams(
        title: _titulo(canal),
        subject: 'Recibo em PDF',
        text: _texto(canal),
        files: [
          XFile.fromData(
            pdfBytes,
            name: nomeArquivo,
            mimeType: 'application/pdf',
          ),
        ],
        fileNameOverrides: [nomeArquivo],
        sharePositionOrigin: origemCompartilhamento,
        downloadFallbackEnabled: true,
        mailToFallbackEnabled: true,
      ),
    );

    return switch (resultado.status) {
      ShareResultStatus.dismissed => ReciboCompartilhamentoResultado(
        status: ReciboCompartilhamentoStatus.cancelado,
        mensagem: _mensagemCancelado(canal),
      ),
      ShareResultStatus.success => ReciboCompartilhamentoResultado(
        status: ReciboCompartilhamentoStatus.concluido,
        mensagem: _mensagemSucesso(canal),
      ),
      ShareResultStatus.unavailable => ReciboCompartilhamentoResultado(
        status: ReciboCompartilhamentoStatus.concluido,
        mensagem: _mensagemIndeterminada(canal),
      ),
    };
  }

  static String _titulo(ReciboCompartilhamentoCanal canal) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email => 'Compartilhar recibo por e-mail',
      ReciboCompartilhamentoCanal.whatsapp =>
        'Compartilhar recibo por WhatsApp',
    };
  }

  static String _texto(ReciboCompartilhamentoCanal canal) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email => 'Segue o recibo em PDF.',
      ReciboCompartilhamentoCanal.whatsapp => 'Recibo em PDF.',
    };
  }

  static String _mensagemCancelado(ReciboCompartilhamentoCanal canal) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email =>
        'Compartilhamento por e-mail cancelado.',
      ReciboCompartilhamentoCanal.whatsapp =>
        'Compartilhamento por WhatsApp cancelado.',
    };
  }

  static String _mensagemSucesso(ReciboCompartilhamentoCanal canal) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email =>
        'Recibo enviado para compartilhamento por e-mail.',
      ReciboCompartilhamentoCanal.whatsapp =>
        'Recibo enviado para compartilhamento por WhatsApp.',
    };
  }

  static String _mensagemIndeterminada(ReciboCompartilhamentoCanal canal) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email =>
        'Compartilhamento por e-mail aberto pela folha do sistema.',
      ReciboCompartilhamentoCanal.whatsapp =>
        'Compartilhamento por WhatsApp aberto pela folha do sistema.',
    };
  }
}

Future<ShareResult> _compartilharPdfPadrao(ShareParams params) {
  return SharePlus.instance.share(params);
}

Future<String?> _salvarPdfPadrao({
  required String dialogTitle,
  required String fileName,
  required FileType type,
  required List<String> allowedExtensions,
  required Uint8List bytes,
  required bool lockParentWindow,
}) {
  return FilePicker.saveFile(
    dialogTitle: dialogTitle,
    fileName: fileName,
    type: type,
    allowedExtensions: allowedExtensions,
    bytes: bytes,
    lockParentWindow: lockParentWindow,
  );
}
