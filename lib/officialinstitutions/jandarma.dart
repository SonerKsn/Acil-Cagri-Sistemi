import 'package:acildurumapp3/controllers/vaka_controller.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';

class Jandarma extends StatefulWidget {
  Jandarma({Key? key}) : super(key: key);

  @override
  State<Jandarma> createState() => _JandarmaState();
}

class _JandarmaState extends State<Jandarma> {
  VakaController controller = Get.find();
  List<String> Vaka = [
    "VAKA SEÇ",
    "Ahlak Olayları",
    "Arama-Kurtarma",
    "Dolandırıcılık",
    "Firar",
    "Gürültü",
    "Hırsızlık",
    "İntihar/Teşebbüs",
    "Kaçakçılık",
    "Kaçırma",
    "Kadına Şiddet",
    "Kavga",
    "Kayıp",
    "Kaza",
    "Kumar Oynama-Oynatma",
    "Mala Zarar Verme",
    "Şüpheli Araç/Şahıs",
    "Terör Suçları",
    "Yasak Avcılık"
  ];

  String? selectedValue;

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
            child: Row(
              children: [
                Column(
                  children: [
                    Text("JANDARMA",
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
                          value: controller.jandarmaDrop.value,
                          onChanged: (value) {
                            controller.saglikDrop.value = "VAKA SEÇ";
                            controller.emniyetDrop.value = "VAKA SEÇ";
                            controller.itfaiyeDrop.value = "VAKA SEÇ";
                            controller.ormanDrop.value = "VAKA SEÇ";

                            controller.jandarmaDrop.value = value.toString();
                            setState(() {
                              controller.secilenDrop.value = value.toString();
                              controller.secilenEkip.value = "Jandarma";
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
                  Icons.security_outlined,
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
