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
    String? destinatarioEmail,
    Rect? origemCompartilhamento,
  }) {
    return _compartilhar(
      canal: ReciboCompartilhamentoCanal.email,
      pdfBytes: pdfBytes,
      nomeArquivo: nomeArquivo,
      destinatarioEmail: destinatarioEmail,
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
    String? destinatarioEmail,
    Rect? origemCompartilhamento,
  }) async {
    final emailNormalizado = destinatarioEmail?.trim();
    final resultado = await compartilharPdf(
      _criarParametrosCompartilhamento(
        canal: canal,
        pdfBytes: pdfBytes,
        nomeArquivo: nomeArquivo,
        emailNormalizado: emailNormalizado,
        origemCompartilhamento: origemCompartilhamento,
      ),
    );

    return switch (resultado.status) {
      ShareResultStatus.dismissed => ReciboCompartilhamentoResultado(
        status: ReciboCompartilhamentoStatus.cancelado,
        mensagem: _mensagemCancelado(canal),
      ),
      ShareResultStatus.success => ReciboCompartilhamentoResultado(
        status: ReciboCompartilhamentoStatus.concluido,
        mensagem: _mensagemSucesso(canal, emailNormalizado),
      ),
      ShareResultStatus.unavailable => ReciboCompartilhamentoResultado(
        status: ReciboCompartilhamentoStatus.concluido,
        mensagem: _mensagemIndeterminada(canal, emailNormalizado),
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

  static ShareParams _criarParametrosCompartilhamento({
    required ReciboCompartilhamentoCanal canal,
    required Uint8List pdfBytes,
    required String nomeArquivo,
    required String? emailNormalizado,
    required Rect? origemCompartilhamento,
  }) {
    final arquivoPdf = XFile.fromData(
      pdfBytes,
      name: nomeArquivo,
      mimeType: 'application/pdf',
    );

    return switch (canal) {
      ReciboCompartilhamentoCanal.email => ShareParams(
        title: _titulo(canal),
        subject: 'Recibo em PDF',
        text: _textoEmail(emailNormalizado),
        files: [arquivoPdf],
        fileNameOverrides: [nomeArquivo],
        sharePositionOrigin: origemCompartilhamento,
        downloadFallbackEnabled: true,
        mailToFallbackEnabled: true,
      ),
      ReciboCompartilhamentoCanal.whatsapp => ShareParams(
        title: _titulo(canal),
        files: [arquivoPdf],
        fileNameOverrides: [nomeArquivo],
        sharePositionOrigin: origemCompartilhamento,
        downloadFallbackEnabled: true,
        mailToFallbackEnabled: true,
      ),
    };
  }

  static String _textoEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Segue o recibo em PDF.';
    }

    return 'Destinatário sugerido: $email\n\nSegue o recibo em PDF.';
  }

  static String _mensagemCancelado(ReciboCompartilhamentoCanal canal) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email =>
        'Compartilhamento por e-mail cancelado.',
      ReciboCompartilhamentoCanal.whatsapp =>
        'Compartilhamento por WhatsApp cancelado.',
    };
  }

  static String _mensagemSucesso(
    ReciboCompartilhamentoCanal canal,
    String? email,
  ) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email => _mensagemEmailComFallback(email),
      ReciboCompartilhamentoCanal.whatsapp =>
        'Recibo enviado para compartilhamento por WhatsApp.',
    };
  }

  static String _mensagemIndeterminada(
    ReciboCompartilhamentoCanal canal,
    String? email,
  ) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email => _mensagemEmailComFallback(email),
      ReciboCompartilhamentoCanal.whatsapp =>
        'Compartilhamento por WhatsApp aberto pela folha do sistema.',
    };
  }

  static String _mensagemEmailComFallback(String? email) {
    if (email == null || email.isEmpty) {
      return 'Compartilhamento por e-mail aberto pela folha do sistema.';
    }

    return 'Compartilhamento por e-mail aberto pela folha do sistema. '
        'Destinatário sugerido: $email.';
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
