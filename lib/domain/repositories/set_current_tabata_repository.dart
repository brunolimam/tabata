import 'package:tabata/domain/entities/tabata.dart';

abstract class SetCurrentTabataRepository {
  Future<void> set(Tabata tabata);
}
