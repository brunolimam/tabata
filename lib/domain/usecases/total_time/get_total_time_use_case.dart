import 'package:tabata/domain/entities/tabata.dart';

abstract class GetTotalTimeUseCase {
  String execute(Tabata tabata);
}
