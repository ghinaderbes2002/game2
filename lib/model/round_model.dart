import 'package:game2/model/word_model.dart';

class RoundModel {
  final int id;
  final String name;
  final List<dynamic> words;

  RoundModel({
    required this.id,
    required this.name,
    required this.words,
  });

  factory RoundModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> wordsList = json['words'] ?? [];
    List<WordModel> words =
        wordsList.map((wordJson) => WordModel.fromJson(wordJson)).toList();

    return RoundModel(
      id: json['id'],
      name: json['name'],
      words: words,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'words': words.map((word) => word.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final RoundModel otherRound = other as RoundModel;
    return id == otherRound.id;
  }

  @override
  int get hashCode => id.hashCode;
}

bool isRoundModelInList(List<RoundModel> openRounds, RoundModel round) {
  return openRounds.contains(round);
}
