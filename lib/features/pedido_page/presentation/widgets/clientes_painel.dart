import 'package:flutter/material.dart';
import 'package:system_card_rs/features/pedido_page/domain/models/cliente.dart';
import 'package:system_card_rs/features/pedido_page/presentation/input_formatters/telefone_input_formatter.dart';

class ClientesPainel extends StatefulWidget {
  const ClientesPainel({
    required this.clientes,
    required this.carregando,
    required this.salvando,
    required this.erro,
    required this.feedback,
    required this.onPesquisar,
    required this.onCadastrar,
    required this.onSelecionar,
    this.onAtualizar,
    this.onExcluir,
    super.key,
  });

  final List<Cliente> clientes;
  final bool carregando;
  final bool salvando;
  final String? erro;
  final String? feedback;
  final ValueChanged<String> onPesquisar;
  final Future<void> Function({
    required String nome,
    required String telefone,
    String email,
  })
  onCadastrar;
  final Future<bool> Function({
    required Cliente cliente,
    required String nome,
    required String telefone,
    String email,
  })?
  onAtualizar;
  final Future<bool> Function(Cliente cliente)? onExcluir;
  final ValueChanged<Cliente> onSelecionar;

  @override
  State<ClientesPainel> createState() => _ClientesPainelState();
}

class _ClientesPainelState extends State<ClientesPainel> {
  late final TextEditingController _buscaController;
  late final TextEditingController _nomeController;
  late final TextEditingController _telefoneController;
  late final TextEditingController _emailController;
  Cliente? _clienteEmEdicao;

  bool get _editandoCliente => _clienteEmEdicao != null;

