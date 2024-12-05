import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:latihan_responsi/models/user.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT
      )
    ''');
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<User> registerUser(User user) async {
    final db = await database;
    final hashedPassword = _hashPassword(user.password);

    final newUser = User(username: user.username, password: hashedPassword);

    try {
      newUser.id = await db.insert('users', newUser.toMap());
      return newUser;
    } catch (e) {
      throw Exception('Gagal melakukan registrasi');
    }
  }

  Future<bool> checkUsernameExists(String username) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty;
  }

  Future<User?> loginUser(String username, String password) async {
    final db = await database;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final hashedPassword = _hashPassword(password);

    final maps = await db.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, hashedPassword]);

    if (maps.isNotEmpty) {
      final user = User.fromMap(maps.first);
      await prefs.setString('userId', user.id.toString());
      return user;
    }

    return null;
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('userId') != null &&
        prefs.getString('userId')!.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
    } catch (e) {
      print('Logout error: $e');
    }
  }
}
