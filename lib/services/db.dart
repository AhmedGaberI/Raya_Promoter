import 'package:promoter_tracking_app/models/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Carts.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Cart(id INTEGER PRIMARY KEY , modelName TEXT NOT NULL , price REAL NOT NULL , quantity INTEGER NOT NULL);"),
        version: _version);
  }

  static Future<int> addItem(CartItemModel cart) async {
    var dbclient = await _getDB();
    return await dbclient.insert(
      "Cart",
      cart.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<dynamic> getTotalPrice() async {
    var dbclient = await _getDB();
    final sum = await dbclient.rawQuery("SELECT sum(price) as sum FROM Cart");

    return (sum[0]["sum"]);
  }

  static Future<dynamic> getItemByModel({required String modelName}) async {
    var dbclient = await _getDB();

    try {
      var result = await dbclient
          .rawQuery('SELECT * FROM Cart WHERE modelName="$modelName"');

      return result;
    } on Exception {
      throw Exception('DataBase Error');
    }
  }

  static Future<List<CartItemModel>?> getAllItems() async {
    var dbclient = await _getDB();
    final List<Map<String, dynamic>> maps = await dbclient.query("Cart");
    if (maps.isEmpty) return null;
    return List.generate(
        maps.length, (index) => CartItemModel.fromMap(maps[index]));
  }

  static Future<int> deleteItem(CartItemModel cart) async {
    final db = await _getDB();
    return await db.delete(
      "Cart",
      where: 'id = ?',
      whereArgs: [cart.id],
    );
  }

  static Future<int> updateItem(CartItemModel cartItemModel) async {
    final db = await _getDB();
    return await db.update("Cart", cartItemModel.toMap(),
        where: 'id = ?',
        whereArgs: [cartItemModel.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> getNumbersOfItems() async {
    final db = await _getDB();
    List<Map<String, dynamic>> items = await db.rawQuery('SELECT * FROM Cart');
    return items.length;
  }

  static clearCartTable() async {
    Database db = await _getDB();
    return await db.rawDelete("DELETE FROM Cart");
  }
}
