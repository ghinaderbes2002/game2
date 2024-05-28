import 'package:game2/controller/main_controller.dart';
import 'package:game2/model/log_model.dart';

import '../core/classes/api_client.dart';
import '../core/constants/connection.dart';
import '../model/round_model.dart';

abstract class RoundController extends MainControllerImp {
  bool isRoundPlayed(int id);

  LogModel? getLogFromId(int id);

  Future<List<RoundModel>> getOpenRounds();
}

class RoundControllerImp extends RoundController {
  List<RoundModel> openRounds = [];

  @override
  bool isRoundPlayed(int id) {
    for (LogModel log in userModel.logs) {
      if (log.roundId == id) {
        return true;
      }
    }
    return false;
  }

  @override
  LogModel? getLogFromId(int id) {
    try {
      return userModel.logs.firstWhere((log) => log.roundId == id);
    } catch (e) {
      print('Log with roundId $id not found');
      return null;
    }
  }

  @override
  Future<List<RoundModel>> getRounds() async {
    ApiClient apiClient = ApiClient();
    try {
      ApiResponse<dynamic> getResponse = await apiClient.getData(
        url: '$serverLink/getRound',
      );
      print('POST Response Data: ${getResponse.data}');

      List<dynamic> roundsList = getResponse.data['rounds'] ?? [];
      return roundsList
          .map((roundJson) => RoundModel.fromJson(roundJson))
          .toList();
    } catch (error) {
      print('Error while making POST request: $error');
      return [];
    }
  }

  @override
  Future<List<RoundModel>> getOpenRounds() async {
    try {
      ApiClient apiClient = ApiClient();
      ApiResponse<dynamic> getResponse = await apiClient.getData(
          url: '$serverLink/getOpenRounds',
          queryParameters: {"userId": userModel.id});
      print('POST Response Data: ${getResponse.data}');

      List<dynamic> roundsList = getResponse.data ?? [];

      return roundsList
          .map((roundJson) => RoundModel.fromJson(roundJson))
          .toList();
    } catch (error) {
      print('Error while making POST request: $error');
      return [];
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchUser();
    openRounds = await getOpenRounds();
  }
}
