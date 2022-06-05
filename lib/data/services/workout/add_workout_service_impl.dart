import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabata/data/models/workout_model.dart';
import 'package:tabata/data/services/workout/add_workout_service.dart';

class AddWorkoutServiceImpl extends AddWorkoutService {
  final FirebaseFirestore _firestore;

  AddWorkoutServiceImpl(this._firestore);

  @override
  Future<void> add(
    WorkoutModel workoutModel,
    String userId,
  ) async {
    var json = workoutModel.toJson();
    json['userId'] = userId;

    await _firestore.collection('workouts').add(json);
  }
}
