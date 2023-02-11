import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../../models/ingredient.dart';
import '../../models/recipe.dart';

final databaseProvider = Provider((ref) => DbHelper());

class DbHelper {
  final String _databaseName = "CookOffDatabase.db";
  final int _databaseVersion = 1;
  Database? _db;

  Future<Database> get database async => _db ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    String path = p.join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE shopping_list (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        quantity REAL NOT NULL,
        image_url TEXT NOT NULL,
        measure TEXT,
        weight REAL
      )
      ''',
    );
    await db.execute(
      '''CREATE TABLE favorites (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        image_url TEXT NOT NULL,
        isFavorite INTEGER NOT NULL
      )
      ''',
    );

    await fixtures(db);
  }

  Future<void> fixtures(Database db) async {
    await db.insert(
      'favorites',
      Recipe(
        id: "604715bfa5f351bc9c8aabcc5b35873e",
        name: "Roast Chicken",
        imageUrl:
            'https://edamam-product-images.s3.amazonaws.com/web-img/32e/32ea653bf137bcef9303397f93b1a845.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDQaCXVzLWVhc3QtMSJIMEYCIQDNsF3hU85rn7X2LzGQjMqQPHom7%2BI9oTwDFcISYYRk%2FwIhAKb9CUiyLJP2oe0f9Juy3vfsQhlSZWzg%2F%2B%2BoN8uPtHhgKtUECL3%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2IgybqfzHdqWQjKi2J6MqqQRaCuttx3M6MYlkH%2FPNBLaqDCM2JNkFE706REdweitrbbkbehpEFM98V%2BU0UsZf%2FdTr%2F2KUX%2FmeF5pC6HKbNdyuq6V4TxddYCasA%2F6d6kZvqKyTs48tTcyeJPrxBni2pXvE7YFVrnKStXu6c9QOtRrxqKeRN41Esnj4dds2M8mAsUolX5ngxEngCx0ik%2FKyreMrVeKK2TbRzLtV36OGrNnjwvLK0ffhpsidWRsnAXvH3BNH9fBlghnDrpflxfgieG9XwXsDx6RE8BwA%2BAifgPAh6rgruG%2Bd3vxdcsUooW%2BZWJJNOJ9lic761njK4q12FO8NDmXySJHOIkafDNivP%2B9yqViSZjaZ%2BL0eNr1t0XzboHjgjo%2Fpg60kpxenWEttpsmpowLV9IcQFZoSinwVpwBReM0vnWHV2xBRQ62nyufnQUw09Zx%2FPKWa2P7MnQfGEZZAqHL%2F9xC7K%2BDaXAVOO5yQsTrrzU%2BDYTuUG1g4Ji5isNIAP503JOWnP9xfaQOcwnIsBKAL0FfQriCmiP6v%2BzTTal%2FylgQb12SjHGHv2hhYsCmyTqhECRkJpGkgacSgdyhk5s2PG8FI%2Fhc%2FAroyAfyVWC6UKiBZqQfYkMDo99kWJF4YSSbuouoAs%2FZxLOU2NsQM%2F%2BuFMR%2FWeiC61rpCXq8%2FNPKiMHPnBUVgWmpKA6%2FVIicYakCfkpwj9v6jYNrbxyjzGri08BEZDVisOwpeJq8%2Fm1GpcPAC9D5rMMuEnp8GOqgBqg36%2BlqHKXSJkVB7lE%2F0x4f%2FA3PsoskY2jh9Ub0xn5C%2FQiBH1xE%2FbpGoRGV8DyLl4mt61YbV7opcBVX2%2FdufOkGMIxFSgRJZZXWjB7236YxIaq01x2R%2FvEs9lq78xIaP0mkfyoKWo7djaRoRtN4vEFYj72jPhKRTRHubJ7nE4Ay3GNwJDRTLsdHDij7fLgd%2FTPCwOkFsvHNqKXgfACpsjqegQLz43RCy&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230211T123606Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFGQ2ZGHMR%2F20230211%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=6d1a0cce21acaf3d3c654b31921214ee43e0aa5b4cd4fbb0a488fee60ebdec5b',
        isFavorite: true,
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    await db.insert(
      'favorites',
      Recipe(
        id: "be3ba087e212f13672b553ecfa876333",
        name: "Baked Chicken",
        imageUrl:
            'https://edamam-product-images.s3.amazonaws.com/web-img/33b/33b15ff1ba5de5805e5ecbc5c91798f9.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEDQaCXVzLWVhc3QtMSJIMEYCIQDNsF3hU85rn7X2LzGQjMqQPHom7%2BI9oTwDFcISYYRk%2FwIhAKb9CUiyLJP2oe0f9Juy3vfsQhlSZWzg%2F%2B%2BoN8uPtHhgKtUECL3%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2IgybqfzHdqWQjKi2J6MqqQRaCuttx3M6MYlkH%2FPNBLaqDCM2JNkFE706REdweitrbbkbehpEFM98V%2BU0UsZf%2FdTr%2F2KUX%2FmeF5pC6HKbNdyuq6V4TxddYCasA%2F6d6kZvqKyTs48tTcyeJPrxBni2pXvE7YFVrnKStXu6c9QOtRrxqKeRN41Esnj4dds2M8mAsUolX5ngxEngCx0ik%2FKyreMrVeKK2TbRzLtV36OGrNnjwvLK0ffhpsidWRsnAXvH3BNH9fBlghnDrpflxfgieG9XwXsDx6RE8BwA%2BAifgPAh6rgruG%2Bd3vxdcsUooW%2BZWJJNOJ9lic761njK4q12FO8NDmXySJHOIkafDNivP%2B9yqViSZjaZ%2BL0eNr1t0XzboHjgjo%2Fpg60kpxenWEttpsmpowLV9IcQFZoSinwVpwBReM0vnWHV2xBRQ62nyufnQUw09Zx%2FPKWa2P7MnQfGEZZAqHL%2F9xC7K%2BDaXAVOO5yQsTrrzU%2BDYTuUG1g4Ji5isNIAP503JOWnP9xfaQOcwnIsBKAL0FfQriCmiP6v%2BzTTal%2FylgQb12SjHGHv2hhYsCmyTqhECRkJpGkgacSgdyhk5s2PG8FI%2Fhc%2FAroyAfyVWC6UKiBZqQfYkMDo99kWJF4YSSbuouoAs%2FZxLOU2NsQM%2F%2BuFMR%2FWeiC61rpCXq8%2FNPKiMHPnBUVgWmpKA6%2FVIicYakCfkpwj9v6jYNrbxyjzGri08BEZDVisOwpeJq8%2Fm1GpcPAC9D5rMMuEnp8GOqgBqg36%2BlqHKXSJkVB7lE%2F0x4f%2FA3PsoskY2jh9Ub0xn5C%2FQiBH1xE%2FbpGoRGV8DyLl4mt61YbV7opcBVX2%2FdufOkGMIxFSgRJZZXWjB7236YxIaq01x2R%2FvEs9lq78xIaP0mkfyoKWo7djaRoRtN4vEFYj72jPhKRTRHubJ7nE4Ay3GNwJDRTLsdHDij7fLgd%2FTPCwOkFsvHNqKXgfACpsjqegQLz43RCy&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230211T123606Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFGQ2ZGHMR%2F20230211%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=120f8b4b02fd492be9390367aa9e9635fc1d85b377bc6ce436d1cf05717b82b9',
        isFavorite: true,
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    await db.insert(
      'shopping_list',
      Ingredient(
        id: "food_a1vgrj1bs8rd1majvmd9ubz8ttkg",
        name: "chicken",
        quantity: 1.0,
        imageUrl:
            "https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg",
        measure: "tablespoon",
        weight: 14.562499999753793,
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    await db.insert(
      'shopping_list',
      Ingredient(
        id: "food_bmyxrshbfao9s1amjrvhoauob6mo",
        name: "chicken",
        quantity: 1.0,
        imageUrl:
            "https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg",
        measure: "",
        weight: 1200.0,
      ).toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