  @override
  void initState() {
    super.initState();
    _buscaController = TextEditingController();
    _nomeController = TextEditingController();
    _telefoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _buscaController.dispose();
    _nomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.groups_outlined, color: colorScheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Clientes',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Fechar clientes',
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            key: const ValueKey('clientes-painel-busca'),
            controller: _buscaController,
            decoration: const InputDecoration(
              labelText: 'Pesquisar por nome, telefone ou e-mail',
              prefixIcon: Icon(Icons.search),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onChanged: widget.onPesquisar,
          ),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_editandoCliente) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: colorScheme.secondary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Editando cliente',
                            style: textTheme.labelLarge?.copyWith(
                              color: colorScheme.secondary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          key: const ValueKey(
                            'clientes-painel-cancelar-edicao',
                          ),
                          onPressed: _limparFormulario,
                          icon: const Icon(Icons.close),
                          label: const Text('Cancelar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final colunas = constraints.maxWidth >= 900
                          ? 3
                          : constraints.maxWidth >= 640
                          ? 2
                          : 1;
                      final larguraCampo = colunas == 1
                          ? constraints.maxWidth
                          : (constraints.maxWidth - (12 * (colunas - 1))) /
                                colunas;

                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          SizedBox(
                            width: larguraCampo,
                            child: TextField(
                              key: const ValueKey('clientes-painel-nome'),
                              controller: _nomeController,
                              decoration: const InputDecoration(
                                labelText: 'Nome do cliente',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          SizedBox(
                            width: larguraCampo,
                            child: TextField(
                              key: const ValueKey('clientes-painel-telefone'),
                              controller: _telefoneController,
                              decoration: const InputDecoration(
                                labelText: 'Telefone',
                                prefixIcon: Icon(Icons.call_outlined),
                              ),
                              keyboardType: TextInputType.phone,
                              inputFormatters: const [TelefoneInputFormatter()],
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          SizedBox(
                            width: larguraCampo,
                            child: TextField(
                              key: const ValueKey('clientes-painel-email'),
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                                prefixIcon: Icon(Icons.mail_outline),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _salvarFormulario(),
                            ),
                          ),
                          FilledButton.icon(
                            key: const ValueKey('clientes-painel-cadastrar'),
                            onPressed: widget.salvando
                                ? null
                                : _salvarFormulario,
                            style: FilledButton.styleFrom(
                              backgroundColor: colorScheme.tertiary,
                              foregroundColor: colorScheme.onTertiary,
                            ),
                            icon: Icon(
                              _editandoCliente
                                  ? Icons.save_outlined
                                  : Icons.person_add_alt_1_outlined,
                            ),
                            label: Text(
                              widget.salvando
                                  ? 'Salvando...'
                                  : _editandoCliente
                                  ? 'Salvar alterações'
                                  : 'Cadastrar',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          if (widget.erro != null) ...[
            const SizedBox(height: 12),
            Text(widget.erro!, style: TextStyle(color: colorScheme.error)),
          ],
          if (widget.feedback != null) ...[
            const SizedBox(height: 12),
            Text(
              widget.feedback!,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.tertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Expanded(
            child: widget.carregando
                ? const Center(child: CircularProgressIndicator())
                : _ListaClientes(
                    clientes: widget.clientes,
                    onSelecionar: widget.onSelecionar,
                    onEditar: widget.onAtualizar == null
                        ? null
                        : _editarCliente,
                    onExcluir: widget.onExcluir == null
                        ? null
                        : (cliente) =>
                              _confirmarExclusaoCliente(context, cliente),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _salvarFormulario() async {
    final cliente = _clienteEmEdicao;
    if (cliente == null) {
      await widget.onCadastrar(
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        email: _emailController.text,
      );
      return;
    }

    final atualizar = widget.onAtualizar;
    if (atualizar == null) {
      return;
    }

    final atualizado = await atualizar(
      cliente: cliente,
      nome: _nomeController.text,
      telefone: _telefoneController.text,
      email: _emailController.text,
    );
    if (!mounted || !atualizado) {
      return;
    }

    _limparFormulario();
  }

  void _editarCliente(Cliente cliente) {
    setState(() {
      _clienteEmEdicao = cliente;
      _nomeController.text = cliente.nome;
      _telefoneController.text = TelefoneInputFormatter.formatar(
        cliente.telefone,
      );
      _emailController.text = cliente.email;
    });
  }

  void _limparFormulario() {
    setState(() {
      _clienteEmEdicao = null;
      _nomeController.clear();
      _telefoneController.clear();
      _emailController.clear();
    });
  }

  Future<void> _confirmarExclusaoCliente(
    BuildContext context,
    Cliente cliente,
  ) async {
    final excluir = widget.onExcluir;
    if (excluir == null) {
      return;
    }

    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final colorScheme = Theme.of(dialogContext).colorScheme;

        return AlertDialog(
          title: const Text('Excluir cliente'),
          content: Text('Deseja excluir o cliente ${cliente.nome}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmado != true) {
      return;
    }

    final excluido = await excluir(cliente);
    if (!mounted || !excluido) {
      return;
    }

    if (_clienteEmEdicao?.id == cliente.id) {
      _limparFormulario();
    }
  }
}

class _ListaClientes extends StatelessWidget {
  const _ListaClientes({
    required this.clientes,
    required this.onSelecionar,
    this.onEditar,
    this.onExcluir,
  });

  final List<Cliente> clientes;
  final ValueChanged<Cliente> onSelecionar;
  final ValueChanged<Cliente>? onEditar;
  final ValueChanged<Cliente>? onExcluir;

  @override
  Widget build(BuildContext context) {
    if (clientes.isEmpty) {
      return const Center(child: Text('Nenhum cliente encontrado.'));
    }

    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      key: const ValueKey('clientes-painel-lista'),
      itemCount: clientes.length,
      separatorBuilder: (_, _) =>
          Divider(height: 1, color: colorScheme.outlineVariant),
      itemBuilder: (context, index) {
        final cliente = clientes[index];
        final chave = cliente.id ?? index;
        return ListTile(
          key: ValueKey('cliente-$chave'),
          leading: Icon(Icons.person_outline, color: colorScheme.secondary),
          title: Text(cliente.nome),
          subtitle: Text(_clienteResumo(cliente)),
          isThreeLine: cliente.email.isNotEmpty,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                key: ValueKey('cliente-selecionar-$chave'),
                onPressed: () => onSelecionar(cliente),
                child: const Text('Selecionar'),
              ),
              if (onEditar != null)
                IconButton(
                  key: ValueKey('cliente-editar-$chave'),
                  tooltip: 'Editar cliente',
                  onPressed: () => onEditar!(cliente),
                  icon: const Icon(Icons.edit_outlined),
                ),
              if (onExcluir != null)
                IconButton(
                  key: ValueKey('cliente-excluir-$chave'),
                  tooltip: 'Excluir cliente',
                  onPressed: () => onExcluir!(cliente),
                  icon: Icon(Icons.delete_outline, color: colorScheme.error),
                ),
            ],
          ),
        );
      },
    );
  }

  String _clienteResumo(Cliente cliente) {
    final telefone = TelefoneInputFormatter.formatar(cliente.telefone);
    if (cliente.email.isEmpty) {
      return telefone;
    }

    return '$telefone\n${cliente.email}';
  }
}
