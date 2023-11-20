import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/core/hive_helper.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage,PlaceLocation pickedLocation) async{
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: pickedLocation,
        image: pickedImage,
    );

    _items.add(newPlace);
    (await HiveHelper.getDB<Place>("user_places")).put(newPlace.id,newPlace);
    notifyListeners();
  }

  Future<void> fetchAndSetData() async{
    var db = await HiveHelper.getDB<Place>("user_places");
    _items = db.values.toList();
    notifyListeners();
  }


  Future<Place?> getPlace(String id) async{
    return (await HiveHelper.getDB<Place>("user_places")).get(id);
  }

  Future<void> deletePlace(String id) async{
    if(!(await HiveHelper.getDB<Place>("user_places")).containsKey(id)) return;
    (await HiveHelper.getDB<Place>("user_places")).get(id)!.image.delete();
    (await HiveHelper.getDB<Place>("user_places")).delete(id);
    fetchAndSetData();
  }



  // Future<void> deleteData(Place place) async{
  //   var db = await HiveHelper.getDB<Place>("user_places");
  //   if(items.contains(place)){
  //     db.deleteAt(_items.indexOf(place));
  //     _items.remove(place);
  //   }
  //   notifyListeners();
  // }
  //
  // Future<void> updateData(int index, Place newPlace) async{
  //   var db = await HiveHelper.getDB<Place>("user_places");
  //   if(index < _items.length){
  //     db.putAt(index, newPlace);
  //     _items.removeAt(index);
  //     _items.insert(index, newPlace);
  //   }
  //   notifyListeners();
  // }
}