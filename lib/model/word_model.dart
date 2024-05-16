class WordModel {
  final int id;
  final String word;

  WordModel({
    required this.id,
    required this.word,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['id'],
      word: json['word'],
    );
  }
}
