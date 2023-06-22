import 'package:acildurumapp3/controllers/vaka_controller.dart';
import 'package:acildurumapp3/models/vaka_model.dart';
import 'package:acildurumapp3/pages/konum_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BenimVakalarim extends StatefulWidget {
  BenimVakalarim({Key? key}) : super(key: key);

  @override
  State<BenimVakalarim> createState() => _BenimVakalarimState();
}

class _BenimVakalarimState extends State<BenimVakalarim> {
  VakaController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vakalarım')),
      body: FutureBuilder<List<VakaModel>>(
          future: controller.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data![index];
                  if (snapshot.data!.length > 0) {
                    return Card(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(data.vakaDurum == 0
                                      ? "İncelemede"
                                      : data.vakaDurum == 1
                                          ? "Ekip Yolda"
                                          : "Talep Red edildi."),
                                  Text(data.vakaDurumu.toString()),
                                  Text(DateFormat('dd/MM/yyyy HH:mm')
                                      .format(data.saveTar)),
                                  Text(data.vakaEkipTanim.toString()),
                                  Text(data.userPhoneNumber.toString()),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () => Get.to(KonumPage(
                                                lat: data.vakaKonumLat,
                                                long: data.vakaKonumLong,
                                                ekipYolda: data.vakaDurum,
                                              )),
                                          child: Text("Konuma Git")),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
