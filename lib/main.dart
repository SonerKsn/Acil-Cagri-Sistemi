import 'package:acildurumapp3/pages/landingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';



void main()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
