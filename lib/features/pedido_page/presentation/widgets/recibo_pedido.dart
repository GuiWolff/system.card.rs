import 'package:flutter/material.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/recibo.dart';
import 'package:system_card_rs/features/pedido_page/presentation/viewmodels/pedido_page_view_model.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/clientes_painel.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/historico_recibos_painel.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/produtos_servicos_tabela.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/recibo_formulario.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/visualizacao_recibo.dart';
import 'package:system_card_rs/observable/obx.dart';

class ReciboPedido extends StatelessWidget {
  const ReciboPedido({
    required this.viewModel,
    this.onImprimir,
    this.onCompartilharPdf,
    this.onGerarPdf,
    super.key,
  });

  final PedidoPageViewModel viewModel;
  final Future<void> Function()? onImprimir;
  final Future<void> Function()? onCompartilharPdf;
  final Future<void> Function()? onGerarPdf;

  static const double _larguraMinimaLayoutLateral = 840;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final recibo = viewModel.reciboEmEdicao;
      final somenteLeitura = viewModel.reciboSomenteLeitura;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ReciboAcoes(viewModel: viewModel, onGerarPdf: onGerarPdf),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final layoutLateral =
                  constraints.maxWidth >= _larguraMinimaLayoutLateral;
              final formulario = ReciboFormulario(
                recibo: recibo,
                valorEntradaFormatado: viewModel.valorEntradaFormatado,
                somenteLeitura: somenteLeitura,
                onNumeroChanged: viewModel.atualizarNumero,
                onDataRecebimentoChanged: viewModel.atualizarDataRecebimento,
                onDataEntregaChanged: viewModel.atualizarDataEntrega,
                onClienteChanged: viewModel.atualizarCliente,
                onPesquisarCliente: viewModel.pesquisarClientes,
                onClienteSelecionado: viewModel.selecionarCliente,
                clientesSugeridos: viewModel.clientes,
                carregandoClientes: viewModel.carregandoClientes,
                onTelefoneChanged: viewModel.atualizarTelefone,
                onValorEntradaChanged: viewModel.atualizarValorEntradaCentavos,
                onObservacoesChanged: viewModel.atualizarObservacoes,
              );
              final visualizacao = _ReciboVisualizacaoSecao(recibo: recibo);

              if (!layoutLateral) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    formulario,
                    const SizedBox(height: 16),
                    visualizacao,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 11, child: formulario),
                  /*const SizedBox(width: 16),
                  Expanded(flex: 9, child: visualizacao),*/
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          ProdutosServicosTabela(
            itens: recibo.itens,
            onAdicionarItem: () => viewModel.solicitarNovoItem(),
            onAdicionarItemPeloValorUnitario: (indice) =>
                viewModel.solicitarNovoItem(indiceReferencia: indice),
            onAtualizarItem: viewModel.atualizarItem,
            onRemoverItem: viewModel.removerItem,
            somenteLeitura: somenteLeitura,
          ),
        ],
      );
    });
  }
}

class _ReciboVisualizacaoSecao extends StatelessWidget {
  const _ReciboVisualizacaoSecao({required this.recibo});

  final Recibo recibo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.preview_outlined,
                  size: 18,
                  color: colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Visualização do Recibo',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            VisualizacaoRecibo(recibo: recibo),
          ],
        ),
      ),
    );
  }
}

class _ReciboAcoes extends StatelessWidget {
  const _ReciboAcoes({required this.viewModel, required this.onGerarPdf});

  final PedidoPageViewModel viewModel;
  final Future<void> Function()? onGerarPdf;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final erro = viewModel.erro;
      final ultimaAcao = viewModel.ultimaAcaoRecibo;
      final feedbackCompartilhamento = viewModel.feedbackCompartilhamentoPdf;
      final somenteLeitura = viewModel.reciboSomenteLeitura;
      final colorScheme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;

