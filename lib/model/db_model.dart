import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model.dart';

class DatabaseConn {
  Database? _database;

  Future<Database?> get database async {
    // ignore: prefer_conditional_assignment
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  Future<Database> initDB() async {
    String databasePath = join(await getDatabasesPath(), "etrade.database");
    var eTradedatabase = await openDatabase(databasePath, version: 1, onCreate: createdatabase);
    return eTradedatabase;
  }

  Future<void> createdatabase(Database db, int version) async {
    await db.execute(
        'Create table Todo(id INTEGER PRIMARY KEY, title TEXT, content TEXT)');
  }

  Future<List> getTodos() async {
    Database? db = await database;
    var result = await db!.query("Todo");
    //return result;
    return List.generate(result.length, (i) {
      return Todo.fromObject(result[i]);
    });
  }

  //ADD
  Future<int?> addTodo(Todo todo) async {
    Database? db = await database;
    var result = await db?.insert("Todo", todo.toMap());
    return result;
  }

  //DELETE
  Future<int?> delete(int id) async {
    Database? db = await database;
    var result = await db?.rawDelete("delete from Todo where id= $id");
    return result;
  }

  //UPDATE
  Future<int?> update(Todo todo) async {
    Database? db = await database;
    var result = await db?.update("Todo", todo.toMap(),
        where: "id=?", whereArgs: [todo.id]);
    return result;
  }
}
