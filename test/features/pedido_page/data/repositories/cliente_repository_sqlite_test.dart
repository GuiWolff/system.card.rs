import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/data/datasources/recibo_database.dart';
import 'package:system_card_rs/features/pedido_page/data/repositories/cliente_repository_sqlite.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  group('ClienteRepositorySqlite', () {
    late ReciboDatabase reciboDatabase;
    late ClienteRepositorySqlite repository;

    setUp(() {
      reciboDatabase = ReciboDatabase.inMemory();
      repository = ClienteRepositorySqlite(reciboDatabase);
    });

    tearDown(() async {
      await reciboDatabase.close();
    });

    test('salva e carrega cliente com telefone normalizado', () async {
      final salvo = await repository.salvar(
        Cliente(nome: 'Maria da Silva', telefone: '(51) 9 9999-0000'),
      );

      final carregado = await repository.buscarPorId(salvo.id!);

      expect(salvo.id, isNotNull);
      expect(carregado, isNotNull);
      expect(carregado!.nome, 'Maria da Silva');
      expect(carregado.telefone, '51999990000');
    });

    test(
      'atualiza cliente existente preservando telefone normalizado',
      () async {
        final salvo = await repository.salvar(
          Cliente(nome: 'Cliente Antigo', telefone: '51 99999-1111'),
        );

        final atualizado = await repository.atualizar(
          Cliente(
            id: salvo.id,
            nome: 'Cliente Atualizado',
            telefone: '(51) 98888-2222',
          ),
        );

        expect(atualizado.id, salvo.id);
        expect(atualizado.nome, 'Cliente Atualizado');
        expect(atualizado.telefone, '51988882222');
      },
    );

    test('lista clientes por nome', () async {
      await repository.salvar(
        Cliente(nome: 'Bruno Costa', telefone: '51911111111'),
      );
      await repository.salvar(
        Cliente(nome: 'Ana Pereira', telefone: '51922222222'),
      );

      final clientes = await repository.listar();

      expect(clientes.map((cliente) => cliente.nome), <String>[
        'Ana Pereira',
        'Bruno Costa',
      ]);
    });

    test('pesquisa cliente por nome ou telefone', () async {
      await repository.salvar(
        Cliente(nome: 'Ana Pereira', telefone: '51911111111'),
      );
      await repository.salvar(
        Cliente(nome: 'Bruno Costa', telefone: '51922222222'),
      );

      final porNome = await repository.pesquisar('bruno');
      final porTelefone = await repository.pesquisar('(51) 91111');

      expect(porNome.single.nome, 'Bruno Costa');
      expect(porTelefone.single.nome, 'Ana Pereira');
    });

    test('bloqueia telefone duplicado normalizado', () async {
      await repository.salvar(
        Cliente(nome: 'Ana Pereira', telefone: '(51) 9 1111-1111'),
      );

      await expectLater(
        repository.salvar(
          Cliente(nome: 'Ana Duplicada', telefone: '51911111111'),
        ),
        throwsStateError,
      );
    });

    test('exclui cliente', () async {
      final salvo = await repository.salvar(
        Cliente(nome: 'Cliente Excluído', telefone: '51933333333'),
      );

      await repository.excluir(salvo.id!);

      expect(await repository.buscarPorId(salvo.id!), isNull);
    });

    test('rejeita cliente inválido e atualização sem id', () async {
      await expectLater(
        repository.salvar(Cliente(nome: '', telefone: '123')),
        throwsArgumentError,
      );

      await expectLater(
        repository.atualizar(Cliente(nome: 'Sem Id', telefone: '51999999999')),
        throwsArgumentError,
      );
    });
  });
}
