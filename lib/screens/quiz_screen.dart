import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../utils/theme.dart';

class QuizScreen extends StatefulWidget {
  final EpisodeQuiz quiz;

  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int? _selectedOption;
  bool _answered = false;
  int _score = 0;
  bool _quizComplete = false;

  QuizQuestion get _current => widget.quiz.questions[_currentIndex];
  int get _total => widget.quiz.questions.length;

  void _selectOption(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (index == _current.correctIndex) _score++;
    });
  }

  void _next() {
    if (_currentIndex < _total - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
    } else {
      setState(() => _quizComplete = true);
    }
  }

  void _restart() {
    setState(() {
      _currentIndex = 0;
      _selectedOption = null;
      _answered = false;
      _score = 0;
      _quizComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepBlack,
      appBar: AppBar(
        backgroundColor: AppColors.bgCharcoal,
        foregroundColor: AppColors.textMain,
        title: Text(
          widget.quiz.episodeTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _quizComplete ? _buildResults() : _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress bar
          Row(
            children: [
              Text(
                'Question ${_currentIndex + 1} of $_total',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                'Score: $_score/$_total',
                style: const TextStyle(
                  color: AppColors.accentAmber,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(Radii.xs),
            child: LinearProgressIndicator(
              value: (_currentIndex + 1) / _total,
              backgroundColor: AppColors.bgCard,
              color: AppColors.accentAmber,
              minHeight: 4,
            ),
          ),
          const SizedBox(height: Spacing.xl),

          // Question
          Container(
            padding: const EdgeInsets.all(Spacing.lg),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(Radii.md),
              border: Border.all(color: AppColors.borderSubtle),
            ),
            child: Text(
              _current.question,
              style: const TextStyle(
                color: AppColors.textMain,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          // Options
          ...List.generate(_current.options.length, (i) {
            final isSelected = _selectedOption == i;
            final isCorrect = i == _current.correctIndex;
            Color borderColor = AppColors.borderSubtle;
            Color bgColor = AppColors.bgCard;
            Color textColor = AppColors.textSecondary;
            Widget? trailing;

            if (_answered) {
              if (isCorrect) {
                borderColor = AppColors.success;
                bgColor = AppColors.success.withValues(alpha: 0.08);
                textColor = AppColors.success;
                trailing = const Icon(Icons.check_circle_rounded,
                    color: AppColors.success, size: 20);
              } else if (isSelected && !isCorrect) {
                borderColor = AppColors.error;
                bgColor = AppColors.error.withValues(alpha: 0.08);
                textColor = AppColors.error;
                trailing = const Icon(Icons.cancel_rounded,
                    color: AppColors.error, size: 20);
              }
            } else if (isSelected) {
              borderColor = AppColors.accentAmber;
              bgColor = AppColors.accentAmber.withValues(alpha: 0.06);
              textColor = AppColors.textMain;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: Spacing.sm),
              child: GestureDetector(
                onTap: () => _selectOption(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.lg,
                    vertical: Spacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(Radii.md),
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected && !_answered
                              ? AppColors.accentAmber
                              : Colors.transparent,
                          border: Border.all(
                            color: isSelected && !_answered
                                ? AppColors.accentAmber
                                : AppColors.textFaint,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            String.fromCharCode(65 + i), // A, B, C, D
                            style: TextStyle(
                              color: isSelected && !_answered
                                  ? AppColors.deepBlack
                                  : AppColors.textFaint,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: Spacing.md),
                      Expanded(
                        child: Text(
                          _current.options[i],
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                      if (trailing != null) ...[
                        const SizedBox(width: Spacing.sm),
                        trailing,
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),

          // Explanation
          if (_answered) ...[
            const SizedBox(height: Spacing.md),
            Container(
              padding: const EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: AppColors.accentAmber.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(Radii.md),
                border: Border.all(
                  color: AppColors.accentAmber.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb_rounded,
                          color: AppColors.accentAmber, size: 18),
                      SizedBox(width: Spacing.sm),
                      Text(
                        'Explanation',
                        style: TextStyle(
                          color: AppColors.accentAmber,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.sm),
                  Text(
                    _current.explanation,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentAmber,
                  foregroundColor: AppColors.deepBlack,
                  padding: const EdgeInsets.symmetric(vertical: Spacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Radii.md),
                  ),
                ),
                child: Text(
                  _currentIndex < _total - 1 ? 'Next Question' : 'See Results',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
          ],
          const SizedBox(height: Spacing.xxl),
        ],
      ),
    );
  }

  Widget _buildResults() {
    final pct = (_score / _total * 100).round();
    final passed = pct >= 70;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Score circle
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: passed ? AppColors.success : AppColors.accentOrange,
                  width: 4,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$pct%',
                    style: TextStyle(
                      color: passed ? AppColors.success : AppColors.accentOrange,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '$_score / $_total',
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.xl),
            Text(
              passed ? 'Great work!' : 'Keep studying!',
              style: const TextStyle(
                color: AppColors.textMain,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: Spacing.sm),
            Text(
              passed
                  ? 'You passed the quiz for this episode.'
                  : 'Listen again and try to score 70% or higher.',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _restart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgCard,
                    foregroundColor: AppColors.textMain,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.xl, vertical: Spacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Radii.md),
                      side: const BorderSide(color: AppColors.borderMedium),
                    ),
                  ),
                  child: const Text('Retry',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: Spacing.md),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentAmber,
                    foregroundColor: AppColors.deepBlack,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.xl, vertical: Spacing.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Radii.md),
                    ),
                  ),
                  child: const Text('Done',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
