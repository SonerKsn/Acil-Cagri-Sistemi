import 'package:acildurumapp3/controllers/vaka_controller.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';

class Orman extends StatefulWidget {
  Orman({Key? key}) : super(key: key);

  @override
  State<Orman> createState() => _OrmanState();
}

class _OrmanState extends State<Orman> {
  VakaController controller = Get.find();
  List<String> Vaka = [
    "VAKA SEÇ",
    "Afetler",
    "Kaçak Kesim",
    "Şüpheli Araç/Şahıs",
    "Kaçakçılık",
    "Yasa Dışı Avcılık"
  ];

  String? selectedValue;
  bool isOpenedDrop = false;
  final TextEditingController textEditingController = TextEditingController();

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
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text("ORMAN",
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
                              value: controller.ormanDrop.value,
                              onChanged: (value) {
                                controller.emniyetDrop.value = "VAKA SEÇ";
                                controller.jandarmaDrop.value = "VAKA SEÇ";
                                controller.saglikDrop.value = "VAKA SEÇ";
                                controller.itfaiyeDrop.value = "VAKA SEÇ";

                                controller.ormanDrop.value = value.toString();
                                setState(() {
                                  controller.secilenDrop.value =
                                      value.toString();
                                  controller.secilenEkip.value = "Orman";
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                setState(() {
                                  isOpenedDrop = isOpen;
                                });
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
                      Icons.forest_outlined,
                      size: 65,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
