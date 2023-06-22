import 'package:acildurumapp3/controllers/auth_with_numbers.dart';
import 'package:acildurumapp3/pages/home_page.dart';
import 'package:acildurumapp3/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  authWithNumber controller = Get.put(authWithNumber());
  @override
  Widget build(BuildContext context) {
    return controller.auth.currentUser != null
        ? KurumOlayBilgisi()
        : RegisterScreen(); //register
  }
}
