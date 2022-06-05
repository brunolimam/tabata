import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/entities/workout_feedback.dart';

class Workout {
  final String? id;
  final Tabata tabata;
  final WorkoutFeedback feedback;
  final DateTime date;

  const Workout({
    this.id,
    required this.tabata,
    required this.feedback,
    required this.date,
  });
}
