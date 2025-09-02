import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/category_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('category.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT
      )
    ''');
  }

// CREATE
  Future<int> insertCategory(CategoryModel category) async {
    final db = await instance.database;
    return await db.insert('categories', category.toMap());
  }

  // READ
  Future<List<CategoryModel>> getCategories() async {
    final db = await instance.database;
    final result = await db.query('categories');
    return result.map((map) => CategoryModel.fromMap(map)).toList();
  }

  // UPDATE
  Future<int> updateCategory(CategoryModel category) async {
    final db = await instance.database;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  // DELETE
  Future<int> deleteCategory(int id) async {
    final db = await instance.database;
    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}