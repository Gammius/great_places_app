import 'package:flutter/material.dart';
import 'package:great_places_app/core/location_helper.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationInput extends StatefulWidget {
  final Function(PlaceLocation) onSelectedLocation;
  const LocationInput({super.key, required this.onSelectedLocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _selectedPlace;

  Future<void> _getPreviewImageUrl( double longitude, double latitude,)  async {
    String address = await LocationHelper.getAddressFromLocation(
        longitude: longitude,
        latitude: latitude,);
    PlaceLocation placeLocation = PlaceLocation(
        id: "id",
        latitude: latitude,
        longitude: longitude,
        address: address,);

    setState(() {
      _selectedPlace = placeLocation;
    });
    widget.onSelectedLocation(_selectedPlace!);
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    if(locData.longitude == null || locData.latitude == null) return;
    _getPreviewImageUrl(locData.longitude!, locData.latitude!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
          ),
          child: _selectedPlace == null
              ? const Text("Местоположение не выбрано")
              : Image.network(
            LocationHelper.generateLocationPreviewImage(
              latitude: _selectedPlace!.longitude,
              longitude: _selectedPlace!.latitude!,
            ),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 5,),
        Row(
          children: [
            Expanded(
              child: TextButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: const Icon(Icons.location_on),
                label: const Text(
                  "Нынешнее местоположение",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                onPressed: () async{
                  Point? selectedPoint = await Navigator.of(context).push<Point>(
                    MaterialPageRoute(
                      builder: (context) => const MapScreen(),
                    ),
                  );
                  if(selectedPoint == null) return;
                  _getPreviewImageUrl(
                      selectedPoint.longitude,
                      selectedPoint.latitude,
                  );
                },
                icon: const Icon(Icons.map),
                label: const Text(
                  "Выбрать на карте",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
