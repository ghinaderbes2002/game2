class WordModel {
  final int id;
  final String word;
  final int seconds;

  WordModel({
    required this.id, required this.word, required this.seconds});

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['id'],
      word: json['word'],
      seconds: json['seconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'word': word, 'seconds': seconds};
  }
}
