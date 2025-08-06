import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DatabaseHelper {
  static final _databaseName = "RentalMobil.db";
  static final _databaseVersion = 2; // Versi bisa tetap

  // Nama tabel dan kolom
  static final tableUsers = 'users';
  static final columnId = 'id';
  static final columnEmail = 'email';
  static final columnPassword = 'password';
  static final columnNama = 'nama';
  static final columnTelepon = 'no_telepon';

  static final tableBookings = 'bookings';

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableUsers (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnEmail TEXT NOT NULL UNIQUE,
            $columnPassword TEXT NOT NULL,
            $columnNama TEXT,
            $columnTelepon TEXT
          )
          ''');

    await db.execute('''
          CREATE TABLE $tableBookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_email TEXT,
            car_brand TEXT,
            start_date TEXT,
            status TEXT
          )
          ''');
  }

  // NOTE: onUpgrade ini akan menghapus semua data saat versi database naik.
  // Cocok untuk development, hati-hati saat aplikasi sudah rilis.
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS $tableUsers');
    await db.execute('DROP TABLE IF EXISTS $tableBookings');
    _onCreate(db, newVersion);
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<int> addUser(
      String email, String password, String nama, String telepon) async {
    Database db = await instance.database;
    final hashedPassword = _hashPassword(password);

    Map<String, dynamic> row = {
      columnEmail: email,
      columnPassword: hashedPassword,
      columnNama: nama,
      columnTelepon: telepon,
    };
    // Menggunakan conflictAlgorithm.fail akan melempar error jika email sudah ada
    // yang akan kita tangkap di UI menggunakan try-catch.
    return await db.insert(tableUsers, row,
        conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    Database db = await instance.database;
    final hashedPassword = _hashPassword(password);

    var res = await db.query(
      tableUsers,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [email, hashedPassword],
    );

    if (res.isNotEmpty) {
      return res.first;
    } else {
      return null;
    }
  }

  // --- TAMBAHAN BARU DIMULAI DI SINI ---

  // =======================================================
  // == FUNGSI-FUNGSI PEMESANAN (BOOKINGS) ==
  // =======================================================

  /// Menambahkan data booking baru ke tabel bookings.
  Future<int> addBooking(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableBookings, row);
  }

  /// Mengambil semua data booking dari database, diurutkan dari yang terbaru.
  Future<List<Map<String, dynamic>>> getAllBookings() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableBookings, orderBy: 'id DESC');
    return maps;
  }

  // --- TAMBAHAN BARU SELESAI DI SINI ---

  // =======================================================
  // == FUNGSI UNTUK DEBUGGING ==
  // =======================================================

  /// Mencetak semua data di tabel 'users' ke konsol debug.
  Future<void> printAllUsersForDebug() async {
    try {
      final db = await instance.database;
      final allRows = await db.query(tableUsers);
      print('----------- ISI TABEL USERS -----------');
      if (allRows.isEmpty) {
        print('Tabel users kosong.');
      } else {
        allRows.forEach((row) => print(row));
      }
      print('---------------------------------------');
    } catch (e) {
      print("Error saat membaca tabel users: $e");
    }
  }
}
