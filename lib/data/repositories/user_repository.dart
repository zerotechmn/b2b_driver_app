import 'package:b2b_driver_app/config/apis.dart';
import 'package:b2b_driver_app/data/models/card_model.dart';
import 'package:b2b_driver_app/data/models/statement_model.dart';
import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:b2b_driver_app/services/api_service.dart';
import 'package:b2b_driver_app/utils/helpers.dart';
import 'package:get/get.dart';

class UserRepository {
  final ApiService apiService = Get.find<ApiService>();

  Future<CardModel> fetchCardDetail(cardId) async {
    final res = await apiService.call(Apis.fetchCardDetail(cardId));
    return parseOrThrow(res.data, CardModel.fromJson);
  }

  Future<List<StatementModel>> fetchStatement(cardId, from, to) async {
    final res = await apiService.call(
      Apis.fetchCardStatements(cardId, from, to),
    );
    return parseListOrThrow(res.data, StatementModel.fromJson);
  }

  Future<List<StationModel>> fetchGasStations() async {
    final res = await apiService.call(Apis.fetchGasStations());
    return parseListOrThrow(res.data, StationModel.fromJson);
  }
}
