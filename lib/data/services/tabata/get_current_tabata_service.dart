import 'package:tabata/data/models/tabata_model.dart';

abstract class GetCurrentTabataService {
  Future<TabataModel?> get(String userId);
}
