import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() => _pickedImage = pickedImage);
  }

  void _selectPosition(LatLng position) {
    setState(() => _pickedPosition = position);
  }

  bool _isValidForm() =>
      _titleController.text.isNotEmpty &&
      _pickedImage != null &&
      _pickedPosition != null;

  void _submitForm() {
    if (!_isValidForm()) return;

    Provider.of<GreatPalces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Título',
                      ),
                      controller: _titleController,
                      onChanged: (text) => setState(() {}),
                    ),
                    const SizedBox(height: 10),
                    ImageInput(_selectImage),
                    const SizedBox(height: 10),
                    LocationInput(_selectPosition),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: _isValidForm() ? _submitForm : null,
          ),
        ],
      ),
    );
  }
}
