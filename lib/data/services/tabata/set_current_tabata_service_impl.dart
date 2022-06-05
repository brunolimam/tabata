import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tabata/data/models/tabata_model.dart';
import 'package:tabata/data/services/tabata/set_current_tabata_service.dart';

class SetCurrentTabataServiceImpl extends SetCurrentTabataService {
  final FirebaseFirestore _firestore;

  SetCurrentTabataServiceImpl(this._firestore);

  @override
  Future<void> set(TabataModel model, String userId) async {
    await _firestore.doc('tabatas/$userId').set(model.toJson());
  }
}
