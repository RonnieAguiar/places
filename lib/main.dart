import 'package:flutter/material.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/screens/place_detail_screen.dart';
import 'package:places/screens/place_form_screen.dart';
import 'package:places/screens/places_list_screen.dart';
import 'package:places/theme/my_theme.dart';
import 'package:places/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPalces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: myTheme,
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.placeForm: (context) => const PlaceFormScreen(),
          AppRoutes.placeDetail: (context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
