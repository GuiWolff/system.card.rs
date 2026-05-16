import '../../domain/models/cliente.dart';

class ClienteDto {
  const ClienteDto({
    this.id,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.criadoEm,
    required this.atualizadoEm,
  });

  factory ClienteDto.fromDomain(
    Cliente cliente, {
    required DateTime criadoEm,
    required DateTime atualizadoEm,
  }) {
    return ClienteDto(
      id: cliente.id,
      nome: cliente.nome,
      telefone: Cliente.normalizarTelefone(cliente.telefone),
      email: cliente.email,
      criadoEm: criadoEm,
      atualizadoEm: atualizadoEm,
    );
  }

  factory ClienteDto.fromMap(Map<String, Object?> map) {
    return ClienteDto(
      id: map['id'] as int?,
      nome: map['nome']! as String,
      telefone: map['telefone']! as String,
      email: (map['email'] as String?) ?? '',
      criadoEm: DateTime.parse(map['criado_em']! as String),
      atualizadoEm: DateTime.parse(map['atualizado_em']! as String),
    );
  }

  final int? id;
  final String nome;
  final String telefone;
  final String email;
  final DateTime criadoEm;
  final DateTime atualizadoEm;

  Cliente toDomain() {
    return Cliente(id: id, nome: nome, telefone: telefone, email: email);
  }

  Map<String, Object?> toMap({bool incluirId = false}) {
    return <String, Object?>{
      if (incluirId) 'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'criado_em': criadoEm.toIso8601String(),
      'atualizado_em': atualizadoEm.toIso8601String(),
    };
  }
}
