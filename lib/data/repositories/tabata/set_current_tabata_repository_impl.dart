import 'package:tabata/data/models/tabata_model.dart';
import 'package:tabata/data/services/auth/current_user/get_current_user_service.dart';
import 'package:tabata/data/services/tabata/set_current_tabata_service.dart';
import 'package:tabata/domain/entities/tabata.dart';
import 'package:tabata/domain/repositories/set_current_tabata_repository.dart';

class SetCurrentTabataRepositoryImpl extends SetCurrentTabataRepository {
  final SetCurrentTabataService _setCurrentTabataService;
  final GetCurrentUserService _getCurrentUserService;

  SetCurrentTabataRepositoryImpl(
    this._setCurrentTabataService,
    this._getCurrentUserService,
  );

  @override
  Future<void> set(Tabata tabata) async {
    var user = _getCurrentUserService.get();
    if (user == null) return;

    var model = TabataModel(
      seriesTime: tabata.seriesTime,
      seriesQuantity: tabata.seriesQuantity,
      restTime: tabata.restTime,
      cycleQuantity: tabata.cycleQuantity,
      timeBetweenCycles: tabata.timeBetweenCycles,
    );

    _setCurrentTabataService.set(
      model,
      user.id,
    );
  }
}
