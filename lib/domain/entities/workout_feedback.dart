import 'package:tabata/domain/entities/workout_feedback_intensity.dart';

class WorkoutFeedback {
  final String description;
  final WorkoutFeedbackIntensity intensity;

  const WorkoutFeedback({
    required this.description,
    required this.intensity,
  });
}
