class ScoreRecord {
  const ScoreRecord({required this.bestScore, required this.bestAccuracy});

  const ScoreRecord.empty() : bestScore = 0, bestAccuracy = 0;

  final int bestScore;
  final int bestAccuracy;

  bool get hasData => bestScore > 0;
}
