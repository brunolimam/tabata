import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabata/data/services/workout/delete_workout_service.dart';

class DeleteWorkoutServiceImpl extends DeleteWorkoutService {
  final FirebaseFirestore _firestore;

  DeleteWorkoutServiceImpl(this._firestore);

  @override
  Future<void> delete(String workoutId) async {
    await _firestore.doc('workouts/$workoutId').delete();
  }
}
