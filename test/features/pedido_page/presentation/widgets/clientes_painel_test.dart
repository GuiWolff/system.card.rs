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
    Cliente? clienteSelecionado;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 520,
            child: ClientesPainel(
              clientes: [
                Cliente(id: 1, nome: 'Ana Pereira', telefone: '51911111111'),
              ],
              carregando: false,
              salvando: false,
              erro: null,
              feedback: null,
              onPesquisar: (termo) => termoPesquisado = termo,
              onCadastrar: ({required nome, required telefone}) async {
                nomeCadastrado = nome;
                telefoneCadastrado = telefone;
              },
              onSelecionar: (cliente) => clienteSelecionado = cliente,
            ),
          ),
        ),
      ),
    );

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
    await tester.pumpAndSettle();

    expect(find.text('(51) 9 3333-3333'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('clientes-painel-cadastrar')));
    await tester.pumpAndSettle();

    expect(nomeCadastrado, 'Carla Souza');
    expect(telefoneCadastrado, '(51) 9 3333-3333');

    await tester.tap(find.text('Selecionar'));
    await tester.pumpAndSettle();

    expect(clienteSelecionado?.nome, 'Ana Pereira');
    expect(clienteSelecionado?.telefone, '51911111111');
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
              onCadastrar: ({required nome, required telefone}) async {},
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
