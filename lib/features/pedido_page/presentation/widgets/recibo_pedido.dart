import 'package:flutter/material.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/item_recibo.dart';
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final recibo = viewModel.reciboEmEdicao;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ReciboAcoes(
            viewModel: viewModel,
            onImprimir: onImprimir,
            onCompartilharPdf: onCompartilharPdf,
            onGerarPdf: onGerarPdf,
          ),
          const SizedBox(height: 24),
          ReciboFormulario(
            recibo: recibo,
            valorEntradaFormatado: viewModel.valorEntradaFormatado,
            onNumeroChanged: viewModel.atualizarNumero,
            onDataRecebimentoChanged: viewModel.atualizarDataRecebimento,
            onDataEntregaChanged: viewModel.atualizarDataEntrega,
            onClienteChanged: viewModel.atualizarCliente,
            onTelefoneChanged: viewModel.atualizarTelefone,
            onValorEntradaChanged: viewModel.atualizarValorEntradaCentavos,
            onObservacoesChanged: viewModel.atualizarObservacoes,
          ),
          const SizedBox(height: 24),
          ProdutosServicosTabela(
            itens: recibo.itens,
            onAdicionarItem: () {
              viewModel.adicionarItem(
                const ItemRecibo(
                  quantidade: 1,
                  descricao: '',
                  valorUnitarioCentavos: 0,
                ),
              );
            },
            onAtualizarItem: viewModel.atualizarItem,
            onRemoverItem: viewModel.removerItem,
          ),
          const SizedBox(height: 24),
          Text(
            'Visualização do Recibo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          VisualizacaoRecibo(recibo: recibo),
        ],
      );
    });
  }
}

class _ReciboAcoes extends StatelessWidget {
  const _ReciboAcoes({
    required this.viewModel,
    required this.onImprimir,
    required this.onCompartilharPdf,
    required this.onGerarPdf,
  });

  final PedidoPageViewModel viewModel;
  final Future<void> Function()? onImprimir;
  final Future<void> Function()? onCompartilharPdf;
  final Future<void> Function()? onGerarPdf;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final erro = viewModel.erro;
      final ultimaAcao = viewModel.ultimaAcaoRecibo;
      final colorScheme = Theme.of(context).colorScheme;
      final textTheme = Theme.of(context).textTheme;

      return DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ações do recibo',
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: viewModel.salvando
                        ? null
                        : () async => viewModel.salvarRecibo(),
                    icon: const Icon(Icons.save),
                    label: Text(viewModel.salvando ? 'Salvando...' : 'Salvar'),
                  ),
                  OutlinedButton.icon(
                    onPressed: viewModel.iniciarNovoRecibo,
                    icon: const Icon(Icons.note_add),
                    label: const Text('Novo recibo'),
                  ),
                  OutlinedButton.icon(
                    onPressed: viewModel.carregando
                        ? null
                        : () => _abrirHistorico(context),
                    icon: const Icon(Icons.history),
                    label: const Text('Histórico'),
                  ),
                  OutlinedButton.icon(
                    key: const ValueKey('recibo-abrir-clientes'),
                    onPressed: viewModel.carregandoClientes
                        ? null
                        : () => _abrirClientes(context),
                    icon: const Icon(Icons.people_alt_outlined),
                    label: const Text('Clientes'),
                  ),
                  OutlinedButton.icon(
                    onPressed:
                        viewModel.imprimindoPdf ||
                            viewModel.gerandoPdf ||
                            viewModel.compartilhandoPdf
                        ? null
                        : _imprimir,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.secondary,
                      side: BorderSide(color: colorScheme.secondary),
                    ),
                    icon: const Icon(Icons.print),
                    label: Text(
                      viewModel.imprimindoPdf ? 'Imprimindo...' : 'Imprimir',
                    ),
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
                    icon: const Icon(Icons.picture_as_pdf),
                    label: Text(
                      viewModel.gerandoPdf ? 'Gerando PDF...' : 'Gerar PDF',
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed:
                        viewModel.compartilhandoPdf ||
                            viewModel.gerandoPdf ||
                            viewModel.imprimindoPdf
                        ? null
                        : _compartilhar,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.secondary,
                      side: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    icon: const Icon(Icons.share_outlined),
                    label: Text(
                      viewModel.compartilhandoPdf
                          ? 'Compartilhando...'
                          : 'Compartilhar',
                    ),
                  ),
                ],
              ),
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
                const Text('Geração de PDF preparada para integração futura.'),
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
                const Text('Compartilhamento iniciado.'),
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
      );
    });
  }

  Future<void> _imprimir() async {
    final imprimir = onImprimir;
    if (imprimir == null) {
      viewModel.prepararImpressao();
      return;
    }

    await imprimir();
  }

  Future<void> _compartilhar() async {
    final compartilhar = onCompartilharPdf;
    if (compartilhar == null) {
      viewModel.prepararCompartilhamentoPdf();
      return;
    }

    await compartilhar();
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
