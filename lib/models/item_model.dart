class ItemModel {
  final String code;
  final String price;
  final String color;
  final String country;
  final String capacity;
  final String type;
  final String power;
  final String warranty;
  final String otherDescriptions;

  ItemModel(
      {required this.code,
      required this.price,
      required this.color,
      required this.country,
      required this.capacity,
      required this.type,
      required this.power,
      required this.warranty,
      required this.otherDescriptions});

  factory ItemModel.fromJson(json) {
    return ItemModel(
        code: json['code'],
        price: json['price'],
        color: json['color'],
        country: json['country'],
        capacity: json['capacity'],
        type: json['type'],
        power: json['power'],
        warranty: json['warranty'],
        otherDescriptions: json['otherDescriptions']);
  }
}
