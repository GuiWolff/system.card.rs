import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    expect(_findFaIcon(FontAwesomeIcons.magnifyingGlass), findsOneWidget);
    expect(_findFaIcon(FontAwesomeIcons.phone), findsOneWidget);
    expect(_findFaIcon(FontAwesomeIcons.envelope), findsOneWidget);
    expect(_findFaIcon(FontAwesomeIcons.userPlus), findsOneWidget);

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
}

Finder _findFaIcon(FaIconData icon) {
  return find.byWidgetPredicate(
    (widget) => widget is FaIcon && widget.icon == icon.data,
  );
}
