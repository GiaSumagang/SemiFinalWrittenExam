import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.brown),
    title: 'MyApp',
    home: const Myhomepage(),
  ));
}
