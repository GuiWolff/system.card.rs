import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdf/pdf.dart';
import 'package:system_card_rs/features/pedido_page/pedido_page.dart';

void main() {
  group('ReciboPdfService', () {
    test('gera bytes de PDF A4 com dados essenciais do recibo', () async {
      const service = ReciboPdfService(compactarPdf: false);
      final recibo = Recibo(
        numero: '0007',
        cliente: 'João da Silva',
        telefone: '(51) 99999-9999',
        observacoes: 'Retirar no balcão.',
        dataRecebimento: DateTime(2026, 5, 15),
        dataEntrega: DateTime(2026, 5, 22),
        valorEntradaCentavos: 2000,
        itens: const [
          ItemRecibo(
            quantidade: 2,
            descricao: 'Crachá em PVC',
            valorUnitarioCentavos: 1500,
          ),
          ItemRecibo(
            quantidade: 1,
            descricao: 'Cordão Personalizado',
            valorUnitarioCentavos: 1200,
          ),
        ],
      );

      final bytes = await service.gerarPdfA4(
        recibo: recibo,
        cabecalho: const CabecalhoEmpresa.systemCardRs(),
      );
      final conteudoPdf = latin1.decode(bytes, allowInvalid: true);

      expect(bytes, isNotEmpty);
      expect(bytes.length, greaterThan(1000));
      expect(conteudoPdf, contains('%PDF-'));
      expect(conteudoPdf, contains('SYSTEM CARD - RS'));
      expect(conteudoPdf, contains('0007'));
      expect(conteudoPdf, contains('João'));
      expect(conteudoPdf, contains('Silva'));
      expect(conteudoPdf, contains('Crachá'));
      expect(conteudoPdf, contains('PVC'));
      expect(conteudoPdf, contains('Cordão'));
      expect(conteudoPdf, contains('Personalizado'));
      expect(conteudoPdf, contains('balcão.'));
      expect(conteudoPdf, contains('42,00'));
      expect(conteudoPdf, contains('20,00'));
      expect(conteudoPdf, contains('22,00'));
    });

    test('usa formato A4 na MediaBox do documento', () async {
      const service = ReciboPdfService(compactarPdf: false);

      final bytes = await service.gerarPdfA4(
        recibo: _reciboBasico(),
        cabecalho: const CabecalhoEmpresa.systemCardRs(),
      );
      final conteudoPdf = latin1.decode(bytes, allowInvalid: true);
      final larguraA4 = PdfPageFormat.a4.width.toStringAsFixed(5);
      final alturaA4 = PdfPageFormat.a4.height.toStringAsFixed(5);

      expect(conteudoPdf, contains('/MediaBox'));
      expect(conteudoPdf, contains(larguraA4));
      expect(conteudoPdf, contains(alturaA4));
    });

    test(
      'mantém fallback textual quando a logo em base64 é inválida',
      () async {
        const service = ReciboPdfService(compactarPdf: false);

        final bytes = await service.gerarPdfA4(
          recibo: _reciboBasico(),
          cabecalho: const CabecalhoEmpresa.systemCardRs().copyWith(
            logoBase64: 'conteudo-invalido',
          ),
        );
        final conteudoPdf = latin1.decode(bytes, allowInvalid: true);

        expect(bytes, isNotEmpty);
        expect(conteudoPdf, contains('SYSTEM CARD - RS'));
      },
    );
  });
}

Recibo _reciboBasico() {
  return Recibo(
    numero: '0001',
    cliente: 'Cliente Teste',
    valorEntradaCentavos: 0,
    itens: const [
      ItemRecibo(
        quantidade: 1,
        descricao: 'Serviço',
        valorUnitarioCentavos: 1000,
      ),
    ],
  );
}
