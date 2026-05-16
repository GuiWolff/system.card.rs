import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_card_rs/features/pedido_page/data/datasources/recibo_database.dart';

void main() {
  group('ReciboDatabase', () {
    late ReciboDatabase reciboDatabase;

    setUp(() {
      reciboDatabase = ReciboDatabase.inMemory();
    });

    tearDown(() async {
      await reciboDatabase.close();
    });

    test('cria banco em memória com schema versionado', () async {
      final database = await reciboDatabase.open();

      final versao = await database.rawQuery('PRAGMA user_version');
      expect(versao.single['user_version'], ReciboDatabase.version);

      final tabelas = await database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type = 'table'",
      );
      final nomesDasTabelas = tabelas.map((tabela) => tabela['name']).toSet();

      expect(nomesDasTabelas, contains('recibos'));
      expect(nomesDasTabelas, contains('recibo_itens'));
      expect(nomesDasTabelas, contains('clientes'));
    });

    test('cria colunas mínimas de recibos e itens', () async {
      final database = await reciboDatabase.open();

      final colunasRecibos = await database.rawQuery(
        'PRAGMA table_info(recibos)',
      );
      final colunasItens = await database.rawQuery(
        'PRAGMA table_info(recibo_itens)',
      );

      expect(
        _nomesDasColunas(colunasRecibos),
        containsAll(<String>{
          'id',
          'numero',
          'cliente_nome',
          'cliente_telefone',
          'observacoes',
          'data_recebimento',
          'data_entrega',
          'valor_entrada_centavos',
          'criado_em',
          'atualizado_em',
        }),
      );
      expect(
        _nomesDasColunas(colunasItens),
        containsAll(<String>{
          'id',
          'recibo_id',
          'ordem',
          'quantidade',
          'descricao',
          'valor_unitario_centavos',
          'total_centavos',
          'criado_em',
          'atualizado_em',
        }),
      );
    });

    test('cria índices necessários para histórico', () async {
      final database = await reciboDatabase.open();

      final indicesRecibos = await database.rawQuery(
        'PRAGMA index_list(recibos)',
      );
      final nomesDosIndices = indicesRecibos
          .map((indice) => indice['name'])
          .whereType<String>()
          .toSet();

      expect(nomesDosIndices, contains('idx_recibos_numero'));
      expect(nomesDosIndices, contains('idx_recibos_cliente_nome'));
      expect(nomesDosIndices, contains('idx_recibos_atualizado_em'));
    });

    test('cria tabela de clientes com telefone único', () async {
      final database = await reciboDatabase.open();

      final colunasClientes = await database.rawQuery(
        'PRAGMA table_info(clientes)',
      );
      final indicesClientes = await database.rawQuery(
        'PRAGMA index_list(clientes)',
      );
      final nomesDosIndices = indicesClientes
          .map((indice) => indice['name'])
          .whereType<String>()
          .toSet();

      expect(
        _nomesDasColunas(colunasClientes),
        containsAll(<String>{
          'id',
          'nome',
          'telefone',
          'email',
          'criado_em',
          'atualizado_em',
        }),
      );
      expect(nomesDosIndices, contains('idx_clientes_telefone'));
      expect(nomesDosIndices, contains('idx_clientes_nome'));
    });

    test('migra banco v1 para v2 sem perder recibos existentes', () async {
      sqfliteFfiInit();
      final caminho = await _criarBancoV1ComRecibo();
      reciboDatabase = ReciboDatabase.path(caminho);

      final database = await reciboDatabase.open();

      final versao = await database.rawQuery('PRAGMA user_version');
      final recibos = await database.query('recibos');
      final clientes = await database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type = 'table' AND name = 'clientes'",
      );

      expect(versao.single['user_version'], ReciboDatabase.version);
      expect(recibos.single['numero'], 'MIG-001');
      expect(clientes, isNotEmpty);
    });

    test('migra banco v2 para v3 adicionando e-mail em clientes', () async {
      sqfliteFfiInit();
      final caminho = await _criarBancoV2ComCliente();
      reciboDatabase = ReciboDatabase.path(caminho);

      final database = await reciboDatabase.open();

      final versao = await database.rawQuery('PRAGMA user_version');
      final colunasClientes = await database.rawQuery(
        'PRAGMA table_info(clientes)',
      );
      final clientes = await database.query('clientes');

      expect(versao.single['user_version'], ReciboDatabase.version);
      expect(_nomesDasColunas(colunasClientes), contains('email'));
      expect(clientes.single['nome'], 'Cliente v2');
      expect(clientes.single['email'], '');
    });

    test('habilita chave estrangeira com exclusão em cascata', () async {
      final database = await reciboDatabase.open();
      final agora = DateTime(2026, 5, 14, 10, 30).toIso8601String();

      final configuracao = await database.rawQuery('PRAGMA foreign_keys');
      expect(configuracao.single['foreign_keys'], 1);

      final reciboId = await database.insert('recibos', <String, Object?>{
        'numero': '001',
        'cliente_nome': 'Cliente Teste',
        'cliente_telefone': '51999999999',
        'observacoes': 'Observação',
        'data_recebimento': agora,
        'data_entrega': agora,
        'valor_entrada_centavos': 5000,
        'criado_em': agora,
        'atualizado_em': agora,
      });

      await database.insert('recibo_itens', <String, Object?>{
        'recibo_id': reciboId,
        'ordem': 1,
        'quantidade': 2,
        'descricao': 'Cartão PVC',
        'valor_unitario_centavos': 2500,
        'total_centavos': 5000,
        'criado_em': agora,
        'atualizado_em': agora,
      });

      await database.delete(
        'recibos',
        where: 'id = ?',
        whereArgs: <Object?>[reciboId],
      );

      final itensRestantes = await database.query('recibo_itens');
      expect(itensRestantes, isEmpty);
    });
  });
}

