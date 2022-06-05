import 'package:tabata/domain/entities/tabata.dart';

abstract class GetCurrentTabataRepository {
  Future<Tabata?> get();
}
