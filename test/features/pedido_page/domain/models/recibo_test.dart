import 'package:flutter_test/flutter_test.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  group('ItemRecibo', () {
    test('calcula total usando centavos inteiros', () {
      const item = ItemRecibo(
        quantidade: 3,
        descricao: 'Crachá PVC',
        valorUnitarioCentavos: 1299,
      );

      expect(item.totalCentavos, 3897);
      expect(item.valido, isTrue);
    });

    test('valida quantidade, descrição e valor unitário', () {
      const item = ItemRecibo(
        quantidade: 0,
        descricao: '  ',
        valorUnitarioCentavos: -1,
      );

      expect(item.valido, isFalse);
      expect(
        item.validar(),
        containsAll(<String>[
          'A quantidade do item deve ser maior que zero.',
          'A descrição do item é obrigatória.',
          'O valor unitário do item não pode ser negativo.',
        ]),
      );
    });
  });

  group('ResumoRecibo', () {
    test('trata entrada vazia como zero quando não há itens', () {
      final resumo = ResumoRecibo.calcular(
        itens: const <ItemRecibo>[],
        valorEntradaCentavos: 0,
      );

      expect(resumo.totalPedidoCentavos, 0);
      expect(resumo.valorEntradaCentavos, 0);
      expect(resumo.valorAPagarEntregaCentavos, 0);
      expect(resumo.valido, isTrue);
    });

    test('mantém saldo igual ao total quando entrada é zero', () {
      final resumo = ResumoRecibo.calcular(
        itens: const <ItemRecibo>[
          ItemRecibo(
            quantidade: 2,
            descricao: 'Credencial',
            valorUnitarioCentavos: 1750,
          ),
        ],
        valorEntradaCentavos: 0,
      );

      expect(resumo.totalPedidoCentavos, 3500);
      expect(resumo.valorEntradaCentavos, 0);
      expect(resumo.valorAPagarEntregaCentavos, 3500);
      expect(resumo.valido, isTrue);
    });

    test('calcula total do pedido e valor a pagar na entrega', () {
      final resumo = ResumoRecibo.calcular(
        itens: const <ItemRecibo>[
          ItemRecibo(
            quantidade: 2,
            descricao: 'Cordão personalizado',
            valorUnitarioCentavos: 1500,
          ),
          ItemRecibo(
            quantidade: 1,
            descricao: 'Arte final',
            valorUnitarioCentavos: 2500,
          ),
        ],
        valorEntradaCentavos: 2000,
      );

      expect(resumo.totalPedidoCentavos, 5500);
      expect(resumo.valorEntradaCentavos, 2000);
      expect(resumo.valorAPagarEntregaCentavos, 3500);
      expect(resumo.valido, isTrue);
    });

    test('impede entrada negativa ou maior que o total do pedido', () {
      const resumo = ResumoRecibo(
        totalPedidoCentavos: 1000,
        valorEntradaCentavos: 1500,
      );

      expect(resumo.valido, isFalse);
      expect(
        resumo.validar(),
        contains('O valor de entrada não pode ultrapassar o total do pedido.'),
      );

      const resumoComEntradaNegativa = ResumoRecibo(
        totalPedidoCentavos: 1000,
        valorEntradaCentavos: -1,
      );

      expect(
        resumoComEntradaNegativa.validar(),
        contains('O valor de entrada não pode ser negativo.'),
      );
    });
  });

  group('Recibo', () {
    test('agrega itens e expõe resumo financeiro sem duplicar regra', () {
      final recibo = Recibo(
        numero: '000123',
        cliente: 'Maria da Silva',
        valorEntradaCentavos: 3000,
        itens: const <ItemRecibo>[
          ItemRecibo(
            quantidade: 10,
            descricao: 'Crachá PVC',
            valorUnitarioCentavos: 850,
          ),
          ItemRecibo(
            quantidade: 2,
            descricao: 'Porta crachá',
            valorUnitarioCentavos: 1200,
          ),
        ],
      );

      expect(recibo.totalPedidoCentavos, 10900);
      expect(recibo.valorEntradaCentavos, 3000);
      expect(recibo.valorAPagarEntregaCentavos, 7900);
      expect(recibo.resumo.totalPedidoCentavos, recibo.totalPedidoCentavos);
      expect(recibo.valido, isTrue);
    });

    test('valida número, cliente, itens e resumo financeiro', () {
      final recibo = Recibo(
        numero: '',
        cliente: ' ',
        valorEntradaCentavos: 1000,
        itens: const <ItemRecibo>[
          ItemRecibo(quantidade: 0, descricao: '', valorUnitarioCentavos: -10),
        ],
      );

      expect(recibo.valido, isFalse);
      expect(
        recibo.validar(),
        containsAll(<String>[
          'O número do recibo é obrigatório.',
          'O cliente é obrigatório.',
          'Item 1: A quantidade do item deve ser maior que zero.',
          'Item 1: A descrição do item é obrigatória.',
          'Item 1: O valor unitário do item não pode ser negativo.',
          'O valor de entrada não pode ultrapassar o total do pedido.',
        ]),
      );
    });

    test('preserva lista de itens como leitura externa', () {
      final itens = <ItemRecibo>[
        const ItemRecibo(
          quantidade: 1,
          descricao: 'Impressão',
          valorUnitarioCentavos: 500,
        ),
      ];

      final recibo = Recibo(
        numero: '000124',
        cliente: 'João da Silva',
        itens: itens,
      );

      itens.clear();

      expect(recibo.itens, hasLength(1));
      expect(
        () => recibo.itens.add(
          const ItemRecibo(
            quantidade: 1,
            descricao: 'Item externo',
            valorUnitarioCentavos: 100,
          ),
        ),
        throwsUnsupportedError,
      );
    });
  });
}
