import 'package:flutter/foundation.dart';
import 'package:roll2win/model/help_support_model.dart';
import 'package:roll2win/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';

class HelpRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<HelpModel> helpApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.getSupportDataApi);
      return HelpModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during helpApi: $e');
      }
      rethrow;
    }
  }
}