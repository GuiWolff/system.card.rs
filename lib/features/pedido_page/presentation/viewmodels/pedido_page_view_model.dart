import '../../domain/models/cabecalho_empresa.dart';
import '../../domain/models/cliente.dart';
import '../../domain/models/item_recibo.dart';
import '../../domain/models/recibo.dart';
import '../../domain/models/resumo_recibo.dart';
import '../../domain/repositories/cliente_repository.dart';
import '../../domain/repositories/recibo_repository.dart';
import '../../data/repositories/cabecalho_preferencias_repository.dart';
import 'package:system_card_rs/observable/rx.dart';

class PedidoPageViewModel {
  PedidoPageViewModel({
    ReciboRepository? reciboRepository,
    ClienteRepository? clienteRepository,
    CabecalhoPreferenciasRepository? cabecalhoRepository,
    CabecalhoEmpresa cabecalhoEmpresa = const CabecalhoEmpresa.systemCardRs(),
    int totalPedidoCentavos = 0,
    int valorEntradaCentavos = 0,
  }) : _reciboRepository = reciboRepository,
       _clienteRepository = clienteRepository,
       _cabecalhoRepository = cabecalhoRepository,
       _cabecalhoEmpresa = Rx<CabecalhoEmpresa>(cabecalhoEmpresa),
       _reciboEmEdicao = Rx<Recibo>(
         _criarReciboInicial(
           totalPedidoCentavos: totalPedidoCentavos,
           valorEntradaCentavos: valorEntradaCentavos,
         ),
       ),
       _historico = Rx<List<Recibo>>(const <Recibo>[]),
       _carregando = Rx<bool>(false),
       _salvando = Rx<bool>(false),
       _erro = Rx<String?>(null),
       _reciboAtualSalvo = Rx<bool>(false),
       _ultimaAcaoRecibo = Rx<String?>(null),
       _ultimaAcaoCabecalho = Rx<String?>(null),
       _acaoCabecalhoEmAndamento = Rx<CabecalhoAcaoId?>(null),
       _feedbackCabecalho = Rx<String?>(null),
       _carregandoCabecalho = Rx<bool>(false),
       _salvandoCabecalho = Rx<bool>(false),
       _erroCabecalho = Rx<String?>(null),
       _clientes = Rx<List<Cliente>>(const <Cliente>[]),
       _carregandoClientes = Rx<bool>(false),
       _salvandoCliente = Rx<bool>(false),
       _erroClientes = Rx<String?>(null),
       _feedbackClientes = Rx<String?>(null),
       _termoBuscaClientes = Rx<String>('');

  final ReciboRepository? _reciboRepository;
  final ClienteRepository? _clienteRepository;
  CabecalhoPreferenciasRepository? _cabecalhoRepository;
  final Rx<CabecalhoEmpresa> _cabecalhoEmpresa;
  final Rx<Recibo> _reciboEmEdicao;
  final Rx<List<Recibo>> _historico;
  final Rx<bool> _carregando;
  final Rx<bool> _salvando;
  final Rx<String?> _erro;
  final Rx<bool> _reciboAtualSalvo;
  final Rx<String?> _ultimaAcaoRecibo;
  final Rx<String?> _ultimaAcaoCabecalho;
  final Rx<CabecalhoAcaoId?> _acaoCabecalhoEmAndamento;
  final Rx<String?> _feedbackCabecalho;
  final Rx<bool> _carregandoCabecalho;
  final Rx<bool> _salvandoCabecalho;
  final Rx<String?> _erroCabecalho;
  final Rx<List<Cliente>> _clientes;
  final Rx<bool> _carregandoClientes;
  final Rx<bool> _salvandoCliente;
  final Rx<String?> _erroClientes;
  final Rx<String?> _feedbackClientes;
  final Rx<String> _termoBuscaClientes;

  Recibo get reciboEmEdicao => _reciboEmEdicao.value;

  List<ItemRecibo> get itens => reciboEmEdicao.itens;

  List<Recibo> get historico => _historico.value;

  bool get carregando => _carregando.value;

  bool get salvando => _salvando.value;

  String? get erro => _erro.value;

  bool get reciboAtualSalvo => _reciboAtualSalvo.value;

  String? get ultimaAcaoRecibo => _ultimaAcaoRecibo.value;

  int get totalPedidoCentavos => reciboEmEdicao.totalPedidoCentavos;

