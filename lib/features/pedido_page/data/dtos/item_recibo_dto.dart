import '../../domain/models/item_recibo.dart';

class ItemReciboDto {
  const ItemReciboDto({
    this.id,
    required this.reciboId,
    required this.ordem,
    required this.quantidade,
    required this.descricao,
    required this.valorUnitarioCentavos,
    required this.totalCentavos,
    required this.criadoEm,
    required this.atualizadoEm,
  });

  factory ItemReciboDto.fromDomain(
    ItemRecibo item, {
    required int reciboId,
    required DateTime criadoEm,
    required DateTime atualizadoEm,
  }) {
    return ItemReciboDto(
      id: item.id,
      reciboId: reciboId,
      ordem: item.ordem,
      quantidade: item.quantidade,
      descricao: item.descricao,
      valorUnitarioCentavos: item.valorUnitarioCentavos,
      totalCentavos: item.totalCentavos,
      criadoEm: criadoEm,
      atualizadoEm: atualizadoEm,
    );
  }

  factory ItemReciboDto.fromMap(Map<String, Object?> map) {
    return ItemReciboDto(
      id: map['id'] as int?,
      reciboId: map['recibo_id']! as int,
      ordem: map['ordem']! as int,
      quantidade: map['quantidade']! as int,
      descricao: map['descricao']! as String,
      valorUnitarioCentavos: map['valor_unitario_centavos']! as int,
      totalCentavos: map['total_centavos']! as int,
      criadoEm: DateTime.parse(map['criado_em']! as String),
      atualizadoEm: DateTime.parse(map['atualizado_em']! as String),
    );
  }

  final int? id;
  final int reciboId;
  final int ordem;
  final int quantidade;
  final String descricao;
  final int valorUnitarioCentavos;
  final int totalCentavos;
  final DateTime criadoEm;
  final DateTime atualizadoEm;

  ItemRecibo toDomain() {
    return ItemRecibo(
      id: id,
      ordem: ordem,
      quantidade: quantidade,
      descricao: descricao,
      valorUnitarioCentavos: valorUnitarioCentavos,
    );
  }

  Map<String, Object?> toMap({bool incluirId = false}) {
    return <String, Object?>{
      if (incluirId) 'id': id,
      'recibo_id': reciboId,
      'ordem': ordem,
      'quantidade': quantidade,
      'descricao': descricao,
      'valor_unitario_centavos': valorUnitarioCentavos,
      'total_centavos': totalCentavos,
      'criado_em': criadoEm.toIso8601String(),
      'atualizado_em': atualizadoEm.toIso8601String(),
    };
  }
}
