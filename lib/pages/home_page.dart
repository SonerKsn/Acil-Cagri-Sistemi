import 'package:acildurumapp3/controllers/auth_with_numbers.dart';
import 'package:acildurumapp3/controllers/vaka_controller.dart';
import 'package:acildurumapp3/officialinstitutions/emniyet.dart';
import 'package:acildurumapp3/officialinstitutions/itfaiye.dart';
import 'package:acildurumapp3/officialinstitutions/jandarma.dart';
import 'package:acildurumapp3/officialinstitutions/orman.dart';
import 'package:acildurumapp3/officialinstitutions/saglik.dart';
import 'package:acildurumapp3/pages/benim_vakalarim.dart';
import 'package:acildurumapp3/pages/register_page.dart';
import 'package:acildurumapp3/pages/vaka_panel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class KurumOlayBilgisi extends StatefulWidget {
  KurumOlayBilgisi({Key? key}) : super(key: key);

  @override
  State<KurumOlayBilgisi> createState() => _KurumOlayBilgisiState();
}

class _KurumOlayBilgisiState extends State<KurumOlayBilgisi> {
  authWithNumber authController = Get.find();
  String _locationMessage = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocationPermission();
  }

  VakaController controller = Get.put(VakaController());

  void _getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
            'Konum izni kalıcı olarak reddedildi. Ayarlardan izin verebilirsiniz.';
      });
      return;
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _locationMessage =
            'Enlem: ${position.latitude}, Boylam: ${position.longitude}';
      });
      controller.Enlem.value = position.latitude.toString();
      controller.Boylam.value = position.longitude.toString();
      print(_locationMessage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(VakaPanel());
              },
              icon: Icon(Icons.admin_panel_settings_rounded)),
          IconButton(
              onPressed: () {
                Get.to(BenimVakalarim());
              },
              icon: Icon(Icons.emergency)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Uyarı'),
                      content: Text('Çıkış yapmak istediğinize emin misiniz?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Evet'),
                          onPressed: () {
                            controller.emniyetDrop.value = "VAKA SEÇ";
                            controller.jandarmaDrop.value = "VAKA SEÇ";
                            controller.saglikDrop.value = "VAKA SEÇ";
                            controller.itfaiyeDrop.value = "VAKA SEÇ";
                            controller.ormanDrop.value = "VAKA SEÇ";
                            authController.auth.signOut();
                            Get.to(RegisterScreen());
                          },
                        ),
                        TextButton(
                          child: Text('Hayır'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        color: Colors.white60,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.redAccent.shade700,
                        ),
                        height: 150,
                        width: 250,
                        child: Center(
                          child: Text(
                            "112 \nACİL \nÇAĞRI",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Emniyet2(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                maximumSize: Size(300, 90)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Saglik(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              maximumSize: Size(300, 70),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Jandarma(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo[900],
                            maximumSize: Size(300, 70),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Itfaiye(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            maximumSize: Size(300, 70),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Orman(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[300],
                            maximumSize: Size(300, 70),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.secilenDrop.value != "") {
                              controller.addData();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('İşlem Başarılı'),
                                    content: Text(
                                        'Talebiniz başarıyla oluşturulmuştur.Vakalarım sayfasından takip edebilirsiniz.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Tamam'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('İşlem başarısız'),
                                    content: Text('Vaka seçimi yapmadınız.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Tamam'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            "VAKA BİLDİR",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
