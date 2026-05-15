import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_card_rs/features/pedido_page/data/repositories/cabecalho_preferencias_repository.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  test('carrega cabeçalho padrão quando não há preferências salvas', () async {
    SharedPreferences.setMockInitialValues({});
    final preferencias = await SharedPreferences.getInstance();
    final repository = CabecalhoPreferenciasRepository(preferencias);

    final cabecalho = repository.carregar();

    expect(cabecalho.nomeEmpresa, 'SYSTEM CARD - RS');
    expect(cabecalho.subtitulo, 'Sistemas de Identificação');
    expect(cabecalho.instagram, '@systemcards');
    expect(cabecalho.whatsapp, '51 998020198');
    expect(cabecalho.telefone, '51 30551025');
    expect(cabecalho.logoBase64, isNull);
    expect(cabecalho.logoAssetPath, isNull);
    expect(cabecalho.acoesDisponiveis, isNotEmpty);
  });

  test(
    'salva e carrega dados editáveis do cabeçalho com logo base64',
    () async {
      SharedPreferences.setMockInitialValues({});
      final preferencias = await SharedPreferences.getInstance();
      final repository = CabecalhoPreferenciasRepository(preferencias);
      final cabecalho = const CabecalhoEmpresa.systemCardRs().copyWith(
        nomeEmpresa: 'Empresa Teste',
        subtitulo: 'Identificação personalizada',
        instagram: '@empresa_teste',
        whatsapp: '51 99999-0000',
        telefone: '51 3000-0000',
        endereco: 'Rua Teste, 123',
        logoBase64: 'bG9nbw==',
      );

      await repository.salvar(cabecalho);

      final salvo = repository.carregar();

      expect(salvo.nomeEmpresa, 'Empresa Teste');
      expect(salvo.subtitulo, 'Identificação personalizada');
      expect(salvo.instagram, '@empresa_teste');
      expect(salvo.whatsapp, '51 99999-0000');
      expect(salvo.telefone, '51 3000-0000');
      expect(salvo.endereco, 'Rua Teste, 123');
      expect(salvo.logoBase64, 'bG9nbw==');
      expect(salvo.referenciaVisualAssetPath, 'lib/resources/cabecalho.png');
    },
  );

  test('ignora dados ausentes, vazios ou logo base64 inválido', () async {
    SharedPreferences.setMockInitialValues({
      CabecalhoPreferenciasRepository.chaveNomeEmpresa: '',
      CabecalhoPreferenciasRepository.chaveSubtitulo: '  Subtítulo salvo  ',
      CabecalhoPreferenciasRepository.chaveInstagram: '   ',
      CabecalhoPreferenciasRepository.chaveLogoBase64: 'logo inválido',
    });
    final preferencias = await SharedPreferences.getInstance();
    final repository = CabecalhoPreferenciasRepository(preferencias);

    final cabecalho = repository.carregar();

    expect(cabecalho.nomeEmpresa, 'SYSTEM CARD - RS');
    expect(cabecalho.subtitulo, 'Subtítulo salvo');
    expect(cabecalho.instagram, '@systemcards');
    expect(cabecalho.whatsapp, '51 998020198');
    expect(cabecalho.logoBase64, isNull);
  });

  test('remove somente o logo salvo mantendo os demais dados', () async {
    SharedPreferences.setMockInitialValues({});
    final preferencias = await SharedPreferences.getInstance();
    final repository = CabecalhoPreferenciasRepository(preferencias);
    final cabecalho = const CabecalhoEmpresa.systemCardRs().copyWith(
      nomeEmpresa: 'Empresa com Logo',
      logoBase64: 'bG9nbw==',
    );

    await repository.salvar(cabecalho);
    final semLogo = await repository.removerLogo();

    expect(semLogo.nomeEmpresa, 'Empresa com Logo');
    expect(semLogo.logoBase64, isNull);
    expect(
      preferencias.containsKey(CabecalhoPreferenciasRepository.chaveLogoBase64),
      isFalse,
    );
  });

  test('restaura o padrão removendo as chaves persistidas', () async {
    SharedPreferences.setMockInitialValues({});
    final preferencias = await SharedPreferences.getInstance();
    final repository = CabecalhoPreferenciasRepository(preferencias);

    await repository.salvar(
      const CabecalhoEmpresa.systemCardRs().copyWith(
        nomeEmpresa: 'Empresa Alterada',
        logoBase64: 'bG9nbw==',
      ),
    );

    final restaurado = await repository.restaurarPadrao();

    expect(restaurado.nomeEmpresa, 'SYSTEM CARD - RS');
    expect(restaurado.logoBase64, isNull);
    expect(
      preferencias.containsKey(
        CabecalhoPreferenciasRepository.chaveNomeEmpresa,
      ),
      isFalse,
    );
    expect(
      preferencias.containsKey(CabecalhoPreferenciasRepository.chaveLogoBase64),
      isFalse,
    );
  });
}
