import 'dart:convert';

class Answer {
  final String answer;
  final String image;

  Answer({
    required this.answer,
    required this.image,
  });

  Answer copyWith({
    String? answer,
    String? image,
  }) {
    return Answer(
      answer: answer ?? this.answer,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'answer': answer,
      'image': image,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      answer: map['answer'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));

  @override
  String toString() => 'Answer(answer: $answer, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Answer && other.answer == answer && other.image == image;
  }

  @override
  int get hashCode => answer.hashCode ^ image.hashCode;
}
