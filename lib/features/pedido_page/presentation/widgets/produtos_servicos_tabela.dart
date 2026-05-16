import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/item_recibo.dart';

class ProdutosServicosTabela extends StatelessWidget {
  const ProdutosServicosTabela({
    required this.itens,
    required this.onAdicionarItem,
    required this.onAdicionarItemPeloValorUnitario,
    required this.onAtualizarItem,
    required this.onRemoverItem,
    this.somenteLeitura = false,
    super.key,
  });

  final List<ItemRecibo> itens;
  final VoidCallback onAdicionarItem;
  final bool Function(int indice) onAdicionarItemPeloValorUnitario;
  final void Function(int indice, ItemRecibo item) onAtualizarItem;
  final ValueChanged<int> onRemoverItem;
  final bool somenteLeitura;

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
              onPressed: somenteLeitura ? null : onAdicionarItem,
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.tertiary,
                foregroundColor: colorScheme.onTertiary,
              ),
              icon: const FaIcon(FontAwesomeIcons.plus),
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
                            onAdicionarItemPeloValorUnitario:
                                onAdicionarItemPeloValorUnitario,
                            onAtualizarItem: onAtualizarItem,
                            onRemoverItem: onRemoverItem,
                            somenteLeitura: somenteLeitura,
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
          padding: EdgeInsets.symmetric(
            horizontal: _TabelaMetricas.paddingHorizontal,
            vertical: 10,
          ),
          child: Row(
            children: [
              SizedBox(
                width: _TabelaMetricas.larguraQuantidade,
                child: Text('Qtd.', textAlign: TextAlign.center),
              ),
              SizedBox(width: _TabelaMetricas.espacamentoColunas),
              Expanded(child: Text('Produtos')),
              SizedBox(width: _TabelaMetricas.espacamentoColunas),
              SizedBox(
                width: _TabelaMetricas.larguraValorUnitario,
                child: Text('Vl. unitário'),
              ),
              SizedBox(width: _TabelaMetricas.espacamentoColunas),
              SizedBox(
                width: _TabelaMetricas.larguraTotal,
                child: Text('Vl. total', textAlign: TextAlign.right),
              ),
              SizedBox(width: _TabelaMetricas.espacamentoColunas),
              SizedBox(width: _TabelaMetricas.larguraAcao),
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
    required this.onAdicionarItemPeloValorUnitario,
    required this.onAtualizarItem,
    required this.onRemoverItem,
    required this.somenteLeitura,
  });

  final int indice;
  final ItemRecibo item;
  final bool Function(int indice) onAdicionarItemPeloValorUnitario;
  final void Function(int indice, ItemRecibo item) onAtualizarItem;
  final ValueChanged<int> onRemoverItem;
  final bool somenteLeitura;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(_TabelaMetricas.paddingHorizontal),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compacto = constraints.maxWidth < 720;
          final quantidade = _CampoQuantidade(
            indice: indice,
            item: item,
            onAtualizarItem: onAtualizarItem,
            somenteLeitura: somenteLeitura,
          );
          final descricao = _CampoDescricao(
            indice: indice,
            item: item,
            onAtualizarItem: onAtualizarItem,
            somenteLeitura: somenteLeitura,
          );
          final valorUnitario = _CampoValorUnitario(
            indice: indice,
            item: item,
            onAdicionarItemPeloValorUnitario: onAdicionarItemPeloValorUnitario,
            onAtualizarItem: onAtualizarItem,
            somenteLeitura: somenteLeitura,
          );
          final total = _TotalItem(
            item: item,
            textTheme: textTheme,
            colorScheme: colorScheme,
          );
          final remover = IconButton(
            tooltip: 'Remover item',
            onPressed: somenteLeitura ? null : () => onRemoverItem(indice),
            icon: FaIcon(FontAwesomeIcons.trashCan, color: colorScheme.error),
          );

          if (compacto) {
            return Wrap(
              spacing: _TabelaMetricas.espacamentoColunas,
              runSpacing: _TabelaMetricas.espacamentoColunas,
              children: [
                SizedBox(width: constraints.maxWidth, child: quantidade),
                SizedBox(width: constraints.maxWidth, child: descricao),
                SizedBox(width: constraints.maxWidth, child: valorUnitario),
                SizedBox(width: constraints.maxWidth, child: total),
                remover,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: _TabelaMetricas.larguraQuantidade,
                child: quantidade,
              ),
              const SizedBox(width: _TabelaMetricas.espacamentoColunas),
              Expanded(child: descricao),
              const SizedBox(width: _TabelaMetricas.espacamentoColunas),
              SizedBox(
                width: _TabelaMetricas.larguraValorUnitario,
                child: valorUnitario,
              ),
              const SizedBox(width: _TabelaMetricas.espacamentoColunas),
              SizedBox(width: _TabelaMetricas.larguraTotal, child: total),
              const SizedBox(width: _TabelaMetricas.espacamentoColunas),
              SizedBox(
                width: _TabelaMetricas.larguraAcao,
                child: Align(alignment: Alignment.topCenter, child: remover),
              ),
            ],
          );
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

class _TabelaMetricas {
  const _TabelaMetricas._();

  static const double paddingHorizontal = 12;
  static const double espacamentoColunas = 12;
  static const double larguraQuantidade = 84;
  static const double larguraValorUnitario = 150;
  static const double larguraTotal = 140;
  static const double larguraAcao = 48;
}

class _CampoQuantidade extends StatefulWidget {
  const _CampoQuantidade({
    required this.indice,
    required this.item,
    required this.onAtualizarItem,
    required this.somenteLeitura,
  });

