import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "RentalMobil.db";
  static const _databaseVersion = 1;

  // ==================================================================
  // --- DEFINISI NAMA TABEL DAN KOLOM ---
  // Menggunakan konstanta seperti ini adalah praktik terbaik untuk menghindari salah ketik
  // ==================================================================

  // --- Tabel mobil_favorit ---
  static const tableFavorites = 'mobil_favorit';
  static const favColumnId = '_id';
  static const favColumnCarId = 'car_id';
  static const favColumnBrand = 'brand';
  static const favColumnModel = 'model';

  // --- Tabel profiles ---
  static const tableProfiles = 'profiles';
  static const profileColumnId =
      'id'; // Tipe TEXT/String untuk UUID dari sistem auth
  static const profileColumnFullName = 'full_name';
  static const profileColumnPhone = 'phone_number';

  // --- Tabel bookings ---
  static const tableBookings = 'bookings';
  static const bookingColumnId = '_id';
  static const bookingColumnUserId = 'user_id';
  static const bookingColumnCarId = 'car_id';
  static const bookingColumnStartDate = 'start_date';
  static const bookingColumnEndDate = 'end_date';
  static const bookingColumnTotalPrice = 'total_price';
  static const bookingColumnStatus = 'status';

  // ==================================================================
  // --- KODE BOILERPLATE DATABASE ---
  // Bagian ini untuk memastikan hanya ada satu koneksi ke database
  // ==================================================================

  // Singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Variabel untuk menampung koneksi database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Jika _database null, kita inisialisasi
    _database = await _initDatabase();
    return _database!;
  }

  // Fungsi ini membuka database (atau membuatnya jika belum ada)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Perintah SQL untuk membuat SEMUA tabel saat database pertama kali diciptakan
  Future _onCreate(Database db, int version) async {
    // Perintah untuk membuat tabel mobil favorit
    await db.execute('''
          CREATE TABLE $tableFavorites (
            $favColumnId INTEGER PRIMARY KEY,
            $favColumnCarId INTEGER NOT NULL,
            $favColumnBrand TEXT NOT NULL,
            $favColumnModel TEXT NOT NULL
          )
          ''');

    // Perintah untuk membuat tabel profil
    await db.execute('''
          CREATE TABLE $tableProfiles (
            $profileColumnId TEXT PRIMARY KEY,
            $profileColumnFullName TEXT NOT NULL,
            $profileColumnPhone TEXT NOT NULL
          )
          ''');

    // Perintah untuk membuat tabel booking
    await db.execute('''
          CREATE TABLE $tableBookings (
            $bookingColumnId INTEGER PRIMARY KEY,
            $bookingColumnUserId TEXT NOT NULL,
            $bookingColumnCarId INTEGER NOT NULL,
            $bookingColumnStartDate TEXT NOT NULL,
            $bookingColumnEndDate TEXT NOT NULL,
            $bookingColumnTotalPrice INTEGER NOT NULL,
            $bookingColumnStatus TEXT NOT NULL 
          )
          ''');
  }

  // ==================================================================
  // --- FUNGSI-FUNGSI UNTUK TABEL FAVORIT ---
  // ==================================================================
  Future<int> insertFavorite(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableFavorites, row);
  }

  Future<List<Map<String, dynamic>>> queryAllFavorites() async {
    Database db = await instance.database;
    return await db.query(tableFavorites);
  }

  Future<int> deleteFavorite(int carId) async {
    Database db = await instance.database;
    return await db.delete(tableFavorites,
        where: '$favColumnCarId = ?', whereArgs: [carId]);
  }

  // ==================================================================
  // --- FUNGSI-FUNGSI UNTUK TABEL PROFIL ---
  // ==================================================================
  Future<int> insertProfile(Map<String, dynamic> row) async {
    Database db = await instance.database;
    // Gunakan conflictAlgorithm.replace untuk menangani kasus update (jika id sudah ada, datanya diganti)
    return await db.insert(tableProfiles, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> queryProfile(String userId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(tableProfiles,
        where: '$profileColumnId = ?', whereArgs: [userId]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // ==================================================================
  // --- FUNGSI-FUNGSI UNTUK TABEL BOOKING ---
  // ==================================================================
  Future<int> insertBooking(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableBookings, row);
  }

  Future<List<Map<String, dynamic>>> queryBookingsByUser(String userId) async {
    Database db = await instance.database;
    return await db.query(tableBookings,
        where: '$bookingColumnUserId = ?',
        whereArgs: [userId],
        orderBy: '$bookingColumnId DESC');
  }

  // ==================================================================
  // --- FUNGSI LANJUTAN (JOIN) UNTUK HOMESCREEN ---
  // ==================================================================
  Future<List<Map<String, dynamic>>> queryAllBookingsWithDetails() async {
    Database db = await instance.database;

    // Ini adalah query SQL mentah untuk menggabungkan 3 tabel
    final String rawQuery = '''
      SELECT
        B.$bookingColumnId,
        B.$bookingColumnStatus,
        B.$bookingColumnStartDate,
        P.$profileColumnFullName,
        C.$favColumnBrand,
        C.$favColumnModel
      FROM $tableBookings AS B
      JOIN $tableProfiles AS P ON B.$bookingColumnUserId = P.$profileColumnId
      JOIN $tableFavorites AS C ON B.$bookingColumnCarId = C.$favColumnCarId
      ORDER BY B.$bookingColumnStartDate DESC
    ''';

    return await db.rawQuery(rawQuery);
  }
}