Set<Object?> _nomesDasColunas(List<Map<String, Object?>> colunas) {
  return colunas.map((coluna) => coluna['name']).toSet();
}

Future<String> _criarBancoV1ComRecibo() async {
  final diretorio = await Directory.systemTemp.createTemp('recibo_database_');
  final caminho = '${diretorio.path}/recibos_v1.db';
  final database = await databaseFactoryFfi.openDatabase(
    caminho,
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
CREATE TABLE recibos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  numero TEXT NOT NULL,
  cliente_nome TEXT NOT NULL,
  cliente_telefone TEXT NOT NULL DEFAULT '',
  observacoes TEXT NOT NULL DEFAULT '',
  data_recebimento TEXT,
  data_entrega TEXT,
  valor_entrada_centavos INTEGER NOT NULL DEFAULT 0,
  criado_em TEXT NOT NULL,
  atualizado_em TEXT NOT NULL
)
''');

        await database.execute('''
CREATE TABLE recibo_itens (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  recibo_id INTEGER NOT NULL,
  ordem INTEGER NOT NULL,
  quantidade INTEGER NOT NULL,
  descricao TEXT NOT NULL,
  valor_unitario_centavos INTEGER NOT NULL,
  total_centavos INTEGER NOT NULL,
  criado_em TEXT NOT NULL,
  atualizado_em TEXT NOT NULL,
  FOREIGN KEY (recibo_id)
    REFERENCES recibos (id)
    ON DELETE CASCADE
)
''');

        await database.execute(
          'CREATE INDEX idx_recibos_numero ON recibos (numero)',
        );
        await database.execute(
          'CREATE INDEX idx_recibos_cliente_nome ON recibos (cliente_nome)',
        );
        await database.execute(
          'CREATE INDEX idx_recibos_atualizado_em ON recibos (atualizado_em)',
        );
        await database.execute(
          'CREATE INDEX idx_recibo_itens_recibo_id ON recibo_itens (recibo_id)',
        );
      },
    ),
  );

  final agora = DateTime(2026, 5, 15, 9).toIso8601String();
  await database.insert('recibos', <String, Object?>{
    'numero': 'MIG-001',
    'cliente_nome': 'Cliente da Migração',
    'cliente_telefone': '51999999999',
    'observacoes': '',
    'data_recebimento': agora,
    'data_entrega': agora,
    'valor_entrada_centavos': 0,
    'criado_em': agora,
    'atualizado_em': agora,
  });
  await database.close();

  return caminho;
}

Future<String> _criarBancoV2ComCliente() async {
  final diretorio = await Directory.systemTemp.createTemp('recibo_database_');
  final caminho = '${diretorio.path}/recibos_v2.db';
  final database = await databaseFactoryFfi.openDatabase(
    caminho,
    options: OpenDatabaseOptions(
      version: 2,
      onCreate: (database, version) async {
        await database.execute('''
CREATE TABLE recibos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  numero TEXT NOT NULL,
  cliente_nome TEXT NOT NULL,
  cliente_telefone TEXT NOT NULL DEFAULT '',
  observacoes TEXT NOT NULL DEFAULT '',
  data_recebimento TEXT,
  data_entrega TEXT,
  valor_entrada_centavos INTEGER NOT NULL DEFAULT 0,
  criado_em TEXT NOT NULL,
  atualizado_em TEXT NOT NULL
)
''');

        await database.execute('''
CREATE TABLE recibo_itens (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  recibo_id INTEGER NOT NULL,
  ordem INTEGER NOT NULL,
  quantidade INTEGER NOT NULL,
  descricao TEXT NOT NULL,
  valor_unitario_centavos INTEGER NOT NULL,
  total_centavos INTEGER NOT NULL,
  criado_em TEXT NOT NULL,
  atualizado_em TEXT NOT NULL,
  FOREIGN KEY (recibo_id)
    REFERENCES recibos (id)
    ON DELETE CASCADE
)
''');

        await database.execute('''
CREATE TABLE clientes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  telefone TEXT NOT NULL,
  criado_em TEXT NOT NULL,
  atualizado_em TEXT NOT NULL
)
''');

        await database.execute(
          'CREATE UNIQUE INDEX idx_clientes_telefone ON clientes (telefone)',
        );
        await database.execute(
          'CREATE INDEX idx_clientes_nome ON clientes (nome)',
        );
      },
    ),
  );

  final agora = DateTime(2026, 5, 15, 9).toIso8601String();
  await database.insert('clientes', <String, Object?>{
    'nome': 'Cliente v2',
    'telefone': '51999990000',
    'criado_em': agora,
    'atualizado_em': agora,
  });
  await database.close();

  return caminho;
}
