import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/score_record.dart';
import '../../domain/repositories/score_repository.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  static const _bestScoreKey = 'best_score';
  static const _bestAccuracyKey = 'best_accuracy';

  @override
  Future<ScoreRecord> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return ScoreRecord(
      bestScore: prefs.getInt(_bestScoreKey) ?? 0,
      bestAccuracy: prefs.getInt(_bestAccuracyKey) ?? 0,
    );
  }

  @override
  Future<void> saveScore({required int score, required int accuracy}) async {
    final prefs = await SharedPreferences.getInstance();
    final currentBest = prefs.getInt(_bestScoreKey) ?? 0;
    final currentBestAccuracy = prefs.getInt(_bestAccuracyKey) ?? 0;

    if (score > currentBest ||
        (score == currentBest && accuracy > currentBestAccuracy)) {
      await prefs.setInt(_bestScoreKey, score);
      await prefs.setInt(_bestAccuracyKey, accuracy);
    }
  }
}
