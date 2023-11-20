import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/map_check_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  final String placeID;
  const PlaceDetailScreen({super.key, required this.placeID});

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<GreatPlaces>(context, listen: false).getPlace(placeID);

    return FutureBuilder<Place?>(
      future: place,
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator(),),
          );
        } else {
          if(!snapshot.hasData || snapshot.data == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text(
                  "Произошла ошибка выгрузки места, пожалуйста попробуйте еще раз!"),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data!.title),
              ),
              body: Column(
                children: [
                  Container(
                    color: Colors.grey[400],
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Image.file(
                      snapshot.data!.image,
                      height: 300,
                      alignment: Alignment.center,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        snapshot.data!.location!.address!,
                        textAlign: TextAlign.center,
                      ),
                  ),
                  const SizedBox(height: 10,),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            MapCheckScreen(
                                placeLocation: snapshot.data!.location!,
                            ),
                        ),
                      );
                    },
                    child: const Text("Просмотреть на карте"),
                  ),
                ],
              ),
            );
          }
        }
      }
    );
  }
}
