import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabata/data/models/workout_model.dart';
import 'package:tabata/data/services/workout/load_workouts_service.dart';

class LoadWorkoutsServiceImpl extends LoadWorkoutsService {
  final FirebaseFirestore _firestore;

  LoadWorkoutsServiceImpl(this._firestore);

  @override
  Future<List<WorkoutModel>> load(String userId) async {
    var snapshots = await _firestore
        .collection('workouts')
        .where('userId', isEqualTo: userId)
        .get();

    var documents = snapshots.docs;
    return documents.map((e) {
      var data = e.data();
      return WorkoutModel.map(data);
    }).toList();
  }
}
