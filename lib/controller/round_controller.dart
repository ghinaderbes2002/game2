import 'package:game2/controller/main_controller.dart';
import 'package:game2/model/log_model.dart';

abstract class RoundController extends MainControllerimp {
  isRoundPlayed(int id);
  getLogFromId(int id);
}

class RoundControllerimp extends RoundController {
  @override
  bool isRoundPlayed(int id) {
    bool isPlayed = false;
    userModel.logs.map((log) => {
          if (log.roundId == id) {isPlayed = true}
        });
    return isPlayed;
  }

  @override
  getLogFromId(int id) {
    late LogModel logModel;
    userModel.logs.map((log) => {
          if (log.roundId == id) {logModel = log}
        });
    return logModel;
  }
}
