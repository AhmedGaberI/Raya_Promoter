import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:promoter_tracking_app/models/promoter_info_model.dart';

class GetPromoterInfo {
  Future<PromoterInfoModel> getPrmomoterInfo(
      {required dynamic userName,
      required dynamic password,
      required dynamic deviceID}) async {
    http.Response response = await http.post(
        Uri.parse(
            'http://rayatradeapp.com/promotersapi/api/PromoterAPI/GetPromoterInfro'),
        body: jsonEncode({
          'userName': userName,
          'password': password,
          'dviceID': deviceID,
        }),
        headers: {
          'accept': 'text/plain',
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return PromoterInfoModel.fromJson(jsonData[0]);
    } else {
      throw Exception('There is an error ${response.statusCode}');
    }
  }
}
