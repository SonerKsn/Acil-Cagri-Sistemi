import 'package:acildurumapp3/controllers/auth_with_numbers.dart';
import 'package:acildurumapp3/models/vaka_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class VakaController extends GetxController {
  RxString secilenDrop = "".obs;
  RxString secilenEkip = "".obs;

  RxString emniyetDrop = "VAKA SEÇ".obs;
  RxString saglikDrop = "VAKA SEÇ".obs;
  RxString jandarmaDrop = "VAKA SEÇ".obs;
  RxString itfaiyeDrop = "VAKA SEÇ".obs;
  RxString ormanDrop = "VAKA SEÇ".obs;

  authWithNumber controller = Get.find();
  RxString Enlem = "".obs;
  RxString Boylam = "".obs;

  Future addData() async {
    String userId = controller.auth.currentUser!.uid.toString();
    String userPhoneNumber =
        controller.auth.currentUser!.phoneNumber.toString();
    String vakaDurumu = secilenDrop.value;
    String vakaEkipTanim = secilenEkip.value;
    DateTime saveTar = DateTime.now();
    int vakaDurum = 0;
    String vakaKonumLong = Boylam.value;
    String vakaKonumLat = Enlem.value;
    String uniqId = Uuid().v4();

    await FirebaseFirestore.instance
        .collection('vakalar')
        .doc(uniqId)
        .set({
          'uniqId': uniqId,
          'userId': userId,
          'userPhoneNumber': userPhoneNumber,
          'vakaDurumu': vakaDurumu,
          'vakaEkipTanim': vakaEkipTanim,
          'saveTar': saveTar,
          'vakaDurum': vakaDurum,
          'vakaKonumLong': vakaKonumLong,
          'vakaKonumLat': vakaKonumLat,
        })
        .then((value) => print("Veri başarıyla gönderildi"))
        .catchError((error) => print("Hata oluştu: $error"));
  }

  Future updateData(String uid) async {
    await FirebaseFirestore.instance
        .collection('vakalar')
        .doc(uid)
        .update({
          'vakaDurum': 1,
        })
        .then((value) => print("Veri başarıyla güncellendi."))
        .catchError((error) => print("Hata oluştu: $error"));
  }

  Future updateData2(String uid) async {
    await FirebaseFirestore.instance
        .collection('vakalar')
        .doc(uid)
        .update({
          'vakaDurum': 2,
        })
        .then((value) => print("Veri başarıyla güncellendi."))
        .catchError((error) => print("Hata oluştu: $error"));
  }

  Future<List<VakaModel>> fetchData() async {
    String userId =
        "kullaniciId"; // Filtrelemek için kullanıcı kimliğini belirtin

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('vakalar')
        .where('userId', isEqualTo: controller.auth.currentUser!.uid.toString())
        .orderBy('saveTar', descending: true)
        .get();

    List<VakaModel> vakalar = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      if (data != null) {
        return VakaModel.fromMap(data);
      } else {
        throw Exception("Verileri alırken hata oluştu");
      }
    }).toList();

    return vakalar;
  }

  Future<List<VakaModel>> fetchData2() async {
    String userId = "kullaniciId";

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('vakalar')
        .orderBy('saveTar', descending: true)
        .get();

    List<VakaModel> vakalar = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      if (data != null) {
        return VakaModel.fromMap(data);
      } else {
        throw Exception("Verileri alırken hata oluştu");
      }
    }).toList();

    return vakalar;
  }
}
