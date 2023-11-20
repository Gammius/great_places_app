import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapCheckScreen extends StatelessWidget {
  final PlaceLocation placeLocation;
  const MapCheckScreen({super.key, required this.placeLocation});

  @override
  Widget build(BuildContext context) {
    final _mapObject = [
      PlacemarkMapObject(
        mapId: MapObjectId("selectedPlace"),
        point: Point(
            latitude: placeLocation.latitude,
            longitude: placeLocation.longitude,
        ),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              "assets/images/place.png",
            ),
          ),
        ),
        opacity: 1,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ваша карта"),
      ),
      body: YandexMap(
        mapObjects: _mapObject,
        onMapCreated: (controller) => controller.moveCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: Point(
                        latitude: placeLocation.latitude,
                      longitude: placeLocation.longitude,
                    ),
                ),
            ),
          animation: const MapAnimation(),),
      ),
    );
  }
}
