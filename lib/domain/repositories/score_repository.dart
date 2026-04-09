import '../entities/score_record.dart';

abstract class ScoreRepository {
  Future<ScoreRecord> getBestScore();
  Future<void> saveScore({required int score, required int accuracy});
}
