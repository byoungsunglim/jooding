class Questionnaire {
  final String question;
  final List options;

  Questionnaire({this.question, this.options});

  factory Questionnaire.fromJson(Map<String, dynamic> json) {
    return Questionnaire(
      question: json['results']['question'],
      options: json['results']['options']
    );
  }
}