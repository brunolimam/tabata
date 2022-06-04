import 'package:tabata/domain/entities/Time.dart';

abstract class GetTimeFromSeconds {
  Time execute(int seconds);
}
