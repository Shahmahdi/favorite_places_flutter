import 'dart:io';

import 'package:favorite_places_flutter/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

const sqlDatabaseName = 'places.db';
const sqlTableNames = {
  'userPlaces': 'userPlaces',
};

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, sqlDatabaseName),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE ${sqlTableNames['userPlaces']}(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    },
    version: 1,
  );
  return db;
}

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query(sqlTableNames['userPlaces']!);
    final places = data.map(
      (row) {
        return Place(
          id: row['id'] as String,
          title: row['title'] as String,
          image: File(row['image'] as String),
        );
      },
    ).toList();
    state = places;
  }

  void addNewPlace(String title, File image) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');
    final newPlace = Place(
      title: title,
      image: copiedImage,
    );

    final db = await _getDatabase();
    db.insert(sqlTableNames['userPlaces']!, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });

    state = [newPlace, ...state];
  }

  void deletePlace(Place place) async {
    final db = await _getDatabase();
    await db.delete(sqlTableNames['userPlaces']!,
        where: 'id = ?', whereArgs: [place.id]);
    final currentPlaces = state;
    currentPlaces.remove(place);
    state = [...currentPlaces];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>((ref) {
  return FavoritePlacesNotifier();
});
