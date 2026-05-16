import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/models/cabecalho_empresa.dart';

class CabecalhoEditorDialog extends StatefulWidget {
  const CabecalhoEditorDialog({
    required this.cabecalho,
    required this.onSalvar,
    required this.onRemoverLogo,
    required this.onRestaurarPadrao,
    this.salvando = false,
    this.erro,
    super.key,
  });

  final CabecalhoEmpresa cabecalho;
  final Future<void> Function(CabecalhoEmpresa cabecalho) onSalvar;
  final Future<void> Function() onRemoverLogo;
  final Future<void> Function() onRestaurarPadrao;
  final bool salvando;
  final String? erro;

  @override
  State<CabecalhoEditorDialog> createState() => _CabecalhoEditorDialogState();
}

class _CabecalhoEditorDialogState extends State<CabecalhoEditorDialog> {
  static const int _tamanhoMaximoLogoBytes = 768 * 1024;

  late final TextEditingController _nomeController;
  late final TextEditingController _subtituloController;
  late final TextEditingController _instagramController;
  late final TextEditingController _whatsappController;
  late final TextEditingController _telefoneController;
  late final TextEditingController _enderecoController;
  String? _logoBase64;
  String? _erroSelecaoLogo;
  bool _salvandoLocal = false;

  @override
  void initState() {
    super.initState();
    final cabecalho = widget.cabecalho;
    _nomeController = TextEditingController(text: cabecalho.nomeEmpresa);
    _subtituloController = TextEditingController(text: cabecalho.subtitulo);
    _instagramController = TextEditingController(text: cabecalho.instagram);
    _whatsappController = TextEditingController(text: cabecalho.whatsapp);
    _telefoneController = TextEditingController(text: cabecalho.telefone);
    _enderecoController = TextEditingController(text: cabecalho.endereco);
    _logoBase64 = cabecalho.logoBase64;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _subtituloController.dispose();
    _instagramController.dispose();
    _whatsappController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final larguraConteudo = (MediaQuery.sizeOf(context).width - 96).clamp(
      280.0,
      720.0,
    );
    final usarDuasColunas = larguraConteudo >= 640;
    final larguraCampo = usarDuasColunas
        ? (larguraConteudo - 12) / 2
        : larguraConteudo;
    final salvando = widget.salvando || _salvandoLocal;
    final erro = _erroSelecaoLogo ?? widget.erro;

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Row(
        children: [
          FaIcon(FontAwesomeIcons.idBadge, color: colorScheme.primary),
          const SizedBox(width: 10),
          const Expanded(child: Text('Editar cabeçalho')),
        ],
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: larguraConteudo),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SecaoEditor(
                icone: FontAwesomeIcons.building,
                titulo: 'Identidade',
                descricao: 'Dados exibidos no topo do pedido e no recibo.',
              ),
              const SizedBox(height: 12),
              _LogoEditor(
                logoBase64: _logoBase64,
                nomeEmpresa: _nomeController.text,
                onSelecionarLogo: salvando ? null : _selecionarLogo,
                onRemoverLogo: salvando ? null : _removerLogo,
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _CampoCabecalho(
                    key: const ValueKey('cabecalho-editor-nome'),
                    controller: _nomeController,
                    label: 'Nome da empresa',
                    prefixIcon: FontAwesomeIcons.store,
                    largura: larguraCampo,
                  ),
                  _CampoCabecalho(
                    key: const ValueKey('cabecalho-editor-subtitulo'),
                    controller: _subtituloController,
                    label: 'Subtítulo',
                    prefixIcon: FontAwesomeIcons.heading,
                    largura: larguraCampo,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _SecaoEditor(
                icone: FontAwesomeIcons.addressBook,
                titulo: 'Contatos',
                descricao:
                    'Informações usadas na área de contato do cabeçalho.',
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _CampoCabecalho(
                    key: const ValueKey('cabecalho-editor-instagram'),
                    controller: _instagramController,
                    label: 'Instagram',
                    prefixIcon: FontAwesomeIcons.instagram,
                    largura: larguraCampo,
                  ),
                  _CampoCabecalho(
                    key: const ValueKey('cabecalho-editor-whatsapp'),
                    controller: _whatsappController,
                    label: 'WhatsApp',
                    prefixIcon: FontAwesomeIcons.whatsapp,
                    largura: larguraCampo,
                  ),
                  _CampoCabecalho(
                    key: const ValueKey('cabecalho-editor-telefone'),
                    controller: _telefoneController,
                    label: 'Telefone',
                    prefixIcon: FontAwesomeIcons.phone,
                    largura: larguraCampo,
                  ),
                  _CampoCabecalho(
                    key: const ValueKey('cabecalho-editor-endereco'),
                    controller: _enderecoController,
                    label: 'Endereço',
                    prefixIcon: FontAwesomeIcons.locationDot,
                    largura: larguraConteudo,
                  ),
                ],
              ),
              if (erro != null) ...[
                const SizedBox(height: 12),
                Text(
                  erro,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: salvando ? null : _restaurarPadrao,
          child: const Text('Restaurar padrão'),
        ),
        TextButton(
          onPressed: salvando ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton.icon(
          key: const ValueKey('cabecalho-editor-salvar'),
          onPressed: salvando ? null : _salvar,
          icon: salvando
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const FaIcon(FontAwesomeIcons.floppyDisk),
          label: const Text('Salvar'),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
    );
  }

  Future<void> _selecionarLogo() async {
    setState(() {
      _erroSelecaoLogo = null;
    });

    final resultado = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['png', 'jpg', 'jpeg', 'webp'],
      withData: true,
    );

    if (resultado == null || resultado.files.isEmpty) {
      return;
    }

    final arquivo = resultado.files.single;
    final bytes = arquivo.bytes;
    if (bytes == null) {
      setState(() {
        _erroSelecaoLogo = 'Não foi possível ler a imagem selecionada.';
      });
      return;
    }

    if (bytes.length > _tamanhoMaximoLogoBytes) {
      setState(() {
        _erroSelecaoLogo = 'Selecione uma imagem de até 768 KB.';
      });
      return;
    }

    setState(() {
      _logoBase64 = base64Encode(bytes);
      _erroSelecaoLogo = null;
    });
  }

  Future<void> _removerLogo() async {
    setState(() {
      _logoBase64 = null;
      _erroSelecaoLogo = null;
      _salvandoLocal = true;
    });

    await widget.onRemoverLogo();

    if (!mounted) {
      return;
    }

    setState(() {
      _salvandoLocal = false;
    });
  }

  Future<void> _restaurarPadrao() async {
    setState(() {
      _salvandoLocal = true;
      _erroSelecaoLogo = null;
    });

    await widget.onRestaurarPadrao();

    if (!mounted) {
      return;
    }

    setState(() {
      _salvandoLocal = false;
    });

    Navigator.of(context).pop();
  }

  Future<void> _salvar() async {
    setState(() {
      _salvandoLocal = true;
      _erroSelecaoLogo = null;
    });

    final cabecalhoAtualizado = widget.cabecalho.copyWith(
      nomeEmpresa: _nomeController.text,
      subtitulo: _subtituloController.text,
      instagram: _instagramController.text,
      whatsapp: _whatsappController.text,
      telefone: _telefoneController.text,
      endereco: _enderecoController.text,
      logoBase64: _logoBase64,
      removerLogoBase64: _logoBase64 == null,
      removerLogoAssetPath: _logoBase64 != null,
    );

    await widget.onSalvar(cabecalhoAtualizado);

    if (!mounted) {
      return;
    }

    setState(() {
      _salvandoLocal = false;
    });

    Navigator.of(context).pop();
  }
}

class _SecaoEditor extends StatelessWidget {
  const _SecaoEditor({
    required this.icone,
    required this.titulo,
    required this.descricao,
  });

  final FaIconData icone;
  final String titulo;
  final String descricao;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: FaIcon(icone, color: colorScheme.onPrimaryContainer, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                descricao,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LogoEditor extends StatelessWidget {
  const _LogoEditor({
    required this.logoBase64,
    required this.nomeEmpresa,
    required this.onSelecionarLogo,
    required this.onRemoverLogo,
  });

  final String? logoBase64;
  final String nomeEmpresa;
  final VoidCallback? onSelecionarLogo;
  final VoidCallback? onRemoverLogo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 16,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _PreviewLogo(logoBase64: logoBase64, nomeEmpresa: nomeEmpresa),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 220),
              child: Text(
                'Use uma imagem quadrada em PNG, JPG ou WebP de até 768 KB.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            OutlinedButton.icon(
              key: const ValueKey('cabecalho-editor-selecionar-logo'),
              onPressed: onSelecionarLogo,
              icon: const FaIcon(FontAwesomeIcons.image),
              label: const Text('Selecionar logo'),
            ),
            TextButton.icon(
              key: const ValueKey('cabecalho-editor-remover-logo'),
              onPressed: onRemoverLogo,
              icon: const FaIcon(FontAwesomeIcons.trashCan),
              label: const Text('Remover logo'),
              style: TextButton.styleFrom(foregroundColor: colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewLogo extends StatelessWidget {
  const _PreviewLogo({required this.logoBase64, required this.nomeEmpresa});

  final String? logoBase64;
  final String nomeEmpresa;

  @override
  Widget build(BuildContext context) {
    final bytes = _bytesLogo();
    final colorScheme = Theme.of(context).colorScheme;

    if (bytes != null) {
      return Semantics(
        label: 'Prévia da logo $nomeEmpresa',
        image: true,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            bytes,
            width: 72,
            height: 72,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                _fallback(colorScheme),
          ),
        ),
      );
    }

    return _fallback(colorScheme);
  }

  Widget _fallback(ColorScheme colorScheme) {
    return Container(
      width: 72,
      height: 72,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'SC',
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Uint8List? _bytesLogo() {
    final logo = logoBase64;
    if (logo == null) {
      return null;
    }

    try {
      return base64Decode(logo);
    } on FormatException {
      return null;
    }
  }
}

class _CampoCabecalho extends StatelessWidget {
  const _CampoCabecalho({
    required this.controller,
    required this.label,
    required this.prefixIcon,
    required this.largura,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final FaIconData prefixIcon;
  final double largura;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: largura,
      child: TextField(
        key: key,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: FaIcon(prefixIcon),
        ),
      ),
    );
  }
}