  int get valorEntradaCentavos => reciboEmEdicao.valorEntradaCentavos;

  int get valorAPagarEntregaCentavos =>
      reciboEmEdicao.valorAPagarEntregaCentavos;

  ResumoRecibo get resumoFinanceiro => reciboEmEdicao.resumo;

  List<String> get errosResumoFinanceiro => resumoFinanceiro.validar();

  bool get resumoFinanceiroValido => errosResumoFinanceiro.isEmpty;

  String? get mensagemValorEntrada {
    if (valorEntradaCentavos < 0) {
      return 'O valor de entrada não pode ser negativo.';
    }

    if (valorEntradaCentavos > totalPedidoCentavos) {
      return 'O valor de entrada não pode ultrapassar o total do pedido.';
    }

    return null;
  }

  bool get valorEntradaValido => mensagemValorEntrada == null;

  String? get ultimaAcaoCabecalho => _ultimaAcaoCabecalho.value;

  CabecalhoAcaoId? get acaoCabecalhoEmAndamento =>
      _acaoCabecalhoEmAndamento.value;

  String? get feedbackCabecalho => _feedbackCabecalho.value;

  bool get carregandoCabecalho => _carregandoCabecalho.value;

  bool get salvandoCabecalho => _salvandoCabecalho.value;

  String? get erroCabecalho => _erroCabecalho.value;

  List<Cliente> get clientes => _clientes.value;

  bool get carregandoClientes => _carregandoClientes.value;

  bool get salvandoCliente => _salvandoCliente.value;

  String? get erroClientes => _erroClientes.value;

  String? get feedbackClientes => _feedbackClientes.value;

  String get termoBuscaClientes => _termoBuscaClientes.value;

  CabecalhoEmpresa get cabecalhoEmpresa {
    final cabecalho = _cabecalhoEmpresa.value;
    final acaoEmAndamento = _acaoCabecalhoEmAndamento.value;
    final podeExecutar =
        !_carregando.value &&
        !_salvando.value &&
        !_carregandoCabecalho.value &&
        !_salvandoCabecalho.value;

    return cabecalho.copyWith(
      acoesDisponiveis: [
        for (final acao in cabecalho.acoesDisponiveis)
          acao.copyWith(
            habilitada: podeExecutar && acaoEmAndamento == null,
            emAndamento: acao.id == acaoEmAndamento,
          ),
      ],
    );
  }

  String get totalPedidoFormatado =>
      _formatarCentavosComoMoeda(totalPedidoCentavos);

  String get valorEntradaFormatado =>
      _formatarCentavosComoMoeda(valorEntradaCentavos);

  String get valorAPagarEntregaFormatado =>
      _formatarCentavosComoMoeda(valorAPagarEntregaCentavos);

  Future<void> iniciarNovoRecibo() async {
    _reciboEmEdicao.value = _criarReciboVazio();
    _reciboAtualSalvo.value = false;
    _erro.value = null;
    await prepararProximoNumeroRecibo();
  }

  Future<void> prepararProximoNumeroRecibo({bool registrarErro = true}) async {
    final repository = _reciboRepository;
    if (repository == null) {
      return;
    }

    final reciboAtual = reciboEmEdicao;
    if (reciboAtual.id != null || reciboAtual.numero.trim().isNotEmpty) {
      return;
    }

    try {
      final numero = await repository.proximoNumero();
      final reciboAindaAtual = reciboEmEdicao;
      if (reciboAindaAtual.id == null &&
          reciboAindaAtual.numero.trim().isEmpty) {
        _reciboEmEdicao.value = reciboAindaAtual.copyWith(numero: numero);
        _reciboAtualSalvo.value = false;
        _erro.value = null;
      }
    } catch (erro) {
      if (registrarErro) {
        _erro.value = erro.toString();
      }
    }
  }

  void atualizarNumero(String numero) {
    _atualizarRecibo(reciboEmEdicao.copyWith(numero: numero));
  }

  void atualizarCliente(String cliente) {
    _atualizarRecibo(reciboEmEdicao.copyWith(cliente: cliente));
  }

  void atualizarTelefone(String telefone) {
    _atualizarRecibo(
      reciboEmEdicao.copyWith(telefone: Cliente.normalizarTelefone(telefone)),
    );
  }

