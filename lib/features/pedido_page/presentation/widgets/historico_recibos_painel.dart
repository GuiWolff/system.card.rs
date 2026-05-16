import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/recibo.dart';

class HistoricoRecibosPainel extends StatefulWidget {
  const HistoricoRecibosPainel({
    required this.historico,
    required this.carregando,
    required this.onPesquisar,
    required this.onCarregar,
    required this.onDuplicar,
    required this.onExcluir,
    super.key,
  });

  final List<Recibo> historico;
  final bool carregando;
  final ValueChanged<String> onPesquisar;
  final ValueChanged<Recibo> onCarregar;
  final ValueChanged<Recibo> onDuplicar;
  final ValueChanged<Recibo> onExcluir;

  @override
  State<HistoricoRecibosPainel> createState() => _HistoricoRecibosPainelState();
}

class _HistoricoRecibosPainelState extends State<HistoricoRecibosPainel> {
  late final TextEditingController _pesquisaController;

  @override
  void initState() {
    super.initState();
    _pesquisaController = TextEditingController();
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      container: true,
      namesRoute: true,
      label: 'Histórico de recibos',
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.clockRotateLeft,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Histórico de recibos',
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Fechar histórico',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pesquisaController,
              decoration: InputDecoration(
                labelText: 'Pesquisar por número, cliente ou telefone',
                prefixIcon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                suffixIcon: IconButton(
                  tooltip: 'Limpar pesquisa',
                  onPressed: () {
                    _pesquisaController.clear();
                    widget.onPesquisar('');
                  },
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                ),
              ),
              textInputAction: TextInputAction.search,
              onChanged: widget.onPesquisar,
              onSubmitted: widget.onPesquisar,
            ),
            const SizedBox(height: 16),
            if (widget.carregando)
              const LinearProgressIndicator()
            else
              const SizedBox(height: 4),
            const SizedBox(height: 12),
            Flexible(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border.all(color: colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: widget.historico.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Nenhum recibo encontrado.'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.historico.length,
                        itemBuilder: (context, indice) {
                          final recibo = widget.historico[indice];
                          return _HistoricoReciboItem(
                            recibo: recibo,
                            onCarregar: widget.onCarregar,
                            onDuplicar: widget.onDuplicar,
                            onExcluir: widget.onExcluir,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoricoReciboItem extends StatelessWidget {
  const _HistoricoReciboItem({
    required this.recibo,
    required this.onCarregar,
    required this.onDuplicar,
    required this.onExcluir,
  });

  final Recibo recibo;
  final ValueChanged<Recibo> onCarregar;
  final ValueChanged<Recibo> onDuplicar;
  final ValueChanged<Recibo> onExcluir;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compacto = constraints.maxWidth < 760;
            final detalhes = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recibo ${recibo.numero}', style: textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(recibo.cliente),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  runSpacing: 4,
                  children: [
                    Text('Recebido: ${_formatarData(recibo.dataRecebimento)}'),
                    Text(
                      'Total: ${_formatarCentavos(recibo.totalPedidoCentavos)}',
                    ),
                    Text(
                      'Atualizado: ${_formatarDataHora(recibo.atualizadoEm)}',
                    ),
                  ],
                ),
              ],
            );
            final acoes = Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () => onCarregar(recibo),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.secondary,
                    side: BorderSide(color: colorScheme.secondary),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.fileArrowUp),
                  label: const Text('Carregar'),
                ),
                OutlinedButton.icon(
                  onPressed: () => onDuplicar(recibo),
                  icon: const FaIcon(FontAwesomeIcons.copy),
                  label: const Text('Duplicar'),
                ),
                OutlinedButton.icon(
                  onPressed: () => onExcluir(recibo),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.trashCan),
                  label: const Text('Excluir'),
                ),
              ],
            );

            if (compacto) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [detalhes, const SizedBox(height: 12), acoes],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: detalhes),
                const SizedBox(width: 16),
                acoes,
              ],
            );
          },
        ),
      ),
    );
  }

  static String _formatarData(DateTime? data) {
    if (data == null) {
      return '-';
    }

    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year.toString().padLeft(4, '0')}';
  }

  static String _formatarDataHora(DateTime? data) {
    if (data == null) {
      return '-';
    }

    return '${_formatarData(data)} '
        '${data.hour.toString().padLeft(2, '0')}:'
        '${data.minute.toString().padLeft(2, '0')}';
  }

  static String _formatarCentavos(int centavos) {
    final sinal = centavos < 0 ? '-' : '';
    final valorAbsoluto = centavos.abs();
    final reais = valorAbsoluto ~/ 100;
    final centavosRestantes = valorAbsoluto % 100;

    return '${sinal}R\$ $reais,${centavosRestantes.toString().padLeft(2, '0')}';
  }
}
