part of 'tabata_bloc.dart';

abstract class TabataState extends Equatable {
  const TabataState();

  @override
  List<Object> get props => [];
}

class CurrentTabataLoading extends TabataState {}

class CurrentTabataDone extends TabataState {
  final Tabata tabata;
  final String totalTime;

  const CurrentTabataDone(
    this.tabata,
    this.totalTime,
  );
}
