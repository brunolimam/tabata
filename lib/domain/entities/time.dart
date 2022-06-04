import 'package:equatable/equatable.dart';

class Time extends Equatable {
  final int minutes;
  final int seconds;

  const Time(this.minutes, this.seconds);

  @override
  List<Object?> get props => [minutes, seconds];
}
