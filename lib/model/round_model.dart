import 'package:game2/model/word_model.dart';

class RoundModel {
  final int id;
  final String name;
  final List<WordModel> words;

  RoundModel({
    required this.id,
    required this.name,
    required this.words,
  });

  factory RoundModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> wordsList = json['round'] ?? [];
    List<WordModel> words =
        wordsList.map((wordJson) => WordModel.fromJson(wordJson)).toList();

    return RoundModel(
      id: json['id'],
      name: json['name'],
      words: words,
    );
  }
}
