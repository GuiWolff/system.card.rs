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

    expect(
      find.byKey(const ValueKey('recibo-formulario-numero')),
      findsOneWidget,
    );
    expect(find.text('Gerado automaticamente pelo sistema'), findsOneWidget);
    expect(_findIcon(Icons.tag_outlined), findsOneWidget);
    expect(_findIcon(Icons.calendar_month_outlined), findsOneWidget);
    expect(_findIcon(Icons.event_available_outlined), findsOneWidget);
    expect(_findIcon(Icons.person_outline), findsOneWidget);
    expect(_findIcon(Icons.call_outlined), findsWidgets);
    expect(_findIcon(Icons.payments_outlined), findsOneWidget);
    expect(_findIcon(Icons.notes_outlined), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('recibo-formulario-cliente')),
      'Ana Lima',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('recibo-formulario-telefone')),
      '51999990000',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('recibo-formulario-valor-entrada')),
      '235',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('recibo-formulario-observacoes')),
      'Entregar no balcão.',
    );
    await tester.pumpAndSettle();

    expect(viewModel.reciboEmEdicao.numero, '0007');
    expect(viewModel.reciboEmEdicao.cliente, 'Ana Lima');
    expect(viewModel.reciboEmEdicao.telefone, '51999990000');
    expect(viewModel.valorEntradaCentavos, 235);
    expect(
      _textoDoCampo(
        tester,
        find.byKey(const ValueKey('recibo-formulario-valor-entrada')),
      ),
      '2,35',
    );
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
    expect(_findIcon(Icons.add), findsOneWidget);

    final botaoAdicionar = find.text('Adicionar item');
    await tester.ensureVisible(botaoAdicionar);
    await tester.pumpAndSettle();
    await tester.tap(botaoAdicionar);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('produto-quantidade-0')),
      '3',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('produto-descricao-0')),
      'Cordão personalizado',
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('produto-valor-unitario-0')),
      '235',
    );
    await tester.pumpAndSettle();

    expect(viewModel.itens, hasLength(1));
    expect(viewModel.itens.single.quantidade, 3);
    expect(viewModel.itens.single.descricao, 'Cordão personalizado');
    expect(viewModel.itens.single.valorUnitarioCentavos, 235);
    expect(viewModel.totalPedidoCentavos, 705);
    expect(
      _textoDoCampo(
        tester,
        find.byKey(const ValueKey('produto-valor-unitario-0')),
      ),
      '2,35',
    );
    expect(find.text('7,05'), findsWidgets);

    final botaoRemover = find.byTooltip('Remover item');
    await tester.ensureVisible(botaoRemover);
    await tester.pumpAndSettle();
    expect(_findIcon(Icons.delete_outline), findsOneWidget);
    await tester.tap(botaoRemover);
    await tester.pumpAndSettle();

    expect(viewModel.itens, isEmpty);
    expect(viewModel.totalPedidoCentavos, 0);
    expect(find.text('Nenhum produto/serviço adicionado.'), findsOneWidget);
  });

  testWidgets('ReciboPedido mantém foco dos campos do formulário ao digitar', (
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

    final campoCliente = find.byKey(
      const ValueKey('recibo-formulario-cliente'),
    );
    await tester.tap(campoCliente);
    await tester.enterText(campoCliente, 'Ana');
    await tester.pumpAndSettle();

    expect(viewModel.reciboEmEdicao.cliente, 'Ana');
    expect(tester.testTextInput.hasAnyClients, isTrue);
    expect(_campoTemFoco(tester, campoCliente), isTrue);
  });

  testWidgets('ReciboPedido mantém foco dos campos da tabela ao digitar', (
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

    final botaoAdicionar = find.text('Adicionar item');
    await tester.ensureVisible(botaoAdicionar);
    await tester.pumpAndSettle();
    await tester.tap(botaoAdicionar);
    await tester.pumpAndSettle();

    final campoValorUnitario = find.byKey(
      const ValueKey('produto-valor-unitario-0'),
    );
    await tester.tap(campoValorUnitario);
    await tester.enterText(campoValorUnitario, '8,00');
    await tester.pumpAndSettle();

    expect(viewModel.itens.single.valorUnitarioCentavos, 800);
    expect(tester.testTextInput.hasAnyClients, isTrue);
    expect(_campoTemFoco(tester, campoValorUnitario), isTrue);
  });

  testWidgets(
    'ReciboPedido adiciona item ao pressionar Enter no valor unitário',
    (WidgetTester tester) async {
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

      final botaoAdicionar = find.text('Adicionar item');
      await tester.ensureVisible(botaoAdicionar);
      await tester.pumpAndSettle();
      await tester.tap(botaoAdicionar);
      await tester.pumpAndSettle();

      final campoValorUnitario = find.byKey(
        const ValueKey('produto-valor-unitario-0'),
      );
      await tester.tap(campoValorUnitario);
      await tester.enterText(campoValorUnitario, '18,00');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(viewModel.itens, hasLength(2));
      expect(viewModel.itens.first.valorUnitarioCentavos, 1800);
      expect(
        find.byKey(const ValueKey('produto-valor-unitario-1')),
        findsOneWidget,
      );
    },
  );

  testWidgets('ReciboPedido bloqueia novo item por Enter com valor zero', (
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

    final botaoAdicionar = find.text('Adicionar item');
    await tester.ensureVisible(botaoAdicionar);
    await tester.pumpAndSettle();
    await tester.tap(botaoAdicionar);
    await tester.pumpAndSettle();

    final campoValorUnitario = find.byKey(
      const ValueKey('produto-valor-unitario-0'),
    );
    await tester.tap(campoValorUnitario);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(viewModel.itens, hasLength(1));
    expect(
      find.text(
        'Informe um valor unitário maior que zero antes de adicionar outro item.',
      ),
      findsOneWidget,
    );
    expect(_campoTemFoco(tester, campoValorUnitario), isTrue);
  });

  testWidgets('ReciboPedido reflete recibo carregado em modo somente leitura', (
    WidgetTester tester,
  ) async {
    final repository = _ReciboRepositoryFake();
    final salvo = await repository.salvar(
      Recibo(
        numero: '0500',
        cliente: 'Cliente Histórico',
        dataRecebimento: DateTime(2026, 5, 15),
        dataEntrega: DateTime(2026, 5, 20),
        itens: const [
          ItemRecibo(
            quantidade: 1,
            descricao: 'Crachá PVC',
            valorUnitarioCentavos: 1500,
          ),
        ],
      ),
    );
    final viewModel = PedidoPageViewModel(reciboRepository: repository);
    addTearDown(viewModel.dispose);
    await viewModel.carregarRecibo(salvo.id!);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReciboPedido(viewModel: viewModel),
          ),
        ),
      ),
    );

    expect(
      find.text(
        'Recibo carregado do histórico em modo somente leitura. '
        'Use Duplicar no histórico para editar uma cópia.',
      ),
      findsOneWidget,
    );
    expect(
      tester
          .widget<TextFormField>(
            find.byKey(const ValueKey('recibo-formulario-cliente')),
          )
          .enabled,
      isFalse,
    );
    expect(
      tester
          .widget<TextFormField>(
            find.byKey(const ValueKey('produto-valor-unitario-0')),
          )
          .enabled,
      isFalse,
    );
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Salvar'))
          .onPressed,
      isNull,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Adicionar item'),
          )
          .onPressed,
      isNull,
    );
  });

  testWidgets(
    'ReciboPedido alinha formulário e visualização em largura ampla',
    (WidgetTester tester) async {
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      tester.view.physicalSize = const Size(880, 900);
      tester.view.devicePixelRatio = 1;

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

      final dadosRect = tester.getRect(find.text('Dados do Recibo'));
      final visualizacaoRect = tester.getRect(
        find.text('Visualização do Recibo'),
      );

      expect((dadosRect.top - visualizacaoRect.top).abs(), lessThan(1));
      expect(visualizacaoRect.left, greaterThan(dadosRect.left));
    },
  );

  testWidgets('ReciboPedido mantém visualização abaixo em largura compacta', (
    WidgetTester tester,
  ) async {
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    tester.view.physicalSize = const Size(390, 900);
    tester.view.devicePixelRatio = 1;

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

    final dadosRect = tester.getRect(find.text('Dados do Recibo'));
    final visualizacaoRect = tester.getRect(
      find.text('Visualização do Recibo'),
    );

    expect(visualizacaoRect.top, greaterThan(dadosRect.bottom));
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'ReciboPedido mantém campos da tabela alinhados em largura ampla',
    (WidgetTester tester) async {
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      tester.view.physicalSize = const Size(1000, 900);
      tester.view.devicePixelRatio = 1;

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

      final botaoAdicionar = find.text('Adicionar item');
      await tester.ensureVisible(botaoAdicionar);
      await tester.pumpAndSettle();
      await tester.tap(botaoAdicionar);
      await tester.pumpAndSettle();

      final quantidadeRect = tester.getRect(
        find.byKey(const ValueKey('produto-quantidade-0')),
      );
      final descricaoRect = tester.getRect(
        find.byKey(const ValueKey('produto-descricao-0')),
      );
      final valorUnitarioRect = tester.getRect(
        find.byKey(const ValueKey('produto-valor-unitario-0')),
      );

      expect((quantidadeRect.top - descricaoRect.top).abs(), lessThan(1));
      expect((descricaoRect.top - valorUnitarioRect.top).abs(), lessThan(1));
      expect(descricaoRect.left, greaterThan(quantidadeRect.right));
      expect(valorUnitarioRect.left, greaterThan(descricaoRect.right));
    },
  );

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

  testWidgets(
    'ReciboPedido pesquisa clientes ao digitar e seleciona sugestão',
    (WidgetTester tester) async {
      final repository = _ClienteRepositoryFake();
      await repository.salvar(
        Cliente(
          nome: 'Ana Pereira',
          telefone: '51911111111',
          email: 'ana@exemplo.com',
        ),
      );
      await repository.salvar(
        Cliente(
          nome: 'Ana Sem Telefone',
          telefone: '',
          email: 'semtelefone@exemplo.com',
        ),
      );
      await repository.salvar(
        Cliente(nome: 'Bruno Costa', telefone: '51922222222'),
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

      final campoCliente = find.byKey(
        const ValueKey('recibo-formulario-cliente'),
      );
      await tester.tap(campoCliente);
      await tester.enterText(campoCliente, 'ana');
      await tester.pumpAndSettle();

      expect(viewModel.reciboEmEdicao.cliente, 'ana');
      expect(viewModel.termoBuscaClientes, 'ana');
      expect(
        find.text('Ana Pereira - (51) 9 1111-1111 - ana@exemplo.com'),
        findsOneWidget,
      );
      expect(
        find.text('Ana Sem Telefone - semtelefone@exemplo.com'),
        findsOneWidget,
      );
      expect(find.text('Bruno Costa'), findsNothing);

      await tester.tap(
        find.byKey(const ValueKey('recibo-formulario-cliente-sugestao-0')),
      );
      await tester.pumpAndSettle();

      expect(viewModel.reciboEmEdicao.cliente, 'Ana Pereira');
      expect(viewModel.reciboEmEdicao.telefone, '51911111111');
      expect(viewModel.emailClienteSelecionado, 'ana@exemplo.com');
      expect(
        find.text('Ana Pereira - (51) 9 1111-1111 - ana@exemplo.com'),
        findsNothing,
      );
      expect(
        _textoDoCampo(
          tester,
          find.byKey(const ValueKey('recibo-formulario-cliente')),
        ),
        'Ana Pereira',
      );
    },
  );

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

  testWidgets(
    'ReciboPedido não exibe Imprimir nem Compartilhar nas ações rápidas',
    (WidgetTester tester) async {
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

      expect(find.widgetWithText(OutlinedButton, 'Imprimir'), findsNothing);
      expect(find.widgetWithText(OutlinedButton, 'Compartilhar'), findsNothing);
      expect(find.widgetWithText(OutlinedButton, 'Gerar PDF'), findsOneWidget);
    },
  );

  testWidgets('ReciboPedido usa ícones nativos nas ações do recibo', (
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

    expect(_findIcon(Icons.save_outlined), findsOneWidget);
    expect(_findIcon(Icons.note_add_outlined), findsOneWidget);
    expect(_findIcon(Icons.history_outlined), findsOneWidget);
    expect(_findIcon(Icons.groups_outlined), findsOneWidget);
    expect(_findIcon(Icons.picture_as_pdf_outlined), findsOneWidget);
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
              cliente.email.toLowerCase().contains(termoNome) ||
              (termoTelefone.isNotEmpty &&
                  cliente.telefone.contains(termoTelefone)),
        )
        .toList(growable: false);
  }

  @override
  Future<void> excluir(int id) async {}
}

class _ReciboRepositoryFake implements ReciboRepository {
  final List<Recibo> salvos = <Recibo>[];
  int _proximoId = 1;

  @override
  Future<String> proximoNumero() async {
    return _proximoId.toString().padLeft(4, '0');
  }

  @override
  Future<Recibo> salvar(Recibo recibo) async {
    final salvo = recibo.copyWith(id: _proximoId++);
    salvos.add(salvo);
    return salvo;
  }

  @override
  Future<Recibo> atualizar(Recibo recibo) async {
    final indice = salvos.indexWhere((salvo) => salvo.id == recibo.id);
    if (indice == -1) {
      throw StateError('Recibo não encontrado.');
    }

    salvos[indice] = recibo;
    return recibo;
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
    return List<Recibo>.unmodifiable(salvos);
  }

  @override
  Future<void> excluir(int id) async {
    salvos.removeWhere((recibo) => recibo.id == id);
  }
}

bool _campoTemFoco(WidgetTester tester, Finder campo) {
  final editableText = tester.widget<EditableText>(
    find.descendant(of: campo, matching: find.byType(EditableText)),
  );

  return editableText.focusNode.hasFocus;
}

String _textoDoCampo(WidgetTester tester, Finder campo) {
  final editableText = tester.widget<EditableText>(
    find.descendant(of: campo, matching: find.byType(EditableText)),
  );

  return editableText.controller.text;
}

Finder _findIcon(IconData icon) {
  return find.byWidgetPredicate(
    (widget) => widget is Icon && widget.icon == icon,
  );
}
