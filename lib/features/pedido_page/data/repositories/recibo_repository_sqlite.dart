import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/models/item_recibo.dart';
import '../../domain/models/recibo.dart';
import '../../domain/repositories/recibo_repository.dart';
import '../datasources/recibo_database.dart';
import '../dtos/item_recibo_dto.dart';
import '../dtos/recibo_dto.dart';

class ReciboRepositorySqlite implements ReciboRepository {
  ReciboRepositorySqlite(this._reciboDatabase);

  final ReciboDatabase _reciboDatabase;
  static final RegExp _numeroSomenteDigitos = RegExp(r'^\d+$');

  @override
  Future<String> proximoNumero() async {
    final database = await _reciboDatabase.open();
    return _proximoNumero(database);
  }

  @override
  Future<Recibo> salvar(Recibo recibo) async {
    final database = await _reciboDatabase.open();
    return database.transaction((transaction) async {
      final agora = DateTime.now();
      final reciboPreparado = recibo.numero.trim().isEmpty
          ? recibo.copyWith(numero: await _proximoNumero(transaction))
          : recibo;

      _validarRecibo(reciboPreparado);

      final reciboDto = ReciboDto.fromDomain(
        reciboPreparado,
        criadoEm: reciboPreparado.criadoEm ?? agora,
        atualizadoEm: agora,
      );

      final reciboId = await transaction.insert('recibos', reciboDto.toMap());

      await _inserirItens(
        transaction,
        reciboPreparado.copyWith(id: reciboId),
        criadoEm: agora,
        atualizadoEm: agora,
      );

      return _buscarPorId(transaction, reciboId);
    });
  }

  @override
  Future<Recibo> atualizar(Recibo recibo) async {
    _validarRecibo(recibo);

    final reciboId = recibo.id;
    if (reciboId == null) {
      throw ArgumentError('Não é possível atualizar um recibo sem id.');
    }

    final database = await _reciboDatabase.open();
    return database.transaction((transaction) async {
      final existente = await _buscarPorIdOuNull(transaction, reciboId);
      if (existente == null) {
        throw StateError('Recibo não encontrado para atualização.');
      }

      final agora = DateTime.now();
      final reciboDto = ReciboDto.fromDomain(
        recibo,
        criadoEm: recibo.criadoEm ?? existente.criadoEm ?? agora,
        atualizadoEm: agora,
      );

      await transaction.update(
        'recibos',
        reciboDto.toMap(),
        where: 'id = ?',
        whereArgs: <Object?>[reciboId],
      );
      await transaction.delete(
        'recibo_itens',
        where: 'recibo_id = ?',
        whereArgs: <Object?>[reciboId],
      );
      await _inserirItens(
        transaction,
        recibo,
        criadoEm: agora,
        atualizadoEm: agora,
      );

      return _buscarPorId(transaction, reciboId);
    });
  }

  @override
  Future<Recibo?> buscarPorId(int id) async {
    final database = await _reciboDatabase.open();
    return _buscarPorIdOuNull(database, id);
  }

  @override
  Future<List<Recibo>> listarHistorico() async {
    final database = await _reciboDatabase.open();
    final recibos = await database.query(
      'recibos',
      orderBy: 'atualizado_em DESC, id DESC',
    );

    return _mapearRecibos(database, recibos);
  }

  @override
  Future<List<Recibo>> pesquisarHistorico(String termo) async {
    final termoNormalizado = termo.trim();
    if (termoNormalizado.isEmpty) {
      return listarHistorico();
    }

    final database = await _reciboDatabase.open();
    final filtro = '%${termoNormalizado.toLowerCase()}%';
    final recibos = await database.query(
      'recibos',
      where: '''
LOWER(numero) LIKE ?
OR LOWER(cliente_nome) LIKE ?
OR LOWER(cliente_telefone) LIKE ?
''',
      whereArgs: <Object?>[filtro, filtro, filtro],
      orderBy: 'atualizado_em DESC, id DESC',
    );

    return _mapearRecibos(database, recibos);
  }

  @override
  Future<void> excluir(int id) async {
    final database = await _reciboDatabase.open();
    await database.delete('recibos', where: 'id = ?', whereArgs: <Object?>[id]);
  }

  Future<String> _proximoNumero(DatabaseExecutor executor) async {
    final recibos = await executor.query(
      'recibos',
      columns: const <String>['numero'],
    );

    var maiorNumero = 0;
    for (final recibo in recibos) {
      final numero = (recibo['numero'] as String?)?.trim() ?? '';
      if (!_numeroSomenteDigitos.hasMatch(numero)) {
        continue;
      }

      final numeroInteiro = int.tryParse(numero);
      if (numeroInteiro != null && numeroInteiro > maiorNumero) {
        maiorNumero = numeroInteiro;
      }
    }

    return (maiorNumero + 1).toString().padLeft(4, '0');
  }

  Future<void> _inserirItens(
    Transaction transaction,
    Recibo recibo, {
    required DateTime criadoEm,
    required DateTime atualizadoEm,
  }) async {
    final reciboId = recibo.id;
    if (reciboId == null) {
      throw ArgumentError('Não é possível salvar itens sem id do recibo.');
    }

    for (var indice = 0; indice < recibo.itens.length; indice++) {
      final item = recibo.itens[indice];
      final itemDto = ItemReciboDto.fromDomain(
        item.copyWith(ordem: item.ordem == 0 ? indice + 1 : item.ordem),
        reciboId: reciboId,
        criadoEm: criadoEm,
        atualizadoEm: atualizadoEm,
      );

      await transaction.insert('recibo_itens', itemDto.toMap());
    }
  }

  Future<Recibo> _buscarPorId(DatabaseExecutor executor, int id) async {
    final recibo = await _buscarPorIdOuNull(executor, id);
    if (recibo == null) {
      throw StateError('Recibo não encontrado.');
    }

    return recibo;
  }

  Future<Recibo?> _buscarPorIdOuNull(DatabaseExecutor executor, int id) async {
    final recibos = await executor.query(
      'recibos',
      where: 'id = ?',
      whereArgs: <Object?>[id],
      limit: 1,
    );

    if (recibos.isEmpty) {
      return null;
    }

    final itens = await _buscarItens(executor, id);
    return ReciboDto.fromMap(recibos.single).toDomain(itens: itens);
  }

  Future<List<Recibo>> _mapearRecibos(
    DatabaseExecutor executor,
    List<Map<String, Object?>> recibos,
  ) async {
    final resultado = <Recibo>[];
    for (final reciboMap in recibos) {
      final reciboDto = ReciboDto.fromMap(reciboMap);
      final itens = await _buscarItens(executor, reciboDto.id!);
      resultado.add(reciboDto.toDomain(itens: itens));
    }

    return resultado;
  }

  Future<List<ItemRecibo>> _buscarItens(
    DatabaseExecutor executor,
    int reciboId,
  ) async {
    final itens = await executor.query(
      'recibo_itens',
      where: 'recibo_id = ?',
      whereArgs: <Object?>[reciboId],
      orderBy: 'ordem ASC, id ASC',
    );

    return itens
        .map((itemMap) => ItemReciboDto.fromMap(itemMap).toDomain())
        .toList(growable: false);
  }

  void _validarRecibo(Recibo recibo) {
    final erros = recibo.validar();
    if (erros.isNotEmpty) {
      throw ArgumentError(erros.join('\n'));
    }
  }
}
