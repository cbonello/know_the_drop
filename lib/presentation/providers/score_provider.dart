import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/score_repository_impl.dart';
import '../../domain/entities/score_record.dart';
import '../../domain/repositories/score_repository.dart';

final scoreRepositoryProvider = Provider<ScoreRepository>(
  (_) => ScoreRepositoryImpl(),
);

final bestScoreProvider = FutureProvider<ScoreRecord>(
  (ref) => ref.read(scoreRepositoryProvider).getBestScore(),
);
