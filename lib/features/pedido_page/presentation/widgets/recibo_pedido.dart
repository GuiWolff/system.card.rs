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
  const ReciboPedido({required this.viewModel, super.key});

  final PedidoPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final recibo = viewModel.reciboEmEdicao;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ReciboAcoes(viewModel: viewModel),
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
  const _ReciboAcoes({required this.viewModel});

  final PedidoPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final erro = viewModel.erro;
      final ultimaAcao = viewModel.ultimaAcaoRecibo;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                onPressed: viewModel.prepararImpressao,
                icon: const Icon(Icons.print),
                label: const Text('Imprimir'),
              ),
              OutlinedButton.icon(
                onPressed: viewModel.prepararGeracaoPdf,
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('Gerar PDF'),
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
          if (ultimaAcao == 'pdf-preparado') ...[
            const SizedBox(height: 8),
            const Text('Geração de PDF preparada para integração futura.'),
          ],
          if (erro != null) ...[
            const SizedBox(height: 8),
            Text(
              erro,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ],
        ],
      );
    });
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
