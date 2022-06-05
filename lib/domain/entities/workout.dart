import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/entities/workout_feedback.dart';

class Workout {
  final Tabata tabata;
  final WorkoutFeedback feedback;

  const Workout({
    required this.tabata,
    required this.feedback,
  });
}
