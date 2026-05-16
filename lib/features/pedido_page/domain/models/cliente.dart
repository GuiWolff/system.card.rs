class Cliente {
  Cliente({
    this.id,
    required String nome,
    required String telefone,
    String email = '',
  }) : nome = nome.trim(),
       telefone = normalizarTelefone(telefone),
       email = email.trim();

  final int? id;
  final String nome;
  final String telefone;
  final String email;

  bool get valido => validar().isEmpty;

  List<String> validar() {
    final erros = <String>[];

    if (nome.trim().isEmpty) {
      erros.add('O nome do cliente é obrigatório.');
    }

    if (!telefoneValido(telefone)) {
      erros.add('O telefone do cliente deve ter 10 ou 11 dígitos.');
    }

    if (email.isNotEmpty && !emailValido(email)) {
      erros.add('O e-mail do cliente é inválido.');
    }

    return erros;
  }

  Cliente copyWith({int? id, String? nome, String? telefone, String? email}) {
    return Cliente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
    );
  }

  static String normalizarTelefone(String telefone) {
    return telefone.replaceAll(RegExp(r'\D'), '');
  }

  static bool telefoneValido(String telefone) {
    final normalizado = normalizarTelefone(telefone);
    return normalizado.length == 10 || normalizado.length == 11;
  }

  static bool emailValido(String email) {
    final normalizado = email.trim();
    if (normalizado.isEmpty) {
      return true;
    }

    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(normalizado);
  }
}
