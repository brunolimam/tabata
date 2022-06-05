import 'package:tabata/data/models/tabata_model.dart';
import 'package:tabata/data/models/workout_feedback_model.dart';
import 'package:tabata/domain/entities/workout.dart';

class WorkoutModel extends Workout {
  const WorkoutModel(
    TabataModel tabata,
    WorkoutFeedbackModel feedback,
  ) : super(
          tabata: tabata,
          feedback: feedback,
        );

  WorkoutModel.map(Map<String, dynamic> map)
      : super(
          tabata: TabataModel.map(map['tabata']),
          feedback: WorkoutFeedbackModel.map(map['feedback']),
        );

  Map<String, dynamic> toJson() {
    return {
      "tabata": (tabata as TabataModel).toJson(),
      "feedback": (feedback as WorkoutFeedbackModel).toJson(),
    };
  }
}
