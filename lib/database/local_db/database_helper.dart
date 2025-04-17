import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal() {
    _initRepositories();
  }

  void _initRepositories() {
    // Initialize repositories here if needed
  }

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    const databaseName = 'app.db';

    // Create a new database
    final db = await openDatabase(
      join(databasePath, databaseName),
      version: 1,
      onCreate: _onCreate,
    );

    // Ensure foreign keys are always enabled
    await db.execute('PRAGMA foreign_keys = ON;');
    return db;
  }

  Future<void> deleteDB() async {
    final databasePath = await getDatabasesPath();
    const databaseName = 'app.db';
    final path = join(databasePath, databaseName);
    await deleteDatabase(path);
  }

  // Called when creating the database
  Future<void> _onCreate(Database db, int version) async {
    // Enable foreign keys
    await db.execute('PRAGMA foreign_keys = ON;');

    await _createTables(db); // Create tables
    await _createIndexes(db); // Tạo index sau khi đã tạo bảng
  }

  // Create all tables in the database
  Future<void> _createTables(Database db) async {
    await _createProfileTable(db);
  }

  Future<void> _createIndexes(Database db) async {
    // Tạo index cho user_profiles
    await db.execute(
        'CREATE INDEX idx_user_profiles_user_id ON User(id);');
    await db.execute(
        'CREATE INDEX idx_user_profiles_email ON User(email);');
  }

  Future<void> _createProfileTable(Database db) async {
    await db.execute('''
      CREATE TABLE User (
        id TEXT PRIMARY KEY,
        email TEXT,         -- Thêm cột user_id
        full_name TEXT,  -- Tên đầy đủ của người dùng
        url_avatar TEXT         -- URL ảnh đại diện
      );
    ''');
  }

  // Create the Songs table
  Future<void> _createSongsTable(Database db) async {
    await db.execute('''
      CREATE TABLE Songs (
        id TEXT PRIMARY KEY,           -- ID bài hát (UUID)
        email_artist TEXT,             -- Email của nghệ sĩ
        title TEXT NOT NULL,           -- Tên bài hát
        artist TEXT NOT NULL,          -- Nghệ sĩ trình bày
        cover TEXT,                    -- URL ảnh bìa
        duration REAL,                 -- Thời lượng (phút, ví dụ: 3.45)
        url TEXT,                      -- URL bài hát
        releaseDate TEXT               -- Ngày phát hành (ISO 8601 hoặc định dạng chuỗi hợp lệ)
      );
    ''');
  }
}
