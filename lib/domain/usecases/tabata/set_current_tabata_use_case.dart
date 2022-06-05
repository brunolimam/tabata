import 'package:tabata/domain/entities/tabata.dart';

abstract class SetCurrentTabataUseCase {
  Future<void> execute(Tabata tabata);
}
