import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class authWithNumber extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController number = TextEditingController();
  TextEditingController otp = TextEditingController();
  String verifyId = "";
  RxString userMobilerNumber = "".obs;

  User? users = FirebaseAuth.instance.currentUser;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
  }

  void getUserData() {
    if (users != null) {
      userMobilerNumber.value = users!.phoneNumber.toString();
    }
  }

  void logoutUser() async {
    await auth.signOut();
    getUserData();
  }
}
