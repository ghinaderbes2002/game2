class LogModel {
  final int id;
  final int score;
  final int mistakes;
  final DateTime date;
  final int roundId;

  LogModel({
    required this.id,
    required this.score,
    required this.mistakes,
    required this.date,
    required this.roundId,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      id: json['id'],
      score: json['score'],
      mistakes: json['mistakes'],
      date: DateTime.parse(json['date']),
      roundId: json['roundId'],
    );
  }
}
