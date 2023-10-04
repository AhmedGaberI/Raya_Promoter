class PromoterInfoModel {
  final String promoterName;
  final String store;
  final String bransh;
  final double storeLat;
  final double storeLong;
  final bool isActive;

  PromoterInfoModel(
      {required this.promoterName,
      required this.store,
      required this.bransh,
      required this.storeLat,
      required this.storeLong,
      required this.isActive});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'promoterName': promoterName});
    result.addAll({'store': store});
    result.addAll({'bransh': bransh});
    result.addAll({'storeLat': storeLat});
    result.addAll({'storeLong': storeLong});
    result.addAll({'isActive': isActive});

    return result;
  }

  factory PromoterInfoModel.fromJson(jsonData) {
    return PromoterInfoModel(
      promoterName: jsonData['promoterName'],
      store: jsonData['store'] ?? '',
      bransh: jsonData['bransh'] ?? '',
      storeLat: jsonData['storeLat']?.toDouble() ?? 0.0,
      storeLong: jsonData['storeLong']?.toDouble() ?? 0.0,
      isActive: jsonData['isActive'] ?? false,
    );
  }
}
