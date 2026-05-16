import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ReciboCompartilhamentoOpcao { email, whatsapp, salvarArquivo }

class ReciboCompartilhamentoDialog extends StatelessWidget {
  const ReciboCompartilhamentoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Row(
        children: [
          FaIcon(FontAwesomeIcons.shareNodes, color: colorScheme.primary),
          const SizedBox(width: 10),
          const Expanded(child: Text('Compartilhar recibo')),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _OpcaoCompartilhamento(
              key: ValueKey('recibo-compartilhar-email'),
              opcao: ReciboCompartilhamentoOpcao.email,
              icon: FontAwesomeIcons.envelope,
              titulo: 'E-mail',
            ),
            _OpcaoCompartilhamento(
              key: ValueKey('recibo-compartilhar-whatsapp'),
              opcao: ReciboCompartilhamentoOpcao.whatsapp,
              icon: FontAwesomeIcons.whatsapp,
              titulo: 'WhatsApp',
            ),
            _OpcaoCompartilhamento(
              key: ValueKey('recibo-compartilhar-salvar-arquivo'),
              opcao: ReciboCompartilhamentoOpcao.salvarArquivo,
              icon: FontAwesomeIcons.fileArrowDown,
              titulo: 'Salvar arquivo',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

class _OpcaoCompartilhamento extends StatelessWidget {
  const _OpcaoCompartilhamento({
    required this.opcao,
    required this.icon,
    required this.titulo,
    super.key,
  });

  final ReciboCompartilhamentoOpcao opcao;
  final FaIconData icon;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
          leading: FaIcon(icon, color: colorScheme.secondary),
          title: Text(titulo),
          onTap: () => Navigator.of(context).pop(opcao),
        ),
      ),
    );
  }
}
