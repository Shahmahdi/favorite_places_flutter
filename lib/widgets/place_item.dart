import 'package:favorite_places_flutter/models/place.dart';
import 'package:favorite_places_flutter/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) {
              return PlaceDetailsScreen(
                placeDetails: place,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: FileImage(place.image),
              radius: 26,
            ),
            const SizedBox(width: 16),
            Text(
              place.title,
              // style: const TextStyle(
              //   color: Colors.white,
              //   fontSize: 16,
              // ),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
