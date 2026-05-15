class CabecalhoEmpresa {
  const CabecalhoEmpresa({
    this.logoAssetPath,
    this.logoBase64,
    required this.referenciaVisualAssetPath,
    required this.nomeEmpresa,
    required this.subtitulo,
    required this.instagram,
    required this.whatsapp,
    required this.telefone,
    required this.endereco,
    required this.acoesDisponiveis,
  });

  const CabecalhoEmpresa.systemCardRs()
    : logoAssetPath = null,
      logoBase64 = null,
      referenciaVisualAssetPath = 'lib/resources/cabecalho.png',
      nomeEmpresa = 'SYSTEM CARD - RS',
      subtitulo = 'Sistemas de Identificação',
      instagram = '@systemcards',
      whatsapp = '51 998020198',
      telefone = '51 30551025',
      endereco = 'Rua 20 de Setembro, 528 - Centro - Guaíba - RS',
      acoesDisponiveis = const [
        CabecalhoAcao(id: CabecalhoAcaoId.imprimir, rotulo: 'IMPRIMIR'),
        CabecalhoAcao(id: CabecalhoAcaoId.gerarPdf, rotulo: 'GERAR PDF'),
        CabecalhoAcao(id: CabecalhoAcaoId.maisOpcoes, rotulo: 'MAIS OPÇÕES'),
      ];

  final String? logoAssetPath;
  final String? logoBase64;
  final String referenciaVisualAssetPath;
  final String nomeEmpresa;
  final String subtitulo;
  final String instagram;
  final String whatsapp;
  final String telefone;
  final String endereco;
  final List<CabecalhoAcao> acoesDisponiveis;

  CabecalhoEmpresa copyWith({
    String? logoAssetPath,
    String? logoBase64,
    String? referenciaVisualAssetPath,
    String? nomeEmpresa,
    String? subtitulo,
    String? instagram,
    String? whatsapp,
    String? telefone,
    String? endereco,
    List<CabecalhoAcao>? acoesDisponiveis,
    bool removerLogoAssetPath = false,
    bool removerLogoBase64 = false,
  }) {
    return CabecalhoEmpresa(
      logoAssetPath: removerLogoAssetPath
          ? null
          : logoAssetPath ?? this.logoAssetPath,
      logoBase64: removerLogoBase64 ? null : logoBase64 ?? this.logoBase64,
      referenciaVisualAssetPath:
          referenciaVisualAssetPath ?? this.referenciaVisualAssetPath,
      nomeEmpresa: nomeEmpresa ?? this.nomeEmpresa,
      subtitulo: subtitulo ?? this.subtitulo,
      instagram: instagram ?? this.instagram,
      whatsapp: whatsapp ?? this.whatsapp,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      acoesDisponiveis: acoesDisponiveis ?? this.acoesDisponiveis,
    );
  }
}

class CabecalhoAcao {
  const CabecalhoAcao({
    required this.id,
    required this.rotulo,
    this.habilitada = true,
    this.emAndamento = false,
  });

  final CabecalhoAcaoId id;
  final String rotulo;
  final bool habilitada;
  final bool emAndamento;

  CabecalhoAcao copyWith({
    CabecalhoAcaoId? id,
    String? rotulo,
    bool? habilitada,
    bool? emAndamento,
  }) {
    return CabecalhoAcao(
      id: id ?? this.id,
      rotulo: rotulo ?? this.rotulo,
      habilitada: habilitada ?? this.habilitada,
      emAndamento: emAndamento ?? this.emAndamento,
    );
  }
}

enum CabecalhoAcaoId { imprimir, gerarPdf, maisOpcoes }

enum CabecalhoMenuOpcao { salvar, historico, novoRecibo }
