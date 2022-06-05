import 'package:easy_localization/easy_localization.dart';

enum WorkoutFeedbackIntensity {
  light,
  normal,
  hard,
}

extension WorkoutFeedbackIntensityName on WorkoutFeedbackIntensity {
  String get displayName {
    switch (this) {
      case WorkoutFeedbackIntensity.light:
        return "light".tr();
      case WorkoutFeedbackIntensity.normal:
        return "moderate".tr();
      case WorkoutFeedbackIntensity.hard:
        return "hard".tr();
    }
  }
}
