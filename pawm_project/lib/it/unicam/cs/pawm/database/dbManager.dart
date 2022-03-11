
import 'package:path/path.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/ContrattoPrivato.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaComune.dart';
import 'package:pawm_project/it/unicam/cs/pawm/schede/SchedaPrivato.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {

  static final DbManager instance = DbManager._init();
  ///connessione al database
  static Database? _database;

  DbManager._init();

  Future<Database> get database async {

    if(_database != null) return _database!;

    _database = await _initDB('pawm_2.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    ///crea tabella scheda privato
    await db.execute('''
    CREATE TABLE $tablePrivato (
    ${SchedaPrivatoFields.numeroScheda} $idType,
    ${SchedaPrivatoFields.durata} $integerType,
    ${SchedaPrivatoFields.data} $textType,
    ${SchedaPrivatoFields.orario} $textType,
    ${SchedaPrivatoFields.descrizione} $textType,
    ${SchedaPrivatoFields.cliente} $textType
    )
    ''');

    ///crea tabella scheda privato per contratto
    await db.execute('''
    CREATE TABLE $tablePrivatoContratto (
    ${SchedaPrivatoFields.numeroScheda} $integerType,
    ${SchedaPrivatoFields.idContratto} $integerType,
    ${SchedaPrivatoFields.durata} $integerType,
    ${SchedaPrivatoFields.data} $textType,
    ${SchedaPrivatoFields.orario} $textType,
    ${SchedaPrivatoFields.descrizione} $textType,
    ${SchedaPrivatoFields.cliente} $textType,
    PRIMARY KEY(${SchedaPrivatoFields.numeroScheda}, ${SchedaPrivatoFields.idContratto}, ${SchedaPrivatoFields.data}))
    ''');

    ///crea scheda comune
    await db.execute('''
    CREATE TABLE $tableComune (
    ${SchedaComuneFields.numeroScheda} $integerType,
    ${SchedaComuneFields.idContratto} $integerType,
    ${SchedaComuneFields.durata} $integerType,
    ${SchedaComuneFields.ufficio} $textType,
    ${SchedaComuneFields.data} $textType,
    ${SchedaComuneFields.orario} $textType,
    ${SchedaComuneFields.descrizione} $textType,
    PRIMARY KEY(${SchedaComuneFields.numeroScheda}, ${SchedaComuneFields.idContratto}))
    ''');

    ///crea la tabella per contratto comune
    await db.execute('''
    CREATE TABLE $tableContrattoComune (
    ${ContrattoComuneFields.id} $idType,
    ${ContrattoComuneFields.oreTotali} $integerType,
    ${ContrattoComuneFields.oreRimanenti} $integerType,
    ${ContrattoComuneFields.valoreContratto} $integerType
    )
    ''');

    ///crea tabella per contratto privato
    await db.execute('''
    CREATE TABLE $tableContrattoPrivato (
    ${ContrattoPrivatoFields.id} $idType,
    ${ContrattoPrivatoFields.cliente} $textType,
    ${ContrattoPrivatoFields.oreTotali} $integerType,
    ${ContrattoPrivatoFields.oreRimanenti} $integerType,
    ${ContrattoPrivatoFields.valoreContratto} $integerType
    )
    ''');
  }

  Future<void> writeContrattoComune(ContrattoComune contratto) async {
    final db = await instance.database;
    await db.insert(tableContrattoComune, contratto.toMap());
  }

  Future<void> writeSchedaComune(SchedaComune scheda) async {
    final db = await instance.database;
    await db.insert(tableComune, scheda.toMap());
  }

  Future<void> writeSchedaPrivatoContratto(SchedaPrivato scheda) async {
    final db = await instance.database;
    await db.insert(tablePrivatoContratto, scheda.toMap());
  }

  Future<void> writeContrattoPrivato(ContrattoPrivato contratto) async {
    final db = await instance.database;
    await db.insert(tableContrattoPrivato, contratto.toMap());
  }

  Future<List<ContrattoComune>> readAllContrattoComune() async {
    final db = await instance.database;
    final result = await db.query(tableContrattoComune);
    
    return result.map((e) => ContrattoComune.fromMap(e)).toList();
  }

  Future<List<SchedaComune>> readAllSchedaComune(int id) async {
    final db = await instance.database;
    final result = await db.query(tableComune, where: '${SchedaComuneFields.idContratto} = ?', whereArgs: [id]);

    return result.map((e) => SchedaComune.fromMap(e)).toList();
  }

  Future<List<SchedaPrivato>> readAllSchedaPrivatoContratto(int id) async {
    final db = await instance.database;
    final result = await db.query(tablePrivatoContratto, where: '${SchedaPrivatoFields.idContratto} = ?', whereArgs: [id]);

    return result.map((e) => SchedaPrivato.fromMap(e)).toList();
  }

  Future<List<ContrattoPrivato>> readAllContrattoPrivato() async {
    final db = await instance.database;
    final result = await db.query(tableContrattoPrivato);

    return result.map((e) => ContrattoPrivato.fromMap(e)).toList();
  }

  Future<int> updateContrattoComune(ContrattoComune contratto) async {
    final db = await instance.database;

    return db.update(tableContrattoComune, contratto.toMap(), where: '${ContrattoComuneFields.id} = ?', whereArgs: [contratto.id]);
  }

  Future<int> updateContrattoPrivato(ContrattoPrivato contratto) async {
    final db = await instance.database;

    return db.update(tableContrattoPrivato, contratto.toMap(), where: '${ContrattoPrivatoFields.id} = ?', whereArgs: [contratto.id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

}