import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  testWidgets('ClientesPainel pesquisa, cadastra e seleciona cliente', (
    WidgetTester tester,
  ) async {
    String termoPesquisado = '';
    String nomeCadastrado = '';
    String telefoneCadastrado = '';
    String emailCadastrado = '';
    Cliente? clienteSelecionado;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 520,
            child: ClientesPainel(
              clientes: [
                Cliente(
                  id: 1,
                  nome: 'Ana Pereira',
                  telefone: '51911111111',
                  email: 'ana@exemplo.com',
                ),
              ],
              carregando: false,
              salvando: false,
              erro: null,
              feedback: null,
              onPesquisar: (termo) => termoPesquisado = termo,
              onCadastrar:
                  ({required nome, required telefone, email = ''}) async {
                    nomeCadastrado = nome;
                    telefoneCadastrado = telefone;
                    emailCadastrado = email;
                  },
              onSelecionar: (cliente) => clienteSelecionado = cliente,
            ),
          ),
        ),
      ),
    );

    expect(_findIcon(Icons.search), findsOneWidget);
    expect(_findIcon(Icons.call_outlined), findsOneWidget);
    expect(_findIcon(Icons.mail_outline), findsOneWidget);
    expect(_findIcon(Icons.person_add_alt_1_outlined), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('clientes-painel-busca')),
      'Ana',
    );
    await tester.pumpAndSettle();

    expect(termoPesquisado, 'Ana');

    await tester.enterText(
      find.byKey(const ValueKey('clientes-painel-nome')),
      'Carla Souza',
    );
    await tester.enterText(
      find.byKey(const ValueKey('clientes-painel-telefone')),
      '51933333333',
    );
    await tester.enterText(
      find.byKey(const ValueKey('clientes-painel-email')),
      'carla@exemplo.com',
    );
    await tester.pumpAndSettle();

    expect(find.text('(51) 9 3333-3333'), findsOneWidget);
    expect(find.textContaining('ana@exemplo.com'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('clientes-painel-cadastrar')));
    await tester.pumpAndSettle();

    expect(nomeCadastrado, 'Carla Souza');
    expect(telefoneCadastrado, '(51) 9 3333-3333');
    expect(emailCadastrado, 'carla@exemplo.com');

    await tester.tap(find.text('Selecionar'));
    await tester.pumpAndSettle();

    expect(clienteSelecionado?.nome, 'Ana Pereira');
    expect(clienteSelecionado?.telefone, '51911111111');
    expect(clienteSelecionado?.email, 'ana@exemplo.com');
  });

  testWidgets('ClientesPainel exibe erro e estado vazio', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 420,
            child: ClientesPainel(
              clientes: const <Cliente>[],
              carregando: false,
              salvando: false,
              erro: 'Já existe um cliente com este telefone.',
              feedback: null,
              onPesquisar: (_) {},
              onCadastrar:
                  ({required nome, required telefone, email = ''}) async {},
              onSelecionar: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(
      find.text('Já existe um cliente com este telefone.'),
      findsOneWidget,
    );
    expect(find.text('Nenhum cliente encontrado.'), findsOneWidget);
  });

  testWidgets('ClientesPainel edita e exclui cliente', (
    WidgetTester tester,
  ) async {
    Cliente? clienteAtualizado;
    Cliente? clienteExcluido;
    String nomeAtualizado = '';
    String telefoneAtualizado = '';
    String emailAtualizado = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 560,
            child: ClientesPainel(
              clientes: [
                Cliente(
                  id: 7,
                  nome: 'Ana Pereira',
                  telefone: '51911111111',
                  email: 'ana@exemplo.com',
                ),
              ],
              carregando: false,
              salvando: false,
              erro: null,
              feedback: null,
              onPesquisar: (_) {},
              onCadastrar:
                  ({required nome, required telefone, email = ''}) async {},
              onAtualizar:
                  ({
                    required cliente,
                    required nome,
                    required telefone,
                    email = '',
                  }) async {
                    clienteAtualizado = cliente;
                    nomeAtualizado = nome;
                    telefoneAtualizado = telefone;
                    emailAtualizado = email;
                    return true;
                  },
              onExcluir: (cliente) async {
                clienteExcluido = cliente;
                return true;
              },
              onSelecionar: (_) {},
            ),
          ),
        ),
      ),
    );

    expect(_findIcon(Icons.edit_outlined), findsOneWidget);
    expect(_findIcon(Icons.delete_outline), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('cliente-editar-7')));
    await tester.pumpAndSettle();

    expect(find.text('Editando cliente'), findsOneWidget);
    expect(
      _textoDoCampo(tester, find.byKey(const ValueKey('clientes-painel-nome'))),
      'Ana Pereira',
    );
    expect(
      _textoDoCampo(
        tester,
        find.byKey(const ValueKey('clientes-painel-telefone')),
      ),
      '(51) 9 1111-1111',
    );
    expect(
      _textoDoCampo(
        tester,
        find.byKey(const ValueKey('clientes-painel-email')),
      ),
      'ana@exemplo.com',
    );

    await tester.enterText(
      find.byKey(const ValueKey('clientes-painel-nome')),
      'Ana Lima',
    );
    await tester.enterText(
      find.byKey(const ValueKey('clientes-painel-telefone')),
      '51944444444',
    );
    await tester.enterText(
      find.byKey(const ValueKey('clientes-painel-email')),
      'lima@exemplo.com',
    );
    await tester.tap(find.byKey(const ValueKey('clientes-painel-cadastrar')));
    await tester.pumpAndSettle();

    expect(clienteAtualizado?.id, 7);
    expect(nomeAtualizado, 'Ana Lima');
    expect(telefoneAtualizado, '(51) 9 4444-4444');
    expect(emailAtualizado, 'lima@exemplo.com');
    expect(find.text('Editando cliente'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('cliente-excluir-7')));
    await tester.pumpAndSettle();

    expect(find.text('Excluir cliente'), findsOneWidget);
    expect(find.text('Deseja excluir o cliente Ana Pereira?'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Excluir'));
    await tester.pumpAndSettle();

    expect(clienteExcluido?.id, 7);
  });
}

Finder _findIcon(IconData icon) {
  return find.byWidgetPredicate(
    (widget) => widget is Icon && widget.icon == icon,
  );
}

String _textoDoCampo(WidgetTester tester, Finder campo) {
  final editableText = tester.widget<EditableText>(
    find.descendant(of: campo, matching: find.byType(EditableText)),
  );

  return editableText.controller.text;
}
