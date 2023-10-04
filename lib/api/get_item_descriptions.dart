import 'dart:convert';

import 'package:promoter_tracking_app/models/item_model.dart';
import 'package:http/http.dart' as http;

class GetItemDescriptions {
  Future<ItemModel> getItemDesriptions({required String modelName}) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'http://rayatradeapp.com/promotersapi/api/PromoterAPI/GetItemDescriptions/$modelName'));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        return ItemModel.fromJson(jsonData['aA_ItemDescriptions'][0]);
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on Exception {
      // TODO
      throw Exception("Error");
    }
  }
}
