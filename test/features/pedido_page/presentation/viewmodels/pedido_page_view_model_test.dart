import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_card_rs/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';
import 'package:system_card_rs/observable/i_rx_subscribe.dart';
import 'package:system_card_rs/observable/rx_observer.dart';

void main() {
  test('PedidoPageViewModel expõe dados padrão do cabeçalho', () {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    final cabecalho = viewModel.cabecalhoEmpresa;

    expect(cabecalho.logoAssetPath, isNull);
    expect(cabecalho.logoBase64, isNull);
    expect(cabecalho.referenciaVisualAssetPath, 'lib/resources/cabecalho.png');
    expect(cabecalho.nomeEmpresa, 'SYSTEM CARD - RS');
    expect(cabecalho.subtitulo, 'Sistemas de Identificação');
    expect(cabecalho.instagram, '@systemcards');
    expect(cabecalho.whatsapp, '51 998020198');
    expect(cabecalho.telefone, '51 30551025');
    expect(
      cabecalho.endereco,
      'Rua 20 de Setembro, 528 - Centro - Guaíba - RS',
    );
    expect(cabecalho.acoesDisponiveis.map((acao) => acao.id), [
      CabecalhoAcaoId.imprimir,
      CabecalhoAcaoId.gerarPdf,
      CabecalhoAcaoId.maisOpcoes,
    ]);
    expect(cabecalho.acoesDisponiveis.map((acao) => acao.rotulo), [
      'IMPRIMIR',
      'GERAR PDF',
      'MAIS OPÇÕES',
    ]);
    expect(cabecalho.acoesDisponiveis.every((acao) => acao.habilitada), isTrue);
  });

  test('PedidoPageViewModel carrega cabeçalho editável persistido', () async {
    SharedPreferences.setMockInitialValues({
      CabecalhoPreferenciasRepository.chaveNomeEmpresa: 'Empresa Persistida',
      CabecalhoPreferenciasRepository.chaveSubtitulo: 'Subtítulo persistido',
      CabecalhoPreferenciasRepository.chaveInstagram: '@persistida',
      CabecalhoPreferenciasRepository.chaveWhatsapp: '51 99999-9999',
      CabecalhoPreferenciasRepository.chaveTelefone: '51 3333-3333',
      CabecalhoPreferenciasRepository.chaveEndereco: 'Rua Persistida, 10',
      CabecalhoPreferenciasRepository.chaveLogoBase64: 'bG9nbw==',
    });
    final preferencias = await SharedPreferences.getInstance();
    final viewModel = PedidoPageViewModel(
      cabecalhoRepository: CabecalhoPreferenciasRepository(preferencias),
    );
    addTearDown(viewModel.dispose);

    await viewModel.carregarCabecalho();

    expect(viewModel.carregandoCabecalho, isFalse);
    expect(viewModel.erroCabecalho, isNull);
    expect(viewModel.cabecalhoEmpresa.nomeEmpresa, 'Empresa Persistida');
    expect(viewModel.cabecalhoEmpresa.subtitulo, 'Subtítulo persistido');
    expect(viewModel.cabecalhoEmpresa.instagram, '@persistida');
    expect(viewModel.cabecalhoEmpresa.whatsapp, '51 99999-9999');
    expect(viewModel.cabecalhoEmpresa.telefone, '51 3333-3333');
    expect(viewModel.cabecalhoEmpresa.endereco, 'Rua Persistida, 10');
    expect(viewModel.cabecalhoEmpresa.logoBase64, 'bG9nbw==');
  });

  test('PedidoPageViewModel edita e salva dados do cabeçalho', () async {
    SharedPreferences.setMockInitialValues({});
    final preferencias = await SharedPreferences.getInstance();
    final repository = CabecalhoPreferenciasRepository(preferencias);
    final viewModel = PedidoPageViewModel(cabecalhoRepository: repository);
    addTearDown(viewModel.dispose);

    viewModel.atualizarCabecalhoEmpresa(
      nomeEmpresa: 'Nova Empresa',
      subtitulo: 'Novo subtítulo',
      instagram: '@nova_empresa',
      whatsapp: '51 98888-7777',
      telefone: '51 3222-1111',
      endereco: 'Rua Nova, 456',
    );
    await viewModel.salvarCabecalho();

    final salvo = repository.carregar();

    expect(viewModel.salvandoCabecalho, isFalse);
    expect(viewModel.erroCabecalho, isNull);
    expect(viewModel.feedbackCabecalho, 'Cabeçalho salvo.');
    expect(viewModel.ultimaAcaoCabecalho, 'cabecalho-salvo');
    expect(salvo.nomeEmpresa, 'Nova Empresa');
    expect(salvo.subtitulo, 'Novo subtítulo');
    expect(salvo.instagram, '@nova_empresa');
    expect(salvo.whatsapp, '51 98888-7777');
    expect(salvo.telefone, '51 3222-1111');
    expect(salvo.endereco, 'Rua Nova, 456');
  });

  test('PedidoPageViewModel restaura cabeçalho padrão', () async {
    SharedPreferences.setMockInitialValues({});
    final preferencias = await SharedPreferences.getInstance();
    final repository = CabecalhoPreferenciasRepository(preferencias);
    final viewModel = PedidoPageViewModel(cabecalhoRepository: repository);
    addTearDown(viewModel.dispose);

    viewModel.atualizarCabecalhoEmpresa(nomeEmpresa: 'Empresa Alterada');
    viewModel.definirLogoCabecalhoBase64('bG9nbw==');
    await viewModel.salvarCabecalho();
    await viewModel.restaurarCabecalhoPadrao();

    expect(viewModel.erroCabecalho, isNull);
    expect(viewModel.cabecalhoEmpresa.nomeEmpresa, 'SYSTEM CARD - RS');
    expect(viewModel.cabecalhoEmpresa.logoBase64, isNull);
    expect(
      preferencias.containsKey(
        CabecalhoPreferenciasRepository.chaveNomeEmpresa,
      ),
      isFalse,
    );
    expect(viewModel.feedbackCabecalho, 'Cabeçalho restaurado para o padrão.');
    expect(viewModel.ultimaAcaoCabecalho, 'cabecalho-restaurado');
  });

  test('PedidoPageViewModel define, salva e remove logo base64', () async {
    SharedPreferences.setMockInitialValues({});
    final preferencias = await SharedPreferences.getInstance();
    final repository = CabecalhoPreferenciasRepository(preferencias);
    final viewModel = PedidoPageViewModel(cabecalhoRepository: repository);
    addTearDown(viewModel.dispose);

    viewModel.definirLogoCabecalhoBase64('bG9nbw==');
    await viewModel.salvarCabecalho();

    expect(repository.carregar().logoBase64, 'bG9nbw==');
    expect(viewModel.cabecalhoEmpresa.logoBase64, 'bG9nbw==');

    await viewModel.removerLogoCabecalho();

    expect(viewModel.erroCabecalho, isNull);
    expect(viewModel.cabecalhoEmpresa.logoBase64, isNull);
    expect(repository.carregar().logoBase64, isNull);
    expect(viewModel.feedbackCabecalho, 'Logo removida.');
    expect(viewModel.ultimaAcaoCabecalho, 'cabecalho-logo-removida');
  });

  test('PedidoPageViewModel expõe erro quando cabeçalho falha', () async {
    final viewModel = PedidoPageViewModel(
      cabecalhoRepository: _CabecalhoRepositoryFake(falharAoSalvar: true),
    );
    addTearDown(viewModel.dispose);

    await viewModel.salvarCabecalho();

    expect(viewModel.salvandoCabecalho, isFalse);
    expect(viewModel.erroCabecalho, contains('Falha simulada no cabeçalho.'));
  });

  test('PedidoPageViewModel mantém resumo a partir dos dados do recibo', () {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    viewModel.atualizarDadosDoRecibo(
      totalPedidoCentavos: 12345,
      valorEntradaCentavos: 4500,
    );

    expect(viewModel.totalPedidoCentavos, 12345);
    expect(viewModel.valorEntradaCentavos, 4500);
    expect(viewModel.valorAPagarEntregaCentavos, 7845);
    expect(viewModel.totalPedidoFormatado, 'R\$ 123,45');
    expect(viewModel.valorEntradaFormatado, 'R\$ 45,00');
    expect(viewModel.valorAPagarEntregaFormatado, 'R\$ 78,45');
    expect(viewModel.resumoFinanceiro.totalPedidoCentavos, 12345);
    expect(viewModel.valorEntradaValido, isTrue);
    expect(viewModel.mensagemValorEntrada, isNull);
    expect(viewModel.reciboAtualSalvo, isFalse);
  });

  test('PedidoPageViewModel expõe validação de entrada maior que o total', () {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    viewModel.atualizarDadosDoRecibo(
      totalPedidoCentavos: 3000,
      valorEntradaCentavos: 4500,
    );

    expect(viewModel.valorEntradaValido, isFalse);
    expect(
      viewModel.mensagemValorEntrada,
      'O valor de entrada não pode ultrapassar o total do pedido.',
    );
    expect(viewModel.resumoFinanceiroValido, isFalse);
    expect(
      viewModel.errosResumoFinanceiro,
      contains('O valor de entrada não pode ultrapassar o total do pedido.'),
    );
  });

  test('PedidoPageViewModel edita recibo e itens usando o domínio', () {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    viewModel.atualizarNumero('0001');
    viewModel.atualizarCliente('Maria da Silva');
    viewModel.atualizarTelefone('51999990000');
    viewModel.atualizarObservacoes('Entrega no balcão.');
    viewModel.adicionarItem(
      const ItemRecibo(
        quantidade: 2,
        descricao: 'Crachá PVC',
        valorUnitarioCentavos: 1500,
      ),
    );
    viewModel.adicionarItem(
      const ItemRecibo(
        quantidade: 1,
        descricao: 'Arte final',
        valorUnitarioCentavos: 2500,
      ),
    );
    viewModel.atualizarValorEntradaCentavos(1000);

    expect(viewModel.reciboEmEdicao.numero, '0001');
    expect(viewModel.reciboEmEdicao.cliente, 'Maria da Silva');
    expect(viewModel.reciboEmEdicao.telefone, '51999990000');
    expect(viewModel.itens, hasLength(2));
    expect(viewModel.totalPedidoCentavos, 5500);
    expect(viewModel.valorAPagarEntregaCentavos, 4500);

    viewModel.atualizarItem(
      1,
      const ItemRecibo(
        quantidade: 2,
        descricao: 'Arte final',
        valorUnitarioCentavos: 2500,
      ),
    );
    viewModel.removerItem(0);

    expect(viewModel.itens.single.ordem, 1);
    expect(viewModel.totalPedidoCentavos, 5000);
    expect(viewModel.valorAPagarEntregaCentavos, 4000);

    viewModel.limparItens();

    expect(viewModel.itens, isEmpty);
    expect(viewModel.totalPedidoCentavos, 0);
  });

  test('PedidoPageViewModel prepara próximo número para recibo novo', () async {
    final repository = _ReciboRepositoryFake();
    await repository.salvar(_recibo(numero: '0009'));
    await repository.salvar(_recibo(numero: 'REC-LEGADO'));
    final viewModel = PedidoPageViewModel(reciboRepository: repository);
    addTearDown(viewModel.dispose);

    await viewModel.prepararProximoNumeroRecibo();

    expect(viewModel.erro, isNull);
    expect(viewModel.reciboEmEdicao.numero, '0010');

    await viewModel.iniciarNovoRecibo();

    expect(viewModel.reciboEmEdicao.id, isNull);
    expect(viewModel.reciboEmEdicao.numero, '0010');
    expect(viewModel.reciboAtualSalvo, isFalse);
  });

  test('PedidoPageViewModel salva recibo novo sem número manual', () async {
    final repository = _ReciboRepositoryFake();
    final viewModel = PedidoPageViewModel(reciboRepository: repository);
    addTearDown(viewModel.dispose);

    viewModel.atualizarCliente('Cliente Teste');
    viewModel.adicionarItem(
      const ItemRecibo(
        quantidade: 1,
        descricao: 'Crachá PVC',
        valorUnitarioCentavos: 1500,
      ),
    );

    await viewModel.salvarRecibo();

    expect(viewModel.erro, isNull);
    expect(viewModel.reciboAtualSalvo, isTrue);
    expect(viewModel.reciboEmEdicao.numero, '0001');
    expect(viewModel.reciboEmEdicao.criadoEm, isNotNull);
    expect(repository.salvos.single.numero, '0001');
  });

  test('PedidoPageViewModel salva recibo e atualiza histórico', () async {
    final repository = _ReciboRepositoryFake();
    final viewModel = PedidoPageViewModel(reciboRepository: repository);
    addTearDown(viewModel.dispose);

    _preencherReciboValido(viewModel, numero: '0002');

    await viewModel.salvarRecibo();

    expect(viewModel.erro, isNull);
    expect(viewModel.salvando, isFalse);
    expect(viewModel.reciboAtualSalvo, isTrue);
    expect(viewModel.reciboEmEdicao.id, 1);
    expect(viewModel.historico.map((recibo) => recibo.numero), ['0002']);

    viewModel.atualizarCliente('Cliente Atualizado');
    await viewModel.salvarRecibo();

    expect(viewModel.reciboEmEdicao.id, 1);
    expect(viewModel.reciboEmEdicao.cliente, 'Cliente Atualizado');
    expect(repository.salvos.single.cliente, 'Cliente Atualizado');
  });

  test(
    'PedidoPageViewModel carrega, pesquisa e exclui recibos do histórico',
    () async {
      final repository = _ReciboRepositoryFake();
      final primeiro = await repository.salvar(_recibo(numero: '0100'));
      final segundo = await repository.salvar(
        _recibo(numero: '0200', cliente: 'Bruno Costa'),
      );
      final viewModel = PedidoPageViewModel(reciboRepository: repository);
      addTearDown(viewModel.dispose);

      await viewModel.listarHistorico();

      expect(viewModel.carregando, isFalse);
      expect(viewModel.historico.map((recibo) => recibo.id), [
        primeiro.id,
        segundo.id,
      ]);

      await viewModel.pesquisarHistorico('bruno');

      expect(viewModel.historico.single.id, segundo.id);

      await viewModel.carregarRecibo(segundo.id!);

      expect(viewModel.reciboEmEdicao.cliente, 'Bruno Costa');
      expect(viewModel.reciboAtualSalvo, isTrue);

      await viewModel.excluirRecibo(segundo.id!);

      expect(viewModel.historico.map((recibo) => recibo.id), [primeiro.id]);
      expect(viewModel.reciboEmEdicao.id, isNull);
      expect(viewModel.reciboAtualSalvo, isFalse);
    },
  );

  test(
    'PedidoPageViewModel lista, pesquisa, salva e seleciona clientes',
    () async {
      final repository = _ClienteRepositoryFake();
      await repository.salvar(
        Cliente(nome: 'Ana Pereira', telefone: '(51) 9 1111-1111'),
      );
      await repository.salvar(
        Cliente(nome: 'Bruno Costa', telefone: '51922222222'),
      );
      final viewModel = PedidoPageViewModel(clienteRepository: repository);
      addTearDown(viewModel.dispose);

      await viewModel.listarClientes();

      expect(viewModel.carregandoClientes, isFalse);
      expect(viewModel.erroClientes, isNull);
      expect(viewModel.clientes.map((cliente) => cliente.nome), [
        'Ana Pereira',
        'Bruno Costa',
      ]);

      await viewModel.pesquisarClientes('9222');

      expect(viewModel.termoBuscaClientes, '9222');
      expect(viewModel.clientes.single.nome, 'Bruno Costa');

      await viewModel.salvarCliente(
        nome: 'Carla Souza',
        telefone: '(51) 9 3333-3333',
      );

      expect(viewModel.feedbackClientes, 'Cliente salvo.');
      expect(viewModel.reciboEmEdicao.cliente, 'Carla Souza');
      expect(viewModel.reciboEmEdicao.telefone, '51933333333');

      viewModel.selecionarCliente(repository.salvos.first);

      expect(viewModel.feedbackClientes, 'Cliente selecionado.');
      expect(viewModel.reciboEmEdicao.cliente, 'Ana Pereira');
      expect(viewModel.reciboEmEdicao.telefone, '51911111111');
    },
  );

  test(
    'PedidoPageViewModel expõe erro claro para telefone duplicado',
    () async {
      final repository = _ClienteRepositoryFake();
      await repository.salvar(
        Cliente(nome: 'Ana Pereira', telefone: '(51) 9 1111-1111'),
      );
      final viewModel = PedidoPageViewModel(clienteRepository: repository);
      addTearDown(viewModel.dispose);

      await viewModel.salvarCliente(
        nome: 'Ana Duplicada',
        telefone: '51911111111',
      );

      expect(viewModel.salvandoCliente, isFalse);
      expect(viewModel.erroClientes, 'Já existe um cliente com este telefone.');
    },
  );

  test('PedidoPageViewModel duplica recibo sem reaproveitar ids', () async {
    final repository = _ReciboRepositoryFake();
    final salvo = await repository.salvar(_recibo(numero: '0300'));
    final viewModel = PedidoPageViewModel(reciboRepository: repository);
    addTearDown(viewModel.dispose);

    await viewModel.duplicarRecibo(salvo.id!);

    expect(viewModel.erro, isNull);
    expect(viewModel.reciboEmEdicao.id, isNull);
    expect(viewModel.reciboEmEdicao.numero, '0301');
    expect(viewModel.reciboEmEdicao.itens.single.id, isNull);
    expect(viewModel.reciboAtualSalvo, isFalse);
    expect(viewModel.ultimaAcaoRecibo, 'recibo-duplicado');
  });

  test('PedidoPageViewModel prepara impressão e PDF como estado', () {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    viewModel.prepararImpressao();

    expect(viewModel.ultimaAcaoRecibo, 'imprimir-preparado');

    viewModel.prepararGeracaoPdf();

    expect(viewModel.ultimaAcaoRecibo, 'pdf-preparado');
  });

  test('PedidoPageViewModel controla ações temporárias do cabeçalho', () async {
    final viewModel = PedidoPageViewModel();
    addTearDown(viewModel.dispose);

    final impressao = viewModel.solicitarImpressaoCabecalho();

    expect(viewModel.ultimaAcaoCabecalho, 'imprimir');
    expect(viewModel.acaoCabecalhoEmAndamento, CabecalhoAcaoId.imprimir);
    expect(
      viewModel.cabecalhoEmpresa.acoesDisponiveis.every(
        (acao) => !acao.habilitada,
      ),
      isTrue,
    );

    await impressao;

    expect(viewModel.acaoCabecalhoEmAndamento, isNull);
    expect(viewModel.ultimaAcaoRecibo, 'imprimir-preparado');
    expect(
      viewModel.feedbackCabecalho,
      'Impressão preparada para integração futura.',
    );
    expect(
      viewModel.cabecalhoEmpresa.acoesDisponiveis.every(
        (acao) => acao.habilitada,
      ),
      isTrue,
    );

    await viewModel.solicitarGeracaoPdfCabecalho();

    expect(viewModel.ultimaAcaoCabecalho, 'gerar-pdf');
    expect(viewModel.ultimaAcaoRecibo, 'pdf-preparado');
    expect(
      viewModel.feedbackCabecalho,
      'PDF preparado para integração futura.',
    );
  });

  test('PedidoPageViewModel registra seleção do menu do cabeçalho', () async {
    final viewModel = PedidoPageViewModel(totalPedidoCentavos: 1000);
    addTearDown(viewModel.dispose);

    await viewModel.selecionarOpcaoCabecalho(CabecalhoMenuOpcao.novoRecibo);

    expect(viewModel.ultimaAcaoCabecalho, 'mais-opcoes-novo-recibo');
    expect(viewModel.totalPedidoCentavos, 0);
    expect(viewModel.feedbackCabecalho, 'Novo recibo iniciado.');
  });

  test('PedidoPageViewModel expõe erro quando repository falha', () async {
    final viewModel = PedidoPageViewModel(
      reciboRepository: _ReciboRepositoryFake(falharAoSalvar: true),
    );
    addTearDown(viewModel.dispose);

    _preencherReciboValido(viewModel, numero: '0003');

    await viewModel.salvarRecibo();

    expect(viewModel.reciboAtualSalvo, isFalse);
    expect(viewModel.erro, contains('Falha simulada ao salvar.'));
    expect(viewModel.salvando, isFalse);
  });

  test(
    'PedidoPageViewModel notifica observador reativo quando estado muda',
    () async {
      final viewModel = PedidoPageViewModel(totalPedidoCentavos: 1000);
      final observer = _RxObserverTeste();
      addTearDown(observer.dispose);
      addTearDown(viewModel.dispose);

      RxDependencyTracker.track(observer, () {
        viewModel.totalPedidoFormatado;
        viewModel.valorEntradaFormatado;
        viewModel.valorAPagarEntregaFormatado;
        viewModel.ultimaAcaoCabecalho;
      });

      expect(observer.dependenciasRegistradas, 2);

      viewModel.atualizarTotalPedidoCentavos(1000);
      viewModel.atualizarTotalPedidoCentavos(1500);
      viewModel.atualizarValorEntradaCentavos(500);
      viewModel.registrarAcaoCabecalho('acao-temporaria');
      viewModel.registrarAcaoCabecalho('acao-temporaria');

      await Future<void>.delayed(Duration.zero);

      expect(observer.notificacoes, 2);
      expect(viewModel.totalPedidoCentavos, 1500);
      expect(viewModel.valorEntradaCentavos, 500);
      expect(viewModel.ultimaAcaoCabecalho, 'acao-temporaria');
    },
  );
}

