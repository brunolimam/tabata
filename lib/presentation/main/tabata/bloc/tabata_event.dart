part of 'tabata_bloc.dart';

abstract class TabataEvent extends Equatable {
  const TabataEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentTabataEvent extends TabataEvent {}
