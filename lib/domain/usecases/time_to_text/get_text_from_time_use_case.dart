import 'package:tabata/domain/entities/Time.dart';

abstract class GetTextFromTimeUseCase {
  String execute(Time value);
}