  final int indice;
  final ItemRecibo item;
  final void Function(int indice, ItemRecibo item) onAtualizarItem;
  final bool somenteLeitura;

  @override
  State<_CampoQuantidade> createState() => _CampoQuantidadeState();
}

class _CampoQuantidadeState extends State<_CampoQuantidade> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.item.quantidade.toString(),
    );
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _CampoQuantidade oldWidget) {
    super.didUpdateWidget(oldWidget);
    final quantidade = widget.item.quantidade.toString();
    if (quantidade != oldWidget.item.quantidade.toString() &&
        !_focusNode.hasFocus) {
      _sincronizarTexto(quantidade);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey('produto-quantidade-${widget.indice}'),
      controller: _controller,
      focusNode: _focusNode,
      decoration: const InputDecoration(labelText: 'Qtd.'),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textAlign: TextAlign.center,
      readOnly: widget.somenteLeitura,
      enabled: !widget.somenteLeitura,
      onChanged: (valor) {
        if (widget.somenteLeitura) {
          return;
        }

        final quantidade = int.tryParse(valor) ?? 0;
        widget.onAtualizarItem(
          widget.indice,
          widget.item.copyWith(quantidade: quantidade),
        );
      },
    );
  }

  void _sincronizarTexto(String texto) {
    if (_controller.text == texto) {
      return;
    }

    _controller.value = TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}

class _CampoDescricao extends StatefulWidget {
  const _CampoDescricao({
    required this.indice,
    required this.item,
    required this.onAtualizarItem,
    required this.somenteLeitura,
  });

  final int indice;
  final ItemRecibo item;
  final void Function(int indice, ItemRecibo item) onAtualizarItem;
  final bool somenteLeitura;

  @override
  State<_CampoDescricao> createState() => _CampoDescricaoState();
}

class _CampoDescricaoState extends State<_CampoDescricao> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.item.descricao);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _CampoDescricao oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.descricao != oldWidget.item.descricao &&
        !_focusNode.hasFocus) {
      _sincronizarTexto(widget.item.descricao);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey('produto-descricao-${widget.indice}'),
      controller: _controller,
      focusNode: _focusNode,
      decoration: const InputDecoration(labelText: 'Descrição'),
      textInputAction: TextInputAction.next,
      readOnly: widget.somenteLeitura,
      enabled: !widget.somenteLeitura,
      onChanged: (valor) {
        if (widget.somenteLeitura) {
          return;
        }

        widget.onAtualizarItem(
          widget.indice,
          widget.item.copyWith(descricao: valor),
        );
      },
    );
  }

  void _sincronizarTexto(String texto) {
    if (_controller.text == texto) {
      return;
    }

    _controller.value = TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}

class _CampoValorUnitario extends StatefulWidget {
  const _CampoValorUnitario({
    required this.indice,
    required this.item,
    required this.onAdicionarItemPeloValorUnitario,
    required this.onAtualizarItem,
    required this.somenteLeitura,
  });

  final int indice;
  final ItemRecibo item;
  final bool Function(int indice) onAdicionarItemPeloValorUnitario;
  final void Function(int indice, ItemRecibo item) onAtualizarItem;
  final bool somenteLeitura;

  @override
  State<_CampoValorUnitario> createState() => _CampoValorUnitarioState();
}

class _CampoValorUnitarioState extends State<_CampoValorUnitario> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: _ProdutoServicoLinha._formatarCentavos(
        widget.item.valorUnitarioCentavos,
      ),
    );
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _CampoValorUnitario oldWidget) {
    super.didUpdateWidget(oldWidget);
    final valorUnitario = _ProdutoServicoLinha._formatarCentavos(
      widget.item.valorUnitarioCentavos,
    );
    if (widget.item.valorUnitarioCentavos !=
            oldWidget.item.valorUnitarioCentavos &&
        !_focusNode.hasFocus) {
      _sincronizarTexto(valorUnitario);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey('produto-valor-unitario-${widget.indice}'),
      controller: _controller,
      focusNode: _focusNode,
      decoration: const InputDecoration(labelText: 'Valor unitário'),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))],
      textInputAction: TextInputAction.done,
      readOnly: widget.somenteLeitura,
      enabled: !widget.somenteLeitura,
      onChanged: (valor) {
        if (widget.somenteLeitura) {
          return;
        }

        widget.onAtualizarItem(
          widget.indice,
          widget.item.copyWith(
            valorUnitarioCentavos: _ProdutoServicoLinha._converterMoeda(valor),
          ),
        );
      },
      onFieldSubmitted: (_) {
        if (widget.somenteLeitura) {
          return;
        }

        final adicionou = widget.onAdicionarItemPeloValorUnitario(
          widget.indice,
        );
        if (!adicionou) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _focusNode.requestFocus();
            }
          });
        }
      },
    );
  }

  void _sincronizarTexto(String texto) {
    if (_controller.text == texto) {
      return;
    }

    _controller.value = TextEditingValue(
      text: texto,
      selection: TextSelection.collapsed(offset: texto.length),
    );
  }
}

class _TotalItem extends StatelessWidget {
  const _TotalItem({
    required this.item,
    required this.textTheme,
    required this.colorScheme,
  });

  final ItemRecibo item;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Total', style: textTheme.labelMedium),
          const SizedBox(height: 4),
          Text(
            _ProdutoServicoLinha._formatarCentavos(item.totalCentavos),
            textAlign: TextAlign.right,
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.tertiary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
