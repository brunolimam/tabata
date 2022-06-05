import 'package:tabata/data/models/tabata_model.dart';

abstract class SetCurrentTabataService {
  Future<void> set(
    TabataModel model,
    String userId,
  );
}
