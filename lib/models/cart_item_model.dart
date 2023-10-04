import 'dart:convert';

class CartItemModel {
  int? id;
  String modelName;
  double price;
  int quantity; 
  CartItemModel({
    this.id,
    required this.modelName,
    required this.price,
    required this.quantity,
  });
  
  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    result.addAll({'modelName': modelName});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
  
    return result;
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id']?.toInt(),
      modelName: map['modelName'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) => CartItemModel.fromMap(json.decode(source));
}
