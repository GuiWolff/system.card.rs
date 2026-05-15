import '../../domain/models/item_recibo.dart';
import '../../domain/models/recibo.dart';

class ReciboDto {
  const ReciboDto({
    this.id,
    required this.numero,
    required this.clienteNome,
    required this.clienteTelefone,
    required this.observacoes,
    required this.dataRecebimento,
    required this.dataEntrega,
    required this.valorEntradaCentavos,
    required this.criadoEm,
    required this.atualizadoEm,
  });

  factory ReciboDto.fromDomain(
    Recibo recibo, {
    required DateTime criadoEm,
    required DateTime atualizadoEm,
  }) {
    return ReciboDto(
      id: recibo.id,
      numero: recibo.numero,
      clienteNome: recibo.cliente,
      clienteTelefone: recibo.telefone,
      observacoes: recibo.observacoes,
      dataRecebimento: recibo.dataRecebimento,
      dataEntrega: recibo.dataEntrega,
      valorEntradaCentavos: recibo.valorEntradaCentavos,
      criadoEm: criadoEm,
      atualizadoEm: atualizadoEm,
    );
  }

  factory ReciboDto.fromMap(Map<String, Object?> map) {
    return ReciboDto(
      id: map['id'] as int?,
      numero: map['numero']! as String,
      clienteNome: map['cliente_nome']! as String,
      clienteTelefone: map['cliente_telefone']! as String,
      observacoes: map['observacoes']! as String,
      dataRecebimento: _dateTimeFromMap(map['data_recebimento']),
      dataEntrega: _dateTimeFromMap(map['data_entrega']),
      valorEntradaCentavos: map['valor_entrada_centavos']! as int,
      criadoEm: DateTime.parse(map['criado_em']! as String),
      atualizadoEm: DateTime.parse(map['atualizado_em']! as String),
    );
  }

  final int? id;
  final String numero;
  final String clienteNome;
  final String clienteTelefone;
  final String observacoes;
  final DateTime? dataRecebimento;
  final DateTime? dataEntrega;
  final int valorEntradaCentavos;
  final DateTime criadoEm;
  final DateTime atualizadoEm;

  Recibo toDomain({Iterable<ItemRecibo> itens = const <ItemRecibo>[]}) {
    return Recibo(
      id: id,
      numero: numero,
      cliente: clienteNome,
      telefone: clienteTelefone,
      observacoes: observacoes,
      dataRecebimento: dataRecebimento,
      dataEntrega: dataEntrega,
      valorEntradaCentavos: valorEntradaCentavos,
      criadoEm: criadoEm,
      atualizadoEm: atualizadoEm,
      itens: itens,
    );
  }

  Map<String, Object?> toMap({bool incluirId = false}) {
    return <String, Object?>{
      if (incluirId) 'id': id,
      'numero': numero,
      'cliente_nome': clienteNome,
      'cliente_telefone': clienteTelefone,
      'observacoes': observacoes,
      'data_recebimento': dataRecebimento?.toIso8601String(),
      'data_entrega': dataEntrega?.toIso8601String(),
      'valor_entrada_centavos': valorEntradaCentavos,
      'criado_em': criadoEm.toIso8601String(),
      'atualizado_em': atualizadoEm.toIso8601String(),
    };
  }

  static DateTime? _dateTimeFromMap(Object? value) {
    if (value == null) {
      return null;
    }

    return DateTime.parse(value as String);
  }
}
