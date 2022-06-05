import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/usecases/tabata/get_current_tabata_use_case.dart';
import 'package:tabata/domain/usecases/total_time/get_total_time_use_case.dart';

part 'tabata_event.dart';
part 'tabata_state.dart';

class TabataBloc extends Bloc<TabataEvent, TabataState> {
  final GetCurrentTabataUseCase _getCurrentTabataUseCase;
  final GetTotalTimeUseCase _getTotalTimeUseCase;

  TabataBloc(
    this._getCurrentTabataUseCase,
    this._getTotalTimeUseCase,
  ) : super(CurrentTabataLoading()) {
    on<GetCurrentTabataEvent>(_mapGetCurrentTabata);
  }

  void _mapGetCurrentTabata(
    GetCurrentTabataEvent event,
    Emitter<TabataState> emit,
  ) async {
    emit(CurrentTabataLoading());
    Tabata tabata = await _getCurrentTabataUseCase.execute();
    String totalTime = _getTotalTimeUseCase.execute(tabata);

    emit(CurrentTabataDone(tabata, totalTime));
  }
}
