import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:system_card_rs/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart';
import 'package:system_card_rs/features/pedido_page/data/datasources/recibo_database.dart';
import 'package:system_card_rs/features/pedido_page/data/repositories/cliente_repository_sqlite.dart';
import 'package:system_card_rs/features/pedido_page/data/repositories/recibo_repository_sqlite.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/cabecalho_empresa.dart';
import 'package:system_card_rs/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/cabecalho_app.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/cabecalho_editor_dialog.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/pedido_page_layout.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/recibo_compartilhamento_dialog.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/recibo_pdf_preview_dialog.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/recibo_pedido.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/resumo_pedido.dart';
import 'package:system_card_rs/features/pedido_page/services/recibo_compartilhamento_service.dart';
import 'package:system_card_rs/features/pedido_page/services/recibo_impressao_service.dart';
import 'package:system_card_rs/features/pedido_page/services/recibo_pdf_service.dart';
import 'package:system_card_rs/observable/obx.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({
    super.key,
    this.viewModel,
    this.reciboPdfService = const ReciboPdfService(),
    this.reciboImpressaoService = const ReciboImpressaoService(),
    this.reciboCompartilhamentoService = const ReciboCompartilhamentoService(),
    this.reciboPdfPreviewBuilder,
  });

  final PedidoPageViewModel? viewModel;
  final ReciboPdfService reciboPdfService;
  final ReciboImpressaoService reciboImpressaoService;
  final ReciboCompartilhamentoService reciboCompartilhamentoService;
  final ReciboPdfPreviewContentBuilder? reciboPdfPreviewBuilder;

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  late final PedidoPageViewModel _viewModel;
  late final bool _deveDescartarViewModel;
  bool _descartado = false;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel ?? _criarViewModelPadrao();
    _deveDescartarViewModel = widget.viewModel == null;
    _prepararNumeroReciboInicial();
    if (_deveDescartarViewModel) {
      _carregarCabecalhoPersistido();
    }
  }

  @override
  void dispose() {
    _descartado = true;
    if (_deveDescartarViewModel) {
      _viewModel.dispose();
    }
    super.dispose();
  }

  Future<void> _carregarCabecalhoPersistido() async {
    final repository =
        await CabecalhoPreferenciasRepository.carregarInstancia();
    if (_descartado) {
      return;
    }

    _viewModel.configurarCabecalhoRepository(repository);
    await _viewModel.carregarCabecalho();
  }

  Future<void> _prepararNumeroReciboInicial() async {
    await _viewModel.prepararProximoNumeroRecibo(registrarErro: false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(title: const Text('Pedido')),
      body: PedidoPageLayout(
        cabecalho: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  key: const ValueKey('pedido-page-editar-cabecalho'),
                  onPressed:
                      _viewModel.carregandoCabecalho ||
                          _viewModel.salvandoCabecalho
                      ? null
                      : _abrirEditorCabecalho,
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Editar cabeçalho'),
                ),
              ),
              const SizedBox(height: 8),
              CabecalhoApp(
                cabecalho: _viewModel.cabecalhoEmpresa,
                feedback: _viewModel.feedbackCabecalho,
                onImprimir: () {
                  unawaited(_imprimirRecibo(acionadoPeloCabecalho: true));
                },
                onGerarPdf: () {
                  unawaited(_abrirPreviaPdf(acionadoPeloCabecalho: true));
                },
                onMaisOpcoes: () =>
                    _viewModel.registrarAcaoCabecalho('mais-opcoes'),
                onSelecionarMaisOpcao: _viewModel.selecionarOpcaoCabecalho,
              ),
            ],
          ),
        ),
        recibo: _PedidoPageSection(
          titulo: 'Recibo',
          child: ReciboPedido(
            viewModel: _viewModel,
            onImprimir: _imprimirRecibo,
            onCompartilharPdf: _abrirCompartilhamentoPdf,
            onGerarPdf: _abrirPreviaPdf,
          ),
        ),
        resumo: Obx(
          () => ResumoPedido(
            totalPedido: _viewModel.totalPedidoFormatado,
            valorEntrada: _viewModel.valorEntradaFormatado,
            valorAPagarEntrega: _viewModel.valorAPagarEntregaFormatado,
            mensagemValorEntrada: _viewModel.mensagemValorEntrada,
            onValorEntradaChanged: _viewModel.atualizarValorEntradaCentavos,
          ),
        ),
      ),
    );
  }

  Future<void> _abrirEditorCabecalho() async {
    await showDialog<void>(
      context: context,
      builder: (context) => Obx(
        () => CabecalhoEditorDialog(
          cabecalho: _viewModel.cabecalhoEmpresa,
          salvando: _viewModel.salvandoCabecalho,
          erro: _viewModel.erroCabecalho,
          onSalvar: _salvarCabecalhoEditado,
          onRemoverLogo: _viewModel.removerLogoCabecalho,
          onRestaurarPadrao: _viewModel.restaurarCabecalhoPadrao,
        ),
      ),
    );
  }

  Future<void> _salvarCabecalhoEditado(CabecalhoEmpresa cabecalho) async {
    _viewModel.atualizarCabecalhoEmpresa(
      nomeEmpresa: cabecalho.nomeEmpresa,
      subtitulo: cabecalho.subtitulo,
      instagram: cabecalho.instagram,
      whatsapp: cabecalho.whatsapp,
      telefone: cabecalho.telefone,
      endereco: cabecalho.endereco,
    );

    if (cabecalho.logoBase64 != null) {
      _viewModel.definirLogoCabecalhoBase64(cabecalho.logoBase64!);
    } else if (_viewModel.cabecalhoEmpresa.logoBase64 != null) {
      await _viewModel.removerLogoCabecalho();
    }

    await _viewModel.salvarCabecalho();
  }

  Future<void> _abrirPreviaPdf({bool acionadoPeloCabecalho = false}) async {
    if (_viewModel.gerandoPdf ||
        _viewModel.imprimindoPdf ||
        _viewModel.compartilhandoPdf) {
      return;
    }

    if (acionadoPeloCabecalho) {
      _viewModel.registrarAcaoCabecalho('gerar-pdf');
    }

    await _viewModel.prepararProximoNumeroRecibo();
    if (!_viewModel.validarReciboParaGeracaoPdf()) {
      return;
    }

    _viewModel.prepararGeracaoPdf();
    _viewModel.iniciarGeracaoPdf();

    late final Uint8List pdfBytes;
    try {
      pdfBytes = await widget.reciboPdfService.gerarPdfA4(
        recibo: _viewModel.reciboEmEdicao,
        cabecalho: _viewModel.cabecalhoEmpresa,
      );
      _viewModel.concluirGeracaoPdf();
    } catch (erro) {
      _viewModel.registrarErroGeracaoPdf(_mensagemErroGeracaoPdf(erro));
      return;
    }

    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => ReciboPdfPreviewDialog(
        pdfBytes: pdfBytes,
        nomeArquivo: _nomeArquivoRecibo(),
        previewBuilder: widget.reciboPdfPreviewBuilder,
      ),
    );
  }

  Future<void> _imprimirRecibo({bool acionadoPeloCabecalho = false}) async {
    if (_viewModel.gerandoPdf ||
        _viewModel.imprimindoPdf ||
        _viewModel.compartilhandoPdf) {
      return;
    }

    if (acionadoPeloCabecalho) {
      _viewModel.registrarAcaoCabecalho('imprimir');
    }

    await _viewModel.prepararProximoNumeroRecibo();
    if (!_viewModel.validarReciboParaImpressao()) {
      return;
    }

    _viewModel.prepararImpressao();
    _viewModel.iniciarImpressao(acionadoPeloCabecalho: acionadoPeloCabecalho);

    try {
      final pdfBytes = await widget.reciboPdfService.gerarPdfA4(
        recibo: _viewModel.reciboEmEdicao,
        cabecalho: _viewModel.cabecalhoEmpresa,
      );
      final impresso = await widget.reciboImpressaoService.imprimirPdf(
        pdfBytes: pdfBytes,
        nomeArquivo: _nomeArquivoRecibo(),
      );
      _viewModel.concluirImpressao(
        cancelada: !impresso,
        acionadoPeloCabecalho: acionadoPeloCabecalho,
      );
    } catch (erro) {
      _viewModel.registrarErroImpressao(
        _mensagemErroImpressao(erro),
        acionadoPeloCabecalho: acionadoPeloCabecalho,
      );
    }
  }

  Future<void> _abrirCompartilhamentoPdf() async {
    if (_viewModel.gerandoPdf ||
        _viewModel.imprimindoPdf ||
        _viewModel.compartilhandoPdf) {
      return;
    }

    await _viewModel.prepararProximoNumeroRecibo();
    if (!_viewModel.validarReciboParaCompartilhamento()) {
      return;
    }

    _viewModel.prepararCompartilhamentoPdf();
    final nomeArquivo = _nomeArquivoRecibo();
    if (!mounted) {
      return;
    }

    final opcao = await showDialog<ReciboCompartilhamentoOpcao>(
      context: context,
      builder: (dialogContext) => const ReciboCompartilhamentoDialog(),
    );

    if (opcao == null) {
      _viewModel.cancelarCompartilhamentoPdf();
      return;
    }

    if (!mounted) {
      return;
    }

    _viewModel.iniciarCompartilhamentoPdf();

    try {
      final pdfBytes = await widget.reciboPdfService.gerarPdfA4(
        recibo: _viewModel.reciboEmEdicao,
        cabecalho: _viewModel.cabecalhoEmpresa,
      );
      final resultado = await _executarCompartilhamento(
        opcao: opcao,
        pdfBytes: pdfBytes,
        nomeArquivo: nomeArquivo,
      );
      _registrarResultadoCompartilhamento(opcao, resultado);
    } catch (erro) {
      _viewModel.registrarErroCompartilhamentoPdf(
        _mensagemErroCompartilhamento(erro),
      );
    }
  }

  Future<ReciboCompartilhamentoResultado> _executarCompartilhamento({
    required ReciboCompartilhamentoOpcao opcao,
    required Uint8List pdfBytes,
    required String nomeArquivo,
  }) {
    return switch (opcao) {
      ReciboCompartilhamentoOpcao.email =>
        widget.reciboCompartilhamentoService.compartilharPorEmail(
          pdfBytes: pdfBytes,
          nomeArquivo: nomeArquivo,
        ),
      ReciboCompartilhamentoOpcao.whatsapp =>
        widget.reciboCompartilhamentoService.compartilharPorWhatsapp(
          pdfBytes: pdfBytes,
          nomeArquivo: nomeArquivo,
        ),
      ReciboCompartilhamentoOpcao.salvarArquivo =>
        widget.reciboCompartilhamentoService.salvarArquivo(
          pdfBytes: pdfBytes,
          nomeArquivo: nomeArquivo,
        ),
    };
  }

  void _registrarResultadoCompartilhamento(
    ReciboCompartilhamentoOpcao opcao,
    ReciboCompartilhamentoResultado resultado,
  ) {
    if (resultado.status == ReciboCompartilhamentoStatus.cancelado) {
      _viewModel.cancelarCompartilhamentoPdf();
      return;
    }

    if (opcao == ReciboCompartilhamentoOpcao.salvarArquivo) {
      _viewModel.concluirSalvamentoPdf();
      return;
    }

    _viewModel.concluirCompartilhamentoPdf();
  }

  String _nomeArquivoRecibo() {
    final numero = _viewModel.reciboEmEdicao.numero.trim();
    final identificador = numero.isEmpty ? 'rascunho' : numero;
    final seguro = identificador.replaceAll(RegExp(r'[^a-zA-Z0-9_-]+'), '-');
    return 'recibo-$seguro.pdf';
  }

  String _mensagemErroGeracaoPdf(Object erro) {
    final mensagem = erro.toString();
    const prefixos = ['Exception: ', 'Bad state: ', 'Invalid argument(s): '];

    for (final prefixo in prefixos) {
      if (mensagem.startsWith(prefixo)) {
        return 'Não foi possível gerar o PDF: ${mensagem.substring(prefixo.length)}';
      }
    }

    return 'Não foi possível gerar o PDF: $mensagem';
  }

  String _mensagemErroImpressao(Object erro) {
    final mensagem = erro.toString();
    const prefixos = ['Exception: ', 'Bad state: ', 'Invalid argument(s): '];

    for (final prefixo in prefixos) {
      if (mensagem.startsWith(prefixo)) {
        return 'Não foi possível imprimir o recibo: ${mensagem.substring(prefixo.length)}';
      }
    }

    return 'Não foi possível imprimir o recibo: $mensagem';
  }

  String _mensagemErroCompartilhamento(Object erro) {
    final mensagem = erro.toString();
    const prefixos = ['Exception: ', 'Bad state: ', 'Invalid argument(s): '];

    for (final prefixo in prefixos) {
      if (mensagem.startsWith(prefixo)) {
        return 'Não foi possível compartilhar o PDF: ${mensagem.substring(prefixo.length)}';
      }
    }

    return 'Não foi possível compartilhar o PDF: $mensagem';
  }
}

PedidoPageViewModel _criarViewModelPadrao() {
  final reciboDatabase = ReciboDatabase.desktop();
  return PedidoPageViewModel(
    reciboRepository: ReciboRepositorySqlite(reciboDatabase),
    clienteRepository: ClienteRepositorySqlite(reciboDatabase),
  );
}

class _PedidoPageSection extends StatelessWidget {
  const _PedidoPageSection({required this.titulo, required this.child});

  final String titulo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      container: true,
      label: titulo,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 22,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      titulo,
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
