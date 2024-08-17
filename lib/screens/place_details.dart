import 'package:favorite_places_flutter/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.placeDetails});

  final Place placeDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(placeDetails.title),
      ),
      body: Center(
        child: Text(
          placeDetails.title,
          // style: const TextStyle(
          //   color: Colors.white,
          // ),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
