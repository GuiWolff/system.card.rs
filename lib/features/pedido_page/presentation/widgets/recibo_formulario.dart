import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/cliente.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/recibo.dart';
import 'package:system_card_rs/features/pedido_page/presentation/input_formatters/monetario_input_formatter.dart';
import 'package:system_card_rs/features/pedido_page/presentation/input_formatters/telefone_input_formatter.dart';

class ReciboFormulario extends StatelessWidget {
  const ReciboFormulario({
    required this.recibo,
    required this.valorEntradaFormatado,
    required this.onNumeroChanged,
    required this.onDataRecebimentoChanged,
    required this.onDataEntregaChanged,
    required this.onClienteChanged,
    required this.onPesquisarCliente,
    required this.onClienteSelecionado,
    required this.onTelefoneChanged,
    required this.onValorEntradaChanged,
    required this.onObservacoesChanged,
    this.clientesSugeridos = const <Cliente>[],
    this.carregandoClientes = false,
    this.somenteLeitura = false,
    super.key,
  });

  final Recibo recibo;
  final String valorEntradaFormatado;
  final ValueChanged<String> onNumeroChanged;
  final ValueChanged<DateTime> onDataRecebimentoChanged;
  final ValueChanged<DateTime> onDataEntregaChanged;
  final ValueChanged<String> onClienteChanged;
  final Future<void> Function(String termo) onPesquisarCliente;
  final ValueChanged<Cliente> onClienteSelecionado;
  final ValueChanged<String> onTelefoneChanged;
  final ValueChanged<int> onValorEntradaChanged;
  final ValueChanged<String> onObservacoesChanged;
  final List<Cliente> clientesSugeridos;
  final bool carregandoClientes;
  final bool somenteLeitura;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 18,
                  color: colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Dados do Recibo',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final largura = constraints.maxWidth;
                final colunas = largura >= 900
                    ? 3
                    : largura >= 640
                    ? 2
                    : 1;
                final larguraCampo = colunas == 1
                    ? largura
                    : (largura - (12 * (colunas - 1))) / colunas;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _CampoFormulario(
                      chave: 'recibo-formulario-numero',
                      largura: larguraCampo,
                      label: 'Número do recibo',
                      valorInicial: recibo.numero,
                      helperText: 'Gerado automaticamente pelo sistema',
                      readOnly: true,
                      somenteLeitura: somenteLeitura,
                      prefixIcon: Icons.tag_outlined,
                      onChanged: onNumeroChanged,
                      textInputAction: TextInputAction.next,
                    ),
                    _CampoFormulario(
                      chave: 'recibo-formulario-recebido',
                      largura: larguraCampo,
                      label: 'Recebido',
                      valorInicial: _formatarData(recibo.dataRecebimento),
                      hintText: 'dd/mm/aaaa',
                      prefixIcon: Icons.calendar_month_outlined,
                      keyboardType: TextInputType.datetime,
                      somenteLeitura: somenteLeitura,
                      onChanged: (valor) {
                        final data = _converterData(valor);
                        if (data != null) {
                          onDataRecebimentoChanged(data);
                        }
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    _CampoFormulario(
                      chave: 'recibo-formulario-entrega',
                      largura: larguraCampo,
                      label: 'Entrega',
                      valorInicial: _formatarData(recibo.dataEntrega),
                      hintText: 'dd/mm/aaaa',
                      prefixIcon: Icons.event_available_outlined,
                      keyboardType: TextInputType.datetime,
                      somenteLeitura: somenteLeitura,
                      onChanged: (valor) {
                        final data = _converterData(valor);
                        if (data != null) {
                          onDataEntregaChanged(data);
                        }
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    _CampoClienteFormulario(
                      chave: 'recibo-formulario-cliente',
                      largura: larguraCampo,
                      label: 'Cliente',
                      valorInicial: recibo.cliente,
                      prefixIcon: Icons.person_outline,
                      somenteLeitura: somenteLeitura,
                      clientesSugeridos: clientesSugeridos,
                      carregandoClientes: carregandoClientes,
                      onChanged: onClienteChanged,
                      onPesquisar: onPesquisarCliente,
                      onSelecionar: onClienteSelecionado,
                      textInputAction: TextInputAction.next,
                    ),
                    _CampoFormulario(
                      chave: 'recibo-formulario-telefone',
                      largura: larguraCampo,
                      label: 'Telefone',
                      valorInicial: TelefoneInputFormatter.formatar(
                        recibo.telefone,
                      ),
                      prefixIcon: Icons.call_outlined,
                      keyboardType: TextInputType.phone,
                      inputFormatters: const [TelefoneInputFormatter()],
                      somenteLeitura: somenteLeitura,
                      onChanged: onTelefoneChanged,
                      textInputAction: TextInputAction.next,
                    ),
                    _CampoFormulario(
                      chave: 'recibo-formulario-valor-entrada',
                      largura: larguraCampo,
                      label: 'Valor de entrada',
                      valorInicial: valorEntradaFormatado.replaceFirst(
                        'R\$ ',
                        '',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      prefixIcon: Icons.payments_outlined,
                      inputFormatters: const [MonetarioInputFormatter()],
                      somenteLeitura: somenteLeitura,
                      onChanged: (valor) => onValorEntradaChanged(
                        MonetarioInputFormatter.converterParaCentavos(valor),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    _CampoFormulario(
                      chave: 'recibo-formulario-observacoes',
                      largura: largura,
                      label: 'Observações',
                      valorInicial: recibo.observacoes,
                      maxLines: 3,
                      prefixIcon: Icons.notes_outlined,
                      somenteLeitura: somenteLeitura,
                      onChanged: onObservacoesChanged,
                      textInputAction: TextInputAction.newline,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static String _formatarData(DateTime? data) {
    if (data == null) {
      return '';
    }

    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year.toString().padLeft(4, '0')}';
  }

  static DateTime? _converterData(String valor) {
    final partes = valor.trim().split('/');
    if (partes.length != 3) {
      return null;
    }

    final dia = int.tryParse(partes[0]);
    final mes = int.tryParse(partes[1]);
    final ano = int.tryParse(partes[2]);
    if (dia == null || mes == null || ano == null) {
      return null;
    }

    final data = DateTime(ano, mes, dia);
    if (data.day != dia || data.month != mes || data.year != ano) {
      return null;
    }

    return data;
  }
}

class _CampoClienteFormulario extends StatefulWidget {
  const _CampoClienteFormulario({
    required this.chave,
    required this.largura,
    required this.label,
    required this.valorInicial,
    required this.onChanged,
    required this.onPesquisar,
    required this.onSelecionar,
    required this.clientesSugeridos,
    required this.carregandoClientes,
    required this.somenteLeitura,
    this.prefixIcon,
    this.textInputAction,
  });

  final String chave;
  final double largura;
  final String label;
  final String valorInicial;
  final ValueChanged<String> onChanged;
  final Future<void> Function(String termo) onPesquisar;
  final ValueChanged<Cliente> onSelecionar;
  final List<Cliente> clientesSugeridos;
  final bool carregandoClientes;
  final bool somenteLeitura;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;

  @override
  State<_CampoClienteFormulario> createState() =>
      _CampoClienteFormularioState();
}

class _CampoClienteFormularioState extends State<_CampoClienteFormulario> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _exibirSugestoes = false;

  bool get _deveExibirSugestoes =>
      _exibirSugestoes &&
      !widget.somenteLeitura &&
      _focusNode.hasFocus &&
      _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.valorInicial);
    _focusNode = FocusNode()..addListener(_aoAlterarFoco);
  }

  @override
  void didUpdateWidget(covariant _CampoClienteFormulario oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.valorInicial != oldWidget.valorInicial && !_focusNode.hasFocus) {
      _sincronizarTexto(widget.valorInicial);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_aoAlterarFoco);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final sugestoes = _sugestoesFiltradas;

    return SizedBox(
      width: widget.largura,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            key: ValueKey(widget.chave),
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              labelText: widget.label,
              prefixIcon: widget.prefixIcon == null
                  ? null
                  : Icon(widget.prefixIcon),
              suffixIcon: widget.carregandoClientes && _deveExibirSugestoes
                  ? const Center(
                      child: SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : null,
            ),
            textInputAction: widget.textInputAction,
            readOnly: widget.somenteLeitura,
            enabled: !widget.somenteLeitura,
            onChanged: widget.somenteLeitura ? null : _aoAlterarTexto,
          ),
          if (_deveExibirSugestoes && sugestoes.isNotEmpty) ...[
            const SizedBox(height: 4),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outlineVariant),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 176),
                child: ListView.separated(
                  key: const ValueKey('recibo-formulario-cliente-sugestoes'),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemCount: sugestoes.length,
                  separatorBuilder: (_, _) =>
                      Divider(height: 1, color: colorScheme.outlineVariant),
                  itemBuilder: (context, index) {
                    final cliente = sugestoes[index];
                    return InkWell(
                      key: ValueKey(
                        'recibo-formulario-cliente-sugestao-$index',
                      ),
                      onTap: () => _selecionarCliente(cliente),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Text(
                          _formatarCliente(cliente),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _aoAlterarFoco() {
    if (!mounted) {
      return;
    }

    setState(() {
      _exibirSugestoes = _focusNode.hasFocus;
    });
  }

  void _aoAlterarTexto(String valor) {
    setState(() {
      _exibirSugestoes = true;
    });
    widget.onChanged(valor);
    unawaited(widget.onPesquisar(valor));
  }

  void _selecionarCliente(Cliente cliente) {
    _sincronizarTexto(cliente.nome);
    setState(() {
      _exibirSugestoes = false;
    });
    _focusNode.unfocus();
    widget.onSelecionar(cliente);
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

  static String _formatarCliente(Cliente cliente) {
    final partes = <String>[cliente.nome];
    final telefone = TelefoneInputFormatter.formatar(cliente.telefone);
    if (telefone.isNotEmpty) {
      partes.add(telefone);
    }
    if (cliente.email.isNotEmpty) {
      partes.add(cliente.email);
    }

    return partes.join(' - ');
  }

  List<Cliente> get _sugestoesFiltradas {
    final termo = _controller.text.trim();
    if (termo.isEmpty) {
      return const <Cliente>[];
    }

    final termoTexto = termo.toLowerCase();
    final termoTelefone = Cliente.normalizarTelefone(termo);
    return widget.clientesSugeridos
        .where(
          (cliente) =>
              cliente.nome.toLowerCase().contains(termoTexto) ||
              cliente.email.toLowerCase().contains(termoTexto) ||
              (termoTelefone.isNotEmpty &&
                  cliente.telefone.contains(termoTelefone)),
        )
        .take(6)
        .toList(growable: false);
  }
}

class _CampoFormulario extends StatefulWidget {
  const _CampoFormulario({
    required this.chave,
    required this.largura,
    required this.label,
    required this.valorInicial,
    required this.onChanged,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.textInputAction,
    this.helperText,
    this.readOnly = false,
    this.somenteLeitura = false,
    this.prefixIcon,
  });

  final String chave;
  final double largura;
  final String label;
  final String valorInicial;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final TextInputAction? textInputAction;
  final String? helperText;
  final bool readOnly;
  final bool somenteLeitura;
  final IconData? prefixIcon;

  @override
  State<_CampoFormulario> createState() => _CampoFormularioState();
}

class _CampoFormularioState extends State<_CampoFormulario> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.valorInicial);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _CampoFormulario oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.valorInicial != oldWidget.valorInicial && !_focusNode.hasFocus) {
      _sincronizarTexto(widget.valorInicial);
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
    return SizedBox(
      width: widget.largura,
      child: TextFormField(
        key: ValueKey(widget.chave),
        controller: _controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          helperText: widget.helperText,
          prefixIcon: widget.prefixIcon == null
              ? null
              : Icon(widget.prefixIcon),
        ),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
        readOnly: widget.readOnly || widget.somenteLeitura,
        enabled: !widget.somenteLeitura,
        onChanged: widget.somenteLeitura ? null : widget.onChanged,
      ),
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
