import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  testWidgets('ReciboPedido edita dados do recibo na PedidoPageViewModel', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    viewModel.atualizarNumero('0007');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReciboPedido(viewModel: viewModel),
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('Número do recibo-0007')), findsOneWidget);
    expect(find.text('Gerado automaticamente pelo sistema'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('Cliente-')), 'Ana Lima');
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('Telefone-')),
      '51999990000',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('Valor de entrada-0,00')),
      '10,00',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('Observações-')),
      'Entregar no balcão.',
    );
    await tester.pumpAndSettle();

    expect(viewModel.reciboEmEdicao.numero, '0007');
    expect(viewModel.reciboEmEdicao.cliente, 'Ana Lima');
    expect(viewModel.reciboEmEdicao.telefone, '51999990000');
    expect(viewModel.valorEntradaCentavos, 1000);
    expect(viewModel.reciboEmEdicao.observacoes, 'Entregar no balcão.');
  });

  testWidgets('ReciboPedido adiciona, edita e remove produtos ou serviços', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReciboPedido(viewModel: viewModel),
          ),
        ),
      ),
    );

    expect(find.text('Nenhum produto/serviço adicionado.'), findsOneWidget);

    await tester.tap(find.text('Adicionar item'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const ValueKey('quantidade-0-1')), '3');
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('descricao-0-')),
      'Cordão personalizado',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('valor-unitario-0-0')),
      '12,50',
    );
    await tester.pumpAndSettle();

    expect(viewModel.itens, hasLength(1));
    expect(viewModel.itens.single.quantidade, 3);
    expect(viewModel.itens.single.descricao, 'Cordão personalizado');
    expect(viewModel.itens.single.valorUnitarioCentavos, 1250);
    expect(viewModel.totalPedidoCentavos, 3750);
    expect(find.text('37,50'), findsWidgets);

    final botaoRemover = find.byTooltip('Remover item');
    await tester.ensureVisible(botaoRemover);
    await tester.pumpAndSettle();
    await tester.tap(botaoRemover);
    await tester.pumpAndSettle();

    expect(viewModel.itens, isEmpty);
    expect(viewModel.totalPedidoCentavos, 0);
    expect(find.text('Nenhum produto/serviço adicionado.'), findsOneWidget);
  });

  testWidgets('ReciboPedido seleciona cliente cadastrado pelo painel', (
    WidgetTester tester,
  ) async {
    final repository = _ClienteRepositoryFake();
    await repository.salvar(
      Cliente(nome: 'Ana Pereira', telefone: '51911111111'),
    );
    final viewModel = PedidoPageViewModel(clienteRepository: repository);
    addTearDown(viewModel.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReciboPedido(viewModel: viewModel),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const ValueKey('recibo-abrir-clientes')));
    await tester.pumpAndSettle();

    expect(find.text('Clientes'), findsWidgets);
    expect(find.text('Ana Pereira'), findsOneWidget);
    expect(find.text('(51) 9 1111-1111'), findsOneWidget);

    await tester.tap(find.text('Selecionar'));
    await tester.pumpAndSettle();

    expect(viewModel.reciboEmEdicao.cliente, 'Ana Pereira');
    expect(viewModel.reciboEmEdicao.telefone, '51911111111');
    expect(find.text('(51) 9 1111-1111'), findsWidgets);
  });

  testWidgets('ReciboPedido aciona callback de Gerar PDF', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    var chamadas = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReciboPedido(
              viewModel: viewModel,
              onGerarPdf: () async {
                chamadas++;
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Gerar PDF'));
    await tester.pumpAndSettle();

    expect(chamadas, 1);
  });

  testWidgets('ReciboPedido aciona callback de Compartilhar', (
    WidgetTester tester,
  ) async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);
    var chamadas = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReciboPedido(
              viewModel: viewModel,
              onCompartilharPdf: () async {
                chamadas++;
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Compartilhar'));
    await tester.pumpAndSettle();

    expect(chamadas, 1);
  });
}

class _ClienteRepositoryFake implements ClienteRepository {
  final List<Cliente> salvos = <Cliente>[];
  int _proximoId = 1;

  @override
  Future<Cliente> salvar(Cliente cliente) async {
    final salvo = cliente.copyWith(id: _proximoId++);
    salvos.add(salvo);
    return salvo;
  }

  @override
  Future<Cliente> atualizar(Cliente cliente) async => cliente;

  @override
  Future<Cliente?> buscarPorId(int id) async {
    for (final cliente in salvos) {
      if (cliente.id == id) {
        return cliente;
      }
    }

    return null;
  }

  @override
  Future<List<Cliente>> listar() async {
    return List<Cliente>.unmodifiable(salvos);
  }

  @override
  Future<List<Cliente>> pesquisar(String termo) async {
    final termoNome = termo.toLowerCase();
    final termoTelefone = Cliente.normalizarTelefone(termo);
    return salvos
        .where(
          (cliente) =>
              cliente.nome.toLowerCase().contains(termoNome) ||
              cliente.telefone.contains(termoTelefone),
        )
        .toList(growable: false);
  }

  @override
  Future<void> excluir(int id) async {}
}
