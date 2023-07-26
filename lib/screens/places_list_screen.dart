import 'package:flutter/material.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPalces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPalces>(
                builder: (context, greatPlaces, child) =>
                    greatPlaces.itemsCount == 0
                        ? child as Widget
                        : ListView.builder(
                            itemCount: greatPlaces.itemsCount,
                            itemBuilder: (context, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.itemByIndex(i).image),
                              ),
                              title: Text(greatPlaces.itemByIndex(i).title),
                              subtitle: Text(greatPlaces
                                  .itemByIndex(i)
                                  .location!
                                  .address!),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.placeDetail,
                                  arguments: greatPlaces.itemByIndex(i),
                                );
                              },
                            ),
                          ),
                child: const Center(
                  child: Text('Nenhum local cadastrado'),
                ),
              ),
      ),
    );
  }
}
