class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class EpisodeQuiz {
  final String episodeTitle;
  final List<QuizQuestion> questions;

  const EpisodeQuiz({
    required this.episodeTitle,
    required this.questions,
  });
}
