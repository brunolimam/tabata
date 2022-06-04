import 'package:tabata/domain/entities/Time.dart';

abstract class GetTimeFromTextUseCase {
  Time execute(String value);
}
