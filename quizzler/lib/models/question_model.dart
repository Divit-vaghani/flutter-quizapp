enum Type { boolean, multiple }

enum Difficulty { easy, medium, hard }

class Question {
  late final String category;
  late final Type type;
  late final Difficulty difficulty;
  late final String question;
  late final String correct_answer;
  late final List<dynamic> incorrect_answer;

  Question.fromMap(Map<String, dynamic> data)
      : category = data['category'],
        type = data['type'] == 'multiple' ? Type.multiple : Type.boolean,
        difficulty = data['difficulty'] == 'easy'
            ? Difficulty.easy
            : data['difficulty'] == 'medium'
                ? Difficulty.medium
                : Difficulty.hard,
        question = data['question'],
        correct_answer = data['correct_answer'],
        incorrect_answer = data['incorrect_answers'];

  static List<Question> fromData(List<Map<String, dynamic>> data) =>
      data.map((question) => Question.fromMap(question)).toList();
}
