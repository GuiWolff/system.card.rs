class Cliente {
  Cliente({this.id, required String nome, required String telefone})
    : nome = nome.trim(),
      telefone = normalizarTelefone(telefone);

  final int? id;
  final String nome;
  final String telefone;

  bool get valido => validar().isEmpty;

  List<String> validar() {
    final erros = <String>[];

    if (nome.trim().isEmpty) {
      erros.add('O nome do cliente é obrigatório.');
    }

    if (!telefoneValido(telefone)) {
      erros.add('O telefone do cliente deve ter 10 ou 11 dígitos.');
    }

    return erros;
  }

  Cliente copyWith({int? id, String? nome, String? telefone}) {
    return Cliente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
    );
  }

  static String normalizarTelefone(String telefone) {
    return telefone.replaceAll(RegExp(r'\D'), '');
  }

  static bool telefoneValido(String telefone) {
    final normalizado = normalizarTelefone(telefone);
    return normalizado.length == 10 || normalizado.length == 11;
  }
}