      return SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 18,
                      color: colorScheme.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Ações do recibo',
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    if (somenteLeitura)
                      Icon(
                        Icons.lock_outline,
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: viewModel.salvando || somenteLeitura
                          ? null
                          : () async => viewModel.salvarRecibo(),
                      icon: const Icon(Icons.save_outlined),
                      label: Text(
                        viewModel.salvando ? 'Salvando...' : 'Salvar',
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: viewModel.iniciarNovoRecibo,
                      icon: const Icon(Icons.note_add_outlined),
                      label: const Text('Novo recibo'),
                    ),
                    OutlinedButton.icon(
                      onPressed: viewModel.carregando
                          ? null
                          : () => _abrirHistorico(context),
                      icon: const Icon(Icons.history_outlined),
                      label: const Text('Histórico'),
                    ),
                    OutlinedButton.icon(
                      key: const ValueKey('recibo-abrir-clientes'),
                      onPressed: viewModel.carregandoClientes
                          ? null
                          : () => _abrirClientes(context),
                      icon: const Icon(Icons.groups_outlined),
                      label: const Text('Clientes'),
                    ),
                    OutlinedButton.icon(
                      onPressed:
                          viewModel.gerandoPdf ||
                              viewModel.imprimindoPdf ||
                              viewModel.compartilhandoPdf
                          ? null
                          : _gerarPdf,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.tertiary,
                        side: BorderSide(color: colorScheme.tertiary),
                      ),
                      icon: const Icon(Icons.picture_as_pdf_outlined),
                      label: Text(
                        viewModel.gerandoPdf ? 'Gerando PDF...' : 'Gerar PDF',
                      ),
                    ),
                  ],
                ),
                if (somenteLeitura) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Recibo carregado do histórico em modo somente leitura. '
                    'Use Duplicar no histórico para editar uma cópia.',
                  ),
                ],
                if (viewModel.reciboAtualSalvo) ...[
                  const SizedBox(height: 8),
                  const Text('Recibo salvo.'),
                ],
                if (ultimaAcao == 'imprimir-preparado') ...[
                  const SizedBox(height: 8),
                  const Text('Impressão preparada para integração futura.'),
                ],
                if (ultimaAcao == 'impressao-em-andamento') ...[
                  const SizedBox(height: 8),
                  const Text('Preparando impressão...'),
                ],
                if (ultimaAcao == 'impressao-concluida') ...[
                  const SizedBox(height: 8),
                  const Text('Recibo enviado para impressão.'),
                ],
                if (ultimaAcao == 'impressao-cancelada') ...[
                  const SizedBox(height: 8),
                  const Text('Impressão cancelada.'),
                ],
                if (ultimaAcao == 'pdf-preparado') ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Geração de PDF preparada para integração futura.',
                  ),
                ],
                if (ultimaAcao == 'pdf-gerado') ...[
                  const SizedBox(height: 8),
                  const Text('PDF gerado para visualização.'),
                ],
                if (ultimaAcao == 'compartilhamento-preparado') ...[
                  const SizedBox(height: 8),
                  const Text('Escolha como compartilhar o PDF.'),
                ],
                if (ultimaAcao == 'compartilhando-pdf') ...[
                  const SizedBox(height: 8),
                  const Text('Preparando compartilhamento...'),
                ],
                if (ultimaAcao == 'pdf-compartilhado') ...[
                  const SizedBox(height: 8),
                  Text(
                    feedbackCompartilhamento ?? 'Compartilhamento iniciado.',
                  ),
                ],
                if (ultimaAcao == 'pdf-salvo') ...[
                  const SizedBox(height: 8),
                  const Text('PDF salvo.'),
                ],
                if (ultimaAcao == 'compartilhamento-cancelado') ...[
                  const SizedBox(height: 8),
                  const Text('Compartilhamento cancelado.'),
                ],
                if (erro != null) ...[
                  const SizedBox(height: 8),
                  Text(erro, style: TextStyle(color: colorScheme.error)),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _gerarPdf() async {
    final gerarPdf = onGerarPdf;
    if (gerarPdf == null) {
      viewModel.prepararGeracaoPdf();
      return;
    }

    await gerarPdf();
  }

  Future<void> _abrirHistorico(BuildContext context) async {
    await viewModel.listarHistorico();
    if (!context.mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final tamanho = MediaQuery.sizeOf(dialogContext);

        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          child: SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 980,
                maxHeight: (tamanho.height - 32).clamp(320, 720),
              ),
              child: Obx(() {
                return HistoricoRecibosPainel(
                  historico: viewModel.historico,
                  carregando: viewModel.carregando,
                  onPesquisar: viewModel.pesquisarHistorico,
                  onCarregar: (recibo) async {
                    final id = recibo.id;
                    if (id == null) {
                      return;
                    }

                    await viewModel.carregarRecibo(id);
                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext).pop();
                    }
                  },
                  onDuplicar: (recibo) async {
                    final id = recibo.id;
                    if (id == null) {
                      return;
                    }

                    await viewModel.duplicarRecibo(id);
                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext).pop();
                    }
                  },
                  onExcluir: (recibo) =>
                      _confirmarExclusao(dialogContext, recibo),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Future<void> _abrirClientes(BuildContext context) async {
    await viewModel.listarClientes();
    if (!context.mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final tamanho = MediaQuery.sizeOf(dialogContext);

        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          child: SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 820,
                maxHeight: (tamanho.height - 32).clamp(360, 680),
              ),
              child: Obx(() {
                return ClientesPainel(
                  clientes: viewModel.clientes,
                  carregando: viewModel.carregandoClientes,
                  salvando: viewModel.salvandoCliente,
                  erro: viewModel.erroClientes,
                  feedback: viewModel.feedbackClientes,
                  onPesquisar: viewModel.pesquisarClientes,
                  onCadastrar: viewModel.salvarCliente,
                  onSelecionar: (cliente) {
                    viewModel.selecionarCliente(cliente);
                    Navigator.of(dialogContext).pop();
                  },
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmarExclusao(BuildContext context, Recibo recibo) async {
    final id = recibo.id;
    if (id == null) {
      return;
    }

    final confirmado = await showDialog<bool>(
      context: context,
      builder: (confirmacaoContext) {
        return AlertDialog(
          title: const Text('Excluir recibo'),
          content: Text('Deseja excluir o recibo ${recibo.numero}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(confirmacaoContext).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(confirmacaoContext).pop(true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmado == true) {
      await viewModel.excluirRecibo(id);
    }
  }
}
