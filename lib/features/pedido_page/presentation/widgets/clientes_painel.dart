import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final ValueChanged<Cliente> onSelecionar;

  @override
  State<ClientesPainel> createState() => _ClientesPainelState();
}

class _ClientesPainelState extends State<ClientesPainel> {
  late final TextEditingController _buscaController;
  late final TextEditingController _nomeController;
  late final TextEditingController _telefoneController;
  late final TextEditingController _emailController;

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
              FaIcon(FontAwesomeIcons.user, color: colorScheme.primary),
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
                icon: const FaIcon(FontAwesomeIcons.xmark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            key: const ValueKey('clientes-painel-busca'),
            controller: _buscaController,
            decoration: const InputDecoration(
              labelText: 'Pesquisar por nome, telefone ou e-mail',
              prefixIcon: FaIcon(FontAwesomeIcons.magnifyingGlass),
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final colunas = constraints.maxWidth >= 900
                      ? 3
                      : constraints.maxWidth >= 640
                      ? 2
                      : 1;
                  final larguraCampo = colunas == 1
                      ? constraints.maxWidth
                      : (constraints.maxWidth - (12 * (colunas - 1))) / colunas;

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
                            prefixIcon: FaIcon(FontAwesomeIcons.user),
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
                            prefixIcon: FaIcon(FontAwesomeIcons.phone),
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
                            prefixIcon: FaIcon(FontAwesomeIcons.envelope),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _cadastrarCliente(),
                        ),
                      ),
                      FilledButton.icon(
                        key: const ValueKey('clientes-painel-cadastrar'),
                        onPressed: widget.salvando ? null : _cadastrarCliente,
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.tertiary,
                          foregroundColor: colorScheme.onTertiary,
                        ),
                        icon: const FaIcon(FontAwesomeIcons.userPlus),
                        label: Text(
                          widget.salvando ? 'Salvando...' : 'Cadastrar',
                        ),
                      ),
                    ],
                  );
                },
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
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _cadastrarCliente() async {
    await widget.onCadastrar(
      nome: _nomeController.text,
      telefone: _telefoneController.text,
      email: _emailController.text,
    );
  }
}

class _ListaClientes extends StatelessWidget {
  const _ListaClientes({required this.clientes, required this.onSelecionar});

  final List<Cliente> clientes;
  final ValueChanged<Cliente> onSelecionar;

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
        return ListTile(
          key: ValueKey('cliente-${cliente.id ?? index}'),
          leading: FaIcon(FontAwesomeIcons.user, color: colorScheme.secondary),
          title: Text(cliente.nome),
          subtitle: Text(_clienteResumo(cliente)),
          trailing: TextButton(
            onPressed: () => onSelecionar(cliente),
            child: const Text('Selecionar'),
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
