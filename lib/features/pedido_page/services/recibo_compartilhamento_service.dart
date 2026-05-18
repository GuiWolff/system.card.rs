import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:system_card_rs/features/pedido_page/services/recibo_pdf_compartilhavel.dart';

enum ReciboCompartilhamentoStatus { concluido, cancelado }

enum ReciboCompartilhamentoCanal { email, generico }

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

typedef ReciboCriarPdfCompartilhavel =
    Future<XFile> Function({
      required Uint8List pdfBytes,
      required String nomeArquivo,
    });

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
    this.criarPdfCompartilhavel = criarReciboPdfCompartilhavel,
    this.salvarPdf = _salvarPdfPadrao,
    this.isWeb = kIsWeb,
  });

  final ReciboCompartilharPdf compartilharPdf;
  final ReciboCriarPdfCompartilhavel criarPdfCompartilhavel;
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

  Future<ReciboCompartilhamentoResultado> compartilharGenerico({
    required Uint8List pdfBytes,
    required String nomeArquivo,
    Rect? origemCompartilhamento,
  }) {
    return _compartilhar(
      canal: ReciboCompartilhamentoCanal.generico,
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
    return compartilharGenerico(
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
    final parametros = await _criarParametrosCompartilhamento(
      canal: canal,
      pdfBytes: pdfBytes,
      nomeArquivo: nomeArquivo,
      origemCompartilhamento: origemCompartilhamento,
    );
    final resultado = await compartilharPdf(parametros);

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
      ReciboCompartilhamentoCanal.generico => 'Compartilhar recibo',
    };
  }

  Future<ShareParams> _criarParametrosCompartilhamento({
    required ReciboCompartilhamentoCanal canal,
    required Uint8List pdfBytes,
    required String nomeArquivo,
    required Rect? origemCompartilhamento,
  }) async {
    final arquivoPdf = await criarPdfCompartilhavel(
      pdfBytes: pdfBytes,
      nomeArquivo: nomeArquivo,
    );

    return switch (canal) {
      ReciboCompartilhamentoCanal.email => ShareParams(
        title: _titulo(canal),
        subject: 'Recibo em PDF',
        files: [arquivoPdf],
        fileNameOverrides: [nomeArquivo],
        sharePositionOrigin: origemCompartilhamento,
        downloadFallbackEnabled: true,
        mailToFallbackEnabled: true,
      ),
      ReciboCompartilhamentoCanal.generico => ShareParams(
        title: _titulo(canal),
        files: [arquivoPdf],
        fileNameOverrides: [nomeArquivo],
        sharePositionOrigin: origemCompartilhamento,
        downloadFallbackEnabled: true,
        mailToFallbackEnabled: true,
      ),
    };
  }

  static String _mensagemCancelado(ReciboCompartilhamentoCanal canal) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email =>
        'Compartilhamento por e-mail cancelado.',
      ReciboCompartilhamentoCanal.generico => 'Compartilhamento cancelado.',
    };
  }

  static String _mensagemSucesso(
    ReciboCompartilhamentoCanal canal,
    String? email,
  ) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email => _mensagemEmailComFallback(email),
      ReciboCompartilhamentoCanal.generico =>
        'Recibo enviado para compartilhamento.',
    };
  }

  static String _mensagemIndeterminada(
    ReciboCompartilhamentoCanal canal,
    String? email,
  ) {
    return switch (canal) {
      ReciboCompartilhamentoCanal.email => _mensagemEmailComFallback(email),
      ReciboCompartilhamentoCanal.generico =>
        'Compartilhamento aberto pela folha do sistema.',
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
