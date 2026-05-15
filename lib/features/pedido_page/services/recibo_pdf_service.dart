import 'dart:convert';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../domain/models/cabecalho_empresa.dart';
import '../domain/models/item_recibo.dart';
import '../domain/models/recibo.dart';

class ReciboPdfService {
  const ReciboPdfService({this.compactarPdf = true});

  final bool compactarPdf;

  Future<Uint8List> gerarPdfA4({
    required Recibo recibo,
    required CabecalhoEmpresa cabecalho,
  }) {
    final documento = pw.Document(
      compress: compactarPdf,
      title: 'Recibo ${_valorOuTraco(recibo.numero)}',
      author: cabecalho.nomeEmpresa,
      creator: 'system_card_rs',
      subject: 'Recibo em formato A4',
    );

    documento.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (_) => [
          _cabecalho(cabecalho),
          pw.SizedBox(height: 20),
          _dadosRecibo(recibo),
          pw.SizedBox(height: 10),
          _observacoes(recibo.observacoes),
          _tabelaItens(recibo.itens),
          pw.SizedBox(height: 16),
          pw.Align(alignment: pw.Alignment.centerRight, child: _totais(recibo)),
        ],
      ),
    );

    return documento.save();
  }

  pw.Widget _cabecalho(CabecalhoEmpresa cabecalho) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Expanded(
          flex: 3,
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              _logo(cabecalho),
              pw.SizedBox(width: 14),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      _valorOuTraco(cabecalho.nomeEmpresa),
                      style: pw.TextStyle(
                        color: _primaria,
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      _valorOuTraco(cabecalho.subtitulo),
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 18),
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _contato('@', cabecalho.instagram),
              _contato('W', cabecalho.whatsapp),
              _contato('T', cabecalho.telefone),
              _contato('E', cabecalho.endereco),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _logo(CabecalhoEmpresa cabecalho) {
    final logo = _imagemBase64(cabecalho.logoBase64);
    if (logo != null) {
      return pw.Container(
        width: 66,
        height: 66,
        alignment: pw.Alignment.center,
        child: pw.Image(logo, fit: pw.BoxFit.contain),
      );
    }

    return pw.Container(
      width: 66,
      height: 66,
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        border: pw.Border.all(color: _primaria, width: 2),
      ),
      child: pw.Text(
        _iniciais(cabecalho.nomeEmpresa),
        style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.MemoryImage? _imagemBase64(String? logoBase64) {
    final valor = logoBase64?.trim();
    if (valor == null || valor.isEmpty) {
      return null;
    }

    final marcadorBase64 = valor.indexOf('base64,');
    final conteudo = marcadorBase64 >= 0
        ? valor.substring(marcadorBase64 + 'base64,'.length)
        : valor;

    try {
      return pw.MemoryImage(base64Decode(conteudo));
    } on FormatException {
      return null;
    } on ArgumentError {
      return null;
    }
  }

  pw.Widget _contato(String rotulo, String valor) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 14,
            alignment: pw.Alignment.center,
            child: pw.Text(
              rotulo,
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(width: 6),
          pw.Expanded(
            child: pw.Text(_valorOuTraco(valor), style: _textoPequeno),
          ),
        ],
      ),
    );
  }

  pw.Widget _dadosRecibo(Recibo recibo) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Expanded(
              child: _linhaDado(
                'Recebido:',
                _formatarData(recibo.dataRecebimento),
              ),
            ),
            pw.SizedBox(width: 18),
            pw.Expanded(
              child: _linhaDado('Entrega:', _formatarData(recibo.dataEntrega)),
            ),
          ],
        ),
        pw.SizedBox(height: 8),
        _linhaDado('Recibo:', _valorOuTraco(recibo.numero)),
        _linhaDado('Cliente:', _valorOuTraco(recibo.cliente)),
        _linhaDado('Fone:', _valorOuTraco(recibo.telefone)),
      ],
    );
  }

  pw.Widget _linhaDado(String rotulo, String valor) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey500)),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(rotulo, style: _textoNegrito),
          pw.SizedBox(width: 6),
          pw.Expanded(child: pw.Text(valor, style: _textoComum)),
        ],
      ),
    );
  }

  pw.Widget _observacoes(String observacoes) {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(color: _borda)),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          _faixa('Observações'),
          pw.Container(
            constraints: const pw.BoxConstraints(minHeight: 68),
            padding: const pw.EdgeInsets.all(8),
            child: pw.Text(observacoes.trim(), style: _textoComum),
          ),
        ],
      ),
    );
  }

  pw.Widget _tabelaItens(List<ItemRecibo> itens) {
    final linhas = itens.isEmpty
        ? <pw.TableRow>[
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'Nenhum produto/serviço informado.',
                    style: _textoComum,
                  ),
                ),
              ],
            ),
          ]
        : itens.map(_linhaItem).toList();

    return pw.Table(
      border: pw.TableBorder.all(color: _borda),
      columnWidths: itens.isEmpty
          ? const <int, pw.TableColumnWidth>{0: pw.FlexColumnWidth()}
          : const <int, pw.TableColumnWidth>{
              0: pw.FixedColumnWidth(52),
              1: pw.FlexColumnWidth(),
              2: pw.FixedColumnWidth(96),
            },
      children: [
        if (itens.isNotEmpty)
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: _escuro),
            children: [
              _celulaCabecalho('Qtde.', align: pw.TextAlign.center),
              _celulaCabecalho('Produtos', align: pw.TextAlign.center),
              _celulaCabecalho('Vl. Total', align: pw.TextAlign.right),
            ],
          ),
        ...linhas,
      ],
    );
  }

  pw.TableRow _linhaItem(ItemRecibo item) {
    return pw.TableRow(
      children: [
        _celula(item.quantidade.toString(), align: pw.TextAlign.center),
        _celula(_valorOuTraco(item.descricao)),
        _celula(
          _formatarCentavosSemSimbolo(item.totalCentavos),
          align: pw.TextAlign.right,
        ),
      ],
    );
  }

  pw.Widget _celulaCabecalho(String texto, {required pw.TextAlign align}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: pw.Text(
        texto,
        textAlign: align,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _celula(String texto, {pw.TextAlign align = pw.TextAlign.left}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(texto, textAlign: align, style: _textoComum),
    );
  }

  pw.Widget _totais(Recibo recibo) {
    return pw.SizedBox(
      width: 360,
      child: pw.Column(
        children: [
          _linhaTotal('Total do Pedido', recibo.totalPedidoCentavos),
          _linhaTotal('Valor Entrada', recibo.valorEntradaCentavos),
          _linhaTotal(
            'Valor a pagar na Entrega',
            recibo.valorAPagarEntregaCentavos,
            destaque: true,
          ),
        ],
      ),
    );
  }

  pw.Widget _linhaTotal(
    String rotulo,
    int valorCentavos, {
    bool destaque = false,
  }) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Text(rotulo, style: destaque ? _textoNegrito : _textoComum),
        ),
        pw.Container(
          width: 104,
          padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: pw.BoxDecoration(border: pw.Border.all(color: _borda)),
          child: pw.Text(
            _formatarCentavosSemSimbolo(valorCentavos),
            textAlign: pw.TextAlign.right,
            style: destaque ? _textoNegrito : _textoComum,
          ),
        ),
      ],
    );
  }

  pw.Widget _faixa(String texto) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      color: _escuro,
      alignment: pw.Alignment.center,
      child: pw.Text(
        texto,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }
}

