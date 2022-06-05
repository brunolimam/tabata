import 'package:tabata/domain/entities/workout_feed_Intensity.dart';

class WorkoutFeedback {
  final String description;
  final WorkoutFeedbackIntensity intensity;

  const WorkoutFeedback({
    required this.description,
    required this.intensity,
  });
}
