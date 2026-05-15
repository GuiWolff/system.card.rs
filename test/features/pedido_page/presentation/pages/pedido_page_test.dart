import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';
import 'package:system_card_rs/features/pedido_page/presentation/widgets/pedido_page_layout.dart';

void main() {
  const logoPngBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMB/axc3V8AAAAASUVORK5CYII=';

  testWidgets('PedidoPage renderiza bloco inicial de recibo integrado', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: PedidoPage()));

    expect(find.byType(PedidoPage), findsOneWidget);
    expect(find.text('Pedido'), findsOneWidget);
    expect(find.text('SYSTEM CARD - RS'), findsWidgets);
    expect(find.text('Sistemas de Identificação'), findsWidgets);
    expect(find.text('@systemcards'), findsWidgets);
    expect(find.text('IMPRIMIR'), findsOneWidget);
    expect(find.text('GERAR PDF'), findsOneWidget);
    expect(find.text('MAIS OPÇÕES'), findsOneWidget);
    expect(
      find.text(
        'Bloco inicial real de recibo integrado à composição do pedido.',
      ),
      findsOneWidget,
    );
    expect(find.text('Recibo'), findsOneWidget);
    expect(find.text('Dados do Recibo'), findsOneWidget);
    expect(find.text('Produtos / Serviços'), findsOneWidget);
    expect(find.text('Adicionar item'), findsOneWidget);
    expect(find.text('RESUMO'), findsOneWidget);
    expect(find.text('Total do Pedido:'), findsOneWidget);
    expect(find.text('Valor Entrada:'), findsOneWidget);
    expect(find.text('Valor a pagar na Entrega:'), findsWidgets);
    expect(find.text('R\$ 0,00'), findsWidgets);
  });

  testWidgets('PedidoPage exibe número automático para recibo novo', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel(
      reciboRepository: _ReciboRepositoryFake(),
    );
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );
    await tester.pumpAndSettle();

    expect(viewModel.reciboEmEdicao.numero, '0001');
    expect(find.byKey(const ValueKey('Número do recibo-0001')), findsOneWidget);
    expect(find.text('Gerado automaticamente pelo sistema'), findsOneWidget);
  });

  testWidgets('PedidoPage exibe resumo a partir da ViewModel compartilhada', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel(
      totalPedidoCentavos: 12345,
      valorEntradaCentavos: 4500,
    );
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    expect(find.text('R\$ 123,45'), findsOneWidget);
    expect(
      find.byKey(const ValueKey(r'resumo-valor-entrada-R$ 45,00')),
      findsOneWidget,
    );
    expect(find.text('R\$ 78,45'), findsWidgets);

    viewModel.atualizarDadosDoRecibo(
      totalPedidoCentavos: 20000,
      valorEntradaCentavos: 7500,
    );
    await tester.pumpAndSettle();

    expect(find.text('R\$ 200,00'), findsOneWidget);
    expect(
      find.byKey(const ValueKey(r'resumo-valor-entrada-R$ 75,00')),
      findsOneWidget,
    );
    expect(find.text('R\$ 125,00'), findsWidgets);
  });

  testWidgets('PedidoPage conecta callbacks temporários ao estado da tela', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    await tester.tap(find.text('IMPRIMIR'));
    await tester.pumpAndSettle();

    expect(viewModel.ultimaAcaoCabecalho, 'imprimir');
    expect(viewModel.ultimaAcaoRecibo, 'imprimir-preparado');
    expect(
      find.text('Impressão preparada para integração futura.'),
      findsWidgets,
    );

    final botaoAdicionar = find.text('Adicionar item');
    await tester.ensureVisible(botaoAdicionar);
    await tester.pumpAndSettle();
    await tester.tap(botaoAdicionar);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const ValueKey('quantidade-0-1')), '2');
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('descricao-0-')),
      'Crachá PVC',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('valor-unitario-0-0')),
      '15,00',
    );
    await tester.pumpAndSettle();

    expect(viewModel.totalPedidoCentavos, 3000);
    expect(find.text('R\$ 30,00'), findsWidgets);
  });

  testWidgets('PedidoPage conecta menu do cabeçalho à ViewModel', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel(totalPedidoCentavos: 5000);
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    await tester.tap(find.byKey(const ValueKey('cabecalho-mais-opcoes-menu')));
    await tester.pumpAndSettle();

    expect(viewModel.ultimaAcaoCabecalho, 'mais-opcoes');
    expect(
      find.widgetWithText(PopupMenuItem<CabecalhoMenuOpcao>, 'Novo recibo'),
      findsOneWidget,
    );

    await tester.tap(
      find.widgetWithText(PopupMenuItem<CabecalhoMenuOpcao>, 'Novo recibo'),
    );
    await tester.pumpAndSettle();

    expect(viewModel.ultimaAcaoCabecalho, 'mais-opcoes-novo-recibo');
    expect(viewModel.totalPedidoCentavos, 0);
    expect(find.text('Novo recibo iniciado.'), findsOneWidget);
  });

  testWidgets('PedidoPage edita e salva dados do cabeçalho pelo dialog', (
    WidgetTester tester,
  ) async {
    final repository = _CabecalhoRepositoryFake();
    final viewModel = PedidoPageViewModel(cabecalhoRepository: repository);
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    await tester.tap(
      find.byKey(const ValueKey('pedido-page-editar-cabecalho')),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-nome')),
      'Empresa Editada',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-subtitulo')),
      'Novo subtítulo',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-instagram')),
      '@empresaeditada',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-whatsapp')),
      '51 99999-0000',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-telefone')),
      '51 3333-2222',
    );
    await tester.enterText(
      find.byKey(const ValueKey('cabecalho-editor-endereco')),
      'Rua Atualizada, 100',
    );
    await tester.tap(find.byKey(const ValueKey('cabecalho-editor-salvar')));
    await tester.pumpAndSettle();

    expect(viewModel.cabecalhoEmpresa.nomeEmpresa, 'Empresa Editada');
    expect(repository.cabecalhoSalvo?.instagram, '@empresaeditada');
    expect(find.text('Empresa Editada'), findsOneWidget);
    expect(find.text('Rua Atualizada, 100'), findsOneWidget);
  });

  testWidgets('PedidoPage remove logo e preserva fallback do cabeçalho', (
    WidgetTester tester,
  ) async {
    final repository = _CabecalhoRepositoryFake(
      cabecalho: const CabecalhoEmpresa.systemCardRs().copyWith(
        logoBase64: logoPngBase64,
      ),
    );
    final viewModel = PedidoPageViewModel(cabecalhoRepository: repository);
    addTearDown(viewModel.dispose);
    await viewModel.carregarCabecalho();

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    expect(find.byType(Image), findsWidgets);

    await tester.tap(
      find.byKey(const ValueKey('pedido-page-editar-cabecalho')),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey('cabecalho-editor-remover-logo')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(viewModel.cabecalhoEmpresa.logoBase64, isNull);
    expect(repository.cabecalhoSalvo?.logoBase64, isNull);
    expect(find.text('SC'), findsWidgets);
  });

  testWidgets('PedidoPage abre editor do cabeçalho em largura estreita', (
    WidgetTester tester,
  ) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    tester.view.physicalSize = const Size(390, 700);
    tester.view.devicePixelRatio = 1;

    final viewModel = PedidoPageViewModel(
      cabecalhoRepository: _CabecalhoRepositoryFake(),
    );
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    await tester.tap(
      find.byKey(const ValueKey('pedido-page-editar-cabecalho')),
    );
    await tester.pumpAndSettle();

    expect(find.text('Editar cabeçalho'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('PedidoPage salva, lista e carrega recibo pelo histórico', (
    WidgetTester tester,
  ) async {
    final repository = _ReciboRepositoryFake();
    final viewModel = PedidoPageViewModel(reciboRepository: repository);
    addTearDown(viewModel.dispose);

    viewModel.atualizarNumero('0008');
    viewModel.atualizarCliente('Carla Souza');
    viewModel.atualizarTelefone('51988887777');
    viewModel.adicionarItem(
      const ItemRecibo(
        quantidade: 2,
        descricao: 'Cartão PVC',
        valorUnitarioCentavos: 2500,
      ),
    );
    viewModel.atualizarValorEntradaCentavos(1000);

    await tester.pumpWidget(
      MaterialApp(home: PedidoPage(viewModel: viewModel)),
    );

    final botaoSalvar = find.text('Salvar');
    await tester.ensureVisible(botaoSalvar);
    await tester.pumpAndSettle();
    await tester.tap(botaoSalvar);
    await tester.pumpAndSettle();

    expect(viewModel.reciboAtualSalvo, isTrue);
    expect(repository.salvos.single.numero, '0008');
    expect(find.text('Recibo salvo.'), findsOneWidget);

    viewModel.atualizarCliente('Rascunho local');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Histórico'));
    await tester.pumpAndSettle();

    expect(find.text('Histórico de recibos'), findsOneWidget);
    expect(find.text('Recibo 0008'), findsOneWidget);
    expect(find.text('Carla Souza'), findsOneWidget);

    await tester.tap(find.text('Carregar'));
    await tester.pumpAndSettle();

    expect(viewModel.reciboEmEdicao.cliente, 'Carla Souza');
    expect(viewModel.totalPedidoCentavos, 5000);
    expect(find.text('R\$ 40,00'), findsWidgets);
  });

  testWidgets('PedidoPageLayout mantém ordem visual dos blocos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PedidoPageLayout(
            cabecalho: _BlocoTeste(texto: 'Cabeçalho'),
            recibo: _BlocoTeste(texto: 'Recibo'),
            resumo: _BlocoTeste(texto: 'Resumo'),
          ),
        ),
      ),
    );

    final cabecalhoTop = tester.getTopLeft(find.text('Cabeçalho')).dy;
    final reciboTop = tester.getTopLeft(find.text('Recibo')).dy;
    final resumoTop = tester.getTopLeft(find.text('Resumo')).dy;

    expect(cabecalhoTop, lessThan(reciboTop));
    expect(reciboTop, lessThan(resumoTop));
  });

  testWidgets(
    'PedidoPageLayout não gera overflow em larguras representativas',
    (WidgetTester tester) async {
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      const tamanhos = [
        Size(390, 700),
        Size(768, 700),
        Size(1024, 700),
        Size(1366, 768),
      ];

      for (final tamanho in tamanhos) {
        await _pumpPedidoPageEmTamanho(tester, tamanho);
        expect(tester.takeException(), isNull);
      }
    },
  );
}

