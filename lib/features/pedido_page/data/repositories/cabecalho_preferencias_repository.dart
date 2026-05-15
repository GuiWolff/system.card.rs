import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/cabecalho_empresa.dart';

class CabecalhoPreferenciasRepository {
  CabecalhoPreferenciasRepository(this._preferencias);

  final SharedPreferences _preferencias;

  static const chaveNomeEmpresa = 'pedido_page.cabecalho.nome_empresa';
  static const chaveSubtitulo = 'pedido_page.cabecalho.subtitulo';
  static const chaveInstagram = 'pedido_page.cabecalho.instagram';
  static const chaveWhatsapp = 'pedido_page.cabecalho.whatsapp';
  static const chaveTelefone = 'pedido_page.cabecalho.telefone';
  static const chaveEndereco = 'pedido_page.cabecalho.endereco';
  static const chaveLogoBase64 = 'pedido_page.cabecalho.logo_base64';

  static const _chaves = [
    chaveNomeEmpresa,
    chaveSubtitulo,
    chaveInstagram,
    chaveWhatsapp,
    chaveTelefone,
    chaveEndereco,
    chaveLogoBase64,
  ];

  static Future<CabecalhoPreferenciasRepository> carregarInstancia() async {
    final preferencias = await SharedPreferences.getInstance();
    return CabecalhoPreferenciasRepository(preferencias);
  }

  CabecalhoEmpresa carregar() {
    const padrao = CabecalhoEmpresa.systemCardRs();
    final logoBase64 = _logoBase64Salvo();

    return padrao.copyWith(
      nomeEmpresa: _textoSalvo(chaveNomeEmpresa, padrao.nomeEmpresa),
      subtitulo: _textoSalvo(chaveSubtitulo, padrao.subtitulo),
      instagram: _textoSalvo(chaveInstagram, padrao.instagram),
      whatsapp: _textoSalvo(chaveWhatsapp, padrao.whatsapp),
      telefone: _textoSalvo(chaveTelefone, padrao.telefone),
      endereco: _textoSalvo(chaveEndereco, padrao.endereco),
      logoBase64: logoBase64,
      removerLogoBase64: logoBase64 == null,
    );
  }

  Future<void> salvar(CabecalhoEmpresa cabecalho) async {
    await _preferencias.setString(
      chaveNomeEmpresa,
      cabecalho.nomeEmpresa.trim(),
    );
    await _preferencias.setString(chaveSubtitulo, cabecalho.subtitulo.trim());
    await _preferencias.setString(chaveInstagram, cabecalho.instagram.trim());
    await _preferencias.setString(chaveWhatsapp, cabecalho.whatsapp.trim());
    await _preferencias.setString(chaveTelefone, cabecalho.telefone.trim());
    await _preferencias.setString(chaveEndereco, cabecalho.endereco.trim());

    final logoBase64 = cabecalho.logoBase64?.trim();
    if (logoBase64 == null || logoBase64.isEmpty) {
      await _preferencias.remove(chaveLogoBase64);
      return;
    }

    await _preferencias.setString(chaveLogoBase64, logoBase64);
  }

  Future<CabecalhoEmpresa> removerLogo() async {
    await _preferencias.remove(chaveLogoBase64);
    return carregar();
  }

  Future<CabecalhoEmpresa> restaurarPadrao() async {
    for (final chave in _chaves) {
      await _preferencias.remove(chave);
    }

    return const CabecalhoEmpresa.systemCardRs();
  }

  String _textoSalvo(String chave, String valorPadrao) {
    final valor = _preferencias.getString(chave)?.trim();
    if (valor == null || valor.isEmpty) {
      return valorPadrao;
    }

    return valor;
  }

  String? _logoBase64Salvo() {
    final valor = _preferencias.getString(chaveLogoBase64)?.trim();
    if (valor == null || valor.isEmpty) {
      return null;
    }

    try {
      base64Decode(valor);
      return valor;
    } on FormatException {
      return null;
    }
  }
}
