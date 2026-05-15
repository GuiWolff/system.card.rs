import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ReciboDatabase {
  ReciboDatabase._({required this.databasePath, required this.inMemory});

  factory ReciboDatabase.desktop({String databaseName = _databaseName}) {
    return ReciboDatabase._(databasePath: databaseName, inMemory: false);
  }

  factory ReciboDatabase.path(String databasePath) {
    return ReciboDatabase._(databasePath: databasePath, inMemory: false);
  }

  factory ReciboDatabase.inMemory() {
    return ReciboDatabase._(databasePath: inMemoryDatabasePath, inMemory: true);
  }

  static const int version = 2;
  static const String _databaseName = 'system_card_rs_recibos.db';

  final String databasePath;
  final bool inMemory;

  Database? _database;

  Future<Database> open() async {
    final database = _database;
    if (database != null && database.isOpen) {
      return database;
    }

    _initializeFfi();

    final path = inMemory ? inMemoryDatabasePath : await _resolveDatabasePath();
    _database = await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: version,
        onConfigure: _onConfigure,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      ),
    );

    return _database!;
  }

  Future<void> close() async {
    final database = _database;
    if (database == null) {
      return;
    }

    await database.close();
    _database = null;
  }

  Future<String> _resolveDatabasePath() async {
    if (p.isAbsolute(databasePath)) {
      return databasePath;
    }

    final directory = await getApplicationSupportDirectory();
    return p.join(directory.path, databasePath);
  }

  Future<void> _onConfigure(Database database) async {
    await database.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database database, int version) async {
    await _createV1(database);
    await _createV2(database);
  }

  Future<void> _onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 1) {
      await _createV1(database);
    }
    if (oldVersion < 2) {
      await _createV2(database);
    }
  }

  Future<void> _createV1(Database database) async {
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
  }

  Future<void> _createV2(Database database) async {
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
    await database.execute('CREATE INDEX idx_clientes_nome ON clientes (nome)');
  }

  static void _initializeFfi() {
    sqfliteFfiInit();
  }
}
