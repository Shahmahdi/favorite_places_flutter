import 'package:favorite_places_flutter/providers/favorite_places_provider.dart';
import 'package:favorite_places_flutter/screens/add_place.dart';
import 'package:favorite_places_flutter/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceListScreen extends ConsumerStatefulWidget {
  const PlaceListScreen({super.key});

  @override
  ConsumerState<PlaceListScreen> createState() {
    return _PlaceListScreen();
  }
}

class _PlaceListScreen extends ConsumerState<PlaceListScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(favoritePlacesProvider.notifier).loadPlaces();
  }

  void _addPlace(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return const AddPlaceScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(favoritePlacesProvider);
    Widget content = Center(
      child: Text(
        "No places added yet.",
        // style: TextStyle(
        //   color: Colors.white,
        // ),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );

    if (places.isNotEmpty) {
      content = ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return PlaceItem(
            place: places[index],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              _addPlace(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _placesFuture,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : content;
        },
      ),
    );
  }
}