  void atualizarObservacoes(String observacoes) {
    _atualizarRecibo(reciboEmEdicao.copyWith(observacoes: observacoes));
  }

  void atualizarDataRecebimento(DateTime dataRecebimento) {
    _atualizarRecibo(reciboEmEdicao.copyWith(dataRecebimento: dataRecebimento));
  }

  void atualizarDataEntrega(DateTime dataEntrega) {
    _atualizarRecibo(reciboEmEdicao.copyWith(dataEntrega: dataEntrega));
  }

  void atualizarValorEntradaCentavos(int valor) {
    _atualizarRecibo(reciboEmEdicao.copyWith(valorEntradaCentavos: valor));
  }

  void atualizarTotalPedidoCentavos(int valor) {
    atualizarDadosDoRecibo(
      totalPedidoCentavos: valor,
      valorEntradaCentavos: valorEntradaCentavos,
    );
  }

  void adicionarItem(ItemRecibo item) {
    final itensAtualizados = <ItemRecibo>[
      ...itens,
      item.copyWith(ordem: itens.length + 1),
    ];
    _atualizarItens(itensAtualizados);
  }

  void atualizarItem(int indice, ItemRecibo item) {
    if (indice < 0 || indice >= itens.length) {
      _erro.value = 'Item não encontrado para atualização.';
      return;
    }

    final itensAtualizados = List<ItemRecibo>.of(itens);
    itensAtualizados[indice] = item.copyWith(ordem: indice + 1);
    _atualizarItens(itensAtualizados);
  }

  void removerItem(int indice) {
    if (indice < 0 || indice >= itens.length) {
      _erro.value = 'Item não encontrado para remoção.';
      return;
    }

    final itensAtualizados = List<ItemRecibo>.of(itens)..removeAt(indice);
    _atualizarItens(_reordenarItens(itensAtualizados));
  }

  void limparItens() {
    _atualizarItens(const <ItemRecibo>[]);
  }

  void atualizarDadosDoRecibo({
    required int totalPedidoCentavos,
    required int valorEntradaCentavos,
  }) {
    final reciboAtualizado = reciboEmEdicao.copyWith(
      itens: totalPedidoCentavos == 0
          ? const <ItemRecibo>[]
          : <ItemRecibo>[
              ItemRecibo(
                ordem: 1,
                quantidade: 1,
                descricao: 'Item temporário',
                valorUnitarioCentavos: totalPedidoCentavos,
              ),
            ],
      valorEntradaCentavos: valorEntradaCentavos,
    );

    _atualizarRecibo(reciboAtualizado);
  }

  Future<void> salvarRecibo() async {
    if (reciboEmEdicao.id == null && reciboEmEdicao.numero.trim().isEmpty) {
      await prepararProximoNumeroRecibo();
      if (_erro.value != null && reciboEmEdicao.numero.trim().isEmpty) {
        return;
      }
    }

    final erros = reciboEmEdicao.validar();
    if (erros.isNotEmpty) {
      _erro.value = erros.first;
      return;
    }

    await _executarComRepository((repository) async {
      _salvando.value = true;
      final reciboSalvo = reciboEmEdicao.id == null
          ? await repository.salvar(reciboEmEdicao)
          : await repository.atualizar(reciboEmEdicao);

      _reciboEmEdicao.value = reciboSalvo;
      _reciboAtualSalvo.value = true;
      await listarHistorico();
    }, atualizarCarregando: false);
  }

  Future<void> carregarRecibo(int id) async {
    await _executarComRepository((repository) async {
      _carregando.value = true;
      final recibo = await repository.buscarPorId(id);
      if (recibo == null) {
        _erro.value = 'Recibo não encontrado.';
        return;
      }

      _reciboEmEdicao.value = recibo;
      _reciboAtualSalvo.value = true;
    });
  }

  Future<void> duplicarRecibo(int id) async {
    await _executarComRepository((repository) async {
      _carregando.value = true;
      final recibo = await repository.buscarPorId(id);
      if (recibo == null) {
        _erro.value = 'Recibo não encontrado para duplicação.';
        return;
      }

      _reciboEmEdicao.value = _duplicarSemIds(recibo);
      _reciboAtualSalvo.value = false;
      _ultimaAcaoRecibo.value = 'recibo-duplicado';
      await prepararProximoNumeroRecibo();
    });
  }

