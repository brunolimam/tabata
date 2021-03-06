import 'package:tabata/domain/entities/workout_feedback.dart';
import 'package:tabata/domain/entities/workout_feedback_intensity.dart';

class WorkoutFeedbackModel extends WorkoutFeedback {
  const WorkoutFeedbackModel(
    String description,
    WorkoutFeedbackIntensity intensity,
  ) : super(
          description: description,
          intensity: intensity,
        );

  WorkoutFeedbackModel.map(Map<String, dynamic> map)
      : super(
          description: map['description'],
          intensity: WorkoutFeedbackIntensity.values[map['intensity']],
        );

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "intensity": intensity.index,
    };
  }
}