Future<void> _pumpPedidoPageEmTamanho(WidgetTester tester, Size tamanho) async {
  tester.view.physicalSize = tamanho;
  tester.view.devicePixelRatio = 1;

  await tester.pumpWidget(const MaterialApp(home: PedidoPage()));
}

class _BlocoTeste extends StatelessWidget {
  const _BlocoTeste({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Align(alignment: Alignment.topLeft, child: Text(texto)),
    );
  }
}

class _ReciboRepositoryFake implements ReciboRepository {
  final List<Recibo> salvos = <Recibo>[];
  int _proximoId = 1;

  @override
  Future<String> proximoNumero() async {
    var maiorNumero = 0;
    for (final recibo in salvos) {
      final numero = int.tryParse(recibo.numero);
      if (numero != null && numero > maiorNumero) {
        maiorNumero = numero;
      }
    }

    return (maiorNumero + 1).toString().padLeft(4, '0');
  }

  @override
  Future<Recibo> salvar(Recibo recibo) async {
    final agora = DateTime(2026, 5, 15, 10, _proximoId);
    final numero = recibo.numero.trim().isEmpty
        ? await proximoNumero()
        : recibo.numero;
    final salvo = Recibo(
      id: _proximoId++,
      numero: numero,
      cliente: recibo.cliente,
      telefone: recibo.telefone,
      observacoes: recibo.observacoes,
      dataRecebimento: recibo.dataRecebimento,
      dataEntrega: recibo.dataEntrega,
      valorEntradaCentavos: recibo.valorEntradaCentavos,
      itens: recibo.itens,
      criadoEm: agora,
      atualizadoEm: agora,
    );
    salvos.add(salvo);
    return salvo;
  }

