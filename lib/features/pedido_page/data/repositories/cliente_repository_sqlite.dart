import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/models/cliente.dart';
import '../../domain/repositories/cliente_repository.dart';
import '../datasources/recibo_database.dart';
import '../dtos/cliente_dto.dart';

class ClienteRepositorySqlite implements ClienteRepository {
  ClienteRepositorySqlite(this._reciboDatabase);

  final ReciboDatabase _reciboDatabase;

  @override
  Future<Cliente> salvar(Cliente cliente) async {
    _validarCliente(cliente);

    final database = await _reciboDatabase.open();
    final agora = DateTime.now();
    final clienteDto = ClienteDto.fromDomain(
      cliente,
      criadoEm: agora,
      atualizadoEm: agora,
    );

    try {
      final clienteId = await database.insert('clientes', clienteDto.toMap());
      return _buscarPorId(database, clienteId);
    } on DatabaseException catch (erro) {
      if (erro.isUniqueConstraintError()) {
        throw StateError('Já existe um cliente com este telefone.');
      }

      rethrow;
    }
  }

  @override
  Future<Cliente> atualizar(Cliente cliente) async {
    _validarCliente(cliente);

    final clienteId = cliente.id;
    if (clienteId == null) {
      throw ArgumentError('Não é possível atualizar um cliente sem id.');
    }

    final database = await _reciboDatabase.open();
    final existente = await _buscarPorIdOuNull(database, clienteId);
    if (existente == null) {
      throw StateError('Cliente não encontrado para atualização.');
    }

    final agora = DateTime.now();
    final clienteDto = ClienteDto.fromDomain(
      cliente,
      criadoEm: agora,
      atualizadoEm: agora,
    );

    try {
      await database.update(
        'clientes',
        clienteDto.toMap(),
        where: 'id = ?',
        whereArgs: <Object?>[clienteId],
      );
      return _buscarPorId(database, clienteId);
    } on DatabaseException catch (erro) {
      if (erro.isUniqueConstraintError()) {
        throw StateError('Já existe um cliente com este telefone.');
      }

      rethrow;
    }
  }

  @override
  Future<Cliente?> buscarPorId(int id) async {
    final database = await _reciboDatabase.open();
    return _buscarPorIdOuNull(database, id);
  }

  @override
  Future<List<Cliente>> listar() async {
    final database = await _reciboDatabase.open();
    final clientes = await database.query(
      'clientes',
      orderBy: 'nome COLLATE NOCASE ASC, id ASC',
    );

    return clientes
        .map((clienteMap) => ClienteDto.fromMap(clienteMap).toDomain())
        .toList(growable: false);
  }

  @override
  Future<List<Cliente>> pesquisar(String termo) async {
    final termoNormalizado = termo.trim();
    if (termoNormalizado.isEmpty) {
      return listar();
    }

    final database = await _reciboDatabase.open();
    final telefone = Cliente.normalizarTelefone(termoNormalizado);
    final filtroNome = '%${termoNormalizado.toLowerCase()}%';
    final filtroTelefone = '%$telefone%';
    final clientes = await database.query(
      'clientes',
      where: telefone.isEmpty
          ? 'LOWER(nome) LIKE ?'
          : 'LOWER(nome) LIKE ? OR telefone LIKE ?',
      whereArgs: telefone.isEmpty
          ? <Object?>[filtroNome]
          : <Object?>[filtroNome, filtroTelefone],
      orderBy: 'nome COLLATE NOCASE ASC, id ASC',
    );

    return clientes
        .map((clienteMap) => ClienteDto.fromMap(clienteMap).toDomain())
        .toList(growable: false);
  }

  @override
  Future<void> excluir(int id) async {
    final database = await _reciboDatabase.open();
    await database.delete(
      'clientes',
      where: 'id = ?',
      whereArgs: <Object?>[id],
    );
  }

  Future<Cliente> _buscarPorId(DatabaseExecutor executor, int id) async {
    final cliente = await _buscarPorIdOuNull(executor, id);
    if (cliente == null) {
      throw StateError('Cliente não encontrado.');
    }

    return cliente;
  }

  Future<Cliente?> _buscarPorIdOuNull(DatabaseExecutor executor, int id) async {
    final clientes = await executor.query(
      'clientes',
      where: 'id = ?',
      whereArgs: <Object?>[id],
      limit: 1,
    );

    if (clientes.isEmpty) {
      return null;
    }

    return ClienteDto.fromMap(clientes.single).toDomain();
  }

  void _validarCliente(Cliente cliente) {
    final erros = cliente.validar();
    if (erros.isNotEmpty) {
      throw ArgumentError(erros.join('\n'));
    }
  }
}
