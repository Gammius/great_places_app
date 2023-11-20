import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<MapObject> _mapObject = [];
  Point? _selectedPoint;
  late YandexMapController _controller;

  final MapObjectId userPlacemarkID = MapObjectId("userPoint");
  final MapObjectId selectedPlacemarkID = MapObjectId("selectedPoint");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ваша карта"),
        actions: [
          IconButton(
              onPressed: _selectedPoint != null
                  ? () {
                Navigator.of(context).pop(_selectedPoint);
              }
                  : null,
              icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          YandexMap(
            mapObjects: _mapObject,
            onMapCreated: (controller){
              _controller = controller;
            },
            onMapTap: (point) {
              setState(() {
                _selectedPoint = point;
                _mapObject.add(
                  PlacemarkMapObject(
                    mapId: selectedPlacemarkID,
                    point: point,
                    icon: PlacemarkIcon.single(
                      PlacemarkIconStyle(
                        image: BitmapDescriptor.fromAssetImage(
                            "assets/images/place.png",
                        ),
                      ),
                    ),
                    opacity: 1,
                  ),
                );
              });
            },
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 60,),
            child: RawMaterialButton(
              padding: const EdgeInsets.all(10),
              shape: const CircleBorder(),
              fillColor: Colors.white,
              elevation: 2,
              onPressed: () async {
                LocationData locData = await Location().getLocation();

                _controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                          latitude: locData.latitude ?? 0,
                          longitude: locData.longitude ?? 0,),
                      zoom: 13,
                    ),
                  ),
                  animation: const MapAnimation(),
                );
              },
              child: const Icon(Icons.place),
            ),
          ),
        ],
      ),
    );
  }
}
