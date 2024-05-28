class LogModel {
  final int id;
  final int score;
  final int mistake; // Ensure this field name matches the JSON response
  final DateTime date;
  final int roundId;

  LogModel({
    required this.id,
    required this.score,
    required this.mistake,
    required this.date,
    required this.roundId,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      id: json['id'],
      score: json['score'],
      mistake: json['mistake'],
      date: DateTime.parse(json['date']),
      roundId: json['roundId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'score': score,
      'mistake': mistake,
      'date': date.toIso8601String(),
      'roundId': roundId,
    };
  }
}