void _preencherReciboValido(
  PedidoPageViewModel viewModel, {
  required String numero,
}) {
  viewModel.atualizarNumero(numero);
  viewModel.atualizarCliente('Cliente Teste');
  viewModel.adicionarItem(
    const ItemRecibo(
      quantidade: 2,
      descricao: 'Crachá PVC',
      valorUnitarioCentavos: 1500,
    ),
  );
  viewModel.atualizarValorEntradaCentavos(500);
}

Recibo _recibo({required String numero, String cliente = 'Cliente Teste'}) {
  return Recibo(
    numero: numero,
    cliente: cliente,
    telefone: '51999999999',
    dataRecebimento: DateTime(2026, 5, 14),
    dataEntrega: DateTime(2026, 5, 18),
    valorEntradaCentavos: 500,
    itens: const <ItemRecibo>[
      ItemRecibo(
        quantidade: 2,
        descricao: 'Crachá PVC',
        valorUnitarioCentavos: 1500,
      ),
    ],
  );
}

class _ReciboRepositoryFake implements ReciboRepository {
  _ReciboRepositoryFake({this.falharAoSalvar = false});

  final bool falharAoSalvar;
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
    if (falharAoSalvar) {
      throw StateError('Falha simulada ao salvar.');
    }

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

class _ClienteRepositoryFake implements ClienteRepository {
  final List<Cliente> salvos = <Cliente>[];
  int _proximoId = 1;

