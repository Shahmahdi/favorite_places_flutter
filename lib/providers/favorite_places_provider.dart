import 'dart:io';

import 'package:favorite_places_flutter/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super(const []);

  void addNewPlace(String title, File image) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      final copiedImage = await image.copy('${appDir.path}/$fileName');
      final newPlace = Place(
        title: title,
        image: copiedImage,
      );
    state = [newPlace, ...state];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>((ref) {
  return FavoritePlacesNotifier();
});
