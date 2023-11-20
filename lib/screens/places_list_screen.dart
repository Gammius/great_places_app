import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_places_screen.dart';
import 'package:great_places_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ваши места"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlacesScreen.route);
              },
              icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetData(),
        builder: (context, snapshot)
        => snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator(),)
            : Consumer<GreatPlaces>(
          builder: (context, greatPlaces, child) => greatPlaces.items.isEmpty
              ? child!
              : ListView.builder(
            itemCount: greatPlaces.items.length,
            itemBuilder: (ctx, i) => ListTile(
              title: Text(greatPlaces.items[i].title),
              subtitle: greatPlaces.items[i].location != null &&
                  greatPlaces.items[i].location!.address != null
                  ? Text(greatPlaces.items[i].location!.address!)
                  : null,
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailScreen(
                        placeID: greatPlaces.items[i].id,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: FileImage(greatPlaces.items[i].image),
              ),
              trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ), onPressed: () {
                    greatPlaces.deletePlace(greatPlaces.items[i].id);
                  },
                  ),
            ),
          ),
          child: const Center(
            child: Text("Не найдено ни одного места \n Самое время добавить новое! ",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
