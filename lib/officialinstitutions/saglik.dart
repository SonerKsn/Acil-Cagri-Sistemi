import 'package:acildurumapp3/controllers/vaka_controller.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';

class Saglik extends StatefulWidget {
  Saglik({Key? key}) : super(key: key);

  @override
  State<Saglik> createState() => _SaglikState();
}

class _SaglikState extends State<Saglik> {
  List<String> Vaka = [
    "VAKA SEÇ",
    "Ambulans Talebi",
    "Darp",
    "İntihar/Teşebbüs",
    "Kavga",
    "Madde Bağımlısı",
    "Trafik Kazası/Yaralı"
  ];

  String? selectedValue;
  VakaController controller = Get.find();
  final TextEditingController textEditingController = TextEditingController();
  bool isOpenedDrop = false;
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Row(
              children: [
                Column(
                  children: [
                    Text("SAĞLIK",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        )),
                    Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'VAKA SEÇ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: Vaka.map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )).toList(),
                          value: controller.saglikDrop.value,
                          onChanged: (value) {
                            controller.emniyetDrop.value = "VAKA SEÇ";
                            controller.jandarmaDrop.value = "VAKA SEÇ";
                            controller.itfaiyeDrop.value = "VAKA SEÇ";
                            controller.ormanDrop.value = "VAKA SEÇ";

                            controller.saglikDrop.value = value.toString();

                            setState(() {
                              controller.secilenDrop.value = value.toString();
                              controller.secilenEkip.value = "Sağlık";
                              selectedValue = value as String;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            height: 40,
                            width: 200,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Vaka Arama',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return (item.value
                                  .toString()
                                  .contains(searchValue));
                            },
                          ),
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              textEditingController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.health_and_safety_sharp,
                  size: 65,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
