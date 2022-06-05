import 'package:tabata/domain/entities/tabata.dart';

abstract class GetCurrentTabataUseCase {
  Future<Tabata> execute();
}
