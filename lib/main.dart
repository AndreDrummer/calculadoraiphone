import 'package:flutter/material.dart';
import "package:calculator/screens/calculator.dart";
import 'package:flutter/services.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();  
  Admob.initialize();
  FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-2837828701670824~6493333574');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'Calculadora de iPhone',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
