import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/item_recibo.dart';

class ProdutosServicosTabela extends StatelessWidget {
  const ProdutosServicosTabela({
    required this.itens,
    required this.onAdicionarItem,
    required this.onAtualizarItem,
    required this.onRemoverItem,
    super.key,
  });

  final List<ItemRecibo> itens;
  final VoidCallback onAdicionarItem;
  final void Function(int indice, ItemRecibo item) onAtualizarItem;
  final ValueChanged<int> onRemoverItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Produtos / Serviços',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            FilledButton.icon(
              onPressed: onAdicionarItem,
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.tertiary,
                foregroundColor: colorScheme.onTertiary,
              ),
              icon: const Icon(Icons.add),
              label: const Text('Adicionar item'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final compacto = constraints.maxWidth < 720;

            return DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: [
                    if (!compacto) const _TabelaCabecalho(),
                    if (itens.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Nenhum produto/serviço adicionado.'),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itens.length,
                        separatorBuilder: (_, _) => Divider(
                          height: 1,
                          color: colorScheme.outlineVariant,
                        ),
                        itemBuilder: (context, indice) {
                          return _ProdutoServicoLinha(
                            indice: indice,
                            item: itens[indice],
                            onAtualizarItem: onAtualizarItem,
                            onRemoverItem: onRemoverItem,
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _TabelaCabecalho extends StatelessWidget {
  const _TabelaCabecalho();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final estilo = textTheme.labelLarge?.copyWith(
      color: colorScheme.onSecondary,
      fontWeight: FontWeight.w800,
    );

    return ColoredBox(
      color: colorScheme.secondary,
      child: DefaultTextStyle.merge(
        style: estilo,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              SizedBox(width: 84, child: Text('Qtd.')),
              SizedBox(width: 12),
              Expanded(child: Text('Produtos')),
              SizedBox(width: 150, child: Text('Vl. unitário')),
              SizedBox(width: 140, child: Text('Vl. total')),
              SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProdutoServicoLinha extends StatelessWidget {
  const _ProdutoServicoLinha({
    required this.indice,
    required this.item,
    required this.onAtualizarItem,
    required this.onRemoverItem,
  });

  final int indice;
  final ItemRecibo item;
  final void Function(int indice, ItemRecibo item) onAtualizarItem;
  final ValueChanged<int> onRemoverItem;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compacto = constraints.maxWidth < 720;
          final campos = [
            SizedBox(
              width: compacto ? constraints.maxWidth : 84,
              child: TextFormField(
                key: ValueKey('quantidade-$indice-${item.quantidade}'),
                initialValue: item.quantidade.toString(),
                decoration: const InputDecoration(labelText: 'Qtd.'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (valor) {
                  final quantidade = int.tryParse(valor) ?? 0;
                  onAtualizarItem(
                    indice,
                    item.copyWith(quantidade: quantidade),
                  );
                },
              ),
            ),
            SizedBox(
              width: compacto ? constraints.maxWidth : 360,
              child: TextFormField(
                key: ValueKey('descricao-$indice-${item.descricao}'),
                initialValue: item.descricao,
                decoration: const InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                onChanged: (valor) {
                  onAtualizarItem(indice, item.copyWith(descricao: valor));
                },
              ),
            ),
            SizedBox(
              width: compacto ? constraints.maxWidth : 150,
              child: TextFormField(
                key: ValueKey(
                  'valor-unitario-$indice-${item.valorUnitarioCentavos}',
                ),
                initialValue: _formatarCentavos(item.valorUnitarioCentavos),
                decoration: const InputDecoration(labelText: 'Valor unitário'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                ],
                onChanged: (valor) {
                  onAtualizarItem(
                    indice,
                    item.copyWith(
                      valorUnitarioCentavos: _converterMoeda(valor),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: compacto ? constraints.maxWidth : 140,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total', style: textTheme.labelMedium),
                    const SizedBox(height: 4),
                    Text(
                      _formatarCentavos(item.totalCentavos),
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.tertiary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              tooltip: 'Remover item',
              onPressed: () => onRemoverItem(indice),
              icon: Icon(Icons.delete_outline, color: colorScheme.error),
            ),
          ];

          return Wrap(spacing: 12, runSpacing: 12, children: campos);
        },
      ),
    );
  }

  static String _formatarCentavos(int centavos) {
    final sinal = centavos < 0 ? '-' : '';
    final valorAbsoluto = centavos.abs();
    final reais = valorAbsoluto ~/ 100;
    final centavosRestantes = valorAbsoluto % 100;

    return '$sinal$reais,${centavosRestantes.toString().padLeft(2, '0')}';
  }

  static int _converterMoeda(String valor) {
    final semEspacos = valor.trim().replaceAll('R\$', '').replaceAll(' ', '');
    if (semEspacos.isEmpty) {
      return 0;
    }

    final normalizado = semEspacos.replaceAll('.', '').replaceAll(',', '.');
    final valorDecimal = double.tryParse(normalizado);
    if (valorDecimal == null) {
      return 0;
    }

    return (valorDecimal * 100).round();
  }
}
