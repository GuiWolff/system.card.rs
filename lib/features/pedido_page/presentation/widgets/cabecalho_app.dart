import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/models/cabecalho_empresa.dart';

class CabecalhoApp extends StatelessWidget {
  const CabecalhoApp({
    required this.cabecalho,
    this.onImprimir,
    this.onGerarPdf,
    this.onMaisOpcoes,
    this.onSelecionarMaisOpcao,
    this.onEditarCabecalho,
    this.editarCabecalhoHabilitado = true,
    this.feedback,
    super.key,
  });

  final CabecalhoEmpresa cabecalho;
  final VoidCallback? onImprimir;
  final VoidCallback? onGerarPdf;
  final VoidCallback? onMaisOpcoes;
  final ValueChanged<CabecalhoMenuOpcao>? onSelecionarMaisOpcao;
  final VoidCallback? onEditarCabecalho;
  final bool editarCabecalhoHabilitado;
  final String? feedback;

  static const double _breakpointMobile = 640;
  static const double _breakpointTablet = 920;
  static const double _logoDesktop = 72;
  static const double _logoMobile = 56;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      container: true,
      label: 'Cabeçalho da empresa',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < _breakpointMobile) {
                return _CabecalhoMobile(
                  cabecalho: cabecalho,
                  onEditarCabecalho: onEditarCabecalho,
                  editarCabecalhoHabilitado: editarCabecalhoHabilitado,
                  feedback: feedback,
                );
              }

              if (constraints.maxWidth < _breakpointTablet) {
                return _CabecalhoTablet(
                  cabecalho: cabecalho,
                  onEditarCabecalho: onEditarCabecalho,
                  editarCabecalhoHabilitado: editarCabecalhoHabilitado,
                  feedback: feedback,
                );
              }

              return _CabecalhoDesktop(
                cabecalho: cabecalho,
                onEditarCabecalho: onEditarCabecalho,
                editarCabecalhoHabilitado: editarCabecalhoHabilitado,
                feedback: feedback,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CabecalhoDesktop extends StatelessWidget {
  const _CabecalhoDesktop({
    required this.cabecalho,
    required this.onEditarCabecalho,
    required this.editarCabecalhoHabilitado,
    required this.feedback,
  });

  final CabecalhoEmpresa cabecalho;
  final VoidCallback? onEditarCabecalho;
  final bool editarCabecalhoHabilitado;
  final String? feedback;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: _IdentidadeEmpresa(
            cabecalho: cabecalho,
            tamanhoLogo: CabecalhoApp._logoDesktop,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(flex: 5, child: _ContatosEmpresa(cabecalho: cabecalho)),
        const SizedBox(width: 24),
        Flexible(
          flex: 3,
          child: _AcoesCabecalho(
            onEditarCabecalho: onEditarCabecalho,
            editarCabecalhoHabilitado: editarCabecalhoHabilitado,
            feedback: feedback,
          ),
        ),
      ],
    );
  }
}

class _CabecalhoTablet extends StatelessWidget {
  const _CabecalhoTablet({
    required this.cabecalho,
    required this.onEditarCabecalho,
    required this.editarCabecalhoHabilitado,
    required this.feedback,
  });

  final CabecalhoEmpresa cabecalho;
  final VoidCallback? onEditarCabecalho;
  final bool editarCabecalhoHabilitado;
  final String? feedback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _IdentidadeEmpresa(
                cabecalho: cabecalho,
                tamanhoLogo: CabecalhoApp._logoDesktop,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Align(
                alignment: Alignment.centerRight,
                child: _AcoesCabecalho(
                  onEditarCabecalho: onEditarCabecalho,
                  editarCabecalhoHabilitado: editarCabecalhoHabilitado,
                  feedback: feedback,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _ContatosEmpresa(cabecalho: cabecalho),
      ],
    );
  }
}

class _CabecalhoMobile extends StatelessWidget {
  const _CabecalhoMobile({
    required this.cabecalho,
    required this.onEditarCabecalho,
    required this.editarCabecalhoHabilitado,
    required this.feedback,
  });

  final CabecalhoEmpresa cabecalho;
  final VoidCallback? onEditarCabecalho;
  final bool editarCabecalhoHabilitado;
  final String? feedback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _IdentidadeEmpresa(
          cabecalho: cabecalho,
          tamanhoLogo: CabecalhoApp._logoMobile,
        ),
        const SizedBox(height: 16),
        _ContatosEmpresa(cabecalho: cabecalho),
        const SizedBox(height: 16),
        _AcoesCabecalho(
          onEditarCabecalho: onEditarCabecalho,
          editarCabecalhoHabilitado: editarCabecalhoHabilitado,
          feedback: feedback,
          expandirBotoes: true,
        ),
      ],
    );
  }
}

class _IdentidadeEmpresa extends StatelessWidget {
  const _IdentidadeEmpresa({
    required this.cabecalho,
    required this.tamanhoLogo,
  });