  Future<void> listarHistorico() async {
    await _executarComRepository((repository) async {
      _carregando.value = true;
      _historico.value = await repository.listarHistorico();
    });
  }

  Future<void> pesquisarHistorico(String termo) async {
    await _executarComRepository((repository) async {
      _carregando.value = true;
      _historico.value = await repository.pesquisarHistorico(termo);
    });
  }

  Future<void> excluirRecibo(int id) async {
    await _executarComRepository((repository) async {
      _carregando.value = true;
      await repository.excluir(id);
      _historico.value = await repository.listarHistorico();

      if (reciboEmEdicao.id == id) {
        await iniciarNovoRecibo();
      }
    });
  }

  void prepararImpressao() {
    _ultimaAcaoRecibo.value = 'imprimir-preparado';
    _erro.value = null;
  }

  void prepararGeracaoPdf() {
    _ultimaAcaoRecibo.value = 'pdf-preparado';
    _erro.value = null;
  }

  Future<void> solicitarImpressaoCabecalho() async {
    await _executarAcaoCabecalho(
      id: CabecalhoAcaoId.imprimir,
      chave: 'imprimir',
      feedback: 'Impressão preparada para integração futura.',
      acao: prepararImpressao,
    );
  }

  Future<void> solicitarGeracaoPdfCabecalho() async {
    await _executarAcaoCabecalho(
      id: CabecalhoAcaoId.gerarPdf,
      chave: 'gerar-pdf',
      feedback: 'PDF preparado para integração futura.',
      acao: prepararGeracaoPdf,
    );
  }

  Future<void> selecionarOpcaoCabecalho(CabecalhoMenuOpcao opcao) async {
    await _executarAcaoCabecalho(
      id: CabecalhoAcaoId.maisOpcoes,
      chave: switch (opcao) {
        CabecalhoMenuOpcao.salvar => 'mais-opcoes-salvar',
        CabecalhoMenuOpcao.historico => 'mais-opcoes-historico',
        CabecalhoMenuOpcao.novoRecibo => 'mais-opcoes-novo-recibo',
      },
      feedback: switch (opcao) {
        CabecalhoMenuOpcao.salvar => 'Opção Salvar selecionada.',
        CabecalhoMenuOpcao.historico => 'Opção Histórico selecionada.',
        CabecalhoMenuOpcao.novoRecibo => 'Novo recibo iniciado.',
      },
      acao: () {
        if (opcao == CabecalhoMenuOpcao.novoRecibo) {
          iniciarNovoRecibo();
        }
      },
    );
  }

  void registrarAcaoCabecalho(String acao) {
    _ultimaAcaoCabecalho.value = acao;
  }

  void limparFeedbackCabecalho() {
    _feedbackCabecalho.value = null;
  }

  void configurarCabecalhoRepository(
    CabecalhoPreferenciasRepository repository,
  ) {
    _cabecalhoRepository = repository;
  }

  Future<void> carregarCabecalho() async {
    await _executarComCabecalhoRepository((repository) async {
      _carregandoCabecalho.value = true;
      _cabecalhoEmpresa.value = repository.carregar();
    });
  }

  void atualizarCabecalhoEmpresa({
    String? nomeEmpresa,
    String? subtitulo,
    String? instagram,
    String? whatsapp,
    String? telefone,
    String? endereco,
  }) {
    _cabecalhoEmpresa.value = _cabecalhoEmpresa.value.copyWith(
      nomeEmpresa: nomeEmpresa,
      subtitulo: subtitulo,
      instagram: instagram,
      whatsapp: whatsapp,
      telefone: telefone,
      endereco: endereco,
    );
    _erroCabecalho.value = null;
  }

  Future<void> salvarCabecalho() async {
    await _executarComCabecalhoRepository((repository) async {
      _salvandoCabecalho.value = true;
      await repository.salvar(_cabecalhoEmpresa.value);
      _cabecalhoEmpresa.value = repository.carregar();
      _feedbackCabecalho.value = 'Cabeçalho salvo.';
      _ultimaAcaoCabecalho.value = 'cabecalho-salvo';
    });
  }

  Future<void> restaurarCabecalhoPadrao() async {
    await _executarComCabecalhoRepository((repository) async {
      _salvandoCabecalho.value = true;
      _cabecalhoEmpresa.value = await repository.restaurarPadrao();
      _feedbackCabecalho.value = 'Cabeçalho restaurado para o padrão.';
      _ultimaAcaoCabecalho.value = 'cabecalho-restaurado';
    });
  }