  @override
  Future<Recibo> atualizar(Recibo recibo) async {
    final indice = salvos.indexWhere((salvo) => salvo.id == recibo.id);
    if (indice == -1) {
      throw StateError('Recibo não encontrado.');
    }

    final atualizado = Recibo(
      id: recibo.id,
      numero: recibo.numero,
      cliente: recibo.cliente,
      telefone: recibo.telefone,
      observacoes: recibo.observacoes,
      dataRecebimento: recibo.dataRecebimento,
      dataEntrega: recibo.dataEntrega,
      valorEntradaCentavos: recibo.valorEntradaCentavos,
      itens: recibo.itens,
      criadoEm: salvos[indice].criadoEm,
      atualizadoEm: DateTime(2026, 5, 15, 11, recibo.id!),
    );
    salvos[indice] = atualizado;
    return atualizado;
  }

  @override
  Future<Recibo?> buscarPorId(int id) async {
    for (final recibo in salvos) {
      if (recibo.id == id) {
        return recibo;
      }
    }

    return null;
  }

  @override
  Future<List<Recibo>> listarHistorico() async {
    return List<Recibo>.unmodifiable(salvos);
  }

  @override
  Future<List<Recibo>> pesquisarHistorico(String termo) async {
    final termoNormalizado = termo.toLowerCase();
    return salvos
        .where(
          (recibo) =>
              recibo.numero.toLowerCase().contains(termoNormalizado) ||
              recibo.cliente.toLowerCase().contains(termoNormalizado) ||
              recibo.telefone.toLowerCase().contains(termoNormalizado),
        )
        .toList(growable: false);
  }

  @override
  Future<void> excluir(int id) async {
    salvos.removeWhere((recibo) => recibo.id == id);
  }
}

class _CabecalhoRepositoryFake implements CabecalhoPreferenciasRepository {
  _CabecalhoRepositoryFake({
    CabecalhoEmpresa cabecalho = const CabecalhoEmpresa.systemCardRs(),
  }) : _cabecalho = cabecalho;

  CabecalhoEmpresa _cabecalho;
  CabecalhoEmpresa? cabecalhoSalvo;

  @override
  CabecalhoEmpresa carregar() => _cabecalho;

  @override
  Future<void> salvar(CabecalhoEmpresa cabecalho) async {
    _cabecalho = cabecalho;
    cabecalhoSalvo = cabecalho;
  }

  @override
  Future<CabecalhoEmpresa> removerLogo() async {
    _cabecalho = _cabecalho.copyWith(
      removerLogoAssetPath: true,
      removerLogoBase64: true,
    );
    cabecalhoSalvo = _cabecalho;
    return _cabecalho;
  }

  @override
  Future<CabecalhoEmpresa> restaurarPadrao() async {
    _cabecalho = const CabecalhoEmpresa.systemCardRs();
    cabecalhoSalvo = _cabecalho;
    return _cabecalho;
  }
}