  @override
  Future<Cliente> salvar(Cliente cliente) async {
    if (salvos.any((salvo) => salvo.telefone == cliente.telefone)) {
      throw StateError('Já existe um cliente com este telefone.');
    }

    final salvo = cliente.copyWith(id: _proximoId++);
    salvos.add(salvo);
    return salvo;
  }

  @override
  Future<Cliente> atualizar(Cliente cliente) async {
    final id = cliente.id;
    final indice = salvos.indexWhere((salvo) => salvo.id == id);
    if (id == null || indice == -1) {
      throw StateError('Cliente não encontrado para atualização.');
    }

    salvos[indice] = cliente;
    return cliente;
  }

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
  Future<void> excluir(int id) async {
    salvos.removeWhere((cliente) => cliente.id == id);
  }
}

class _CabecalhoRepositoryFake implements CabecalhoPreferenciasRepository {
  _CabecalhoRepositoryFake({this.falharAoSalvar = false});

  final bool falharAoSalvar;
  CabecalhoEmpresa _cabecalho = const CabecalhoEmpresa.systemCardRs();

  @override
  CabecalhoEmpresa carregar() {
    return _cabecalho;
  }

  @override
  Future<void> salvar(CabecalhoEmpresa cabecalho) async {
    if (falharAoSalvar) {
      throw StateError('Falha simulada no cabeçalho.');
    }

    _cabecalho = cabecalho;
  }

  @override
  Future<CabecalhoEmpresa> removerLogo() async {
    _cabecalho = _cabecalho.copyWith(removerLogoBase64: true);
    return _cabecalho;
  }

  @override
  Future<CabecalhoEmpresa> restaurarPadrao() async {
    _cabecalho = const CabecalhoEmpresa.systemCardRs();
    return _cabecalho;
  }
}

class _RxObserverTeste implements RxTrackingObserver {
  final Set<RxSubscribable> _dependencias = <RxSubscribable>{};

  int notificacoes = 0;

  int get dependenciasRegistradas => _dependencias.length;

  @override
  void beginBuild() {
    for (final dependencia in _dependencias) {
      dependencia.unregisterObserver(this);
    }
    _dependencias.clear();
  }

  @override
  void notify() {
    notificacoes++;
  }

  @override
  void track(RxSubscribable rx) {
    if (_dependencias.add(rx)) {
      rx.registerObserver(this);
    }
  }

  void dispose() {
    beginBuild();
  }
}