const _primaria = PdfColor.fromInt(0xfff7900a);
const _escuro = PdfColor.fromInt(0xff222222);
const _borda = PdfColors.grey600;
const _textoComum = pw.TextStyle(fontSize: 10);
final _textoNegrito = pw.TextStyle(
  fontSize: 10,
  fontWeight: pw.FontWeight.bold,
);
const _textoPequeno = pw.TextStyle(fontSize: 8);

String _formatarData(DateTime? data) {
  if (data == null) {
    return '-';
  }

  return '${data.day.toString().padLeft(2, '0')}/'
      '${data.month.toString().padLeft(2, '0')}/'
      '${data.year.toString().padLeft(4, '0')}';
}

String _formatarCentavosSemSimbolo(int centavos) {
  final sinal = centavos < 0 ? '-' : '';
  final valorAbsoluto = centavos.abs();
  final reais = valorAbsoluto ~/ 100;
  final centavosRestantes = valorAbsoluto % 100;

  return '$sinal$reais,${centavosRestantes.toString().padLeft(2, '0')}';
}

String _valorOuTraco(String valor) {
  final texto = valor.trim();
  return texto.isEmpty ? '-' : texto;
}

String _iniciais(String valor) {
  final palavras = valor
      .trim()
      .split(RegExp(r'\s+'))
      .where((palavra) => palavra.isNotEmpty)
      .toList();
  if (palavras.isEmpty) {
    return 'SC';
  }

  return palavras.take(2).map((palavra) => palavra[0]).join().toUpperCase();
}