  Future<void> listarClientes() async {
    await _executarComClienteRepository((repository) async {
      _carregandoClientes.value = true;
      _clientes.value = await repository.listar();
    });
  }

  Future<void> pesquisarClientes(String termo) async {
    _termoBuscaClientes.value = termo;
    await _executarComClienteRepository((repository) async {
      _carregandoClientes.value = true;
      _clientes.value = await repository.pesquisar(termo);
    });
  }

  Future<void> salvarCliente({
    required String nome,
    required String telefone,
  }) async {
    await _executarComClienteRepository((repository) async {
      _salvandoCliente.value = true;
      final cliente = Cliente(nome: nome, telefone: telefone);
      final clienteSalvo = await repository.salvar(cliente);
      _feedbackClientes.value = 'Cliente salvo.';
      _selecionarClienteNoRecibo(clienteSalvo);

      final termo = _termoBuscaClientes.value;
      _clientes.value = termo.trim().isEmpty
          ? await repository.listar()
          : await repository.pesquisar(termo);
    });
  }

  void selecionarCliente(Cliente cliente) {
    _selecionarClienteNoRecibo(cliente);
    _feedbackClientes.value = 'Cliente selecionado.';
    _erroClientes.value = null;
  }

  void definirLogoCabecalhoBase64(String logoBase64) {
    _cabecalhoEmpresa.value = _cabecalhoEmpresa.value.copyWith(
      logoBase64: logoBase64,
      removerLogoAssetPath: true,
    );
    _erroCabecalho.value = null;
  }

  Future<void> removerLogoCabecalho() async {
    await _executarComCabecalhoRepository((repository) async {
      _salvandoCabecalho.value = true;
      final cabecalhoSemLogo = _cabecalhoEmpresa.value.copyWith(
        removerLogoAssetPath: true,
        removerLogoBase64: true,
      );

      await repository.salvar(cabecalhoSemLogo);
      _cabecalhoEmpresa.value = repository.carregar();
      _feedbackCabecalho.value = 'Logo removida.';
      _ultimaAcaoCabecalho.value = 'cabecalho-logo-removida';
    });
  }

  void dispose() {
    _cabecalhoEmpresa.dispose();
    _reciboEmEdicao.dispose();
    _historico.dispose();
    _carregando.dispose();
    _salvando.dispose();
    _erro.dispose();
    _reciboAtualSalvo.dispose();
    _ultimaAcaoRecibo.dispose();
    _ultimaAcaoCabecalho.dispose();
    _acaoCabecalhoEmAndamento.dispose();
    _feedbackCabecalho.dispose();
    _carregandoCabecalho.dispose();
    _salvandoCabecalho.dispose();
    _erroCabecalho.dispose();
    _clientes.dispose();
    _carregandoClientes.dispose();
    _salvandoCliente.dispose();
    _erroClientes.dispose();
    _feedbackClientes.dispose();
    _termoBuscaClientes.dispose();
  }

  void _atualizarItens(List<ItemRecibo> itensAtualizados) {
    _atualizarRecibo(reciboEmEdicao.copyWith(itens: itensAtualizados));
  }

  void _atualizarRecibo(Recibo recibo) {
    _reciboEmEdicao.value = recibo;
    _reciboAtualSalvo.value = false;
    _erro.value = null;
  }

  Future<void> _executarComRepository(
    Future<void> Function(ReciboRepository repository) acao, {
    bool atualizarCarregando = true,
  }) async {
    final repository = _reciboRepository;
    if (repository == null) {
      _erro.value = 'Repository de recibos não configurado.';
      return;
    }

    _erro.value = null;
    try {
      await acao(repository);
    } catch (erro) {
      _erro.value = erro.toString();
    } finally {
      if (atualizarCarregando) {
        _carregando.value = false;
      }
      _salvando.value = false;
    }
  }

  Future<void> _executarAcaoCabecalho({
    required CabecalhoAcaoId id,
    required String chave,
    required String feedback,
    required void Function() acao,
  }) async {
    if (_acaoCabecalhoEmAndamento.value != null ||
        _carregando.value ||
        _salvando.value ||
        _carregandoCabecalho.value ||
        _salvandoCabecalho.value) {
      return;
    }

    _erro.value = null;
    _feedbackCabecalho.value = null;
    _acaoCabecalhoEmAndamento.value = id;
    _ultimaAcaoCabecalho.value = chave;

    await Future<void>.delayed(const Duration(milliseconds: 120));

    acao();
    _feedbackCabecalho.value = feedback;
    _acaoCabecalhoEmAndamento.value = null;
  }

