import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/models/place.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/widgets/image_input.dart';
import 'package:great_places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlacesScreen extends StatefulWidget {
  static const String route = "/add-places";
  const AddPlacesScreen({super.key});

  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedPlace;


  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _selectPlace(PlaceLocation pickedPlace){
    _pickedPlace = pickedPlace;
  }

  _savePlace() {
    if(_titleController.text.isEmpty
        || _pickedImage == null
        || _pickedPlace == null
    ){
      return;
    }
    Provider.of<GreatPlaces>(
        context,
        listen: false)
        .addPlace(
        _titleController.text,
        _pickedImage!,
      _pickedPlace!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить место"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: "Название"),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 10,),
                    ImageInput(onSelectImage: _selectImage,),
                    const SizedBox(height: 10,),
                    LocationInput(onSelectedLocation: _selectPlace,),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(
                Icons.add, 
                color: Colors.black,
              ),
            label: const Text(
              "Добавить",
              style: TextStyle(
                  color: Colors.black
              ),
            ),
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
