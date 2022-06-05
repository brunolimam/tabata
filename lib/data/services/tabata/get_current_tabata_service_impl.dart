import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabata/data/models/tabata_model.dart';
import 'package:tabata/data/services/tabata/get_current_tabata_service.dart';

class GetCurrentTabataServiceImpl extends GetCurrentTabataService {
  final FirebaseFirestore _firestore;

  GetCurrentTabataServiceImpl(this._firestore);

  @override
  Future<TabataModel?> get(String userId) async {
    var snapshot = await _firestore.doc('tabatas/$userId').get();
    var data = snapshot.data();
    if (data == null) return null;

    return TabataModel.map(data);
  }
}
