import 'package:game2/model/log_model.dart';

class UserModel {
  final int id;
  final String name;
  final String password;
  final List<LogModel> logs;

  UserModel({
    required this.id,
    required this.name,
    required this.password,
    required this.logs,
  });

  factory UserModel.fromServer(Map<String, dynamic> json) {
    // List<dynamic> logsList = json['user']['logs'];
    // List<LogModel> logs =
    //     logsList.map((logJson) => LogModel.fromJson(logJson)).toList();

    var logsFromJson = json['user']['logs'] as List;
    List<LogModel> logList =
        logsFromJson.map((log) => LogModel.fromJson(log)).toList();

    return UserModel(
      id: json['user']['id'],
      name: json['user']['name'],
      password: json['user']['password'],
      logs: logList,
    );
  }

  factory UserModel.fromCache(Map<String, dynamic> json) {
    var logsFromJson = json['logs'] as List;
    List<LogModel> logList =
        logsFromJson.map((log) => LogModel.fromJson(log)).toList();

    return UserModel(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      logs: logList,
    );
  }

  factory UserModel.forTopPlayer(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      logs: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'logs': logs.map((log) => log.toJson()).toList(),
    };
  }

  List<LogModel> getLogsForRound(int roundId) {
    return logs.where((log) => log.roundId == roundId).toList();
  }

  LogModel? getLogWithHighestScore(int roundId) {
    List<LogModel> logsForRound = getLogsForRound(roundId);
    if (logsForRound.isEmpty) {
      return null;
    }
    return logsForRound
        .reduce((current, next) => current.score > next.score ? current : next);
  }
}
