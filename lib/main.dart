import 'package:flutter/material.dart';
import 'package:pet_match/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:pet_match/providers/user_provider.dart';
import 'package:pet_match/providers/adoption_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AdoptionProvider()),
      ],
      child: const PetMatchApp(),
    ),
  );
}

class PetMatchApp extends StatelessWidget {
  const PetMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PetMatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Montserrat'),
      routerConfig: appRouter,
    );
  }
}
