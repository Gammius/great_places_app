import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_places_screen.dart';
import 'package:great_places_app/screens/places_list_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';


void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter<Place>(PlaceAdapter());
  Hive.registerAdapter<PlaceLocation>(PlaceLocationAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: "Прекрасные места",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
          ).copyWith(
            secondary: Colors.amber,
          ),
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlacesScreen.route: (context) => const AddPlacesScreen(),
        },
      ),
    );
  }
}
