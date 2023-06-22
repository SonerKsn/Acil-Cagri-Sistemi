class VakaModel {
  String uniqId;
  String userId;
  String userPhoneNumber;
  String vakaDurumu;
  String vakaEkipTanim;
  DateTime saveTar;
  int vakaDurum;
  String vakaKonumLong;
  String vakaKonumLat;

  VakaModel({
    required this.uniqId,
    required this.userId,
    required this.userPhoneNumber,
    required this.vakaDurumu,
    required this.vakaEkipTanim,
    required this.saveTar,
    required this.vakaDurum,
    required this.vakaKonumLong,
    required this.vakaKonumLat,
  });

  factory VakaModel.fromMap(Map<String, dynamic> map) {
    return VakaModel(
      uniqId: map['uniqId'],
      userId: map['userId'],
      userPhoneNumber: map['userPhoneNumber'],
      vakaDurumu: map['vakaDurumu'],
      vakaEkipTanim: map['vakaEkipTanim'],
      saveTar: map['saveTar'].toDate(),
      vakaDurum: map['vakaDurum'],
      vakaKonumLong: map['vakaKonumLong'],
      vakaKonumLat: map['vakaKonumLat'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uniqId': uniqId,
      'userId': userId,
      'userPhoneNumber': userPhoneNumber,
      'vakaDurumu': vakaDurumu,
      'vakaEkipTanim': vakaEkipTanim,
      'saveTar': saveTar,
      'vakaDurum': vakaDurum,
      'vakaKonumLong': vakaKonumLong,
      'vakaKonumLat': vakaKonumLat,
    };
  }
}
