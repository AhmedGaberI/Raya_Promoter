import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class GetAllModels {
  Future<List<String>> getAllModels({required String catID}) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'http://rayatradeapp.com/promotersapi/api/PromoterAPI/GetModelByID/$catID'));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> data = jsonData['aA_Models'];
        List<String> models = [];
        for (int i = 0; i < data.length; i++) {
          models.add(data[i]['model']);
        }
        return models;
      } else {
        throw Exception('There is an error ${response.statusCode}');
      }
    } on Exception catch (e) {
      log(e.toString());
      throw Exception('There is an error');
    }
  }
}
