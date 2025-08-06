import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "RentalMobil.db";
  static final _databaseVersion = 2;

  static final tableUsers = 'users';
  static final columnId = 'id';
  static final columnEmail = 'email';
  static final columnPassword = 'password';
  static final columnNama = 'nama';
  static final columnTelepon = 'no_telepon';

  static final tableBookings = 'bookings';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    // sqflite versi terbaru akan otomatis menangani path untuk mobile/desktop/web
    return await openDatabase(_databaseName,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    print("--- DB: Membuat tabel baru... ---");
    await db.execute('''
          CREATE TABLE $tableUsers (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnEmail TEXT NOT NULL UNIQUE,
            $columnPassword TEXT NOT NULL, $columnNama TEXT, $columnTelepon TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableBookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT, user_email TEXT, car_brand TEXT,
            start_date TEXT, status TEXT
          )
          ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("--- DB: Upgrade, MENGHAPUS DATA LAMA... ---");
    await db.execute('DROP TABLE IF EXISTS $tableUsers');
    await db.execute('DROP TABLE IF EXISTS $tableBookings');
    _onCreate(db, newVersion);
  }

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<int> addUser(
      String email, String password, String nama, String telepon) async {
    Database db = await instance.database;
    final hashedPassword = _hashPassword(password);
    print(
        "--- DB: MENDAFTARKAN: Email: $email, Pass Hash: $hashedPassword ---");
    Map<String, dynamic> row = {
      columnEmail: email,
      columnPassword: hashedPassword,
      columnNama: nama,
      columnTelepon: telepon,
    };
    return await db.insert(tableUsers, row,
        conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    Database db = await instance.database;
    final hashedPassword = _hashPassword(password);
    print(
        "--- DB: LOGIN: Mencari Email: $email, Pass Hash: $hashedPassword ---");
    var res = await db.query(
      tableUsers,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [email, hashedPassword],
    );
    if (res.isNotEmpty) {
      print("--- DB: LOGIN BERHASIL! ---");
      return res.first;
    } else {
      print("--- DB: LOGIN GAGAL! ---");
      return null;
    }
  }

  Future<int> addBooking(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableBookings, row);
  }

  Future<List<Map<String, dynamic>>> getAllBookings() async {
    Database db = await instance.database;
    return await db.query(tableBookings, orderBy: 'id DESC');
  }
}
