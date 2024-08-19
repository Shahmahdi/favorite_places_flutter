import 'package:favorite_places_flutter/models/place.dart';
import 'package:favorite_places_flutter/providers/favorite_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceDetailsScreen extends ConsumerWidget {
  const PlaceDetailsScreen({super.key, required this.placeDetails});

  final Place placeDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void deletePlace() {
      ref.read(favoritePlacesProvider.notifier).deletePlace(placeDetails);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(placeDetails.title),
        actions: [
          IconButton(onPressed: deletePlace, icon: const Icon(Icons.delete))
        ],
      ),
      body: Stack(
        children: [
          Image.file(
            placeDetails.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        ],
      ),
    );
  }
}