  Future<void> _executarComCabecalhoRepository(
    Future<void> Function(CabecalhoPreferenciasRepository repository) acao,
  ) async {
    final repository = _cabecalhoRepository;
    if (repository == null) {
      _erroCabecalho.value = 'Repository de cabeçalho não configurado.';
      return;
    }

    _erroCabecalho.value = null;
    try {
      await acao(repository);
    } catch (erro) {
      _erroCabecalho.value = erro.toString();
    } finally {
      _carregandoCabecalho.value = false;
      _salvandoCabecalho.value = false;
    }
  }

  Future<void> _executarComClienteRepository(
    Future<void> Function(ClienteRepository repository) acao,
  ) async {
    final repository = _clienteRepository;
    if (repository == null) {
      _erroClientes.value = 'Repository de clientes não configurado.';
      return;
    }

    _erroClientes.value = null;
    _feedbackClientes.value = null;
    try {
      await acao(repository);
    } catch (erro) {
      _erroClientes.value = _mensagemErroCliente(erro);
    } finally {
      _carregandoClientes.value = false;
      _salvandoCliente.value = false;
    }
  }

  void _selecionarClienteNoRecibo(Cliente cliente) {
    _atualizarRecibo(
      reciboEmEdicao.copyWith(
        cliente: cliente.nome,
        telefone: cliente.telefone,
      ),
    );
  }

  static String _mensagemErroCliente(Object erro) {
    final mensagem = erro.toString();
    const prefixos = ['Bad state: ', 'Invalid argument(s): '];

    for (final prefixo in prefixos) {
      if (mensagem.startsWith(prefixo)) {
        return mensagem.substring(prefixo.length);
      }
    }

    return mensagem;
  }

  static Recibo _criarReciboInicial({
    required int totalPedidoCentavos,
    required int valorEntradaCentavos,
  }) {
    if (totalPedidoCentavos == 0 && valorEntradaCentavos == 0) {
      return _criarReciboVazio();
    }

    return _criarReciboVazio().copyWith(
      itens: totalPedidoCentavos == 0
          ? const <ItemRecibo>[]
          : <ItemRecibo>[
              ItemRecibo(
                ordem: 1,
                quantidade: 1,
                descricao: 'Item temporário',
                valorUnitarioCentavos: totalPedidoCentavos,
              ),
            ],
      valorEntradaCentavos: valorEntradaCentavos,
    );
  }

  static Recibo _criarReciboVazio() {
    return Recibo(
      numero: '',
      cliente: '',
      dataRecebimento: DateTime.now(),
      dataEntrega: DateTime.now(),
    );
  }

  static List<ItemRecibo> _reordenarItens(List<ItemRecibo> itens) {
    return [
      for (var indice = 0; indice < itens.length; indice++)
        itens[indice].copyWith(ordem: indice + 1),
    ];
  }

  static Recibo _duplicarSemIds(Recibo recibo) {
    return Recibo(
      numero: '',
      cliente: recibo.cliente,
      dataRecebimento: recibo.dataRecebimento,
      dataEntrega: recibo.dataEntrega,
      telefone: recibo.telefone,
      observacoes: recibo.observacoes,
      valorEntradaCentavos: recibo.valorEntradaCentavos,
      itens: [
        for (var indice = 0; indice < recibo.itens.length; indice++)
          ItemRecibo(
            ordem: indice + 1,
            quantidade: recibo.itens[indice].quantidade,
            descricao: recibo.itens[indice].descricao,
            valorUnitarioCentavos: recibo.itens[indice].valorUnitarioCentavos,
          ),
      ],
    );
  }

  static String _formatarCentavosComoMoeda(int centavos) {
    final sinal = centavos < 0 ? '-' : '';
    final valorAbsoluto = centavos.abs();
    final reais = valorAbsoluto ~/ 100;
    final centavosRestantes = valorAbsoluto % 100;

    return '${sinal}R\$ $reais,${centavosRestantes.toString().padLeft(2, '0')}';
  }
}
