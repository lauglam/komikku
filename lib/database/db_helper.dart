// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class DBHelper {
//   /// 数据库名称
//   static const dbname = 'komikku.db';
//
//   /// 历史表名称
//   static const histories = 'histories';
//
//   /// 刷新令牌表名称
//   static const refreshes = 'refreshes';
//
//   /// 数据库
//   static Future<Database> database() async {
//     final dbPath = await getDatabasesPath();
//
//     return await openDatabase(
//       join(dbPath, dbname),
//       onCreate: (db, version) async {
//         await db.transaction((txn) async {
//           // History
//           await txn.execute('CREATE TABLE IF NOT EXISTS $histories(id TEXT PRIMARY KEY,'
//               ' manga_id TEXT,'
//               ' chapter_id TEXT,'
//               ' updated_at TEXT,'
//               ' create_at TEXT)');
//
//           // Refresh
//           await txn.execute('CREATE TABLE IF NOT EXISTS $refreshes(id TEXT PRIMARY KEY,'
//               ' token TEXT,'
//               ' expire TEXT,'
//               ' updated_at TEXT,'
//               ' create_at TEXT)');
//         });
//       },
//       version: 1,
//     );
//   }
//
//   /// 选择所有
//   static Future<List<Map<String, dynamic>>> selectAll(String table) async {
//     final db = await DBHelper.database();
//
//     // With out Query
//     return db.query(table);
//     // With Query
//     // return db.rawQuery('SELECT * FROM $histories');
//   }
//
//   /// 插入
//   static Future<int> insert(String table, Map<String, Object> data) async {
//     final db = await DBHelper.database();
//
//     return db.insert(
//       table,
//       data,
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   /// 更新
//   static Future<int> update(String table, Map<String, Object> values, String id) async {
//     final db = await DBHelper.database();
//
//     // 更新时间
//     values.addAll({'updated_at': DateTime.now().toIso8601String()});
//
//     return db.update(
//       table,
//       values,
//       where: 'id = ? ',
//       whereArgs: [id],
//     );
//   }
// }
