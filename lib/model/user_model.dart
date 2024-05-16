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
    List<dynamic> logsList = json['user']['logs'] ?? [];
    List<LogModel> logs =
        logsList.map((logJson) => LogModel.fromJson(logJson)).toList();

    return UserModel(
      id: json['user']['id'],
      name: json['user']['name'],
      password: json['user']['password'],
      logs: logs,
    );
  }

  factory UserModel.fromCache(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      logs: json['logs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'logs': logs,
    };
  }
}