  final CabecalhoEmpresa cabecalho;
  final double tamanhoLogo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LogoEmpresa(cabecalho: cabecalho, tamanho: tamanhoLogo),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                cabecalho.nomeEmpresa,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    (tamanhoLogo >= CabecalhoApp._logoDesktop
                            ? textTheme.headlineSmall
                            : textTheme.titleLarge)
                        ?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
              ),
              const SizedBox(height: 4),
              Text(
                cabecalho.subtitulo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LogoEmpresa extends StatelessWidget {
  const _LogoEmpresa({required this.cabecalho, required this.tamanho});

  final CabecalhoEmpresa cabecalho;
  final double tamanho;

  @override
  Widget build(BuildContext context) {
    final logoAssetPath = cabecalho.logoAssetPath;
    final logoBase64 = cabecalho.logoBase64;

    if (logoBase64 != null) {
      final bytes = _decodificarLogo(logoBase64);
      if (bytes != null) {
        return Semantics(
          label: 'Logomarca ${cabecalho.nomeEmpresa}',
          image: true,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.memory(
              bytes,
              width: tamanho,
              height: tamanho,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  _LogoFallback(cabecalho: cabecalho, tamanho: tamanho),
            ),
          ),
        );
      }
    }

    if (logoAssetPath != null) {
      return Semantics(
        label: 'Logomarca ${cabecalho.nomeEmpresa}',
        image: true,
        child: Image.asset(
          logoAssetPath,
          width: tamanho,
          height: tamanho,
          fit: BoxFit.contain,
        ),
      );
    }

    return _LogoFallback(cabecalho: cabecalho, tamanho: tamanho);
  }

  Uint8List? _decodificarLogo(String logoBase64) {
    try {
      return base64Decode(logoBase64);
    } on FormatException {
      return null;
    }
  }
}

class _LogoFallback extends StatelessWidget {
  const _LogoFallback({required this.cabecalho, required this.tamanho});

  final CabecalhoEmpresa cabecalho;
  final double tamanho;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: 'Identidade visual ${cabecalho.nomeEmpresa}',
      image: true,
      child: Container(
        width: tamanho,
        height: tamanho,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.primary),
        ),
        child: Text(
          'SC',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _ContatosEmpresa extends StatelessWidget {
  const _ContatosEmpresa({required this.cabecalho});

  final CabecalhoEmpresa cabecalho;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 14,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _ContatoItem(
          icone: FaIcon(
            FontAwesomeIcons.instagram,
            size: 18,
            color: colorScheme.primary,
          ),
          label: 'Instagram',
          texto: cabecalho.instagram,
        ),
        _ContatoItem(
          icone: FaIcon(
            FontAwesomeIcons.whatsapp,
            size: 18,
            color: colorScheme.tertiary,
          ),
          label: 'WhatsApp',
          texto: cabecalho.whatsapp,
        ),
        _ContatoItem(
          icone: Icon(
            Icons.call_outlined,
            size: 18,
            color: colorScheme.onSurface,
          ),
          label: 'Telefone',
          texto: cabecalho.telefone,
        ),
        _ContatoItem(
          icone: Icon(
            Icons.location_on_outlined,
            size: 18,
            color: colorScheme.onSurface,
          ),
          label: 'Endereço',
          texto: cabecalho.endereco,
          larguraMaxima: 360,
        ),
      ],
    );
  }
}

class _ContatoItem extends StatelessWidget {
  const _ContatoItem({
    required this.icone,
    required this.label,
    required this.texto,
    this.larguraMaxima = 190,
  });

  final Widget icone;
  final String label;
  final String texto;
  final double larguraMaxima;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: '$label: $texto',
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: larguraMaxima),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(dimension: 18, child: icone),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                texto,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AcoesCabecalho extends StatelessWidget {
  const _AcoesCabecalho({
    required this.onEditarCabecalho,
    required this.editarCabecalhoHabilitado,
    required this.feedback,
    this.expandirBotoes = false,
  });

  final VoidCallback? onEditarCabecalho;
  final bool editarCabecalhoHabilitado;
  final String? feedback;
  final bool expandirBotoes;

  @override
  Widget build(BuildContext context) {
    final feedbackAtual = feedback;
    final botaoEditar = OutlinedButton.icon(
      key: const ValueKey('pedido-page-editar-cabecalho'),
      onPressed: editarCabecalhoHabilitado ? onEditarCabecalho : null,
      icon: const Icon(Icons.edit_outlined),
      label: const Text('Editar cabeçalho'),
    );

    if (expandirBotoes) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          botaoEditar,
          if (feedbackAtual != null) ...[
            const SizedBox(height: 8),
            _FeedbackCabecalho(texto: feedbackAtual),
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        botaoEditar,
        if (feedbackAtual != null) ...[
          const SizedBox(height: 8),
          _FeedbackCabecalho(texto: feedbackAtual),
        ],
      ],
    );
  }
}

class _FeedbackCabecalho extends StatelessWidget {
  const _FeedbackCabecalho({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      liveRegion: true,
      child: Text(
        texto,
        textAlign: TextAlign.end,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
