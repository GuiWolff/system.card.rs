import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/data/datasources/recibo_database.dart';
import 'package:system_card_rs/features/pedido_page/data/repositories/recibo_repository_sqlite.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  group('ReciboRepositorySqlite', () {
    late ReciboDatabase reciboDatabase;
    late ReciboRepositorySqlite repository;

    setUp(() {
      reciboDatabase = ReciboDatabase.inMemory();
      repository = ReciboRepositorySqlite(reciboDatabase);
    });

    tearDown(() async {
      await reciboDatabase.close();
    });

    test('salva e carrega recibo com itens em round-trip completo', () async {
      final recibo = _recibo(
        numero: '0001',
        cliente: 'Maria da Silva',
        telefone: '51999990000',
        valorEntradaCentavos: 1500,
      );

      final salvo = await repository.salvar(recibo);
      final carregado = await repository.buscarPorId(salvo.id!);

      expect(salvo.id, isNotNull);
      expect(carregado, isNotNull);
      expect(carregado!.numero, '0001');
      expect(carregado.cliente, 'Maria da Silva');
      expect(carregado.telefone, '51999990000');
      expect(carregado.valorEntradaCentavos, 1500);
      expect(carregado.totalPedidoCentavos, 5500);
      expect(carregado.valorAPagarEntregaCentavos, 4000);
      expect(carregado.itens, hasLength(2));
      expect(carregado.itens.first.descricao, 'Crachá PVC');
      expect(carregado.itens.first.totalCentavos, 3000);
      expect(carregado.criadoEm, isNotNull);
      expect(carregado.atualizadoEm, isNotNull);
    });

    test('calcula próximo número a partir dos recibos persistidos', () async {
      expect(await repository.proximoNumero(), '0001');

      final primeiro = await repository.salvar(_recibo(numero: ''));
      final segundo = await repository.salvar(_recibo(numero: ''));

      expect(primeiro.numero, '0001');
      expect(segundo.numero, '0002');
      expect(await repository.proximoNumero(), '0003');
    });

    test(
      'ignora números legados não numéricos ao calcular incremento',
      () async {
        await repository.salvar(_recibo(numero: 'REC-2026'));
        await repository.salvar(_recibo(numero: '0007'));
        await repository.salvar(_recibo(numero: '0008-A'));

        expect(await repository.proximoNumero(), '0008');
      },
    );

    test('mantém número legado informado ao salvar recibo novo', () async {
      final salvo = await repository.salvar(_recibo(numero: 'LEG-001'));

      expect(salvo.numero, 'LEG-001');
      expect(salvo.criadoEm, isNotNull);
    });

    test('atualiza recibo existente e substitui itens relacionados', () async {
      final salvo = await repository.salvar(_recibo(numero: '0002'));

      final atualizado = await repository.atualizar(
        Recibo(
          id: salvo.id,
          numero: '0002-A',
          cliente: 'Cliente Atualizado',
          telefone: '51000000000',
          observacoes: 'Entrega combinada no balcão.',
          dataRecebimento: DateTime(2026, 5, 14),
          dataEntrega: DateTime(2026, 5, 20),
          valorEntradaCentavos: 1000,
          criadoEm: salvo.criadoEm,
          itens: const <ItemRecibo>[
            ItemRecibo(
              quantidade: 4,
              descricao: 'Cordão personalizado',
              valorUnitarioCentavos: 750,
            ),
          ],
        ),
      );

      final carregado = await repository.buscarPorId(salvo.id!);

      expect(atualizado.id, salvo.id);
      expect(carregado!.numero, '0002-A');
      expect(carregado.cliente, 'Cliente Atualizado');
      expect(carregado.observacoes, 'Entrega combinada no balcão.');
      expect(carregado.itens, hasLength(1));
      expect(carregado.itens.single.descricao, 'Cordão personalizado');
      expect(carregado.totalPedidoCentavos, 3000);
      expect(carregado.valorAPagarEntregaCentavos, 2000);
      expect(carregado.criadoEm, salvo.criadoEm);
      expect(carregado.atualizadoEm, isNot(salvo.atualizadoEm));
    });

    test('lista histórico por atualização decrescente', () async {
      final primeiro = await repository.salvar(_recibo(numero: '0003'));
      await Future<void>.delayed(const Duration(milliseconds: 5));
      final segundo = await repository.salvar(_recibo(numero: '0004'));

      final historico = await repository.listarHistorico();

      expect(historico.map((recibo) => recibo.id), <int?>[
        segundo.id,
        primeiro.id,
      ]);
    });

    test('pesquisa histórico por número, cliente ou telefone', () async {
      await repository.salvar(
        _recibo(
          numero: '0100',
          cliente: 'Ana Pereira',
          telefone: '51911111111',
        ),
      );
      await repository.salvar(
        _recibo(
          numero: '0200',
          cliente: 'Bruno Costa',
          telefone: '51922222222',
        ),
      );

      final porNumero = await repository.pesquisarHistorico('0100');
      final porCliente = await repository.pesquisarHistorico('bruno');
      final porTelefone = await repository.pesquisarHistorico('2222');

      expect(porNumero.single.cliente, 'Ana Pereira');
      expect(porCliente.single.numero, '0200');
      expect(porTelefone.single.cliente, 'Bruno Costa');
    });

    test('exclui recibo e remove itens por cascata', () async {
      final salvo = await repository.salvar(_recibo(numero: '0005'));

      await repository.excluir(salvo.id!);

      expect(await repository.buscarPorId(salvo.id!), isNull);

      final database = await reciboDatabase.open();
      final itens = await database.query('recibo_itens');
      expect(itens, isEmpty);
    });

    test('rejeita atualização sem id e recibo inválido', () async {
      await expectLater(
        repository.atualizar(_recibo(numero: '0006')),
        throwsArgumentError,
      );

      await expectLater(
        repository.salvar(
          Recibo(
            numero: '',
            cliente: '',
            valorEntradaCentavos: 1,
            itens: const <ItemRecibo>[],
          ),
        ),
        throwsArgumentError,
      );
    });
  });
}

Recibo _recibo({
  required String numero,
  String cliente = 'Cliente Teste',
  String telefone = '51999999999',
  int valorEntradaCentavos = 500,
}) {
  return Recibo(
    numero: numero,
    cliente: cliente,
    telefone: telefone,
    observacoes: 'Observação do pedido',
    dataRecebimento: DateTime(2026, 5, 14),
    dataEntrega: DateTime(2026, 5, 18),
    valorEntradaCentavos: valorEntradaCentavos,
    itens: const <ItemRecibo>[
      ItemRecibo(
        quantidade: 2,
        descricao: 'Crachá PVC',
        valorUnitarioCentavos: 1500,
      ),
      ItemRecibo(
        quantidade: 1,
        descricao: 'Arte final',
        valorUnitarioCentavos: 2500,
      ),
    ],
  );
}
