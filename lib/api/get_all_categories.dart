import 'dart:convert';

import 'package:promoter_tracking_app/models/category_model.dart';
import 'package:http/http.dart' as http;

class GetAllCatgories {
  Future<List<CategoryModel>> getAllCategories() async {
    http.Response response = await http.get(Uri.parse(
        'http://rayatradeapp.com/promotersapi/api/PromoterAPI/GetCategory'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['aA_Categories'];
      List<CategoryModel> categories = [];
      for (int i = 0; i < data.length; i++) {
        categories.add(CategoryModel.fromJson(data[i]));
      }
      return categories;
    } else {
      throw Exception('Opps there is an error ! ${response.statusCode}');
    }
  }
}
