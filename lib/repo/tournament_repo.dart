import 'package:flutter/foundation.dart';
import 'package:roll2win/model/ContestCategoryModel.dart';
import 'package:roll2win/res/api_url.dart';

import '../helper/network/base_api_services.dart';
import '../helper/network/network_api_services.dart';
import '../model/tournament_list_model.dart';

class TournamentRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<TournamentModel> tournamentApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiResponse(ApiUrl.tournamentsApi+data);
      return TournamentModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during tournamentApi: $e');
      }
      rethrow;
    }
  }
}