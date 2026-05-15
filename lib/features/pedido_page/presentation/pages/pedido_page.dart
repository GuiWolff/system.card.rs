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
import 'package:system_card_rs/features/pedido_page/presentation/widgets/recibo_pedido.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/resumo_pedido.dart';
import 'package:system_card_rs/observable/obx.dart';

class PedidoPage extends StatefulWidget {
  const PedidoPage({super.key, this.viewModel});

  final PedidoPageViewModel? viewModel;

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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
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
                onImprimir: _viewModel.solicitarImpressaoCabecalho,
                onGerarPdf: _viewModel.solicitarGeracaoPdfCabecalho,
                onMaisOpcoes: () =>
                    _viewModel.registrarAcaoCabecalho('mais-opcoes'),
                onSelecionarMaisOpcao: _viewModel.selecionarOpcaoCabecalho,
              ),
            ],
          ),
        ),
        recibo: _PedidoPagePlaceholderSection(
          title: 'Recibo',
          description:
              'Bloco inicial real de recibo integrado à composição do pedido.',
          titleStyle: textTheme.titleLarge,
          child: ReciboPedido(viewModel: _viewModel),
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
}

PedidoPageViewModel _criarViewModelPadrao() {
  final reciboDatabase = ReciboDatabase.desktop();
  return PedidoPageViewModel(
    reciboRepository: ReciboRepositorySqlite(reciboDatabase),
    clienteRepository: ClienteRepositorySqlite(reciboDatabase),
  );
}

class _PedidoPagePlaceholderSection extends StatelessWidget {
  const _PedidoPagePlaceholderSection({
    required this.title,
    required this.description,
    required this.titleStyle,
    this.child,
  });

  final String title;
  final String description;
  final TextStyle? titleStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      container: true,
      label: title,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleStyle),
              const SizedBox(height: 8),
              Text(description, style: textTheme.bodyMedium),
              if (child != null) ...[const SizedBox(height: 16), child!],
            ],
          ),
        ),
      ),
    );
  }
}
